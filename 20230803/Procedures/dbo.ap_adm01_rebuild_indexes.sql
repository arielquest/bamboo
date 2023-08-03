SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [ap_adm01_rebuild_indexes] ( @defragMode INT = 0 )
    WITH RECOMPILE
AS
    BEGIN 
        SET NOCOUNT ON;
/*
    @defragMode = 0
    ===================
    The mode is no pre-filter on the index defrag.

    @defragMode = 1
    ===================
    The mode pre-filters the index defrag to just dimension indexes.

    @defragMode = 2
    ===================
    The mode pre-filters the index defrag to just member indexes.

    @defragMode = 3
    ===================
    The mode pre-filters the index defrag to just fact indexes.

    @defragMode = 4
    ===================
    The mode pre-filters the index defrag to just summary indexes.
    
    @defragMode = 5
    ===================
    The mode pre-filters the index defrag to anything not covered by 
    defragMode 1 to 4.
*/
        DECLARE @CURRENTDATETIME DATETIME = GETUTCDATE(),
            @defragTimeLimit NVARCHAR(MAX),
            @DEFRAGWAITDATETIME DATETIME,
            @OBJECT_ID INT,
            @INDEX_ID INT,
            @PARTITION INT,
            @UPDATE_STATS NVARCHAR(MAX),
            @INDEX NVARCHAR(MAX),
            @ERROR INT,
            @STARTTIME DATETIME,
            @ENDTIME DATETIME,
            @MESSAGE NVARCHAR(MAX),
            @minimumSizeMB INT,
            @INDEXNAME VARCHAR(128),
            @SESSION_ID UNIQUEIDENTIFIER,
            @AuditUrn BIGINT;

        EXEC [dbo].[ap_adm01_create_new_session] @SessionUserName = 'System', @SessionType = 'ST_GENERIC', @SessionId = @SESSION_ID OUTPUT;

        SELECT  @defragTimeLimit = ISNULL(NULLIF(MAX(CASE WHEN [PROPERTY_KEY] = 'PROP_INDEX_DEFRAG_TIME_LIMIT' THEN [PROPERTY_VALUE]
                                                          ELSE ''
                                                     END), ''), '03:00:00'),
                @minimumSizeMB = ISNULL(NULLIF(MAX(CASE WHEN [PROPERTY_KEY] = 'PROP_INDEX_MINIMUM_SIZE_MB' THEN [PROPERTY_VALUE]
                                                        ELSE ''
                                                   END), ''), 1)
        FROM    [dbo].[TB_ADM_PROPERTY]
        WHERE   [PROPERTY_KEY] IN ( 'PROP_INDEX_DEFRAG_TIME_LIMIT', 'PROP_INDEX_MINIMUM_SIZE_MB' );

        IF OBJECT_ID('tempdb..#temp_all_indexes') IS NOT NULL
        BEGIN
            DROP TABLE [#temp_all_indexes];
        END;

        SELECT  ROW_NUMBER() OVER ( ORDER BY [a].[FRAGMENTATION] DESC, [a].[DEFRAG_DATE_END] ASC, [a].[OBJECT_NAME] ASC ) AS [RN],
                [a].[OBJECT_ID],
                [a].[INDEX_ID],
                [a].[PARTITION],
                [a].[INDEX_NAME],
                CAST(NULL AS DATETIME) AS [DEFRAG_DATE_END],
                [a].[STATISTICS_UPDATE],
                [a].[CURRENT_EXECUTED_STATEMENT]
        INTO    [#temp_all_indexes]
        FROM    ( SELECT    [state].[OBJECT_NAME],
                            [state].[OBJECT_ID],
                            [state].[INDEX_ID],
                            [state].[INDEX_NAME],
                            [state].[PARTITION],
                            [state].[FRAGMENTATION],
                            ISNULL([state].[DEFRAG_DATE_END], '1900-01-01 00:00:00') AS [DEFRAG_DATE_END],
                            [state].[CURRENT_EXECUTED_STATEMENT],
                            N'UPDATE STATISTICS [' + DB_NAME(DB_ID()) + '].[' + [state].[SCHEMA_NAME] + '].[' + [state].[OBJECT_NAME] + '] ['
                            + [state].[INDEX_NAME] + '];' AS [STATISTICS_UPDATE],
                            [stats].[reserved_page_count] * 8.0 / 1024.0 AS [estimated_size_MB]
                  FROM      [sys].[dm_db_partition_stats] [stats]
                  INNER JOIN [dbo].[TB_ADM_INDEX_STATE] [state] ON [state].[INDEX_ID] = [stats].[index_id]
                                                                   AND [state].[OBJECT_ID] = [stats].[object_id]
                                                                   AND [state].[PARTITION] = [stats].[partition_number]
                  WHERE     [state].[EXECUTION_MASK] & POWER(2, DATEPART(WEEKDAY, @CURRENTDATETIME + @@DATEFIRST - 1)) <> 0
                            AND [state].[CURRENT_EXECUTED_STATEMENT] IS NOT NULL
                ) [a]
        WHERE   [a].[estimated_size_MB] >= @minimumSizeMB
                AND ( @defragMode = 0
                      OR ( @defragMode = 1
                           AND [a].[OBJECT_NAME] LIKE '%\_DIM\_%' ESCAPE '\'
                           AND [a].[OBJECT_NAME] NOT LIKE '%\_MEMBER\_%' ESCAPE '\'
                           AND [a].[OBJECT_NAME] NOT LIKE '%\_MEMBER' ESCAPE '\'
                         )
                      OR ( @defragMode = 2
                           AND [a].[OBJECT_NAME] LIKE '%\_DIM\_%' ESCAPE '\'
                           AND ( [a].[OBJECT_NAME] LIKE '%\_MEMBER\_%' ESCAPE '\'
                                 OR [a].[OBJECT_NAME] LIKE '%\_MEMBER' ESCAPE '\'
                               )
                         )
                      OR ( @defragMode = 3
                           AND [a].[OBJECT_NAME] LIKE '%\_FCT\_%' ESCAPE '\'
                         )
                      OR ( @defragMode = 4
                           AND [a].[OBJECT_NAME] LIKE '%\_SUM\_%' ESCAPE '\'
                         )
                      OR ( @defragMode = 5
                           AND ( NOT ( ( [a].[OBJECT_NAME] LIKE '%\_SUM\_%' ESCAPE '\' )
                                       OR ( [a].[OBJECT_NAME] LIKE '%\_FCT\_%' ESCAPE '\' )
                                       OR ( ([a].[OBJECT_NAME] LIKE '%\_DIM\_%' ESCAPE '\'
                                            AND ( [a].[OBJECT_NAME] LIKE '%\_MEMBER\_%' ESCAPE '\'
                                                  OR [a].[OBJECT_NAME] LIKE '%\_MEMBER' ESCAPE '\'
                                                )
                                                 )
                                          )
                                       OR ( [a].[OBJECT_NAME] LIKE '%\_DIM\_%' ESCAPE '\'
                                            AND [a].[OBJECT_NAME] NOT LIKE '%\_MEMBER\_%' ESCAPE '\'
                                            AND [a].[OBJECT_NAME] NOT LIKE '%\_MEMBER' ESCAPE '\'
                                          )
                                     )
                               )
                         )
                    )
                AND [a].[CURRENT_EXECUTED_STATEMENT] LIKE 'ALTER INDEX %'
                AND [a].[CURRENT_EXECUTED_STATEMENT] LIKE '%;'
                AND LEN(REPLACE([a].[CURRENT_EXECUTED_STATEMENT] COLLATE Latin1_General_BIN2, ';', '')) = ( LEN([a].[CURRENT_EXECUTED_STATEMENT] COLLATE Latin1_General_BIN2)
                                                                                                            - 1 );

        SET @DEFRAGWAITDATETIME = DATEADD(SECOND, DATEDIFF(SECOND, 0, @defragTimeLimit), GETUTCDATE());
        DECLARE @CHECKPOINT_BATCH INT = 0;

        WHILE EXISTS ( SELECT   1
                       FROM     [#temp_all_indexes]
                       WHERE    [DEFRAG_DATE_END] IS NULL )
            AND @DEFRAGWAITDATETIME > GETUTCDATE()
        BEGIN
            SELECT TOP 1
                    @OBJECT_ID = [OBJECT_ID],
                    @INDEX_ID = [INDEX_ID],
                    @INDEXNAME = [INDEX_NAME],
                    @PARTITION = [PARTITION],
                    @UPDATE_STATS = [STATISTICS_UPDATE],
                    @INDEX = [CURRENT_EXECUTED_STATEMENT]
            FROM    [#temp_all_indexes]
            WHERE   [DEFRAG_DATE_END] IS NULL
            ORDER BY [RN];
            SET @CHECKPOINT_BATCH = @CHECKPOINT_BATCH + 1;

            IF EXISTS ( SELECT  1
                        FROM    [sys].[stats]
                        WHERE   [object_id] = @OBJECT_ID
                                AND [name] = @INDEXNAME )
            BEGIN
                BEGIN TRY
                    SET @STARTTIME = GETUTCDATE();

                    EXECUTE [sys].[sp_executesql] @UPDATE_STATS;

                    SET @ENDTIME = GETUTCDATE();

                    UPDATE  [dbo].[TB_ADM_INDEX_STATE]
                    SET     [STATISTICS_DATE_START] = @STARTTIME,
                            [STATISTICS_DATE_END] = @ENDTIME
                    WHERE   [OBJECT_ID] = @OBJECT_ID
                            AND [INDEX_ID] = @INDEX_ID
                            AND [PARTITION] = @PARTITION;
                END TRY
                BEGIN CATCH
                    SELECT  @ERROR = ERROR_NUMBER(),
                            @MESSAGE = ERROR_MESSAGE();
            
                    IF @ERROR = 1222
                    BEGIN 
                        SET @MESSAGE = '[' + CONVERT(VARCHAR(8), GETUTCDATE(), 108) + ']' + SPACE(4) + 'Error locking for' + SPACE(1) + '[' + @UPDATE_STATS
                            + ']' + SPACE(1) + 'on' + SPACE(1) + '[' + OBJECT_NAME(@OBJECT_ID) + ']';
                    END;
                    ELSE
                    BEGIN 
                        SET @MESSAGE = '[' + CONVERT(VARCHAR(8), GETUTCDATE(), 108) + ']' + SPACE(4) + 'Error detected whilst performing' + SPACE(1) + '['
                            + @UPDATE_STATS + ']' + SPACE(1) + 'on' + SPACE(1) + '[' + OBJECT_NAME(@OBJECT_ID) + ']' + ISNULL(': SQL Error[' + @MESSAGE + ']',
                                                                                                                              '');
                    END;

                    SET @CURRENTDATETIME = GETUTCDATE();

                    EXECUTE [dbo].[ap_adm01_audit_event] @SessionId = @SESSION_ID, @AuditTypeName = 'AT_INDEXING_JOB_FAIL', @EventUtcDateTime = @CURRENTDATETIME,
                        @EventOutcome = 'N', @EventDescription = @MESSAGE, @AuditUrn = @AuditUrn OUT;
                END CATCH;
            END;

            IF EXISTS ( SELECT  1
                        FROM    [sys].[indexes]
                        WHERE   [object_id] = @OBJECT_ID
                                AND [index_id] = @INDEX_ID )
            BEGIN
                BEGIN TRY
                    SET @STARTTIME = GETUTCDATE();

                    EXECUTE [sys].[sp_executesql] @INDEX;

                    SET @ENDTIME = GETUTCDATE();

                    UPDATE  [dbo].[TB_ADM_INDEX_STATE]
                    SET     [DEFRAG_DATE_START] = @STARTTIME,
                            [DEFRAG_DATE_END] = @ENDTIME,
                            [LAST_EXECUTED_STATEMENT] = @INDEX
                    WHERE   [OBJECT_ID] = @OBJECT_ID
                            AND [INDEX_ID] = @INDEX_ID
                            AND [PARTITION] = @PARTITION;
                END TRY
                BEGIN CATCH
                    SELECT  @ERROR = ERROR_NUMBER(),
                            @MESSAGE = ERROR_MESSAGE();
            
                    IF @ERROR = 1222
                    BEGIN 
                        SET @MESSAGE = '[' + CONVERT(VARCHAR(8), GETUTCDATE(), 108) + ']' + SPACE(4) + 'Error locking for' + SPACE(1) + '[' + @INDEX + ']'
                            + SPACE(1) + 'on' + SPACE(1) + '[' + OBJECT_NAME(@OBJECT_ID) + ']';
                    END;
                    ELSE
                    BEGIN 
                        SET @MESSAGE = '[' + CONVERT(VARCHAR(8), GETUTCDATE(), 108) + ']' + SPACE(4) + 'Error detected whilst performing' + SPACE(1) + '['
                            + @INDEX + ']' + SPACE(1) + 'on' + SPACE(1) + '[' + OBJECT_NAME(@OBJECT_ID) + ']' + ISNULL(': SQL Error[' + @MESSAGE + ']', '');
                    END;

                    SET @CURRENTDATETIME = GETUTCDATE();

                    EXECUTE [dbo].[ap_adm01_audit_event] @SessionId = @SESSION_ID, @AuditTypeName = 'AT_INDEXING_JOB_FAIL', @EventUtcDateTime = @CURRENTDATETIME,
                        @EventOutcome = 'N', @EventDescription = @MESSAGE, @AuditUrn = @AuditUrn OUT;
                END CATCH;
            END;

            DELETE  FROM [#temp_all_indexes]
            WHERE   [OBJECT_ID] = @OBJECT_ID
                    AND [INDEX_ID] = @INDEX_ID
                    AND [PARTITION] = @PARTITION;
                    
            -- Let the server catch up
            WAITFOR DELAY '00:00:00:50';
            IF @CHECKPOINT_BATCH >= 1000
            BEGIN
                CHECKPOINT;
                SET @CHECKPOINT_BATCH = 0;
            END;
        END;
    END;
GO
