SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_adm01_purge_unused_activities_cases] ( @NewRun AS BIT = 1 ) AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @ReturnCode INT = 0,
        @ErrorMessage NVARCHAR(2000) = N'',
        @SprocLocked INT = -1;
    BEGIN TRY;
        EXEC @SprocLocked = [sys].[sp_getapplock] 'dbo.ap_adm01_purge_unused_activities_cases', 'Exclusive', 'Session', 0;
        IF @SprocLocked < 0
        BEGIN
            RAISERROR('There is already an instance of this procedure running.',16,1);
        END;

        DECLARE @Duration CHAR(12),
            @StartTime DATETIME = GETUTCDATE();
        SELECT  @Duration = CONVERT(CHAR(12), GETUTCDATE() - @StartTime, 114);
        RAISERROR('Start gathering purge information for activities [%s]',0,1,@Duration) WITH NOWAIT;
        IF @NewRun = 1
        BEGIN
            TRUNCATE TABLE [dbo].[TS_PURGE_ACTIVITY_ROWS];
        END;
        DROP TABLE IF EXISTS #ActivityPartitionTables;
        SELECT  [name] AS [TABLE_NAME]
        INTO    [#ActivityPartitionTables]
        FROM    [sys].[objects]
        CROSS APPLY ( SELECT    [a].[TEMPLATE],
                                CONCAT(REPLACE([a].[TEMPLATE], '_', '\_'), '\_[1-2][0-9][0-9][0-9]\_[0-1][0-9]\_[0-9][0-9]%')
                        FROM      ( VALUES ( 'TB_FCT_ACTIVITY_CLASSIFICATION'), ( 'TB_FCT_ACTIVITY_ROUTING'), ( 'TB_FCT_ACTIVITY_SLA'),
                                ( 'TB_FCT_ACTIVITY_STATE_DETAIL'), ( 'TB_FCT_CALLTRACK_ACTIVITY_DETAIL'), ( 'TB_FCT_CALLTRACK_DETAIL'),
                                ( 'TB_FCT_CHAT_ACTIVITY_DETAIL'), ( 'TB_FCT_CHAT_DETAIL'), ( 'TB_FCT_CHAT_RESPONSE_DETAIL'), ( 'TB_FCT_CHAT_SURVEY'),
                                ( 'TB_FCT_EMAIL_ACTIVITY_DETAIL'), ( 'TB_FCT_EMAIL_DETAIL'), ( 'TB_FCT_EVNT_HIST_CASE_MGMT'),
                                ( 'TB_FCT_SCL_ACTIVITY_DETAIL'), ( 'TB_FCT_SCL_SEARCH'), ( 'TB_FCT_TASK_ACTIVITY_DETAIL'), ( 'TB_FCT_TASK_DETAIL') ) [a] ( [TEMPLATE] )
                    ) [ca] ( [TEMPLATE], [NOT_TEMPLATE] )
        WHERE   [name] = [ca].[TEMPLATE]
                OR [name] LIKE [ca].[NOT_TEMPLATE] ESCAPE '\'
                AND [type] = 'U';
        SELECT  @Duration = CONVERT(CHAR(12), GETUTCDATE() - @StartTime, 114);
        RAISERROR('Gathered Activity Partition Table Information [%s]',0,1,@Duration) WITH NOWAIT;
        DECLARE @SQL NVARCHAR(MAX);
        SELECT  @SQL = STUFF((SELECT    CONCAT(CHAR(13), CHAR(10), 'INSERT INTO [dbo].[TS_PURGE_ACTIVITY_ROWS] ([URN]) SELECT DISTINCT ACTIVITY_URN AS URN FROM ',
                                                [TABLE_NAME], ' WHERE NOT EXISTS (SELECT 1 FROM [TS_PURGE_ACTIVITY_ROWS] WHERE [URN] = ACTIVITY_URN);')
                                FROM      [#ActivityPartitionTables]
                FOR          XML PATH(''),
                                    TYPE).[value]('.', 'NVARCHAR(MAX)'), 1, 2, '');
        EXECUTE [sys].[sp_executesql] @SQL;
        SELECT  @Duration = CONVERT(CHAR(12), GETUTCDATE() - @StartTime, 114);
        RAISERROR('Gathered Activity URNs used in fact partitions [%s]',0,1,@Duration) WITH NOWAIT;
        RAISERROR('Start gathering purge information for cases [%s]',0,1,@Duration) WITH NOWAIT;
        IF @NewRun = 1
        BEGIN
            TRUNCATE TABLE [dbo].[TS_PURGE_CASE_ROWS];
        END;
        DROP TABLE IF EXISTS #CasePartitionTables;
        SELECT  [name] AS [TABLE_NAME]
        INTO    [#CasePartitionTables]
        FROM    [sys].[objects]
        CROSS APPLY ( SELECT    [a].[TEMPLATE],
                                CONCAT(REPLACE([a].[TEMPLATE], '_', '\_'), '\_[1-2][0-9][0-9][0-9]\_[0-1][0-9]\_[0-9][0-9]%')
                        FROM      ( VALUES ( 'TB_FCT_ACTIVITY_CLASSIFICATION'), ( 'TB_FCT_ACTIVITY_ROUTING'), ( 'TB_FCT_ACTIVITY_SLA'),
                                ( 'TB_FCT_ACTIVITY_STATE_DETAIL'), ( 'TB_FCT_CALLTRACK_ACTIVITY_DETAIL'), ( 'TB_FCT_CALLTRACK_DETAIL'),
                                ( 'TB_FCT_CASE_DETAIL'), ( 'TB_FCT_CASE_RESOLUTION'), ( 'TB_FCT_CHAT_ACTIVITY_DETAIL'), ( 'TB_FCT_CHAT_DETAIL'),
                                ( 'TB_FCT_CHAT_RESPONSE_DETAIL'), ( 'TB_FCT_CHAT_SURVEY'), ( 'TB_FCT_EMAIL_ACTIVITY_DETAIL'), ( 'TB_FCT_EMAIL_DETAIL'),
                                ( 'TB_FCT_EVNT_HIST_CASE_MGMT'), ( 'TB_FCT_SCL_ACTIVITY_DETAIL'), ( 'TB_FCT_SCL_SEARCH'), ( 'TB_FCT_TASK_ACTIVITY_DETAIL'),
                                ( 'TB_FCT_TASK_DETAIL') ) [a] ( [TEMPLATE] )
                    ) [ca] ( [TEMPLATE], [NOT_TEMPLATE] )
        WHERE   [name] = [ca].[TEMPLATE]
                OR [name] LIKE [ca].[NOT_TEMPLATE] ESCAPE '\'
                AND [type] = 'U';
        SELECT  @Duration = CONVERT(CHAR(12), GETUTCDATE() - @StartTime, 114);
        RAISERROR('Gathered Case Partition Table Information [%s]',0,1,@Duration) WITH NOWAIT;
        SELECT  @SQL = STUFF((SELECT    CONCAT(CHAR(13), CHAR(10), 'INSERT INTO [dbo].[TS_PURGE_CASE_ROWS] ([URN]) SELECT DISTINCT CASE_URN AS URN FROM ',
                                                [TABLE_NAME], ' WHERE NOT EXISTS (SELECT 1 FROM [TS_PURGE_CASE_ROWS] WHERE [URN] = CASE_URN);')
                                FROM      [#ActivityPartitionTables]
                FOR          XML PATH(''),
                                    TYPE).[value]('.', 'NVARCHAR(MAX)'), 1, 2, '');
        EXECUTE [sys].[sp_executesql] @SQL;
        SELECT  @Duration = CONVERT(CHAR(12), GETUTCDATE() - @StartTime, 114);
        RAISERROR('Gathered Case URNs used in fact partitions [%s]',0,1,@Duration) WITH NOWAIT;
        WITH    [CTE]
              AS ( SELECT   [URN],
                            ROW_NUMBER() OVER ( PARTITION BY [URN] ORDER BY [URN] ) AS [RN]
                   FROM     [dbo].[TS_PURGE_ACTIVITY_ROWS]
                 )
        DELETE  FROM [CTE]
        WHERE   [CTE].[RN] > 1;
        SELECT  @SQL = CONCAT('DECLARE @Loop CHAR(6) = 1;
WHILE EXISTS ( SELECT   1
               FROM     [dbo].[VW_PURGE_ACTIVITY_PKEY_ROWS] )
BEGIN
    DELETE  FROM [dbo].[VW_PURGE_ACTIVITY_PKEY_ROWS];
    RAISERROR(', CHAR(39), 'Loop Number: %s', CHAR(39), ',0,1,@Loop) WITH NOWAIT;
    SET @Loop = CAST(CAST(@Loop AS INT) + 1 AS CHAR(6));
END;');
        SELECT  @Duration = CONVERT(CHAR(12), GETUTCDATE() - @StartTime, 114);
        RAISERROR('Start purging activity PKEY MAP rows [%s]',0,1,@Duration) WITH NOWAIT;
        EXECUTE [sys].[sp_executesql] @SQL;
        SELECT  @Duration = CONVERT(CHAR(12), GETUTCDATE() - @StartTime, 114);
        RAISERROR('Activity PKEY MAP rows purged [%s]',0,1,@Duration) WITH NOWAIT;
        SELECT  @Duration = CONVERT(CHAR(12), GETUTCDATE() - @StartTime, 114);
        RAISERROR('Start purging activity BASE rows [%s]',0,1,@Duration) WITH NOWAIT;
        SELECT  @SQL = CONCAT('DECLARE @Loop CHAR(6) = 1;
WHILE EXISTS ( SELECT   1
               FROM     [dbo].[VW_PURGE_ACTIVITY_ROWS] )
BEGIN
    DELETE  FROM [dbo].[VW_PURGE_ACTIVITY_ROWS];
    RAISERROR(', CHAR(39), 'Loop Number: %s', CHAR(39), ',0,1,@Loop) WITH NOWAIT;
    SET @Loop = CAST(CAST(@Loop AS INT) + 1 AS CHAR(6));
END;');
        EXECUTE [sys].[sp_executesql] @SQL;
        SELECT  @Duration = CONVERT(CHAR(12), GETUTCDATE() - @StartTime, 114);
        RAISERROR('Activity BASE rows purged [%s]',0,1,@Duration) WITH NOWAIT;
        RAISERROR('Gather cases still referenced in activity dimension [%s]',0,1,@Duration) WITH NOWAIT;
        INSERT  INTO [dbo].[TS_PURGE_CASE_ROWS]
                ( [URN]
                )
        SELECT  DISTINCT [CASE_BIZ_URN]
        FROM    [dbo].[TB_DIM_ACTIVITY]
        WHERE   NOT EXISTS ( SELECT 1
                                FROM   [TS_PURGE_CASE_ROWS]
                                WHERE  [URN] = [CASE_BIZ_URN] );
        RAISERROR('Cases gathered [%s]',0,1,@Duration) WITH NOWAIT;
        WITH    [CTE]
              AS ( SELECT   [URN],
                            ROW_NUMBER() OVER ( PARTITION BY [URN] ORDER BY [URN] ) AS [RN]
                   FROM     [dbo].[TS_PURGE_CASE_ROWS]
                 )
        DELETE  FROM [CTE]
        WHERE   [CTE].[RN] > 1;
        SELECT  @SQL = CONCAT('DECLARE @Loop CHAR(6) = 1;
WHILE EXISTS ( SELECT   1
               FROM     [dbo].[VW_PURGE_CASE_PKEY_ROWS] )
BEGIN
    DELETE  FROM [dbo].[VW_PURGE_CASE_PKEY_ROWS];
    RAISERROR(', CHAR(39), 'Loop Number: %s', CHAR(39), ',0,1,@Loop) WITH NOWAIT;
    SET @Loop = CAST(CAST(@Loop AS INT) + 1 AS CHAR(6));
END;');
        SELECT  @Duration = CONVERT(CHAR(12), GETUTCDATE() - @StartTime, 114);
        RAISERROR('Start purging case PKEY MAP rows [%s]',0,1,@Duration) WITH NOWAIT;
        EXECUTE [sys].[sp_executesql] @SQL;
        SELECT  @Duration = CONVERT(CHAR(12), GETUTCDATE() - @StartTime, 114);
        RAISERROR('Case PKEY MAP rows purged [%s]',0,1,@Duration) WITH NOWAIT;
        SELECT  @Duration = CONVERT(CHAR(12), GETUTCDATE() - @StartTime, 114);
        RAISERROR('Start purging case BASE rows [%s]',0,1,@Duration) WITH NOWAIT;
        SELECT  @SQL = CONCAT('DECLARE @Loop CHAR(6) = 1;
WHILE EXISTS ( SELECT   1
               FROM     [dbo].[VW_PURGE_CASE_ROWS] )
BEGIN
    DELETE  FROM [dbo].[VW_PURGE_CASE_ROWS];
    RAISERROR(', CHAR(39), 'Loop Number: %s', CHAR(39), ',0,1,@Loop) WITH NOWAIT;
    SET @Loop = CAST(CAST(@Loop AS INT) + 1 AS CHAR(6));
END;');
        EXECUTE [sys].[sp_executesql] @SQL;
        SELECT  @Duration = CONVERT(CHAR(12), GETUTCDATE() - @StartTime, 114);
        RAISERROR('Case BASE rows purged [%s]',0,1,@Duration) WITH NOWAIT;
    END TRY
    BEGIN CATCH;
        SELECT  @ReturnCode = ERROR_NUMBER(),
                @ErrorMessage = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1, @ReturnCode) WITH LOG;
    END CATCH;
    IF @SprocLocked >= 0
    BEGIN
        EXEC [sys].[sp_releaseapplock] 'dbo.ap_adm01_purge_unused_activities_cases', 'Session';
    END;
END;
GO
GRANT EXECUTE
	ON [dbo].[ap_adm01_purge_unused_activities_cases]
	TO [portalapp_role]
GO
