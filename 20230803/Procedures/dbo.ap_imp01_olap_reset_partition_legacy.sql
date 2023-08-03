SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_imp01_olap_reset_partition_legacy] (@I_ParentObjectName VARCHAR(50), @I_ObjectName VARCHAR(128), 
@I_DateUrns VARCHAR(200) = NULL /*If DateUrns are not not passed then the entire measure group has to be reset.*/) AS

SET NOCOUNT ON;

DECLARE @v_Error INT = 0, @InitialTransactionCount INT = @@TRANCOUNT, 
@v_OlapObjectURN INT, @v_PrimaryTable VARCHAR(128), @v_Sql NVARCHAR(MAX);

BEGIN TRANSACTION ResetOlapTransaction;

    BEGIN TRY;
        SELECT @v_OlapObjectURN = [OLAP_OBJECT_URN], @v_PrimaryTable = [PRIMARY_TABLE]
        FROM [dbo].[TB_ADM_OLAP_OBJECT]
        WHERE [PARENT_OLAP_OBJECT_NAME] = @I_ParentObjectName AND [OLAP_OBJECT_NAME] = @I_ObjectName;

        SELECT @v_Sql = 'INSERT INTO [dbo].[TS_IMP_SUMMARIZED]' + CHAR(13) + CHAR(10) +
                        '([OLAP_OBJECT_URN],[PRIMARY_TABLE],[ROW_URN],[ACTION],[STATUS])' + CHAR(13) + CHAR(10) +
                        'SELECT ' + '''' + CAST(@v_OlapObjectURN AS VARCHAR(30)) + '''' + ', ' + CHAR(13) + CHAR(10) +
                        '''' + CAST(@v_PrimaryTable AS VARCHAR(255)) + '''' + ', ' + CHAR(13) + CHAR(10) +
                        '[FACT_URN], ''I'', 0 FROM [dbo].[' + @v_PrimaryTable + ']  AS pt ' +
                        CASE WHEN @I_DateUrns IS NOT NULL THEN CHAR(13) + CHAR(10) + 'WHERE pt.[STARTDATE_URN] IN (' + @I_DateUrns + ');' ELSE ';' END;
        
        EXECUTE sp_executesql @v_Sql;

        IF @InitialTransactionCount = 0 
        BEGIN 
           COMMIT TRANSACTION ResetOlapTransaction;
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
GO
GRANT EXECUTE
	ON [dbo].[ap_imp01_olap_reset_partition_legacy]
	TO [portalapp_role]
GO
