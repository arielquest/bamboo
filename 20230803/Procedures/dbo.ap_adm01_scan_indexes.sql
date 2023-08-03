SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [ap_adm01_scan_indexes] ( @scanMode INT = 2 )
AS
    BEGIN
        SET NOCOUNT ON;
/*
The scanMode variable has different levels.
    
    @scanMode = 0
    ===================
    The mode does not check current fragmentation levels, it simply 
    rebuilds all indexes that are returned and have been used. 
    This is the fastest, but least intelligent mode, meaning that 
    it may rebuild indexes that don't need it and may skip rebuilding 
    indexes that do need it.
    
    @scanMode = 1
    ===================
    The mode does not check current fragmentation levels, it simply 
    rebuilds all indexes. It may rebuild indexes that don't need it.
    
    @scanMode = 2
    ===================
    This mode is the default. It performs a LIMITED scan to work out
    current index fragmentation by reading the key-ordered list of
    page IDs at the leaf level and checking their allocation
    order. It then uses this and the @maxFrag parameter to determine
    the work to be done to the indexes.
    
    @scanMode = 3
    ===================
    This mode performs a SAMPLED scan to work out current index 
    fragmentation by reading the key-ordered list of page IDs at the 
    leaf level and checking their allocation order. If the number of
    leaf pages is less than 10,000, it then reads all of the pages,
    otherwise it takes a sample of every 100th page, then uses this
    information to work out other statistics. The extra statistic that
    we're interested in is "page density".
    
    @scanMode = 4
    ===================
    This mode performs a DETAILED scan to work out current index 
    fragmentation by reading the key-ordered list of page IDs at the 
    leaf level and checking their allocation order. It then reads all
    of the leaf pages to work out other statistics. The extra statistic
    that we're interested in is "page density". Although this mode is
    more accurate than scanMode 2, it is not recommended on a customer
    site due to the amount of time a detailed scan can take on a 
    big database.
*/
        DECLARE @CURRENTDATETIME DATETIME = GETUTCDATE(),
            @SCANWAITDATETIME DATETIME,
            @OBJECT_ID INT,
            @scanTimeLimit NVARCHAR(MAX),
            @MAXDROP INT,
            @SQLVERSION INT,
            @ONLINE_REBUILD BIT = 1,
            @DimensionExecutionMask INT,
            @MemberExecutionMask INT,
            @FactExecutionMask INT,
            @SummaryExecutionMask INT,
            @OtherExecutionMask INT,
            @TodayMask INT = POWER(2, DATEPART(WEEKDAY, GETUTCDATE() + @@DATEFIRST - 1));

        SELECT  @SQLVERSION = CONVERT(INT, ( @@microsoftversion / 0x1000000 ) & 0xff);

        -- Get CPU count for use in MAXDOP option 
        -- on index rebuild statements.
        SELECT  @MAXDROP = CASE WHEN [a].[cpu_count] < 8
                                     AND [a].[HTEnabled] = 0 THEN [a].[cpu_count]
                                WHEN [a].[cpu_count] >= 8
                                     AND [a].[HTEnabled] = 0 THEN 8
                                WHEN [a].[cpu_count] >= 8
                                     AND [a].[HTEnabled] = 1
                                     AND [b].[NoOfNUMA] = 1 THEN [b].[NumberOfLogicalProcessorsPerNuma] / [a].[cpu_count]
                                WHEN [a].[cpu_count] >= 8
                                     AND [a].[HTEnabled] = 1
                                     AND [b].[NoOfNUMA] > 1 THEN [b].[NumberOfLogicalProcessorsPerNuma] / [a].[cpu_count]
                                ELSE 1
                           END
        FROM    ( SELECT    [cpu_count],
                            [hyperthread_ratio],
                            [cpu_count] / [hyperthread_ratio] AS [physicalCPU],
                            CASE WHEN [cpu_count] > [hyperthread_ratio] THEN 1
                                 ELSE 0
                            END AS [HTEnabled]
                  FROM      [sys].[dm_os_sys_info]
                ) [a]
        CROSS APPLY ( SELECT    COUNT([parent_node_id]) AS [NumberOfLogicalProcessorsPerNuma],
                                COUNT(DISTINCT [parent_node_id]) AS [NoOfNUMA]
                      FROM      [sys].[dm_os_schedulers]
                      WHERE     [status] = 'VISIBLE ONLINE'
                                AND [parent_node_id] < 64
                      GROUP BY  [parent_node_id]
                    ) [b]
        OPTION  ( RECOMPILE );

        -- Not more than 8!!
        SELECT  @MAXDROP = CASE WHEN @MAXDROP > 8 THEN 8
                                ELSE @MAXDROP
                           END;

        SELECT  @scanTimeLimit = ISNULL(NULLIF(MAX(CASE WHEN [PROPERTY_KEY] = 'PROP_INDEX_SCAN_TIME_LIMIT' THEN [PROPERTY_VALUE]
                                                        ELSE ''
                                                   END), ''), '01:00:00'),
                @ONLINE_REBUILD = ISNULL(MAX(CASE WHEN [PROPERTY_KEY] = 'PROP_REBUILD_INDEXES_ONLINE' THEN CASE WHEN [PROPERTY_VALUE] = 'True' THEN 1
                                                                                                                ELSE 0
                                                                                                           END
                                                  ELSE NULL
                                             END), 0)
        FROM    [dbo].[TB_ADM_PROPERTY]
        WHERE   [PROPERTY_KEY] IN ( 'PROP_INDEX_SCAN_TIME_LIMIT', 'PROP_REBUILD_INDEXES_ONLINE' );

        -- GET EXECUTION MASK PER INDEX TYPE, DEFAULT 127 (ALL DAYS)
        SELECT  @DimensionExecutionMask = ISNULL(NULLIF(SUM(CASE WHEN [PROPERTY_KEY] = 'PROP_DIMENSION_INDEX_MAINTENANCE_DAYS' THEN TRY_CONVERT(INT, [Item])
                                                                 ELSE 0
                                                            END), 0), 127),
                @MemberExecutionMask = ISNULL(NULLIF(SUM(CASE WHEN [PROPERTY_KEY] = 'PROP_MEMBER_INDEX_MAINTENANCE_DAYS' THEN TRY_CONVERT(INT, [Item])
                                                              ELSE 0
                                                         END), 0), 127),
                @FactExecutionMask = ISNULL(NULLIF(SUM(CASE WHEN [PROPERTY_KEY] = 'PROP_FACT_INDEX_MAINTENANCE_DAYS' THEN TRY_CONVERT(INT, [Item])
                                                            ELSE 0
                                                       END), 0), 127),
                @SummaryExecutionMask = ISNULL(NULLIF(SUM(CASE WHEN [PROPERTY_KEY] = 'PROP_SUMMARY_INDEX_MAINTENANCE_DAYS' THEN TRY_CONVERT(INT, [Item])
                                                               ELSE 0
                                                          END), 0), 127),
                @OtherExecutionMask = ISNULL(NULLIF(SUM(CASE WHEN [PROPERTY_KEY] = 'PROP_OTHER_INDEX_MAINTENANCE_DAYS' THEN TRY_CONVERT(INT, [Item])
                                                             ELSE 0
                                                        END), 0), 127)
        FROM    [dbo].[TB_ADM_PROPERTY]
        CROSS APPLY [dbo].[fn_adm_string_split]([PROPERTY_VALUE], ',')
        WHERE   [PROPERTY_KEY] IN ( 'PROP_DIMENSION_INDEX_MAINTENANCE_DAYS', 'PROP_MEMBER_INDEX_MAINTENANCE_DAYS', 'PROP_FACT_INDEX_MAINTENANCE_DAYS',
                                    'PROP_SUMMARY_INDEX_MAINTENANCE_DAYS', 'PROP_OTHER_INDEX_MAINTENANCE_DAYS' )
                AND -- THE ALLOWED NUMBERS FOR THE EXECUTION MASK
                TRY_CONVERT(INT, [Item]) IN ( 1, 2, 4, 8, 16, 32, 64 );

        -- IN CASE SOMEONE HAS MANUALLY INVALIDATED ALL OF THE ABOVE PROPERTIES, OR THEY'RE ALL MISSING, DEFAULT THEM TO 127 (ALL)
        SELECT  @DimensionExecutionMask = ISNULL(@DimensionExecutionMask, 127),
                @MemberExecutionMask = ISNULL(@MemberExecutionMask, 127),
                @FactExecutionMask = ISNULL(@FactExecutionMask, 127),
                @SummaryExecutionMask = ISNULL(@SummaryExecutionMask, 127),
                @OtherExecutionMask = ISNULL(@OtherExecutionMask, 127);

        SET @ONLINE_REBUILD = CASE WHEN @ONLINE_REBUILD = 1
                                        AND 
                                    -- SERVERPROPERTY('EngineEdition') returns 3 for Enterprise, 
                                    -- Enterprise Evaluation and Developer
                                        CONVERT(INT, SERVERPROPERTY('EngineEdition')) = 3 THEN 1
                                   ELSE 0
                              END;

        -- ENSURE ALL INDEXES ARE IN THE STATE TABLE
        MERGE INTO [dbo].[TB_ADM_INDEX_STATE] WITH ( TABLOCKX, HOLDLOCK ) AS [TARGET]
        USING
            ( SELECT    [ind].[object_id],
                        [ind].[index_id],
                        [part].[partition_number],
                        0,
                        0,
                        NULLIF(NULLIF([ind].[fill_factor], 0), 100),
                        CASE WHEN ( [ind].[type] = 1
                                    AND [BLOB_DATA_PK].[NUMBER] > 0
                                  )
                                  OR ( [ind].[type] <> 1
                                       AND [BLOB_DATA_IX].[NUMBER] > 0
                                     ) THEN 1
                             ELSE 0
                        END,
                        [ind].[name],
                        OBJECT_SCHEMA_NAME([ind].[object_id]),
                        DB_NAME(DB_ID()),
                        OBJECT_NAME([ind].[object_id]),
                        CASE WHEN OBJECT_NAME([ind].[object_id]) LIKE '%\_DIM\_%' ESCAPE '\'
                                  AND OBJECT_NAME([ind].[object_id]) NOT LIKE '%\_MEMBER\_%' ESCAPE '\'
                                  AND OBJECT_NAME([ind].[object_id]) NOT LIKE '%\_MEMBER' ESCAPE '\' THEN @DimensionExecutionMask
                             WHEN OBJECT_NAME([ind].[object_id]) LIKE '%\_DIM\_%' ESCAPE '\'
                                  AND ( OBJECT_NAME([ind].[object_id]) LIKE '%\_MEMBER\_%' ESCAPE '\'
                                        OR OBJECT_NAME([ind].[object_id]) LIKE '%\_MEMBER' ESCAPE '\'
                                      ) THEN @MemberExecutionMask
                             WHEN OBJECT_NAME([ind].[object_id]) LIKE '%\_FCT\_%' ESCAPE '\' THEN @FactExecutionMask
                             WHEN OBJECT_NAME([ind].[object_id]) LIKE '%\_SUM\_%' ESCAPE '\' THEN @SummaryExecutionMask
                             WHEN NOT ( ( OBJECT_NAME([ind].[object_id]) LIKE '%\_SUM\_%' ESCAPE '\' )
                                        OR ( OBJECT_NAME([ind].[object_id]) LIKE '%\_FCT\_%' ESCAPE '\' )
                                        OR ( (OBJECT_NAME([ind].[object_id]) LIKE '%\_DIM\_%' ESCAPE '\'
                                             AND ( OBJECT_NAME([ind].[object_id]) LIKE '%\_MEMBER\_%' ESCAPE '\'
                                                   OR OBJECT_NAME([ind].[object_id]) LIKE '%\_MEMBER' ESCAPE '\'
                                                 )
                                                 )
                                           )
                                        OR ( OBJECT_NAME([ind].[object_id]) LIKE '%\_DIM\_%' ESCAPE '\'
                                             AND OBJECT_NAME([ind].[object_id]) NOT LIKE '%\_MEMBER\_%' ESCAPE '\'
                                             AND OBJECT_NAME([ind].[object_id]) NOT LIKE '%\_MEMBER' ESCAPE '\'
                                           )
                                      ) THEN @OtherExecutionMask
                        END
              FROM      [sys].[indexes] [ind]
              INNER JOIN [sys].[partitions] [part] ON [part].[index_id] = [ind].[index_id]
                                                      AND [part].[object_id] = [ind].[object_id]
              INNER JOIN [sys].[objects] [obj] ON [obj].[object_id] = [ind].[object_id]
              LEFT OUTER JOIN ( SELECT  COUNT(*),
                                        [columns].[object_id]
                                FROM    [sys].[columns] [columns]
                                INNER JOIN [sys].[types] [types] ON [columns].[system_type_id] = [types].[user_type_id]
                                WHERE   [types].[name] IN ( 'image', 'text', 'ntext', 'xml' )
                                        OR ( [types].[name] IN ( 'nvarchar', 'varchar', 'varbinary' )
                                             AND [columns].[max_length] = -1
                                           )
                                GROUP BY [columns].[object_id]
                              ) [BLOB_DATA_PK] ( [NUMBER], [OBJECT_ID] ) ON [BLOB_DATA_PK].[OBJECT_ID] = [ind].[object_id]
                                                                            AND [ind].[type] = 1
              LEFT OUTER JOIN ( SELECT  COUNT(*),
                                        [index_columns].[object_id]
                                FROM    [sys].[index_columns] [index_columns]
                                INNER JOIN [sys].[columns] [columns] ON [columns].[object_id] = [index_columns].[object_id]
                                                                        AND [index_columns].[column_id] = [columns].[column_id]
                                INNER JOIN [sys].[types] [types] ON [columns].[system_type_id] = [types].[user_type_id]
                                WHERE   [types].[name] IN ( 'image', 'text', 'ntext', 'xml' )
                                        OR ( [types].[name] IN ( 'nvarchar', 'varchar', 'varbinary' )
                                             AND [columns].[max_length] = -1
                                           )
                                GROUP BY [index_columns].[object_id]
                              ) [BLOB_DATA_IX] ( [NUMBER], [OBJECT_ID] ) ON [BLOB_DATA_IX].[OBJECT_ID] = [ind].[object_id]
                                                                            AND [ind].[type] <> 1
              WHERE     [obj].[type] IN ( 'U', 'V' )
                        AND [obj].[is_ms_shipped] = 0
                        AND [ind].[type] IN ( 1, 2, 3, 4, 5, 6, 7 )
                        AND [ind].[is_disabled] = 0
                        AND [ind].[is_hypothetical] = 0
            ) [SOURCE] ( [OBJECT_ID], [INDEX_ID], [PARTITION], [FRAGMENTATION], [PAGES], [FILLFACTOR], [BLOB_DATA_TYPE], [INDEX_NAME], [SCHEMA_NAME],
                         [DATABASE_NAME], [OBJECT_NAME], [EXECUTION_MASK] )
        ON [SOURCE].[OBJECT_ID] = [TARGET].[OBJECT_ID]
            AND [SOURCE].[INDEX_ID] = [TARGET].[INDEX_ID]
            AND [SOURCE].[PARTITION] = [TARGET].[PARTITION]
        WHEN MATCHED THEN
            UPDATE SET
                    [TARGET].[RUN_DATE] = @CURRENTDATETIME,
                    [TARGET].[SCAN_DATE_START] = NULL,
                    [TARGET].[SCAN_DATE_END] = NULL,
                    [TARGET].[CURRENT_EXECUTED_STATEMENT] = NULL,
                    [TARGET].[EXECUTION_MASK] = [SOURCE].[EXECUTION_MASK]
        WHEN NOT MATCHED BY TARGET THEN
            INSERT ( [OBJECT_ID],
                     [INDEX_ID],
                     [PARTITION],
                     [FRAGMENTATION],
                     [PAGES],
                     [FILLFACTOR],
                     [BLOB_DATA_TYPE],
                     [INDEX_NAME],
                     [SCHEMA_NAME],
                     [DATABASE_NAME],
                     [OBJECT_NAME],
                     [RUN_DATE],
                     [EXECUTION_MASK]
                   )
            VALUES ( [SOURCE].[OBJECT_ID],
                     [SOURCE].[INDEX_ID],
                     [SOURCE].[PARTITION],
                     [SOURCE].[FRAGMENTATION],
                     [SOURCE].[PAGES],
                     [SOURCE].[FILLFACTOR],
                     [SOURCE].[BLOB_DATA_TYPE],
                     [SOURCE].[INDEX_NAME],
                     [SOURCE].[SCHEMA_NAME],
                     [SOURCE].[DATABASE_NAME],
                     [SOURCE].[OBJECT_NAME],
                     @CURRENTDATETIME,
                     [SOURCE].[EXECUTION_MASK]
                   )
        WHEN NOT MATCHED BY SOURCE THEN
            DELETE
        OPTION
            ( MAXDOP 2 );

        IF @scanMode IN ( 2, 3, 4 )
        BEGIN
            IF OBJECT_ID('tempdb..#temp_all_indexes') IS NOT NULL
            BEGIN
                DROP TABLE [#temp_all_indexes];
            END;

            SELECT  [OBJECT_ID],
                    [INDEX_ID],
                    [PARTITION],
                    [OBJECT_NAME],
                    [SCHEMA_NAME],
                    [INDEX_NAME],
                    [FILLFACTOR],
                    [BLOB_DATA_TYPE],
                    CAST(NULL AS DATETIME) AS [SCAN_DATE_END],
                    [DEFRAG_DATE_END]
            INTO    [#temp_all_indexes]
            FROM    [dbo].[TB_ADM_INDEX_STATE]
            WHERE   CAST(ISNULL([SCAN_DATE_END], 0) AS DATE) < CAST(@CURRENTDATETIME AS DATE);

            SET @SCANWAITDATETIME = DATEADD(SECOND, DATEDIFF(SECOND, 0, @scanTimeLimit), GETUTCDATE());

            WHILE EXISTS ( SELECT   1
                           FROM     [#temp_all_indexes]
                           WHERE    [SCAN_DATE_END] IS NULL )
                AND @SCANWAITDATETIME > GETUTCDATE()
            BEGIN
                SELECT TOP 1
                        @OBJECT_ID = [OBJECT_ID]
                FROM    [#temp_all_indexes]
                WHERE   [SCAN_DATE_END] IS NULL
                ORDER BY [DEFRAG_DATE_END];

                UPDATE  [dbo].[TB_ADM_INDEX_STATE]
                SET     [SCAN_DATE_START] = GETUTCDATE()
                WHERE   [OBJECT_ID] = @OBJECT_ID;

                UPDATE  [a]
                SET     [a].[SCAN_DATE_END] = GETUTCDATE(),
                        [a].[FRAGMENTATION] = [avg_fragmentation_in_percent],
                        [a].[PAGES] = [page_count]
                FROM    [dbo].[TB_ADM_INDEX_STATE] [a]
                INNER JOIN ( SELECT [state].[OBJECT_ID],
                                    [state].[INDEX_ID],
                                    [state].[PARTITION],
                                    SUM([stats].[avg_fragmentation_in_percent]) AS [avg_fragmentation_in_percent],
                                    SUM([stats].[page_count]) AS [page_count]
                             FROM   ( SELECT    [OBJECT_ID],
                                                [INDEX_ID],
                                                [PARTITION]
                                      FROM      [#temp_all_indexes] [a]
                                      WHERE     EXISTS ( SELECT 1
                                                         FROM   [sys].[indexes] [ind]
                                                         INNER JOIN [sys].[partitions] [part] ON [part].[index_id] = [ind].[index_id]
                                                                                                 AND [part].[object_id] = [ind].[object_id]
                                                         WHERE  [ind].[object_id] = [a].[OBJECT_ID]
                                                                AND [ind].[index_id] = [a].[INDEX_ID]
                                                                AND [part].[partition_number] = [a].[PARTITION] )
                                    ) [state]
                             CROSS APPLY [dbo].[fn_adm_db_index_physical_stats](DB_ID(), [state].[OBJECT_ID], [state].[INDEX_ID], [state].[PARTITION],
                                                                                CASE WHEN @scanMode = 2 THEN N'LIMITED'
                                                                                     WHEN @scanMode = 3 THEN N'SAMPLED'
                                                                                     WHEN @scanMode = 4 THEN N'DETAILED'
                                                                                END) [stats]
                             WHERE  [state].[OBJECT_ID] = @OBJECT_ID
                             GROUP BY [state].[OBJECT_ID],
                                    [state].[INDEX_ID],
                                    [state].[PARTITION]
                           ) [b] ON [b].[INDEX_ID] = [a].[INDEX_ID]
                                    AND [b].[OBJECT_ID] = [a].[OBJECT_ID]
                                    AND [b].[PARTITION] = [a].[PARTITION];

                DELETE  FROM [#temp_all_indexes]
                WHERE   [OBJECT_ID] = @OBJECT_ID;
            END;
        END;

        IF @scanMode = 1
        BEGIN
            UPDATE  [dbo].[TB_ADM_INDEX_STATE]
            SET     [CURRENT_EXECUTED_STATEMENT] = N'ALTER INDEX [' + [INDEX_NAME] + '] ON ' + '[' + [DATABASE_NAME] + '].[' + [SCHEMA_NAME] + '].['
                    + [OBJECT_NAME] + ']' + SPACE(1) + 'REBUILD' + CASE WHEN [PARTITION] > 1
                                                                        THEN SPACE(1) + 'PARTITION = ' + CAST([PARTITION] AS VARCHAR(10)) + ';'
                                                                        ELSE SPACE(1) + 'WITH ( MAXDOP = ' + CAST(@MAXDROP AS CHAR(1))
                                                                             + CASE WHEN [FILLFACTOR] IS NOT NULL
                                                                                    THEN ', FILLFACTOR = ' + CAST([FILLFACTOR] AS VARCHAR(3))
                                                                                    ELSE ''
                                                                               END + CASE WHEN @ONLINE_REBUILD = 1
                                                                                               AND [BLOB_DATA_TYPE] = 0
                                                                                          THEN ', ONLINE = ON'
                                                                                               + CASE WHEN @SQLVERSION >= 12
                                                                                                      THEN ' (WAIT_AT_LOW_PRIORITY (MAX_DURATION = 5, ABORT_AFTER_WAIT = SELF) '
                                                                                                      ELSE ''
                                                                                                 END
                                                                                          ELSE ''
                                                                                     END + ')'
                                                                   END + ';'
            WHERE   [EXECUTION_MASK] & @TodayMask <> 0
                    AND [RUN_DATE] = CAST(@CURRENTDATETIME AS SMALLDATETIME)
                    AND ( [SCAN_DATE_END] < CAST(@CURRENTDATETIME AS SMALLDATETIME)
                          OR [SCAN_DATE_END] IS NULL
                        );
        END;
        ELSE
        BEGIN
            UPDATE  [state]
            SET     [state].[CURRENT_EXECUTED_STATEMENT] = NULLIF(CASE WHEN [info].[STATE] = 'REBUILD'
                                                                       THEN N'ALTER INDEX [' + [state].[INDEX_NAME] + '] ON ' + '[' + [state].[DATABASE_NAME]
                                                                            + '].[' + [state].[SCHEMA_NAME] + '].[' + [state].[OBJECT_NAME] + ']' + SPACE(1)
                                                                            + 'REBUILD' + CASE WHEN [state].[PARTITION] > 1
                                                                                               THEN SPACE(1) + 'PARTITION = '
                                                                                                    + CAST([state].[PARTITION] AS VARCHAR(10)) + ';'
                                                                                               ELSE SPACE(1) + 'WITH ( MAXDOP = ' + CAST(@MAXDROP AS CHAR(1))
                                                                                                    + CASE WHEN [state].[FILLFACTOR] IS NOT NULL
                                                                                                           THEN ', FILLFACTOR = '
                                                                                                                + CAST([state].[FILLFACTOR] AS VARCHAR(3))
                                                                                                           ELSE ''
                                                                                                      END
                                                                                                    + CASE WHEN @ONLINE_REBUILD = 1
                                                                                                                AND [state].[BLOB_DATA_TYPE] = 0
                                                                                                           THEN ', ONLINE = ON'
                                                                                                                + CASE WHEN @SQLVERSION >= 12
                                                                                                                       THEN ' (WAIT_AT_LOW_PRIORITY (MAX_DURATION = 5, ABORT_AFTER_WAIT = SELF) '
                                                                                                                       ELSE ''
                                                                                                                  END
                                                                                                           ELSE ''
                                                                                                      END + ')'
                                                                                          END
                                                                       WHEN [info].[STATE] = 'REORGANIZE'
                                                                       THEN N'ALTER INDEX [' + [state].[INDEX_NAME] + '] ON ' + '[' + [state].[DATABASE_NAME]
                                                                            + '].[' + [state].[SCHEMA_NAME] + '].[' + [state].[OBJECT_NAME] + ']' + SPACE(1)
                                                                            + 'REORGANIZE'
                                                                       ELSE ''
                                                                  END + ';', ';')
            FROM    [dbo].[TB_ADM_INDEX_STATE] [state]
            INNER JOIN ( SELECT [a].[object_id],
                                [a].[index_id],
                                [a].[partition_number],
                                CASE WHEN [a].[last_user_seek] > CAST(DATEADD(DAY, -1, @CURRENTDATETIME) AS SMALLDATETIME)
                                          OR [a].[last_user_scan] > CAST(DATEADD(DAY, -1, @CURRENTDATETIME) AS SMALLDATETIME)
                                          OR [a].[last_user_lookup] > CAST(DATEADD(DAY, -1, @CURRENTDATETIME) AS SMALLDATETIME) THEN 'REBUILD'
                                     WHEN [a].[last_user_update] > CAST(DATEADD(DAY, -1, @CURRENTDATETIME) AS SMALLDATETIME) THEN 'REORGANIZE'
                                     ELSE 'SKIP'
                                END AS [STATE]
                         FROM   ( SELECT    [indexes].[object_id],
                                            [indexes].[index_id],
                                            [part].[partition_number],
                                            CAST(ISNULL([stats].[last_user_seek], '1900-01-01 00:00:00') AS SMALLDATETIME) AS [last_user_seek],
                                            CAST(ISNULL([stats].[last_user_scan], '1900-01-01 00:00:00') AS SMALLDATETIME) AS [last_user_scan],
                                            CAST(ISNULL([stats].[last_user_lookup], '1900-01-01 00:00:00') AS SMALLDATETIME) AS [last_user_lookup],
                                            CAST(ISNULL([stats].[last_user_update], '1900-01-01 00:00:00') AS SMALLDATETIME) AS [last_user_update]
                                  FROM      [sys].[indexes] [indexes] WITH ( READPAST )
                                  INNER JOIN [sys].[partitions] [part] ON [part].[index_id] = [indexes].[index_id]
                                                                          AND [part].[object_id] = [indexes].[object_id]
                                  INNER JOIN [sys].[objects] [objects] WITH ( READPAST ) ON [indexes].[object_id] = [objects].[object_id]
                                                                                            AND [objects].[is_ms_shipped] = 0
                                                                                            AND [objects].[type] <> 'TF'
                                  LEFT OUTER JOIN [sys].[dm_db_index_usage_stats] [stats] WITH ( READPAST ) ON [indexes].[object_id] = [stats].[object_id]
                                                                                                               AND [indexes].[index_id] = [stats].[index_id]
                                                                                                               AND [stats].[database_id] = DB_ID()
                                  WHERE     [indexes].[type] IN ( 0, 1, 2, 3, 4, 5, 6 )
                                ) [a]
                       ) [info] ON [info].[object_id] = [state].[OBJECT_ID]
                                   AND [info].[index_id] = [state].[INDEX_ID]
                                   AND [info].[partition_number] = [state].[PARTITION]
            WHERE   [state].[EXECUTION_MASK] & @TodayMask <> 0
                    AND [state].[RUN_DATE] = CAST(@CURRENTDATETIME AS SMALLDATETIME)
                    AND ( -- INDEXES THAT HAVEN'T BEEN SCANNED IN THIS RUN, BUT HAVE BEEN USED
                          ( [state].[SCAN_DATE_END] < CAST(@CURRENTDATETIME AS SMALLDATETIME)
                            OR [state].[SCAN_DATE_END] IS NULL
                          )
                                AND ( [info].[STATE] IN ( 'REBUILD', 'REORGANIZE' )
                                OR [state].[FRAGMENTATION] > 30
                              )
                        );

            UPDATE  [dbo].[TB_ADM_INDEX_STATE]
            SET     [CURRENT_EXECUTED_STATEMENT] = NULLIF(CASE WHEN [FRAGMENTATION] > 0
                                                                    AND [FRAGMENTATION] < 30
                                                               THEN N'ALTER INDEX [' + [INDEX_NAME] + '] ON ' + '[' + [DATABASE_NAME] + '].[' + [SCHEMA_NAME]
                                                                    + '].[' + [OBJECT_NAME] + ']' + SPACE(1) + 'REORGANIZE'
                                                               WHEN [FRAGMENTATION] >= 30
                                                               THEN N'ALTER INDEX [' + [INDEX_NAME] + '] ON ' + '[' + [DATABASE_NAME] + '].[' + [SCHEMA_NAME]
                                                                    + '].[' + [OBJECT_NAME] + ']' + SPACE(1) + 'REBUILD'
                                                                    + CASE WHEN [PARTITION] > 1
                                                                           THEN SPACE(1) + 'PARTITION = ' + CAST([PARTITION] AS VARCHAR(10)) + ';'
                                                                           ELSE SPACE(1) + 'WITH ( MAXDOP = ' + CAST(@MAXDROP AS CHAR(1))
                                                                                + CASE WHEN [FILLFACTOR] IS NOT NULL
                                                                                       THEN ', FILLFACTOR = ' + CAST([FILLFACTOR] AS VARCHAR(3))
                                                                                       ELSE ''
                                                                                  END + CASE WHEN @ONLINE_REBUILD = 1
                                                                                                  AND [BLOB_DATA_TYPE] = 0
                                                                                             THEN ', ONLINE = ON'
                                                                                                  + CASE WHEN @SQLVERSION >= 12
                                                                                                         THEN ' (WAIT_AT_LOW_PRIORITY (MAX_DURATION = 5, ABORT_AFTER_WAIT = SELF) '
                                                                                                         ELSE ''
                                                                                                    END
                                                                                             ELSE ''
                                                                                        END + ')'
                                                                      END
                                                               ELSE ''
                                                          END + ';', ';')
            WHERE   [EXECUTION_MASK] & @TodayMask <> 0
                    AND [RUN_DATE] = CAST(@CURRENTDATETIME AS SMALLDATETIME)
                    AND [SCAN_DATE_START] IS NOT NULL;
        END;
    END;
GO
