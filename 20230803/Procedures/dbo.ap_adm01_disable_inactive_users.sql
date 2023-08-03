SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[ap_adm01_disable_inactive_users]
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @error INT = 0,
        @InitialTransactionCount INT = @@TRANCOUNT,
        @ErrorMessage VARCHAR(2048),
        @PropertyKey NVARCHAR(50) = 'PROP_DISABLE_INACTIVE_USER_ACCOUNTS_TIME_PERIOD',
        @PROPERTY_VALUE NVARCHAR(MAX),
        @EXPIRE_DATE DATETIME;

    BEGIN TRANSACTION [DisableUsers];
    BEGIN TRY

        SELECT  @PROPERTY_VALUE = [PROPERTY_VALUE]
        FROM    [dbo].[TB_ADM_PROPERTY]
        WHERE   [PROPERTY_KEY] = @PropertyKey;

        IF @PROPERTY_VALUE IS NULL
        BEGIN
            RAISERROR (N'Unable to disable inactive users since property ''[%s]'' does not exist!', 16, 1, @PropertyKey);
        END;

        DECLARE @UTCNOW DATETIME = GETUTCDATE();

        SET @EXPIRE_DATE = DATEADD(SECOND,
                                    CASE WHEN PATINDEX('[0-9][0-9][0-9].[0-9][0-9]:[0-9][0-9]:[0-9][0-9]', @PROPERTY_VALUE) > 0
                                                OR PATINDEX('[0-9][0-9].[0-9][0-9]:[0-9][0-9]:[0-9][0-9]', @PROPERTY_VALUE) > 0
                                                OR PATINDEX('[0-9].[0-9][0-9]:[0-9][0-9]:[0-9][0-9]', @PROPERTY_VALUE) > 0
                                        THEN CAST(LEFT(@PROPERTY_VALUE, LEN(@PROPERTY_VALUE) - 8) AS FLOAT) * 24 * 60 * 60 + DATEDIFF(SECOND, 0,
                                                                                                                                        RIGHT(@PROPERTY_VALUE,
                                                                                                                                            8))
                                        WHEN PATINDEX('[0-9][0-9][0-9].[0-9][0-9]:[0-9][0-9]:[0-9][0-9]', @PROPERTY_VALUE) > 0
                                                OR PATINDEX('[0-9][0-9].[0-9]:[0-9][0-9]:[0-9][0-9]', @PROPERTY_VALUE) > 0
                                                OR PATINDEX('[0-9].[0-9]:[0-9][0-9]:[0-9][0-9]', @PROPERTY_VALUE) > 0
                                        THEN CAST(LEFT(@PROPERTY_VALUE, LEN(@PROPERTY_VALUE) - 7) AS FLOAT) * 24 * 60 * 60 + DATEDIFF(SECOND, 0,
                                                                                                                                        RIGHT(@PROPERTY_VALUE,
                                                                                                                                            7))
                                        WHEN PATINDEX('[0-9][0-9]:[0-9][0-9]:[0-9][0-9]', @PROPERTY_VALUE) > 0
                                        THEN DATEDIFF(SECOND, 0, RIGHT(@PROPERTY_VALUE, 8))
                                        WHEN PATINDEX('[0-9]:[0-9][0-9]:[0-9][0-9]', @PROPERTY_VALUE) > 0
                                        THEN DATEDIFF(SECOND, 0, RIGHT(@PROPERTY_VALUE, 7))
                                        ELSE NULL
                                    END * -1, @UTCNOW);

        IF @UTCNOW = @EXPIRE_DATE
        BEGIN
            -- INFORMATIONAL ONLY
            RAISERROR('Property set to "0" so inactive users will not be disabled.',0,1) WITH NOWAIT;
        END;
        ELSE
        BEGIN
            UPDATE  [dbo].[TB_SEC_USER]
            SET     [ENABLED] = 0
            WHERE   [USER_TYPE] = 'U'
                    AND [SYSTEM] = 0
                    AND ISNULL([LAST_LOGIN], '2079-01-01') <= @EXPIRE_DATE;
        END;
        COMMIT;

    END TRY
    BEGIN CATCH
        SET @ErrorMessage = ERROR_MESSAGE();
        IF @InitialTransactionCount = 0
            AND @@TRANCOUNT > 0
        BEGIN 
            ROLLBACK TRANSACTION;
        END;
        ELSE
        BEGIN 
            IF @InitialTransactionCount <> 0
                AND @@TRANCOUNT > @InitialTransactionCount
            BEGIN 
                IF ( XACT_STATE() ) = -1
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
                ELSE
                BEGIN 
                    WHILE @@TRANCOUNT > @InitialTransactionCount
                    BEGIN 
                        COMMIT TRANSACTION;
                    END;
                END;
                SET @ErrorMessage = ISNULL(@ErrorMessage, OBJECT_NAME(@@PROCID));
            END;
        END;
        -- RETHROW ERROR UP A LEVEL
        RAISERROR (@ErrorMessage, 16, 1) WITH LOG;
    END CATCH;
END;
GO
