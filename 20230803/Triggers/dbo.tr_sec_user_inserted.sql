SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER tr_sec_user_inserted ON dbo.TB_SEC_USER FOR INSERT NOT FOR REPLICATION AS
    BEGIN 
        SET NOCOUNT ON;

        DECLARE @error INT ,
                @everyone UNIQUEIDENTIFIER ,
                @userid UNIQUEIDENTIFIER ,
                @ownerid UNIQUEIDENTIFIER ,
                @loginname NVARCHAR(50),
                @clouddeployed bit = 0;
        
        SELECT @loginname = [LOGIN_NAME] FROM inserted;
        SELECT @ownerid = [OWNER_ID] FROM inserted;

        SELECT  @everyone = USER_ID
        FROM    dbo.TB_SEC_USER
        WHERE   LOGIN_NAME = 'Everyone'
                AND USER_TYPE = 'G'
                AND SYSTEM = 1;

        IF @everyone IS NULL
        BEGIN 
            RAISERROR (50207, 16, 1, 'Everyone', 'tr_sec_user_inserted', 'Trigger');
            ROLLBACK TRANSACTION;
            RETURN;
        END;

        SELECT @clouddeployed = CONVERT(BIT,PROPERTY_VALUE)
        FROM dbo.TB_ADM_PROPERTY
        WHERE PROPERTY_KEY = 'PROP_CLOUD_DEPLOYED';

        IF @clouddeployed = 1
        BEGIN
            IF ( SELECT COUNT(*)
                    FROM    dbo.TB_SEC_USER
                    WHERE   (
                                [LOGIN_NAME] = @loginname
                                AND ((@ownerid IS NOT NULL AND [OWNER_ID] = @ownerid) OR (@ownerid IS NULL AND [OWNER_ID] IS NULL))
                                AND [DELETED] = 0
                                AND [USER_TYPE] = 'U'
                            )) > 1
            BEGIN 
                RAISERROR (50200, 16, 1, @loginname, 'tr_sec_user_inserted', 'Trigger');
                ROLLBACK TRANSACTION;
                RETURN;
            END;
        END
        ELSE
        BEGIN
            IF ( SELECT  COUNT(*)
                        FROM    dbo.TB_SEC_USER
                        WHERE   (
                                    [LOGIN_NAME] = @loginname
                                    AND [DELETED] = 0
                                    AND [USER_TYPE] = 'U'
                                )) > 1
            BEGIN 
                RAISERROR (50200, 16, 1, @loginname, 'tr_sec_user_inserted', 'Trigger');
                ROLLBACK TRANSACTION;
                RETURN;
            END;
        END

        INSERT INTO dbo.TB_SEC_GROUP_MEMBER ( PARENT_ID , CHILD_ID )
        SELECT  @everyone, USER_ID
        FROM    dbo.TB_SEC_USER
        WHERE   USER_TYPE = 'U' AND USER_ID IN ( SELECT USER_ID
                                                 FROM inserted );

        EXEC @error = dbo.ap_sec_calc_group_members 'Trigger';

        IF @error <> 0
        BEGIN 
            ROLLBACK TRANSACTION;
            RETURN;
        END;
    END;
GO
