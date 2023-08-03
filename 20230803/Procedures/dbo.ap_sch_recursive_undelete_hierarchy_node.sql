SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE dbo.ap_sch_recursive_undelete_hierarchy_node
(
    @SessionId AS UNIQUEIDENTIFIER,
    @ItemUrn AS INT    
) AS
    SET NOCOUNT ON;
    
    DECLARE @ItemBusinessUrn AS INT,
            @ItemEffectiveTo AS DATETIME,
            @SessionUserId AS UNIQUEIDENTIFIER,
            @InitialTransactionCount AS INT,
            @UtcNow AS DATETIME,
            @ReturnCode AS INT;
    
    SET @InitialTransactionCount = @@TRANCOUNT;
    SET @UtcNow = DATEADD(ms, -(DATEPART(ms, GETUTCDATE())), GETUTCDATE());
    SET @ReturnCode = 0;
    
    -- Check Session Id
    IF @SessionId IS NULL
    BEGIN 
        SET @ReturnCode = 50157;
        RAISERROR(50157, 16, 5, 'ap_sch_recursive_undelete_hierarchy_node');
        RETURN @ReturnCode;
    END;
    
    -- Retrieve user information
    SELECT @SessionUserId = USER_ID 
    FROM dbo.TB_SEC_USER
    WHERE GETUTCDATE() BETWEEN EFFECTIVE_FROM AND EFFECTIVE_TO
    AND LOGIN_NAME = (SELECT SESSION_USER_NAME FROM dbo.TB_ADM_SESSION WHERE SESSION_ID = @SessionId);
    
    SELECT     @ItemBusinessUrn = ITEM_BIZ_URN,
            @ItemEffectiveTo = EFFECTIVE_TO 
    FROM dbo.VW_DIM_HIERARCHY_NODE 
    WHERE ITEM_URN = @ItemUrn;
    
    DECLARE @ChildrenTable AS TABLE
    (
        ITEM_URN INT            
    );
    
    BEGIN TRANSACTION SchUDelTransaction;
    
        
        UPDATE dbo.TB_DIM_HIERARCHY_NODE SET 
                EFFECTIVE_TO = 65535, -- 2079-06-06 00:00:00.000 = 65535
                DELETED = 0,
                LATEST = 1,
                MODIFIED_DATE = @UtcNow,
                MODIFIED_BY_ID = @SessionUserId
        WHERE ITEM_URN = @ItemUrn;
        
        SELECT @ReturnCode = @@ERROR;
        IF @ReturnCode <> 0
        BEGIN 
            RAISERROR('ap_sch_recursive_undelete_hierarchy_node: Error while un-deleting node. Error[%d]', 16, 1, @ReturnCode) WITH LOG;
            GOTO EXIT_WITH_ERROR;
        END;
        
        DECLARE @TempItemUrn INT,
                @ChildItemUrn INT;

        -- Get all the children for the current item
        INSERT INTO @ChildrenTable (ITEM_URN)
        SELECT ITEM_URN FROM dbo.VW_DIM_HIERARCHY_NODE 
        WHERE HIERARCHY_PARENT_URN = @ItemUrn
        AND @ItemEffectiveTo BETWEEN EFFECTIVE_FROM AND EFFECTIVE_TO;
            
        WHILE EXISTS(SELECT * FROM @ChildrenTable)
        BEGIN 
            SELECT TOP 1 @ChildItemUrn = ITEM_URN 
            FROM @ChildrenTable
            ORDER BY [ITEM_URN];
            
            SET @TempItemUrn = @ChildItemUrn;
            
            exec @ReturnCode = dbo.ap_sch_recursive_undelete_hierarchy_node @SessionId, @TempItemUrn;
            
            IF @ReturnCode <> 0
            BEGIN 
                GOTO EXIT_WITH_ERROR;
            END;
            DELETE @ChildrenTable WHERE ITEM_URN = @TempItemUrn;
        END;
        
        -- Add all the associations to the node that existed when the node was deleted.        
        INSERT INTO dbo.TB_DIM_ITEM_HIERARCHY_NODE_MEMBER (ITEM_URN, ITEM_TYPE_URN, HIERARCHY_NODE_URN, PRECEDENCE)
        SELECT i2.ITEM_URN, i2.ITEM_TYPE_URN, @ItemUrn, m2.PRECEDENCE
        FROM dbo.VW_DIM_ITEM AS i2
        JOIN (SELECT DISTINCT i.ITEM_BIZ_URN, i.ITEM_TYPE_URN, m.PRECEDENCE
                FROM dbo.VW_DIM_ITEM AS i
                JOIN dbo.TB_DIM_ITEM_HIERARCHY_NODE_MEMBER AS m ON m.ITEM_URN = i.ITEM_URN AND m.ITEM_TYPE_URN = i.ITEM_TYPE_URN
                WHERE m.HIERARCHY_NODE_URN = @ItemUrn) AS m2 ON i2.ITEM_BIZ_URN = m2.ITEM_BIZ_URN AND i2.ITEM_TYPE_URN = m2.ITEM_TYPE_URN
        WHERE NOT EXISTS(SELECT * FROM dbo.TB_DIM_ITEM_HIERARCHY_NODE_MEMBER
                        WHERE HIERARCHY_NODE_URN = @ItemUrn
                        AND ITEM_URN = i2.ITEM_URN
                        AND ITEM_TYPE_URN = i2.ITEM_TYPE_URN
                        AND PRECEDENCE = m2.PRECEDENCE);
        
        SELECT @ReturnCode = @@ERROR;
        IF @ReturnCode <> 0
        BEGIN 
            RAISERROR('ap_sch_recursive_undelete_hierarchy_node: Error while redoing item associations to node. Error[%d]', 16, 1, @ReturnCode) WITH LOG;
            GOTO EXIT_WITH_ERROR;
        END;
        
    IF @InitialTransactionCount = 0 
    BEGIN 
           COMMIT TRANSACTION SchUDelTransaction;
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
