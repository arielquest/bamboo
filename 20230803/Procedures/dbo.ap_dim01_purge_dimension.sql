SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_dim01_purge_dimension] (@ItemUrn AS INT, @ItemTypeUrn AS INT, @PurgeLaterSurrogates AS BIT = 0) AS
BEGIN 
    SET NOCOUNT ON;
    DECLARE @ErrorCode INT = 0, @InitialTransactionCount INT = @@TRANCOUNT,
    @TableName NVARCHAR(255), @Sql NVARCHAR(255), @MemberUrn INT, @SurrogateItemUrn INT, @EffectiveFrom DATETIME,
    @MemberTypeUrn INT, @ErrorMessage NVARCHAR(200);

    DECLARE @MembersToPurge TABLE (MEMBER_URN INT, MEMBER_TYPE_URN INT);
    DECLARE @AllSurrogates TABLE (ITEM_URN INT, EFFECTIVE_FROM DATETIME);

    BEGIN TRANSACTION PurgeDimensionTransaction;
    
    BEGIN TRY;
        -- Recursivly call this sproc to delete surrogates
        IF @PurgeLaterSurrogates = 1
        BEGIN 
            INSERT INTO @AllSurrogates
            SELECT s.ITEM_URN, s.EFFECTIVE_FROM
            FROM VW_DIM_ITEM i
            JOIN VW_DIM_ITEM s
            ON s.ITEM_BIZ_URN = i.ITEM_BIZ_URN
            WHERE i.ITEM_URN = @ItemUrn
            AND i.ITEM_TYPE_URN = @ItemTypeUrn
            AND s.ITEM_TYPE_URN = @ItemTypeUrn
            OPTION (RECOMPILE);            
                
            SELECT @EffectiveFrom = EFFECTIVE_FROM FROM @AllSurrogates WHERE ITEM_URN = @ItemUrn;
            
            WHILE EXISTS (SELECT 1 FROM @AllSurrogates WHERE EFFECTIVE_FROM >= @EffectiveFrom)
            BEGIN                 
                SELECT TOP 1 @SurrogateItemUrn = ITEM_URN FROM @AllSurrogates WHERE EFFECTIVE_FROM >= @EffectiveFrom ORDER BY EFFECTIVE_FROM DESC;
                
                BEGIN TRY;
                    -- Purge the surrogate
                    EXEC dbo.ap_dim01_purge_dimension @ItemUrn = @SurrogateItemUrn, @ItemTypeUrn = @ItemTypeUrn, @PurgeLaterSurrogates = 0
                END TRY
                BEGIN CATCH;
                    SELECT @ErrorCode = ERROR_NUMBER(), @ErrorMessage = ERROR_MESSAGE();
                    RAISERROR('Error purging surrogate data [%d, %s]', 16, 1, @ErrorCode, @ErrorMessage);
                END CATCH; 
        
                DELETE @AllSurrogates WHERE ITEM_URN = @SurrogateItemUrn;
            END;
        END;
        ELSE BEGIN 
            -- First delete any memberships   
            INSERT INTO @MembersToPurge (MEMBER_URN, MEMBER_TYPE_URN)
            SELECT MEMBER_URN, MEMBER_TYPE_URN
            FROM dbo.VW_DIM_MEMBER
            WHERE (PARENT_ITEM_BIZ_URN = @ItemUrn AND PARENT_ITEM_TYPE_URN = @ItemTypeUrn) OR 
            (CHILD_ITEM_BIZ_URN = @ItemUrn AND CHILD_ITEM_TYPE_URN = @ItemTypeUrn)
            OPTION (RECOMPILE);
        
            WHILE EXISTS (SELECT 1 FROM @MembersToPurge)
            BEGIN 
                SELECT TOP 1 @MemberUrn = MEMBER_URN, @MemberTypeUrn = MEMBER_TYPE_URN
                FROM @MembersToPurge
                ORDER BY [MEMBER_URN];
                
                BEGIN TRY;
                    -- Purge the member
                    EXEC dbo.ap_dim01_purge_member @MemberUrn = @MemberUrn, @MemberTypeUrn = @MemberTypeUrn, @PurgeLaterSurrogates = 1;
                END TRY
                BEGIN CATCH;
                    SELECT @ErrorCode = ERROR_NUMBER(), @ErrorMessage = ERROR_MESSAGE();
                    RAISERROR('Error purging member data [%d, %s]', 16, 1, @ErrorCode, @ErrorMessage);
                END CATCH; 
        
                DELETE @MembersToPurge WHERE MEMBER_URN = @MemberUrn AND MEMBER_TYPE_URN = @MemberTypeUrn;
            END;
            
            -- Delete non standard memberships
            BEGIN TRY;
                -- TB_DIM_ITEM_HIERARCHY_NODE_MEMBER
                DELETE dbo.TB_DIM_ITEM_HIERARCHY_NODE_MEMBER
                WHERE (ITEM_URN = @ItemUrn AND ITEM_TYPE_URN = @ItemTypeUrn) OR 
                      (HIERARCHY_NODE_URN = @ItemUrn AND @ItemTypeUrn = 50); -- IT_HIERARCHY_NODE
            END TRY
            BEGIN CATCH;
                SELECT @ErrorCode = ERROR_NUMBER(), @ErrorMessage = ERROR_MESSAGE();
                RAISERROR('Error purging item hierarchy member data [%d, %s]', 16, 1, @ErrorCode, @ErrorMessage);
            END CATCH;
        
            BEGIN TRY;
                -- TB_DIM_CATEGORY_MAP
                DELETE dbo.TB_DIM_CATEGORY_MAP
                WHERE (ITEM_BIZ_URN = @ItemUrn AND ITEM_TYPE_URN = @ItemTypeUrn) OR 
                      (CATEGORY_BIZ_URN = @ItemUrn AND @ItemTypeUrn = 14); -- IT_CATEGORY
            END TRY
            BEGIN CATCH;
                SELECT @ErrorCode = ERROR_NUMBER(), @ErrorMessage = ERROR_MESSAGE();
                RAISERROR('Error purging category map data [%d, %s]', 16, 1, @ErrorCode, @ErrorMessage);
            END CATCH;
            
            BEGIN TRY;
                -- TB_CLU_RESOURCE_FOLDER_ITEM_MAPPING
                DELETE dbo.TB_CLU_RESOURCE_FOLDER_ITEM_MAPPING
                WHERE (ITEM_BIZ_URN = @ItemUrn AND ITEM_TYPE_URN = @ItemTypeUrn);                    
            END TRY
            BEGIN CATCH;
                SELECT @ErrorCode = ERROR_NUMBER(), @ErrorMessage = ERROR_MESSAGE();
                RAISERROR('Error purging cluster resource folder item mapping data [%d, %s]', 16, 1, @ErrorCode, @ErrorMessage);
            END CATCH;            
            
            -- Get the table name
            SELECT @TableName = TABLE_NAME
            FROM dbo.TE_DIM_ITEM_TYPE
            WHERE ITEM_TYPE_URN = @ItemTypeUrn;
        
            -- Delete item from PKEY_MAP
            SET @Sql = N'DELETE FROM [' + @TableName + '_PKEY_MAP] WHERE ITEM_BIZ_URN = ' + CAST(@ItemUrn AS NVARCHAR(12));
            
            BEGIN TRY;
                EXEC sp_executesql @Sql;
            END TRY
            BEGIN CATCH;
                SELECT @ErrorCode = ERROR_NUMBER(), @ErrorMessage = ERROR_MESSAGE()
                RAISERROR('Error purging pkey map [%d, %s]', 16, 1, @ErrorCode, @ErrorMessage);
            END CATCH;
        
            -- Delete from the dimension table
            SET @Sql = N'DELETE FROM [' + @TableName + '] WHERE ITEM_URN = ' + CAST(@ItemUrn AS NVARCHAR(12));
        
            BEGIN TRY;
                EXEC sp_executesql @Sql;
            END TRY
            BEGIN CATCH;
                SELECT @ErrorCode = ERROR_NUMBER(), @ErrorMessage = ERROR_MESSAGE();
                RAISERROR('Error purging item record [%d, %s]', 16, 1, @ErrorCode, @ErrorMessage);
            END CATCH;
        END;
        
        IF @InitialTransactionCount = 0 
        BEGIN 
           COMMIT TRANSACTION PurgeDimensionTransaction;
        END;
        ELSE BEGIN 
            WHILE @@TRANCOUNT > @InitialTransactionCount
            BEGIN 
                COMMIT TRANSACTION;
            END;
        END;

    END TRY
    BEGIN CATCH;
        SELECT @ErrorMessage = OBJECT_NAME(@@PROCID)+ISNULL(': '+ERROR_MESSAGE(),'');
        -- Did we initiate all transactions
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
        END;
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH;

    RETURN @ErrorCode;
END;
GO
GRANT EXECUTE
	ON [dbo].[ap_dim01_purge_dimension]
	TO [portalapp_role]
GO
