SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE dbo.ap_sch_recursive_purge_hierarchy_node
(
    @SessionId AS UNIQUEIDENTIFIER,
    @ItemUrn AS INT
) AS
    SET NOCOUNT ON;
    DECLARE @ItemBusinessUrn AS INT,
            @ItemEffectiveFrom AS DATETIME,
            @InitialTransactionCount AS INT,
            @ReturnCode AS INT;
    
    SET @InitialTransactionCount = @@TRANCOUNT;
    SET @ReturnCode = 0;
    
    SELECT     @ItemBusinessUrn = ITEM_BIZ_URN,
            @ItemEffectiveFrom = EFFECTIVE_FROM 
    FROM dbo.VW_DIM_HIERARCHY_NODE 
    WHERE ITEM_URN = @ItemUrn;
    
    DECLARE @ChildrenTable AS TABLE
    (
        ITEM_URN INT            
    );
    
    BEGIN TRANSACTION SchPurgeTransaction;
    
        DECLARE @TempItemUrn INT,
                @ChildItemUrn INT;

        -- Get all the children for the current item
        INSERT INTO @ChildrenTable (ITEM_URN)
        SELECT ITEM_URN 
        FROM dbo.VW_DIM_HIERARCHY_NODE 
        WHERE HIERARCHY_PARENT_URN = @ItemUrn;
            
        WHILE EXISTS(SELECT * FROM @ChildrenTable)
        BEGIN 
            SELECT TOP 1 @ChildItemUrn = ITEM_URN 
            FROM @ChildrenTable
            ORDER BY [ITEM_URN];
            
            SET @TempItemUrn = @ChildItemUrn;
            
            exec @ReturnCode = dbo.ap_sch_recursive_purge_hierarchy_node @SessionId, @TempItemUrn;
            
            IF @ReturnCode <> 0
            BEGIN 
                GOTO EXIT_WITH_ERROR;
            END;
                                
            DELETE @ChildrenTable WHERE ITEM_URN = @TempItemUrn;
        END;
        
        -- Get all the furture surrogates of the item and purge them
        INSERT INTO @ChildrenTable (ITEM_URN)
        SELECT ITEM_URN 
        FROM dbo.VW_DIM_HIERARCHY_NODE 
        WHERE ITEM_BIZ_URN = @ItemBusinessUrn
        AND EFFECTIVE_FROM > @ItemEffectiveFrom;
            
        WHILE EXISTS(SELECT * FROM @ChildrenTable)
        BEGIN 
            SELECT TOP 1 @ChildItemUrn = ITEM_URN 
            FROM @ChildrenTable
            ORDER BY [ITEM_URN];
            
            SET @TempItemUrn = @ChildItemUrn;
            
            exec @ReturnCode = dbo.ap_sch_recursive_purge_hierarchy_node @SessionId, @TempItemUrn;
            
            IF @ReturnCode <> 0
            BEGIN 
                GOTO EXIT_WITH_ERROR;
            END;
                                
            DELETE @ChildrenTable WHERE ITEM_URN = @TempItemUrn;
        END;
        
        exec @ReturnCode = dbo.ap_dim01_purge_dimension @ItemUrn, 50; --IT_HIERARCHY_NODE
        
        IF @ReturnCode <> 0
        BEGIN 
            GOTO EXIT_WITH_ERROR;
        END;
    IF @InitialTransactionCount = 0 
    BEGIN 
           COMMIT TRANSACTION SchPurgeTransaction;
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
