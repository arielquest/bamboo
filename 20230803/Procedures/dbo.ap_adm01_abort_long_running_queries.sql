SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[ap_adm01_abort_long_running_queries] ( @Timeout INT = 120 )
AS
    BEGIN
        SET NOCOUNT ON;
        IF ISNULL(@Timeout, 0) <= 0
        BEGIN
            DECLARE @Message VARCHAR(100) = CONCAT('Timeout must be greater than 0.  Passed in [', @Timeout, ']');
            THROW 50000, @Message, 1;
        END;
        ELSE
        BEGIN
            DECLARE @SessionId UNIQUEIDENTIFIER;
            -- Make timeout a minus figure
            SET @Timeout = @Timeout * -1;
  
            -- Create a session to use for auditing
            EXEC [dbo].[ap_adm01_create_new_session] @SessionUserName = N'System', @SessionUserId = '00000002-0000-0000-0000-000000000006',
                @SessionType = N'ST_GENERIC', @SessionComputer = @@SERVERNAME, @SessionClientComputer = @@SERVERNAME, @SessionUserAgent = N'eGainReportTool',
                @ReuseExistingSession = 1, @SessionId = @SessionId OUTPUT;
  
            -- Create dynamic SQL to audit and kill long running queries
            DECLARE @SQL NVARCHAR(MAX);
            SELECT  @SQL = STUFF((SELECT    CONCAT(CHAR(13), CHAR(10), [a].[txt])
                                  FROM      ( SELECT    'DECLARE @CurrentDate DATETIME, @MESSAGE NVARCHAR(500), @AuditUrn BIGINT;'
                                              UNION ALL
                                              SELECT    STUFF((SELECT   CONCAT(CHAR(13), CHAR(10), 'SET @CurrentDate = GETUTCDATE();', CHAR(13), CHAR(10),
                                                                               'SET @MESSAGE = ', CHAR(39),
                                                                               LEFT(CONCAT('Killed SPID [', [session_id], '] Last action [', [a].[last_batch],
                                                                                           '] CPU[', [a].[cpu], '] IO[', [a].[physical_io], '] Trimmed SQL[',
                                                                                           [a].[sql_txt], ']'), 500), CHAR(39), ';', CHAR(13), CHAR(10),
                                                                               'EXECUTE [dbo].[ap_adm01_audit_event] @SessionId = @pSessionId, @AuditTypeName = ',
                                                                               CHAR(39), 'AT_GENERIC', CHAR(39),
                                                                               ', @EventUtcDateTime = @CurrentDate, @EventOutcome = ', CHAR(39), 'N', CHAR(39),
                                                                               ', @EventDescription = @MESSAGE, @AuditUrn = @AuditUrn OUT;', CHAR(13), CHAR(10),
                                                                               'KILL ', [session_id], ';')
                                                               FROM     ( SELECT    [session].[session_id],
                                                                                    COALESCE([session].[last_request_end_time],
                                                                                             [session].[last_request_start_time]) AS [last_batch],
                                                                                    COALESCE([session].[cpu_time], 0) + COALESCE([req].[cpu_time], 0) AS [cpu],
                                                                                    COALESCE([session].[reads], 0) + COALESCE([session].[writes], 0)
                                                                                    + COALESCE([req].[reads], 0) + COALESCE([req].[writes], 0) AS [physical_io],
                                                                                    [session].[memory_usage],
                                                                                    [session].[login_name],
                                                                                    LEFT(RTRIM(LTRIM([sqltext].[text])), 400) AS [sql_txt]
                                                                          FROM      [sys].[dm_exec_sessions] [session]
                                                                          LEFT OUTER JOIN [sys].[dm_exec_connections] [conn] ON [session].[session_id] = [conn].[session_id]
                                                                          LEFT OUTER JOIN [sys].[dm_exec_requests] [req] ON [session].[session_id] = [req].[session_id]
                                                                          OUTER APPLY [sys].[dm_exec_sql_text]([conn].[most_recent_sql_handle]) [sqltext]
                                                                          WHERE     [session].[session_id] > 50
                                                                                    AND [program_name] = 'Report Server'
                                                                                    AND COALESCE([session].[last_request_end_time],
                                                                                                 [session].[last_request_start_time]) < DATEADD(SECOND, @Timeout,
                                                                                                                                                GETUTCDATE())
                                                                        ) [a]
                                                        FOR   XML PATH(''),
                                                                  TYPE).[value]('.', 'NVARCHAR(MAX)'), 1, 2, '')
                                            ) [a] ( [txt] )
                    FOR          XML PATH(''),
                                     TYPE).[value]('.', 'NVARCHAR(MAX)'), 1, 2, '');
    
            -- Execute dynamic SQL
            EXECUTE [sp_executesql] @SQL, N'@pSessionId UNIQUEIDENTIFIER', @pSessionId = @SessionId;
        END;
    END;
GO
