SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE dbo.ap_sch_recursive_update_hierachy_node
(
    @SessionId AS UNIQUEIDENTIFIER,
    @HierarchyChangeId AS UNIQUEIDENTIFIER,
    @RequestType AS CHAR(1),
    @ItemUrn AS INT OUT,
    @ToParentUrn AS INT,
    @EffectiveFrom AS DATETIME,
    @IsPastChange AS BIT = 0    
) AS
    SET NOCOUNT ON;
    
    DECLARE @SessionUserId AS UNIQUEIDENTIFIER,
            @InitialTransactionCount AS INT,
            @ReturnCode AS INT,            
            @CurrentParentBusinessUrn AS INT,
            @ChangeStamp AS INT,
            @NewItemUrn AS INT,            
            @ChildItemUrn AS INT,
            @UtcNow AS DATETIME,
            @RowCount AS DATETIME,
            @NodeBusinessUrn AS INT;
            
    SET @InitialTransactionCount = @@TRANCOUNT;
    SET @UtcNow = DATEADD(ms, -(DATEPART(ms, GETUTCDATE())), GETUTCDATE());
    
    -- Check Session Id
    IF @SessionId IS NULL
    BEGIN 
        SET @ReturnCode = 50157;
        RAISERROR(50157, 16, 5, 'ap_sch_recursive_update_hierachy_node');
        RETURN @ReturnCode;
    END;
    
    -- Retrieve user information
    SELECT @SessionUserId = USER_ID FROM dbo.TB_SEC_USER
    WHERE GETUTCDATE() BETWEEN EFFECTIVE_FROM AND EFFECTIVE_TO
    AND LOGIN_NAME = (SELECT SESSION_USER_NAME FROM dbo.TB_ADM_SESSION WHERE SESSION_ID = @SessionId);
        
    SELECT  @NodeBusinessUrn = n.ITEM_BIZ_URN,
            @CurrentParentBusinessUrn = p.ITEM_BIZ_URN,
            @ChangeStamp = n.CHANGE_STAMP
    FROM dbo.VW_DIM_HIERARCHY_NODE AS n
    LEFT JOIN dbo.VW_DIM_HIERARCHY_NODE AS p ON p.ITEM_URN = n.HIERARCHY_PARENT_URN
    WHERE n.ITEM_URN = @ItemUrn;
        
    SET @NewItemUrn = @ItemUrn;
    BEGIN TRANSACTION SchUpTransaction;
        -- If the request is to delete the node
        IF @RequestType = 'R'
        BEGIN 
            -- Delete the current node.
            UPDATE dbo.TB_DIM_HIERARCHY_NODE 
            SET EFFECTIVE_TO = DATEADD(ss, -1, @EffectiveFrom), -- 1 second before.
                DELETED = 1,
                MODIFIED_DATE = @UtcNow,
                MODIFIED_BY_ID = @SessionUserId,
                CHANGE_STAMP = CHANGE_STAMP + 1
            WHERE ITEM_URN = @ItemUrn            
            AND CHANGE_STAMP = @ChangeStamp;
            
            SELECT @ReturnCode = @@ERROR, @RowCount = @@RowCount;
            IF @ReturnCode <> 0
            BEGIN 
                RAISERROR('ap_sch_recursive_update_hierachy_node: Error deleting item [%d], Error [%d] ', 16, 1, @ItemUrn, @ReturnCode) WITH LOG;
                GOTO EXIT_WITH_ERROR;
            END;
            
            -- Concurrency conflict or attempt to delete non deleted record
            IF @RowCount = 0
            BEGIN 
                SET @ReturnCode = -2;
                RAISERROR('ap_sch_recursive_update_hierachy_node: Concurrency conflict occured whilst deleting item [%d], Error [%d] ', 16, 1, @ItemUrn, @ReturnCode) WITH LOG;
                GOTO EXIT_WITH_ERROR;
            END;
            
            -- purge all the future surrogates of the item.
            DECLARE @FutureSurrogates TABLE
            (
                ITEM_URN INT
            );
            INSERT INTO @FutureSurrogates (ITEM_URN)
            SELECT ITEM_URN 
            FROM dbo.VW_DIM_HIERARCHY_NODE 
            WHERE ITEM_BIZ_URN = @NodeBusinessUrn
            AND EFFECTIVE_FROM > @EffectiveFrom;
            
            WHILE EXISTS(SELECT * FROM @FutureSurrogates)
            BEGIN 
                DECLARE @TempFutureSurrogateItemUrn INT;

                SELECT TOP 1 @ChildItemUrn = ITEM_URN 
                FROM @FutureSurrogates
                ORDER BY [ITEM_URN];
                
                SET @TempFutureSurrogateItemUrn = @ChildItemUrn;
                
                exec @ReturnCode = dbo.ap_sch_recursive_purge_hierarchy_node @SessionId, @ChildItemUrn;
                
                IF @ReturnCode <> 0
                BEGIN 
                    GOTO EXIT_WITH_ERROR;
                END;
                                    
                DELETE @FutureSurrogates 
                WHERE ITEM_URN = @TempFutureSurrogateItemUrn;
            END;
        END;
        ELSE
        BEGIN 
            exec @ReturnCode = dbo.ap_dim01_do_type2_hierarchy_node @SessionId, @NewItemUrn OUT, @NodeBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IsPastChange, 1;
            IF @ReturnCode <> 0
            BEGIN 
                GOTO EXIT_WITH_ERROR;
            END;
        
            UPDATE dbo.TB_DIM_HIERARCHY_NODE 
            SET HIERARCHY_PARENT_URN = @ToParentUrn 
            WHERE ITEM_URN = @NewItemUrn;
        
            SELECT @ReturnCode = @@ERROR;
            IF @ReturnCode <> 0
            BEGIN 
                RAISERROR('ap_sch_recursive_update_hierachy_node: Error updating new surrogate for item [%d], Error Code: [%d]', 16, 1, @ItemUrn, @ReturnCode) WITH LOG;
                GOTO EXIT_WITH_ERROR;
            END;
            
            -- if there are any surrogates of the current node that are effective later than the input effective from
            -- update the hierarchy parent to be the node that were are moving the current node into        
            IF EXISTS(SELECT * FROM dbo.VW_DIM_HIERARCHY_NODE WHERE ITEM_BIZ_URN =  @NodeBusinessUrn AND EFFECTIVE_FROM > @EffectiveFrom)
            BEGIN 
                DECLARE @SubsequentOtherEffectiveFrom AS DATETIME;
                
                -- Find the first surrogate of the affected surrogate in future where the hierarchy parent surrogate is different to that of
                -- the affected surrogates previous surrogate
                SELECT TOP 1 @SubsequentOtherEffectiveFrom = fsur.EFFECTIVE_FROM
                FROM dbo.VW_DIM_HIERARCHY_NODE AS fsur
                JOIN dbo.VW_DIM_HIERARCHY_NODE AS csur ON fsur.ITEM_BIZ_URN = csur.ITEM_BIZ_URN
                WHERE csur.ITEM_URN = @NewItemUrn
                and fsur.EFFECTIVE_FROM >  @EffectiveFrom
                AND fsur.HIERARCHY_PARENT_URN NOT IN (SELECT ITEM_URN FROM dbo.VW_DIM_HIERARCHY_NODE WHERE ITEM_BIZ_URN = @CurrentParentBusinessUrn)
                ORDER BY fsur.EFFECTIVE_FROM;
                
                SET @SubsequentOtherEffectiveFrom = COALESCE(@SubsequentOtherEffectiveFrom, 2958463); -- 2958463 == 9999-12-31 00:00:00.000
                
                UPDATE dbo.VW_DIM_HIERARCHY_NODE SET HIERARCHY_PARENT_URN = cust.NEW_PARENT_URN
                FROM dbo.VW_DIM_HIERARCHY_NODE AS nodes
                JOIN (SELECT n1.ITEM_URN, n1.HIERARCHY_PARENT_URN, n1.EFFECTIVE_FROM, n1.EFFECTIVE_TO, (SELECT TOP 1 a.ITEM_URN
                                                                                FROM dbo.VW_DIM_HIERARCHY_NODE AS n
                                                                                JOIN dbo.VW_DIM_HIERARCHY_NODE AS a ON a.ITEM_BIZ_URN = n.ITEM_BIZ_URN
                                                                                WHERE n.ITEM_URN = @ToParentUrn
                                                                                AND n1.EFFECTIVE_FROM BETWEEN a.EFFECTIVE_FROM AND a.EFFECTIVE_TO
                                                                                ORDER BY a.ITEM_URN) AS NEW_PARENT_URN
                FROM dbo.VW_DIM_HIERARCHY_NODE AS n1
                JOIN dbo.VW_DIM_HIERARCHY_NODE AS n2 ON n2.ITEM_BIZ_URN = n1.ITEM_BIZ_URN
                WHERE n2.ITEM_URN = @NewItemUrn
                AND n1.EFFECTIVE_FROM > @EffectiveFrom AND n1.EFFECTIVE_TO < @SubsequentOtherEffectiveFrom
                AND n1.HIERARCHY_PARENT_URN IN (SELECT ITEM_URN FROM dbo.VW_DIM_HIERARCHY_NODE WHERE ITEM_BIZ_URN = @CurrentParentBusinessUrn)
                ) AS cust ON cust.ITEM_URN = nodes.ITEM_URN;

                SELECT @ReturnCode = @@ERROR;
                IF @ReturnCode <> 0
                BEGIN 
                    RAISERROR('ap_sch_recursive_update_hierachy_node: Error update future surrogates of node [%d], Error [%d] ', 16, 1, @ItemUrn, @ReturnCode) WITH LOG;
                    GOTO EXIT_WITH_ERROR;
                END;
            END;
        END;
        
        DECLARE @ChildrenTable AS TABLE
        (
            ITEM_URN INT            
        );
    
        -- Get all the children for the current item
        INSERT INTO @ChildrenTable (ITEM_URN)
        SELECT ITEM_URN 
        FROM dbo.VW_DIM_HIERARCHY_NODE 
        WHERE HIERARCHY_PARENT_URN = @ItemUrn    
        AND @EffectiveFrom BETWEEN EFFECTIVE_FROM AND EFFECTIVE_TO;
            
        WHILE EXISTS(SELECT * FROM @ChildrenTable)
        BEGIN 
            DECLARE @TempItemUrn INT;

            SELECT TOP 1 @ChildItemUrn = ITEM_URN 
            FROM @ChildrenTable
            ORDER BY [ITEM_URN];
            
            SET @TempItemUrn = @ChildItemUrn;
            
            exec @ReturnCode = dbo.ap_sch_recursive_update_hierachy_node @SessionId, @HierarchyChangeId, @RequestType, @ChildItemUrn OUT, @NewItemUrn, @EffectiveFrom, @IsPastChange;
            
            IF @ReturnCode <> 0
            BEGIN 
                GOTO EXIT_WITH_ERROR;
            END;
                                
            DELETE @ChildrenTable WHERE ITEM_URN = @TempItemUrn;
        END;
        
        DECLARE @pOldItemUrn INT,
                @pItemUrn INT,
                @pItemBizUrn INT,
                @pEffectiveFrom DATETIME,                
                @pEffectiveTo DATETIME,                
                @pItemTypeId UNIQUEIDENTIFIER,            
                @pItemTypeUrn INT,
                @pChangeStamp INT,
                @pItemUrnToDelete INT;
        
        DECLARE @ChangeResultMappingTable as TABLE
        (
            HIERARCHY_CHANGE_ID UNIQUEIDENTIFIER,
            ITEM_TYPE_ID UNIQUEIDENTIFIER,
            ITEM_BUSINESS_URN INT,
            EFFECTIVE_FROM DATETIME,
            EFFECTIVE_TO DATETIME
        );
            
        DECLARE @ItemToNodeMappingTable as TABLE
        (
            ITEM_URN INT,
            ITEM_BIZ_URN INT,
            ITEM_TYPE_URN INT,
            ITEM_TYPE_ID UNIQUEIDENTIFIER,
            EFFECTIVE_FROM DATETIME,
            EFFECTIVE_TO DATETIME,
            CHANGE_STAMP INT
        );
        
        INSERT INTO @ItemToNodeMappingTable (ITEM_URN, ITEM_BIZ_URN, ITEM_TYPE_URN, ITEM_TYPE_ID, EFFECTIVE_FROM, EFFECTIVE_TO, CHANGE_STAMP)
        SELECT i.ITEM_URN, i.ITEM_BIZ_URN, i.ITEM_TYPE_URN, i.ITEM_TYPE_ID, i.EFFECTIVE_FROM, i.EFFECTIVE_TO, i.CHANGE_STAMP
        FROM dbo.VW_DIM_ITEM AS i
        JOIN dbo.TB_DIM_ITEM_HIERARCHY_NODE_MEMBER AS m ON i.ITEM_URN = m.ITEM_URN AND i.ITEM_TYPE_URN = m.ITEM_TYPE_URN
        WHERE m.HIERARCHY_NODE_URN = @ItemUrn
        AND @EffectiveFrom BETWEEN i.EFFECTIVE_FROM AND i.EFFECTIVE_TO;

        WHILE EXISTS(SELECT * FROM @ItemToNodeMappingTable)
        BEGIN 
            SELECT TOP 1 @pItemUrn = ITEM_URN, 
                        @pItemBizUrn = ITEM_BIZ_URN, 
                        @pEffectiveFrom = EFFECTIVE_FROM, 
                        @pEffectiveTo = EFFECTIVE_TO, 
                        @pItemTypeUrn = ITEM_TYPE_URN, 
                        @pItemTypeId = ITEM_TYPE_ID, 
                        @pChangeStamp = CHANGE_STAMP 
            FROM @ItemToNodeMappingTable
            ORDER BY [ITEM_URN];
            
            SET @pOldItemUrn = @pItemUrn;
            SET @pItemUrnToDelete = @pItemUrn;
                        
            exec @ReturnCode = dbo.ap_dim01_do_type2_item @SessionId, @pItemUrn OUT, @pItemBizUrn OUT, @pItemTypeUrn, @pChangeStamp, @EffectiveFrom, 0, 1;
            
            IF @ReturnCode <> 0
            BEGIN 
                GOTO EXIT_WITH_ERROR;
            END;
            
            IF @pOldItemUrn <> @pItemUrn
            BEGIN 
                -- If the item urn has changed then copy old mappings as is and just update the current hierarchy node urn
                INSERT INTO dbo.TB_DIM_ITEM_HIERARCHY_NODE_MEMBER (ITEM_URN, ITEM_TYPE_URN, HIERARCHY_NODE_URN, PRECEDENCE)
                SELECT @pItemUrn, @pItemTypeUrn, CASE WHEN HIERARCHY_NODE_URN = @ItemUrn THEN @NewItemUrn ELSE HIERARCHY_NODE_URN END, PRECEDENCE
                FROM dbo.TB_DIM_ITEM_HIERARCHY_NODE_MEMBER
                WHERE ITEM_URN = @pOldItemUrn
                AND ITEM_TYPE_URN = @pItemTypeUrn;
                
                SELECT @ReturnCode = @@ERROR;
                IF @ReturnCode <> 0
                BEGIN 
                    RAISERROR('ap_sch_recursive_update_hierachy_node: Error updating new surrogate for taxonomy item [%d] mapped to role [%d], Error Code: [%d]', 16, 1, @pOldItemUrn, @ItemUrn, @ReturnCode) WITH LOG;
                    GOTO EXIT_WITH_ERROR;
                END;
            END;
            ELSE
            BEGIN 
                -- if item urn has not changed then just update the hierarchy node urn to the new value.
                UPDATE dbo.TB_DIM_ITEM_HIERARCHY_NODE_MEMBER SET HIERARCHY_NODE_URN = @NewItemUrn
                WHERE ITEM_URN = @pItemUrn AND ITEM_TYPE_URN = @pItemTypeUrn AND HIERARCHY_NODE_URN = @ItemUrn;
                
                SELECT @ReturnCode = @@ERROR;
                IF @ReturnCode <> 0
                BEGIN 
                    RAISERROR('ap_sch_recursive_update_hierachy_node: Error updating new surrogate for taxonomy item [%d] mapped to role [%d], Error Code: [%d]', 16, 1, @pOldItemUrn, @ItemUrn, @ReturnCode) WITH LOG;
                    GOTO EXIT_WITH_ERROR;
                END;
            END;    
            
            -- If the node was deleted then remove the mappings.
            IF @RequestType = 'R'
            BEGIN 
                DELETE dbo.TB_DIM_ITEM_HIERARCHY_NODE_MEMBER 
                WHERE ITEM_URN IN (SELECT ITEM_URN FROM dbo.VW_DIM_ITEM WHERE ITEM_BIZ_URN = @pItemBizUrn AND ITEM_TYPE_URN = @pItemTypeUrn
                                    AND EFFECTIVE_FROM >= @EffectiveFrom)
                AND HIERARCHY_NODE_URN = @NewItemUrn
                AND ITEM_TYPE_URN = @pItemTypeUrn
                OPTION (RECOMPILE);
                
                SELECT @ReturnCode = @@ERROR;
                IF @ReturnCode <> 0
                BEGIN 
                    RAISERROR('ap_sch_recursive_update_hierachy_node: Error updating new surrogate for taxonomy item [%d] mapped to role [%d], Error Code: [%d]', 16, 1, @pOldItemUrn, @ItemUrn, @ReturnCode) WITH LOG;
                    GOTO EXIT_WITH_ERROR;
                END;
            END;
            
            IF @IsPastChange = 1
            BEGIN 
                IF @pItemUrn <> @pOldItemUrn
                BEGIN 
                    SELECT @pEffectiveFrom = EFFECTIVE_FROM, 
                            @pEffectiveTo = EFFECTIVE_TO
                    FROM dbo.VW_DIM_ITEM
                    WHERE ITEM_URN = @pItemUrn
                    AND ITEM_TYPE_URN = @pItemTypeUrn
                    OPTION (RECOMPILE);
                    
                    INSERT INTO @ChangeResultMappingTable (HIERARCHY_CHANGE_ID, ITEM_TYPE_ID, ITEM_BUSINESS_URN, EFFECTIVE_FROM, EFFECTIVE_TO)
                    VALUES (@HierarchyChangeId, @pItemTypeId, @pItemBizUrn, @pEffectiveFrom, @pEffectiveTo);
                END;
            END;

            DELETE @ItemToNodeMappingTable WHERE ITEM_URN = @pItemUrnToDelete AND ITEM_TYPE_URN = @pItemTypeUrn;
                        
            SET @pOldItemUrn = NULL;
            SET @pItemUrn = NULL;
            SET @pItemBizUrn = NULL;
            SET @pEffectiveFrom = NULL;
            SET @pEffectiveTo = NULL;
            SET @pItemTypeId = NULL;
            SET @pItemTypeUrn = NULL;
            SET @pChangeStamp = NULL;
            SET @pItemUrnToDelete = NULL;
        END;
            
        INSERT INTO dbo.TB_SCH_HIERARCHY_CHANGE_RESULT (HIERARCHY_CHANGE_ID, ITEM_TYPE_ID, ITEM_BUSINESS_URN, EFFECTIVE_FROM, EFFECTIVE_TO)
        SELECT a.HIERARCHY_CHANGE_ID, a.ITEM_TYPE_ID, a.ITEM_BUSINESS_URN, a.EFFECTIVE_FROM, a.EFFECTIVE_TO
        FROM @ChangeResultMappingTable AS a
        WHERE NOT EXISTS(SELECT * FROM dbo.TB_SCH_HIERARCHY_CHANGE_RESULT AS b
                        WHERE a.HIERARCHY_CHANGE_ID = b.HIERARCHY_CHANGE_ID
                        AND a.ITEM_TYPE_ID = b.ITEM_TYPE_ID
                        AND a.ITEM_BUSINESS_URN = b.ITEM_BUSINESS_URN
                        AND a.EFFECTIVE_FROM = b.EFFECTIVE_FROM
                        AND a.EFFECTIVE_TO = b.EFFECTIVE_TO                        
                        );
        
        SELECT @ReturnCode = @@ERROR;
        IF @ReturnCode <> 0
        BEGIN 
            RAISERROR('ap_sch_recursive_update_hierachy_node: Error inserting hierarchy change result data. Error[%d]', 16, 1, @ReturnCode) WITH LOG;
            GOTO EXIT_WITH_ERROR;
        END;
                                
        SET @ItemUrn = @NewItemUrn;
                                    
    IF @InitialTransactionCount = 0 
    BEGIN 
        COMMIT TRANSACTION SchUpTransaction;
    END;
    ELSE BEGIN 
        WHILE @@TRANCOUNT > @InitialTransactionCount
        BEGIN 
            COMMIT TRANSACTION;
        END;
    END;
    
    GOTO EXIT_SPROC;
    
    EXIT_WITH_ERROR:
        DECLARE @ErrorMessage VARCHAR(200);
        IF @InitialTransactionCount = 0 AND @@TRANCOUNT > 0
        BEGIN 
            ROLLBACK TRANSACTION;
        END;
        ELSE IF @InitialTransactionCount <> 0 AND @@TRANCOUNT > @InitialTransactionCount
        BEGIN 
            IF (XACT_STATE()) = -1
            BEGIN 
                SET @ErrorMessage = ISNULL(@ErrorMessage,OBJECT_NAME(@@PROCID))+' [Uncommittable Transaction!]';
                ROLLBACK TRANSACTION;
                -- THIS IS TO AVOID TRANSACTION MISMATCHES IN THE CALLING APPLICATION
                DECLARE @transactionFake INT = @@TRANCOUNT;
                WHILE @transactionFake < @InitialTransactionCount
                BEGIN 
                    BEGIN TRANSACTION;
                    SET @transactionFake = @transactionFake + 1;
                END;
            END;
            ELSE BEGIN 
                WHILE @@TRANCOUNT > @InitialTransactionCount
                BEGIN 
                    COMMIT TRANSACTION;
                END;
            END;
            SET @ErrorMessage = ISNULL(@ErrorMessage,OBJECT_NAME(@@PROCID));
            RAISERROR(@ErrorMessage, 16, 1) WITH LOG;
        END;
    
    EXIT_SPROC:    
        RETURN @ReturnCode;
GO
