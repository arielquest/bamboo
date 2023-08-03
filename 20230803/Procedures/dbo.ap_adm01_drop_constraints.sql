SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_adm01_drop_constraints] AS
BEGIN 
    SET NOCOUNT ON;

    DECLARE @error INT, @sql NVARCHAR(MAX), @InitialTransactionCount INT = @@TRANCOUNT, @ErrorMessage VARCHAR(200);

    BEGIN TRANSACTION DropConstTransaction;
    
        BEGIN TRY;

            SELECT @sql = COALESCE(@sql + ';', N'') + 
            N'IF EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(''' + CONSTRAINT_NAME + ''') AND OBJECTPROPERTY(id, ''IsForeignKey'') = 1)' + CHAR(13) + CHAR(10) +
            'ALTER TABLE [' + [SOURCE_SCHEMA_NAME]+N'].['+[SOURCE_TABLE_NAME] + N'] DROP CONSTRAINT [' + CONSTRAINT_NAME + N']'
            FROM dbo.TS_ADM_CONSTRAINTS;

            EXEC @error = sp_executesql @sql;

            IF @error <> 0
            BEGIN 
                RAISERROR (50100, 16, 1, @error, 'ap_adm01_drop_constraints', NULL);
            END;
            
            IF @InitialTransactionCount = 0 
            BEGIN 
               COMMIT TRANSACTION DropConstTransaction;
            END;
            ELSE BEGIN 
                WHILE @@TRANCOUNT > @InitialTransactionCount
                BEGIN 
                    COMMIT TRANSACTION;
                END;
             END;
            
        END TRY
    
        BEGIN CATCH;
            SET @ErrorMessage = ERROR_MESSAGE();
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
            END;
            RAISERROR(@ErrorMessage, 16, 1) WITH LOG;
        END CATCH;

    RETURN @error;
END;
GO
