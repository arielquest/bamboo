SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_adm01_create_new_session] (@SessionUserName AS NVARCHAR(70) = NULL, @SessionUserId AS UNIQUEIDENTIFIER = NULL, @SessionType AS NVARCHAR(50) = NULL, @SessionComputer AS NVARCHAR(50) = NULL, @SessionClientComputer AS NVARCHAR(50) = NULL, @SessionUserAgent AS NVARCHAR(250) = NULL, @ReuseExistingSession AS BIT = 1, @SessionId AS UNIQUEIDENTIFIER OUTPUT)
AS
DECLARE @v_ExistingSessionId AS UNIQUEIDENTIFIER, @v_SessionUserId AS NVARCHAR(70), @v_SessionTypeId AS UNIQUEIDENTIFIER, @v_Error AS INT = 0, @InitialTransactionCount AS INT = @@TRANCOUNT, @ErrorMessage VARCHAR(1000);

BEGIN TRANSACTION AddSessionTransaction;

BEGIN TRY;
    SET @SessionComputer = COALESCE(@SessionComputer, CAST(SERVERPROPERTY('machinename') AS NVARCHAR(50)));

    IF @SessionId IS NOT NULL
    BEGIN 
        IF EXISTS (
                SELECT 1
                FROM TB_ADM_SESSION
                WHERE SESSION_ID = @SessionId
                )
        BEGIN 
            IF @ReuseExistingSession = 0
            BEGIN
                SET @v_Error = 1;
                RAISERROR (50157, 16, 5, 'ap_adm01_create_new_session');
            END;
            ELSE
            BEGIN
                IF @InitialTransactionCount = 0
                BEGIN 
                    COMMIT TRANSACTION AddSessionTransaction;
                END;
                ELSE BEGIN 
                    WHILE @@TRANCOUNT > @InitialTransactionCount
                    BEGIN 
                        COMMIT TRANSACTION;
                    END;
                END;
                RETURN 0;
            END;
        END;
    END;

    -- Set the session user name
    IF @SessionUserName IS NULL
    BEGIN 
        SET @SessionUserName = 'System';
        SET @SessionUserId = '00000003-0000-0000-0000-000000000006';
    END;

    -- Set the session user id
    IF @SessionUserId IS NULL
    BEGIN 
        SELECT TOP 1 @SessionUserId = USER_ID
        FROM dbo.TB_SEC_USER
        WHERE LOGIN_NAME = @SessionUserName
            AND DELETED = 0
        ORDER BY CREATED_DATE DESC;
    END;

    -- Get the session type id
    IF @SessionType IS NULL
    BEGIN 
        RAISERROR (50155, 16, 5, 'ap_adm01_create_new_session', 'NULL');
    END;

    SELECT @v_SessionTypeId = SESSION_TYPE_ID
    FROM dbo.TE_ADM_SESSION_TYPE
    WHERE INTERNAL_NAME = @SessionType;

    IF @v_SessionTypeId IS NULL
    BEGIN 
        SET @v_Error = 1;
        RAISERROR (50155, 16, 5, 'ap_adm01_create_new_session', @SessionType);
    END;

    IF @ReuseExistingSession = 1
    BEGIN 
        DECLARE @SQL NVARCHAR(MAX) = 'SELECT ' /* Ignore TopOrderBy unit test, checked by CW */ + 
                             'TOP 1 @o_ExistingSessionId = SESSION_ID'+CHAR(13)+CHAR(10)+
                             'FROM dbo.TB_ADM_SESSION'+CHAR(13)+CHAR(10)+
                             'WHERE SESSION_TYPE_ID = @i_SessionTypeId'+CHAR(13)+CHAR(10)+
                             'AND SESSION_COMPUTER = @i_SessionComputer'+CHAR(13)+CHAR(10)+
                             'AND SESSION_USER_NAME = @i_SessionUserName';

        IF @SessionUserId IS NOT NULL
        BEGIN 
            SET @SQL = @SQL +CHAR(13)+CHAR(10)+'AND SESSION_USER_ID = @i_SessionUserId';
        END;

        IF @SessionClientComputer IS NOT NULL
        BEGIN 
            SET @SQL = @SQL +CHAR(13)+CHAR(10)+'AND SESSION_CLIENT_COMPUTER = @i_SessionClientComputer';
        END;

        IF @SessionUserAgent IS NOT NULL
        BEGIN 
            SET @SQL = @SQL +CHAR(13)+CHAR(10)+'AND SESSION_USER_AGENT = @i_SessionUserAgent';
        END;

        SET @SQL = @SQL +CHAR(13)+CHAR(10)+ 'ORDER BY SESSION_ID;';

        EXEC sp_executesql @SQL, 
        N'@i_SessionUserAgent NVARCHAR(250), @i_SessionClientComputer NVARCHAR(50), @i_SessionUserId UNIQUEIDENTIFIER, @i_SessionUserName NVARCHAR(70), @i_SessionComputer NVARCHAR(50), @i_SessionTypeId UNIQUEIDENTIFIER, @o_ExistingSessionId UNIQUEIDENTIFIER OUTPUT', 
        @i_SessionUserAgent = @SessionUserAgent, @i_SessionClientComputer = @SessionClientComputer, @i_SessionUserId = @SessionUserId, @i_SessionUserName = @SessionUserName, @i_SessionComputer = @SessionComputer, @i_SessionTypeId = @v_SessionTypeId, @o_ExistingSessionId = @v_ExistingSessionId OUTPUT;
    END;

    IF @v_ExistingSessionId IS NULL
    BEGIN 
        IF @SessionId IS NULL
        BEGIN 
            SET @SessionId = NEWID();
        END;

        INSERT INTO dbo.TB_ADM_SESSION (SESSION_ID, SESSION_TYPE_ID, SESSION_COMPUTER, SESSION_CLIENT_COMPUTER, SESSION_USER_NAME, SESSION_USER_ID, SESSION_USER_AGENT)
        VALUES (@SessionId, @v_SessionTypeId, @SessionComputer, @SessionClientComputer, @SessionUserName, @SessionUserId, @SessionUserAgent);
    END;
    ELSE BEGIN 
        IF @ReuseExistingSession = 1 AND @SessionId IS NOT NULL AND @SessionId <> @v_ExistingSessionId
        BEGIN
            INSERT INTO dbo.TB_ADM_SESSION (SESSION_ID, SESSION_TYPE_ID, SESSION_COMPUTER, SESSION_CLIENT_COMPUTER, SESSION_USER_NAME, SESSION_USER_ID, SESSION_USER_AGENT)
            VALUES (@SessionId, @v_SessionTypeId, @SessionComputer, @SessionClientComputer, @SessionUserName, @SessionUserId, @SessionUserAgent);
        END;
        ELSE BEGIN
            SET @SessionId = @v_ExistingSessionId;
        END;
    END;

    IF @InitialTransactionCount = 0
    BEGIN 
        COMMIT TRANSACTION AddSessionTransaction;
    END;
    ELSE BEGIN 
        WHILE @@TRANCOUNT > @InitialTransactionCount
        BEGIN 
            COMMIT TRANSACTION;
        END;
    END;
END TRY
BEGIN CATCH;
    SELECT @v_Error = CASE WHEN @v_Error <> 1 THEN @@ERROR ELSE @v_Error END, @ErrorMessage = ERROR_MESSAGE();
    SET @ErrorMessage = OBJECT_NAME(@@PROCID) + '[' + @ErrorMessage + ']';
    IF @InitialTransactionCount = 0
        AND @@TRANCOUNT > 0
    BEGIN 
        ROLLBACK TRANSACTION;
    END;
    ELSE BEGIN 
        IF @InitialTransactionCount <> 0
            AND @@TRANCOUNT > @InitialTransactionCount
        BEGIN 
            IF (XACT_STATE()) = - 1
            BEGIN 
                SET @ErrorMessage = ISNULL(@ErrorMessage, OBJECT_NAME(@@PROCID)) + ' [Uncommittable Transaction!]';
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
            SET @ErrorMessage = ISNULL(@ErrorMessage, OBJECT_NAME(@@PROCID));
        END;
    END;
    RAISERROR (@ErrorMessage, 16, 1) WITH LOG;
END CATCH
RETURN @v_Error;
GO
GRANT EXECUTE
	ON [dbo].[ap_adm01_create_new_session]
	TO [portalapp_role]
GO
GRANT EXECUTE
	ON [dbo].[ap_adm01_create_new_session]
	TO [portal_database_configuration_read_role]
GO
GRANT EXECUTE
	ON [dbo].[ap_adm01_create_new_session]
	TO [portal_database_configuration_role]
GO
