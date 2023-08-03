SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_adm01_reseed_table]
(
    @ReplicationTypeFilter AS CHAR(1) = NULL    
) AS
BEGIN 
    SET NOCOUNT ON;
    DECLARE @SEED INT, @ERROR_SEED INT, @SQL NVARCHAR(MAX), @InitialTransactionCount INT = @@TRANCOUNT;

    BEGIN TRANSACTION ReseedTransaction;
    
        BEGIN TRY;
            SELECT @ERROR_SEED = COUNT(*)
            FROM (SELECT SEED
                  FROM TB_ADM_SEED
                  GROUP BY SEED) a;

            IF @ERROR_SEED <> 1
            BEGIN 
                SET @ERROR_SEED = -1;
                RAISERROR ('ap_adm01_reseed_table: Unable to determine server seed. Error: [%d]', 16, 1, @@ERROR) WITH LOG;
            END;
            ELSE BEGIN 
                SET @ERROR_SEED = 0;
            END;

            SELECT @SEED = SEED
            FROM TB_ADM_SEED;

            IF @SEED <> '-1'
            BEGIN 
                SELECT @SQL = COALESCE(@SQL + ';', '') + N'' + CHAR(13) + CHAR(10) +
                'SELECT @v_MaxUrn = ISNULL(MAX([' + b.COLUMN_NAME + ']),1)' + CHAR(13) + CHAR(10) +
                'FROM [' + b.TABLE_SCHEMA + '].[' + a.TABLE_NAME + '];' + CHAR(13) + CHAR(10) +
                'IF 4 * (@v_MaxUrn / 4) + ' + CONVERT(VARCHAR(5), @SEED) + ' > @v_MaxUrn' + CHAR(13) + CHAR(10) +
                'BEGIN ' + CHAR(13) + CHAR(10) +
                     'SET @v_Reseed = 4 * (@v_MaxUrn / 4) + ' + CONVERT(VARCHAR(5), @SEED) + ';' + CHAR(13) + CHAR(10) + 
                'END;' + CHAR(13) + CHAR(10) +
                'ELSE' + CHAR(13) + CHAR(10) +
                'BEGIN ' + CHAR(13) + CHAR(10) +
                     'SET @v_Reseed = 4 * ((@v_MaxUrn / 4) + 1) + ' + CONVERT(VARCHAR(5), @SEED) + ';' + CHAR(13) + CHAR(10) + 
                'END;' + CHAR(13) + CHAR(10) +
                'DBCC CHECKIDENT (' + a.TABLE_NAME + ', RESEED, @v_Reseed)'
                FROM (SELECT SYSOBJECT_NAME AS TABLE_NAME
                      FROM [dbo].[TB_ADM_TABLE]
                      WHERE [RESEED] = 1
                      AND (@ReplicationTypeFilter IS NULL OR [REPLICATED] = @ReplicationTypeFilter)) a
                LEFT OUTER JOIN (SELECT COLUMN_NAME, DATA_TYPE, TABLE_NAME, TABLE_SCHEMA
                                 FROM INFORMATION_SCHEMA.COLUMNS) b ON a.TABLE_NAME = b.TABLE_NAME
                WHERE COLUMNPROPERTY(OBJECT_ID(a.TABLE_NAME), b.COLUMN_NAME, 'IsIdentity') = 1;

                SET @SQL = N'DECLARE @v_MaxUrn BIGINT, @v_Reseed BIGINT ' + @SQL;

                EXEC sp_executesql @SQL;
            END;
            ELSE BEGIN 
                SET @ERROR_SEED = 0;
            END;
            IF @InitialTransactionCount = 0 
            BEGIN 
               COMMIT TRANSACTION ReseedTransaction;
            END;
            ELSE BEGIN 
            WHILE @@TRANCOUNT > @InitialTransactionCount
            BEGIN 
                COMMIT TRANSACTION;
            END;
        END;
        END TRY
        BEGIN CATCH;
            SET @ERROR_SEED = CASE WHEN @ERROR_SEED <> -1 THEN @@ERROR ELSE @ERROR_SEED END;
            IF @InitialTransactionCount = 0 AND @@TRANCOUNT > 0
            BEGIN 
                ROLLBACK TRANSACTION;
            END;
            ELSE IF @InitialTransactionCount <> 0 AND @@TRANCOUNT > @InitialTransactionCount
            BEGIN 
                IF (XACT_STATE()) = -1
                BEGIN 
                    DECLARE @ErrorMessage VARCHAR(200);
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
            RAISERROR ('ap_adm01_reseed_table: Failed to execute reseed query for table. Error: [%d]', 16, 1, @@ERROR) WITH LOG;
        END CATCH;

    RETURN @ERROR_SEED;      
END;
GO
