SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[tr_rep_report_inserted_updated] ON [dbo].[TB_REP_REPORT]
FOR INSERT, UPDATE
NOT FOR REPLICATION
AS
    SET NOCOUNT ON;
    
     DECLARE @error INT,
             @trancount AS INTEGER;
     
     SET @trancount = @@TRANCOUNT;
     
    IF UPDATE(FOLDER_ID) OR UPDATE(NAME)
    BEGIN
        IF EXISTS(SELECT [f].[FOLDER_ID] 
                  FROM [dbo].[TB_SEC_FOLDER] AS f
                  WHERE [f].[PATH] IN (SELECT [f1].[PATH]+'/'+[i].[NAME]
                                   FROM inserted AS i 
                                   JOIN [dbo].[TB_SEC_FOLDER] AS f1 ON [i].[FOLDER_ID] = [f1].[FOLDER_ID])
                  AND [f].[DELETED] = 0
                  )
        BEGIN
            RAISERROR(60031, 16, 1);        
            ROLLBACK TRANSACTION;            
            RETURN;
        END;              

        IF EXISTS(SELECT *
                  FROM inserted AS i                  
                  JOIN [dbo].[TB_SEC_FOLDER] AS f ON [i].[FOLDER_ID] = [f].[FOLDER_ID]                  
                  JOIN [dbo].[TB_SEC_USER] AS u ON [u].[FOLDER_ID] = [i].[FOLDER_ID] AND [u].[LOGIN_NAME] = [i].[NAME]                  
                  AND [u].[DELETED] = 0
                  )
        BEGIN
            RAISERROR(60034, 16, 1);
            ROLLBACK TRANSACTION;            
            RETURN;
        END;           
        
        UPDATE [dbo].[TB_REP_REPORT] SET CONTENT_PATH = [f].[PATH]+'/'+[r].[NAME]
        FROM [dbo].[TB_SEC_FOLDER] f
        JOIN inserted r ON [r].[FOLDER_ID] = [f].[FOLDER_ID] 
        LEFT JOIN [dbo].[TB_REP_REPORT] AS r2 ON [r2].[REPORT_ID] = [r].[REPORT_ID];
        SELECT @error = @@ERROR;
        IF @error <> 0
        BEGIN
            ROLLBACK TRANSACTION;
            RETURN;
        END;
    END;
GO
EXEC sp_settriggerorder @triggername= '[dbo].[tr_rep_report_inserted_updated]', @order='Last', @stmttype='INSERT'
GO
