SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_adm01_audit_event]
    (
      @SessionId AS UNIQUEIDENTIFIER,
      @AuditTypeName AS NVARCHAR(100),
      @EventUtcDateTime AS DATETIME = NULL,
      @IntVal1 INT = NULL,
      @IntVal2 INT = NULL,
      @IntVal3 INT = NULL,
      @IntVal4 INT = NULL,
      @GuidVal1 AS UNIQUEIDENTIFIER = NULL,
      @GuidVal2 AS UNIQUEIDENTIFIER = NULL,
      @EventOutcome AS CHAR(1) = 'U',
      @EventDuration AS FLOAT = 0,
      @EventDescription AS NVARCHAR(500),
      @EventRawDescription AS NVARCHAR(500) = NULL,
      @FieldChangeXmlData XML = NULL,
      @XmlData XML = NULL,
      @AuditUrn AS BIGINT OUT
    )
AS
BEGIN 
    DECLARE @auditTypeId AS UNIQUEIDENTIFIER,
        @eventUtcDate AS DATETIME,
        @eventUtcTime AS DATETIME,
        @eventUtcDateUrn AS INT,
        @eventUtcTimeUrn AS INT,
        @error AS INT = 0,
        @InitialTransactionCount AS INT = @@TRANCOUNT,
        @midnightTime AS SMALLDATETIME = '1900-01-01 00:00:00',
        @ErrorMessage VARCHAR(2000),
        @ErrorHolder NVARCHAR(2000);

    BEGIN TRANSACTION;

    BEGIN TRY
        SELECT  @AuditUrn = NULL,
                @EventUtcDateTime = COALESCE(@EventUtcDateTime, GETUTCDATE()),
                @eventUtcDate = CAST(FLOOR(CAST(@EventUtcDateTime AS FLOAT)) AS DATETIME),
                @eventUtcTime = CAST(CAST(@EventUtcDateTime AS FLOAT)
                - FLOOR(CAST(@EventUtcDateTime AS FLOAT)) AS SMALLDATETIME);

        -- Check session id exists, if not throw error
        IF EXISTS ( SELECT  1
                    FROM    [dbo].[TB_ADM_SESSION]
                    WHERE   [SESSION_ID] = @SessionId )
        BEGIN 
            -- If the time is greater than 23:59:30 then ceil to next day midnight
            IF ( DATEDIFF(DAY, @midnightTime, @eventUtcTime) > 0 )
            BEGIN 
                SELECT  @eventUtcDate = DATEADD(DAY, 1, @eventUtcDate),
                        @eventUtcTime = @midnightTime,
                        @EventUtcDateTime = @eventUtcDate + @eventUtcTime;
            END;

            SELECT  @eventUtcDateUrn = CAST(@eventUtcDate AS INT),
                    @eventUtcTimeUrn = ( DATEPART(hh, @eventUtcTime) * 60 )
                    + DATEPART(mi, @eventUtcTime);

            SELECT  @auditTypeId = [type].[AUDIT_TYPE_ID]
            FROM    ( SELECT    [AUDIT_TYPE_ID],
                                CASE WHEN [INTERNAL_NAME] = @AuditTypeName
                                     THEN 1
                                     ELSE 2
                                END AS [POS]
                      FROM      [dbo].[TE_ADM_AUDIT_TYPE]
                      -- DEFAULT TO AT_GENERIC AUDIT TYPE
                      WHERE     [INTERNAL_NAME] IN ( @AuditTypeName,
                                                     'AT_GENERIC' )
                    ) [type]
            ORDER BY [type].[POS] DESC;

            IF @auditTypeId IS NULL
            BEGIN 
                SELECT  @error = 1,
                        @ErrorMessage = OBJECT_NAME(@@PROCID);
                RAISERROR (50156, 16, 5, @ErrorMessage, @AuditTypeName);
            END;

            INSERT  INTO [dbo].[TB_FCT_SYSTEM_AUDIT]
                    (
                      [SESSION_ID],
                      [AUDIT_TYPE_ID],
                      [EVENT_UTC_DATE_TIME],
                      [EVENT_UTC_DATE_URN],
                      [EVENT_UTC_TIME_URN],
                      [INT_VAL_1],
                      [INT_VAL_2],
                      [INT_VAL_3],
                      [INT_VAL_4],
                      [GUID_VAL_1],
                      [GUID_VAL_2],
                      [EVENT_OUTCOME],
                      [EVENT_DURATION],
                      [EVENT_DESCRIPTION],
                      [EVENT_RAW_DESCRIPTION],
                      [FIELD_CHANGE_XML_DATA],
                      [XML_DATA]
                    )
            VALUES  (
                      @SessionId,
                      @auditTypeId,
                      @EventUtcDateTime,
                      @eventUtcDateUrn,
                      @eventUtcTimeUrn,
                      @IntVal1,
                      @IntVal2,
                      @IntVal3,
                      @IntVal4,
                      @GuidVal1,
                      @GuidVal2,
                      @EventOutcome,
                      @EventDuration,
                      @EventDescription,
                      @EventRawDescription,
                      @FieldChangeXmlData,
                      @XmlData
                    );

            SET @AuditUrn = SCOPE_IDENTITY();

            IF @InitialTransactionCount = 0
            BEGIN 
                COMMIT TRANSACTION [AuditEvntTransaction];
            END;
            ELSE
            BEGIN 
                WHILE @@TRANCOUNT > @InitialTransactionCount
                BEGIN 
                    COMMIT TRANSACTION;
                END;
            END;
        END;
        ELSE
        BEGIN 
            SELECT  @error = 1,
                    @ErrorMessage = OBJECT_NAME(@@PROCID)
                    + ': Session ID invalid - ERROR[%d]';
            RAISERROR (@ErrorMessage, 16, 1, @error);
        END;
    END TRY
    BEGIN CATCH
        SELECT  @error = CASE WHEN @error <> 1 THEN @@ERROR
                              ELSE @error
                         END,
                @ErrorHolder = ERROR_MESSAGE();
        SET @ErrorMessage = OBJECT_NAME(@@PROCID) + ':' + @ErrorHolder;
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
                    SET @ErrorMessage = @ErrorMessage
                        + ' [Uncommittable Transaction!]';
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
            END;
        END;
        RAISERROR(@ErrorMessage, 16, 1, @error) WITH LOG;
    END CATCH;
    RETURN @error;
END;
GO
GRANT EXECUTE
	ON [dbo].[ap_adm01_audit_event]
	TO [portalapp_role]
GO
GRANT EXECUTE
	ON [dbo].[ap_adm01_audit_event]
	TO [portal_database_configuration_read_role]
GO
GRANT EXECUTE
	ON [dbo].[ap_adm01_audit_event]
	TO [portal_database_configuration_role]
GO
