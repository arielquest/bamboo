SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE dbo.ap_sch_recursive_associate_disassociate_item_children
(
    @SessionId AS UNIQUEIDENTIFIER,
    @HierarchyChangeId AS UNIQUEIDENTIFIER,
    @HierarchyNodeSurrogateUrn AS INT,
    @ItemTypeUrn AS INT,
    @EffectiveFrom AS DATETIME,
    @IgnoreConsolidationPeriod AS BIT = 0    
) AS
    SET NOCOUNT ON
    
    DECLARE @InitialTransactionCount AS INT,
            @HistoricalEscalationPeriod AS INT,
            @IsPastChange AS BIT,
            @ReturnCode AS INT,
            @SubsequentOtherEffectiveFrom AS DATETIME,
            @ItemTypeId AS UNIQUEIDENTIFIER,
            @ItemBusinessUrn AS INT,
            @ItemSurrogateUrn AS INT,
            @ItemSurrogateEffectiveFrom AS DATETIME,
            @ItemSurrogateEffectiveTo AS DATETIME,
            @ChangeStamp AS INT,
            @NewItemSurrogateUrn AS INT;
            
    DECLARE @AssociatedItems TABLE
    (
        ITEM_URN INT,
        ITEM_BIZ_URN INT,
        EFFECTIVE_FROM DATETIME,
        EFFECTIVE_TO DATETIME,
        CHANGE_STAMP INT
    );
    
    DECLARE @ChildNodesTable as TABLE
    (
        ITEM_URN INT
    );
    
    DECLARE @ChangeResultMappingTable as TABLE
    (
        HIERARCHY_CHANGE_ID UNIQUEIDENTIFIER,
        ITEM_TYPE_ID UNIQUEIDENTIFIER,
        ITEM_BUSINESS_URN INT,
        EFFECTIVE_FROM DATETIME,
        EFFECTIVE_TO DATETIME
    );
    
    SET @InitialTransactionCount = @@TRANCOUNT;
    SET @ReturnCode = 0;
    SET @HistoricalEscalationPeriod = 1440; -- default is 1 day (1440 minutes)
    
    SELECT @HistoricalEscalationPeriod = COALESCE(CAST(PROPERTY_VALUE AS INT), 1440)
    FROM dbo.TB_ADM_PROPERTY
    WHERE PROPERTY_KEY = 'PROP_TYPE2_HISTORICAL_ESCALATION_PERIOD';
        
    IF (DATEDIFF(mi, @EffectiveFrom, GETUTCDATE())) > @HistoricalEscalationPeriod
    BEGIN 
        SET @IsPastChange = 1;
    END;
    
    -- Check Session Id
    IF @SessionId IS NULL
    BEGIN 
        SET @ReturnCode = 50157;
        RAISERROR(50157, 16, 5, 'ap_sch_recursive_associate_disassociate_item_children');
        RETURN @ReturnCode;
    END;
    
    -- Get all children of the node
    INSERT INTO @ChildNodesTable (ITEM_URN)
    SELECT ITEM_URN FROM dbo.VW_DIM_HIERARCHY_NODE WHERE HIERARCHY_PARENT_URN = @HierarchyNodeSurrogateUrn
    AND @EffectiveFrom BETWEEN EFFECTIVE_FROM AND EFFECTIVE_TO;
    
    -- Get all the items of the input item type associated during the effective period with the node
    INSERT INTO @AssociatedItems (ITEM_URN, ITEM_BIZ_URN, EFFECTIVE_FROM, EFFECTIVE_TO, CHANGE_STAMP)
    SELECT i.ITEM_URN, i.ITEM_BIZ_URN, i.EFFECTIVE_FROM, i.EFFECTIVE_TO, i.CHANGE_STAMP
    FROM dbo.VW_DIM_ITEM AS i
    JOIN dbo.TB_DIM_ITEM_HIERARCHY_NODE_MEMBER AS m ON m.ITEM_URN = i.ITEM_URN
    JOIN dbo.VW_DIM_HIERARCHY_NODE AS n ON n.ITEM_URN = m.HIERARCHY_NODE_URN
    WHERE n.ITEM_URN = @HierarchyNodeSurrogateUrn
    AND @EffectiveFrom BETWEEN i.EFFECTIVE_FROM AND i.EFFECTIVE_TO
    AND i.ITEM_TYPE_URN = @ItemTypeUrn
    AND m.ITEM_TYPE_URN = @ItemTypeUrn
    OPTION(RECOMPILE);
    
    BEGIN TRANSACTION AssDisChildTransaction;
        WHILE EXISTS(SELECT * FROM @AssociatedItems)
        BEGIN 
            SELECT     TOP 1 @ItemSurrogateUrn = ITEM_URN,
                    @ItemBusinessUrn = ITEM_BIZ_URN,
                    @ItemSurrogateEffectiveFrom = EFFECTIVE_FROM,
                    @ItemSurrogateEffectiveTo = EFFECTIVE_TO,
                    @ChangeStamp = CHANGE_STAMP
            FROM @AssociatedItems
            ORDER BY [ITEM_URN];
            
            SET @NewItemSurrogateUrn = @ItemSurrogateUrn;
            
            -- type 2 the item
            exec @ReturnCode = dbo.ap_dim01_do_type2_item @SessionId, @NewItemSurrogateUrn OUT, @ItemBusinessUrn OUT, @ItemTypeUrn, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, 1;
    
            IF @ReturnCode <> 0
            BEGIN 
                GOTO EXIT_WITH_ERROR;
            END;
                
            IF @NewItemSurrogateUrn <> @ItemSurrogateUrn
            BEGIN 
                -- Copy existing mappings to the new surrogate
                INSERT INTO dbo.TB_DIM_ITEM_HIERARCHY_NODE_MEMBER (ITEM_URN, ITEM_TYPE_URN, HIERARCHY_NODE_URN, PRECEDENCE)
                SELECT @NewItemSurrogateUrn, @ItemTypeUrn, HIERARCHY_NODE_URN, PRECEDENCE
                FROM dbo.TB_DIM_ITEM_HIERARCHY_NODE_MEMBER
                WHERE ITEM_URN = @ItemSurrogateUrn    
                AND ITEM_TYPE_URN = @ItemTypeUrn;
                
                SELECT @ReturnCode = @@ERROR;
                IF @ReturnCode <> 0
                BEGIN 
                    RAISERROR('ap_sch_recursive_associate_disassociate_item_children: Error copying node mappings for the new surrogate for taxonomy item [%d], Error Code: [%d]', 16, 1, @ItemSurrogateUrn, @ReturnCode) WITH LOG;
                    GOTO EXIT_WITH_ERROR;
                END;
                                            
                INSERT INTO @ChangeResultMappingTable (HIERARCHY_CHANGE_ID, ITEM_TYPE_ID, ITEM_BUSINESS_URN, EFFECTIVE_FROM, EFFECTIVE_TO)
                SELECT     @HierarchyChangeId,
                        ITEM_TYPE_ID,
                        ITEM_BIZ_URN,
                        EFFECTIVE_FROM,
                        EFFECTIVE_TO
                FROM dbo.VW_DIM_ITEM 
                WHERE ITEM_URN = @NewItemSurrogateUrn
                AND ITEM_TYPE_URN = @ItemTypeUrn                
                OPTION(RECOMPILE);
            END;
            
            DELETE @AssociatedItems WHERE ITEM_URN = @ItemSurrogateUrn;
        END;
        
        IF @IsPastChange = 1
        BEGIN 
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
                RAISERROR('ap_sch_recursive_associate_disassociate_item_children: Error inserting hierarchy change result data. Error[%d]', 16, 1, @ReturnCode) WITH LOG;
                GOTO EXIT_WITH_ERROR;
            END;
        END;
        
        -- Type 2 all the items of the same item type assocated with all the child nodes
        WHILE EXISTS(SELECT * FROM @ChildNodesTable)
        BEGIN 
            DECLARE @ChildNodeUrn INT;
            SELECT TOP 1 @ChildNodeUrn = ITEM_URN
            FROM @ChildNodesTable
            ORDER BY [ITEM_URN];

            exec @ReturnCode = dbo.ap_sch_recursive_associate_disassociate_item_children @SessionId, @HierarchyChangeId, @ChildNodeUrn, @ItemTypeUrn, @EffectiveFrom, @IgnoreConsolidationPeriod;
            
            IF @ReturnCode <> 0
            BEGIN 
                GOTO EXIT_WITH_ERROR;
            END;
            
            DELETE @ChildNodesTable WHERE ITEM_URN = @ChildNodeUrn;
        END;
        
    IF @InitialTransactionCount = 0 
    BEGIN 
           COMMIT TRANSACTION AssDisChildTransaction;
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
