SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_imp01_olap_clean_summarized_data_m2m_legacy] (@I_ParentObjectName VARCHAR(50), @I_ObjectName VARCHAR(128)) 
AS
BEGIN 
    SET NOCOUNT ON;
    DECLARE @v_Error INT = 0, @InitialTransactionCount INT = @@TRANCOUNT, 
    @v_OlapObjectURN INT, @v_PrimaryTable VARCHAR(128), @v_Sql NVARCHAR(MAX);
    BEGIN TRANSACTION CleanOlapTransactionM2M;
        BEGIN TRY;
            SELECT @v_OlapObjectURN = [OLAP_OBJECT_URN], @v_PrimaryTable = [PRIMARY_TABLE]
            FROM [dbo].[TB_ADM_OLAP_OBJECT]
            WHERE [PARENT_OLAP_OBJECT_NAME] = @I_ParentObjectName AND [OLAP_OBJECT_NAME] = @I_ObjectName;

            SET @v_Sql = 'DELETE [dbo].[TS_IMP_SUMMARIZED]' + CHAR(13) + CHAR(10) +
                         'WHERE [OLAP_OBJECT_URN] = ' + CAST(@v_OlapObjectURN AS VARCHAR(30)) + ';';

            EXECUTE sp_executesql @v_Sql;

            IF @InitialTransactionCount = 0 
            BEGIN 
               COMMIT TRANSACTION CleanOlapTransactionM2M;
            END;
            ELSE BEGIN 
                WHILE @@TRANCOUNT > @InitialTransactionCount
                BEGIN 
                    COMMIT TRANSACTION;
                END;
            END;
         END TRY
         BEGIN CATCH;
            DECLARE @ErrorMessage VARCHAR(200) = '['+OBJECT_NAME(@@PROCID)+']' + ISNULL(': ' + ERROR_MESSAGE(),'');
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

    RETURN @v_Error;
END;
GO
GRANT EXECUTE
	ON [dbo].[ap_imp01_olap_clean_summarized_data_m2m_legacy]
	TO [portalapp_role]
GO
