SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_dim01_purge_member] (@MemberUrn INT, @MemberTypeUrn INT, @PurgeLaterSurrogates AS BIT = 0)
AS
BEGIN 
    SET NOCOUNT ON;

    DECLARE @TableName NVARCHAR(255), @SurrogateMemberUrn INT, @EffectiveFrom DATETIME,
    @Sql AS NVARCHAR(255), @ErrorCode INT = 0, @ErrorMessage VARCHAR(200), @InitialTransactionCount INT = @@TRANCOUNT;

    DECLARE @AllSurrogates TABLE (MEMBER_URN INT, EFFECTIVE_FROM DATETIME);
    
    IF @InitialTransactionCount = 0 
    BEGIN 
        BEGIN TRANSACTION PurgeMemberTransaction;
    END;
    ELSE BEGIN 
        SAVE TRANSACTION PurgeMemberTransaction;
    END;
    BEGIN TRY;
        IF @PurgeLaterSurrogates = 1
        BEGIN 
            INSERT INTO @AllSurrogates
            SELECT s.MEMBER_URN, s.EFFECTIVE_FROM
            FROM VW_DIM_MEMBER i
            INNER JOIN VW_DIM_MEMBER s ON s.MEMBER_BIZ_URN = i.MEMBER_BIZ_URN
            WHERE i.MEMBER_URN = @MemberUrn
            AND i.MEMBER_TYPE_URN = @MemberTypeUrn
            AND s.MEMBER_TYPE_URN = @MemberTypeUrn
            OPTION (RECOMPILE);            
                
            SELECT @EffectiveFrom = EFFECTIVE_FROM FROM @AllSurrogates WHERE MEMBER_URN = @MemberUrn;
            
            WHILE EXISTS (SELECT 1 FROM @AllSurrogates WHERE EFFECTIVE_FROM >= @EffectiveFrom)
            BEGIN                 
                SELECT TOP 1 @SurrogateMemberUrn = MEMBER_URN FROM @AllSurrogates WHERE EFFECTIVE_FROM >= @EffectiveFrom ORDER BY EFFECTIVE_FROM DESC;
                
                BEGIN TRY;
                    -- Purge the surrogate
                    EXEC dbo.ap_dim01_purge_member @MemberUrn = @SurrogateMemberUrn, @MemberTypeUrn = @MemberTypeUrn, @PurgeLaterSurrogates = 0;
                END TRY
                BEGIN CATCH;
                    SELECT @ErrorCode = ERROR_NUMBER(), @ErrorMessage = ERROR_MESSAGE();
                    RAISERROR('Error purging surrogate data [%d, %s]', 16, 1, @ErrorCode, @ErrorMessage);
                END CATCH; 
        
                DELETE @AllSurrogates WHERE MEMBER_URN = @SurrogateMemberUrn;
            END;
        END;
        ELSE
        BEGIN 
            -- Get the table name
            SELECT @TableName = TABLE_NAME
            FROM dbo.TE_DIM_MEMBER_TYPE
            WHERE MEMBER_TYPE_URN = @MemberTypeUrn;

            -- Delete member from PKEY_MAP
            SET @Sql = N'DELETE FROM ' + @TableName + '_PKEY_MAP WHERE MEMBER_BIZ_URN = ' + CAST(@MemberUrn AS NVARCHAR(12));

            EXECUTE sp_executesql @Sql;

            SELECT @ErrorCode = @@ERROR;

            IF @ErrorCode <> 0
            BEGIN 
                RAISERROR ('Error purging member pkey map data', 16, 1);
            END;

            -- Delete from the member table
            SET @Sql = N'DELETE FROM ' + @TableName + ' WHERE MEMBER_URN = ' + CAST(@MemberUrn AS NVARCHAR(12));

            EXECUTE sp_executesql @Sql;

            SELECT @ErrorCode = @@ERROR;

            IF @ErrorCode <> 0
            BEGIN 
                RAISERROR ('Error purging member data', 16, 1);
            END;
        END;
        
        IF @InitialTransactionCount = 0 
        BEGIN 
           COMMIT TRANSACTION PurgeMemberTransaction;
        END;
        ELSE
        BEGIN 
            WHILE @@TRANCOUNT > @InitialTransactionCount
            BEGIN 
                COMMIT TRANSACTION;
            END;
        END;
    END TRY
    BEGIN CATCH;
        SELECT @ErrorMessage = OBJECT_NAME(@@PROCID)+ISNULL(': '+ERROR_MESSAGE(),''),
               @ErrorCode = CASE WHEN @ErrorCode <> 0 THEN @ErrorCode ELSE @@ERROR END;

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
            SET @ErrorMessage = ISNULL(@ErrorMessage,OBJECT_NAME(@@PROCID));
            RAISERROR(@ErrorMessage, 16, 1) WITH LOG;
        END;
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH;
END;
GO
GRANT EXECUTE
	ON [dbo].[ap_dim01_purge_member]
	TO [portalapp_role]
GO
