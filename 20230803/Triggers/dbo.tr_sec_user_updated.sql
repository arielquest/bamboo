SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[tr_sec_user_updated] ON [dbo].[TB_SEC_USER] FOR UPDATE NOT FOR REPLICATION AS
    BEGIN 
        SET NOCOUNT ON;

        DECLARE @userid UNIQUEIDENTIFIER ,
                @ownerid UNIQUEIDENTIFIER ,
                @loginname NVARCHAR(50),
                @clouddeployed bit = 0;

        SELECT @loginname = [LOGIN_NAME] FROM inserted;
        SELECT @userid = [USER_ID] FROM inserted;
        SELECT @ownerid = [OWNER_ID] FROM inserted;
        
        SELECT @clouddeployed = CONVERT(BIT,PROPERTY_VALUE)
        FROM dbo.TB_ADM_PROPERTY
        WHERE PROPERTY_KEY = 'PROP_CLOUD_DEPLOYED';

        IF @clouddeployed = 1
        BEGIN
            IF ( SELECT  COUNT(*)
                    FROM    dbo.TB_SEC_USER
                    WHERE   [USER_ID] <> @userid
                            AND (
                                    [LOGIN_NAME] = @loginname
                                    AND ((@ownerid IS NOT NULL AND [OWNER_ID] = @ownerid) OR (@ownerid IS NULL AND [OWNER_ID] IS NULL))
                                    AND [DELETED] = 0
                                    AND [USER_TYPE] = 'U'
                                 )) > 1
            BEGIN 
                RAISERROR (50200, 16, 1, @loginname, 'tr_sec_user_updated', 'Trigger');
                ROLLBACK TRANSACTION;
                RETURN;
            END;
        END
        ELSE
        BEGIN
            IF ( SELECT  COUNT(*)
                    FROM    dbo.TB_SEC_USER
                    WHERE   [USER_ID] <> @userid
                            AND   (
                                        [LOGIN_NAME] = @loginname
                                        AND [DELETED] = 0
                                        AND [USER_TYPE] = 'U'
                                    )) > 1
            BEGIN 
                RAISERROR (50200, 16, 1, @loginname, 'tr_sec_user_updated', 'Trigger');
                ROLLBACK TRANSACTION;
                RETURN;
            END;
        END

    END;
GO
