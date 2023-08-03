SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[ap_sys_get_space_used]
AS
    BEGIN
        SET NOCOUNT ON;
        DROP TABLE IF EXISTS #tableInformation;
        -- GRAB INITIAL TABLE INFORMATION
        SELECT  [BASE_TABLE_NAME],
                [a].[PKEY_TABLE_NAME],
                [INTERNAL_NAME],
                CAST(NULL AS CHAR(2)) AS [CLUSTER_IDENTIFIER],
                CAST(NULL AS VARCHAR(512)) AS [RELATIONSHIP]
        INTO    [#tableInformation]
        FROM    ( SELECT    [TABLE_NAME] AS [BASE_TABLE_NAME],
                            CONCAT([TABLE_NAME], '_PKEY_MAP') AS [PKEY_TABLE_NAME],
                            [INTERNAL_NAME]
                  FROM      [dbo].[TE_DIM_ITEM_TYPE]
                  WHERE     [TABLE_NAME] IS NOT NULL
                ) [a]
        -- Make sure that the table and the pkey table exist
        WHERE   EXISTS ( SELECT 1
                         FROM   [sys].[objects] [b]
                         WHERE  [b].[object_id] = OBJECT_ID([a].[BASE_TABLE_NAME]) )
                AND EXISTS ( SELECT 1
                             FROM   [sys].[objects] [p]
                             WHERE  [p].[object_id] = OBJECT_ID([a].[PKEY_TABLE_NAME]) );
        -- WHAT'S THE CLUSTER IDENTIFIER?
        MERGE INTO [#tableInformation] [TARGET]
        USING
            ( SELECT    [BASE_TABLE_NAME],
                        [tb].[PKEY_TABLE_NAME],
                        MAX(CASE WHEN [c].[NAME] = 'CLUSTER_RESOURCE_URN' THEN 'BC'
                                 WHEN [c].[NAME] = 'RESOURCE_URN' THEN 'BR'
                                 WHEN [c].[NAME] = 'RESOURCE_ID' THEN 'BS'
                                 WHEN [c].[NAME] = 'CLUSTER_RESOURCE_ID' THEN 'BI'
                                 WHEN [d].[NAME] = 'CLUSTER_RESOURCE_URN' THEN 'PC'
                                 WHEN [d].[NAME] = 'RESOURCE_URN' THEN 'PR'
                                 WHEN [d].[NAME] = 'RESOURCE_ID' THEN 'PS'
                                 WHEN [d].[NAME] = 'CLUSTER_RESOURCE_ID' THEN 'PI'
                                 ELSE NULL
                            END) AS [CLUSTER_IDENTIFIER]
              FROM      [#tableInformation] [tb]
              INNER JOIN [sys].[columns] [c] ON [c].[object_id] = OBJECT_ID([tb].[BASE_TABLE_NAME])
              INNER JOIN [sys].[columns] [d] ON [d].[object_id] = OBJECT_ID([tb].[PKEY_TABLE_NAME])
              GROUP BY  [BASE_TABLE_NAME],
                        [tb].[PKEY_TABLE_NAME]
            ) [SOURCE]
        ON [TARGET].[BASE_TABLE_NAME] = [SOURCE].[BASE_TABLE_NAME]
            AND [TARGET].[PKEY_TABLE_NAME] = [SOURCE].[PKEY_TABLE_NAME]
        WHEN MATCHED THEN
            UPDATE SET
                    [TARGET].[CLUSTER_IDENTIFIER] = [SOURCE].[CLUSTER_IDENTIFIER];
        -- BUILD THE RELATIONSHIP BETWEEN BASE AND PKEY TABLE
        MERGE INTO [#tableInformation] [TARGET]
        USING
            ( SELECT    [BASE_TABLE_NAME],
                        [a].[PKEY_TABLE_NAME],
                        [ca].[key_join]
              FROM      [#tableInformation] [a]
              INNER JOIN [sys].[foreign_keys] [fk] ON [fk].[parent_object_id] = OBJECT_ID([a].[PKEY_TABLE_NAME])
                                                      AND [fk].[referenced_object_id] = OBJECT_ID([a].[BASE_TABLE_NAME])
              CROSS APPLY ( SELECT  STUFF((SELECT   CONCAT(CHAR(13), CHAR(10), 'AND [p].[', COL_NAME([fkc].[parent_object_id], [fkc].[parent_column_id]),
                                                           '] = [b].[', COL_NAME([fkc].[referenced_object_id], [fkc].[constraint_column_id]), ']')
                                           FROM     [sys].[foreign_key_columns] [fkc]
                                           WHERE    [fkc].[constraint_object_id] = [fk].[object_id]
                                    FOR   XML PATH(''),
                                              TYPE).[value]('.', 'NVARCHAR(MAX)'), 1, 6, '')
                          ) [ca] ( [key_join] )
            ) [SOURCE]
        ON [TARGET].[BASE_TABLE_NAME] = [SOURCE].[BASE_TABLE_NAME]
            AND [TARGET].[PKEY_TABLE_NAME] = [SOURCE].[PKEY_TABLE_NAME]
        WHEN MATCHED THEN
            UPDATE SET
                    [TARGET].[RELATIONSHIP] = [SOURCE].[key_join];
        DELETE  FROM [#tableInformation]
        WHERE   [CLUSTER_IDENTIFIER] IS NULL
                OR [CLUSTER_IDENTIFIER] = '';
        -- BUILD THE DYNAMIC ROW COUNT PER CLUSTER PER TYPE
        DROP TABLE IF EXISTS #dynamic;
        SELECT  CONCAT('SELECT ', CHAR(39), [INTERNAL_NAME], CHAR(39), ' AS [INTERNAL_NAME], [BASE_RECORDS], [PKEY_RECORDS], ',
                       CASE WHEN [CLUSTER_IDENTIFIER] IN ( 'BC', 'PC' ) THEN '[CLUSTER_RESOURCE_URN]'
                            WHEN [CLUSTER_IDENTIFIER] IN ( 'BR', 'PR' ) THEN '[RESOURCE_URN]'
                            WHEN [CLUSTER_IDENTIFIER] IN ( 'BS', 'PS' ) THEN '[RESOURCE_ID]'
                            WHEN [CLUSTER_IDENTIFIER] IN ( 'BI', 'PI' ) THEN '[CLUSTER_RESOURCE_ID]'
                       END, ', ', CHAR(39), [BASE_TABLE_NAME], CHAR(39), ', ', CHAR(39), [PKEY_TABLE_NAME], CHAR(39), CHAR(13), CHAR(10), 'FROM (', CHAR(13),
                       CHAR(10), 'SELECT COUNT(DISTINCT [b].[ITEM_URN]) AS [BASE_RECORDS], COUNT(DISTINCT [p].[PKEY_MAP_URN]) AS [PKEY_RECORDS], ',
                       CASE WHEN [CLUSTER_IDENTIFIER] = 'BC' THEN '[b].[CLUSTER_RESOURCE_URN]'
                            WHEN [CLUSTER_IDENTIFIER] = 'BR' THEN '[b].[RESOURCE_URN]'
                            WHEN [CLUSTER_IDENTIFIER] = 'BS' THEN '[b].[RESOURCE_ID]'
                            WHEN [CLUSTER_IDENTIFIER] = 'BI' THEN '[b].[CLUSTER_RESOURCE_ID]'
                            WHEN [CLUSTER_IDENTIFIER] = 'PC' THEN '[p].[CLUSTER_RESOURCE_URN]'
                            WHEN [CLUSTER_IDENTIFIER] = 'PR' THEN '[p].[RESOURCE_URN]'
                            WHEN [CLUSTER_IDENTIFIER] = 'PS' THEN '[p].[RESOURCE_ID]'
                            WHEN [CLUSTER_IDENTIFIER] = 'PI' THEN '[p].[CLUSTER_RESOURCE_ID]'
                       END, CHAR(13), CHAR(10), 'FROM [', [BASE_TABLE_NAME], '] [b]', CHAR(13), CHAR(10), 'INNER JOIN [', [PKEY_TABLE_NAME], '] [p] ON ',
                       [RELATIONSHIP], CHAR(13), CHAR(10), 'GROUP BY ', CASE WHEN [CLUSTER_IDENTIFIER] = 'BC' THEN '[b].[CLUSTER_RESOURCE_URN]'
                                                                             WHEN [CLUSTER_IDENTIFIER] = 'BR' THEN '[b].[RESOURCE_URN]'
                                                                             WHEN [CLUSTER_IDENTIFIER] = 'BS' THEN '[b].[RESOURCE_ID]'
                                                                             WHEN [CLUSTER_IDENTIFIER] = 'BI' THEN '[b].[CLUSTER_RESOURCE_ID]'
                                                                             WHEN [CLUSTER_IDENTIFIER] = 'PC' THEN '[p].[CLUSTER_RESOURCE_URN]'
                                                                             WHEN [CLUSTER_IDENTIFIER] = 'PR' THEN '[p].[RESOURCE_URN]'
                                                                             WHEN [CLUSTER_IDENTIFIER] = 'PS' THEN '[p].[RESOURCE_ID]'
                                                                             WHEN [CLUSTER_IDENTIFIER] = 'PI' THEN '[p].[CLUSTER_RESOURCE_ID]'
                                                                        END, ')a', CHAR(13), CHAR(10), ';') AS [SQL],
                [INTERNAL_NAME]
        INTO    [#dynamic]
        FROM    [#tableInformation];
        DROP TABLE IF EXISTS [#tableInformation];
        DROP TABLE IF EXISTS [#TS_SYS_TABLE_SPACE_USED];
        CREATE TABLE [#TS_SYS_TABLE_SPACE_USED]
            (
              [INTERNAL_NAME] VARCHAR(255) NOT NULL,
              [BASE_ROW_COUNT] INT NOT NULL,
              [PKEY_ROW_COUNT] INT NOT NULL,
              [CLUSTER_RESOURCE] VARCHAR(36) NULL,
              [CLUSTER_RESOURCE_URN] INT NULL,
              [BASE_TABLE_NAME] VARCHAR(255) NULL,
              [PKEY_TABLE_NAME] VARCHAR(255) NULL
            );
        DECLARE @SQL NVARCHAR(MAX),
            @INTERNAL_NAME VARCHAR(255);
        -- INSERT THE ROWCOUNTS PER CLUSTER PER TYPE
        WHILE EXISTS ( SELECT   1
                       FROM     [#dynamic] )
        BEGIN
            SELECT  @SQL = [a].[SQL],
                    @INTERNAL_NAME = [INTERNAL_NAME]
            FROM    ( SELECT TOP 1
                                [SQL],
                                [INTERNAL_NAME]
                      FROM      [#dynamic]
                      ORDER BY  [INTERNAL_NAME]
                    ) [a];
            INSERT  INTO [#TS_SYS_TABLE_SPACE_USED]
                    ( [INTERNAL_NAME],
                      [BASE_ROW_COUNT],
                      [PKEY_ROW_COUNT],
                      [CLUSTER_RESOURCE],
                      [BASE_TABLE_NAME],
                      [PKEY_TABLE_NAME]
                    )
                    EXECUTE [sp_executesql] @SQL;
            DELETE  FROM [#dynamic]
            WHERE   [SQL] = @SQL;
        END;
        DROP TABLE IF EXISTS [#dynamic];
        -- REMOVE ANY COUNTS WHERE WE DON'T HAVE A CLUSTER IDENTIFIER
        DELETE  FROM [#TS_SYS_TABLE_SPACE_USED]
        WHERE   [CLUSTER_RESOURCE] IS NULL;
        -- FIND THE CLUSTER INTEGER IDENTIFIER
        MERGE INTO [#TS_SYS_TABLE_SPACE_USED] [TARGET]
        USING
            ( SELECT    [a].[INTERNAL_NAME],
                        [a].[BASE_ROW_COUNT],
                        [a].[PKEY_ROW_COUNT],
                        [a].[CLUSTER_RESOURCE],
                        [a].[CLUSTER_RESOURCE_URN]
              FROM      ( SELECT    [u].[INTERNAL_NAME],
                                    [u].[BASE_ROW_COUNT],
                                    [u].[PKEY_ROW_COUNT],
                                    [u].[CLUSTER_RESOURCE],
                                    ISNULL([r].[RESOURCE_URN], TRY_CAST([u].[CLUSTER_RESOURCE] AS INT)) AS [CLUSTER_RESOURCE_URN]
                          FROM      [#TS_SYS_TABLE_SPACE_USED] [u]
                          LEFT OUTER JOIN [dbo].[TB_CLU_RESOURCE] [r] ON TRY_CAST([u].[CLUSTER_RESOURCE] AS UNIQUEIDENTIFIER) = [r].[RESOURCE_ID]
                        ) [a]
              WHERE     [a].[CLUSTER_RESOURCE_URN] IS NOT NULL
            ) [SOURCE]
        ON [SOURCE].[INTERNAL_NAME] = [TARGET].[INTERNAL_NAME]
            AND [SOURCE].[CLUSTER_RESOURCE] = [TARGET].[CLUSTER_RESOURCE]
        WHEN MATCHED THEN
            UPDATE SET
                    [TARGET].[CLUSTER_RESOURCE_URN] = [SOURCE].[CLUSTER_RESOURCE_URN];
        -- GET THE SPACE PER ROW FOR BASE EACH TYPE
        MERGE INTO [dbo].[TS_SYS_TABLE_SPACE_USED] [TARGET]
        USING
            ( SELECT    [a].[INTERNAL_NAME],
                        [a].[CLUSTER_RESOURCE_URN],
                        [a].[BASE_ROW_COUNT],
                        'D' AS [TYPE],
                        SUM([a].[Space per row(MB)]) AS [Space per row(MB)]
              FROM      ( SELECT    [table].[INTERNAL_NAME],
                                    [table].[CLUSTER_RESOURCE_URN],
                                    [table].[BASE_ROW_COUNT],
                                    CASE WHEN [partitions].[rows] = 0 THEN 0
                                         ELSE CONVERT(DECIMAL(22, 6), ( SUM([space].[used_pages]) * 8 / 1024.0 ) / [partitions].[rows])
                                    END AS [Space per row(MB)]
                          FROM      [#TS_SYS_TABLE_SPACE_USED] [table]
                          INNER JOIN [sys].[indexes] [indexes] ON OBJECT_ID([table].[BASE_TABLE_NAME]) = [indexes].[object_id]
                          INNER JOIN [sys].[partitions] [partitions] ON [indexes].[object_id] = [partitions].[OBJECT_ID]
                                                                        AND [indexes].[index_id] = [partitions].[index_id]
                          INNER JOIN [sys].[allocation_units] [space] ON [partitions].[partition_id] = [space].[container_id]
                          GROUP BY  [table].[INTERNAL_NAME],
                                    [table].[CLUSTER_RESOURCE_URN],
                                    [table].[BASE_ROW_COUNT],
                                    [partitions].[rows]
                        ) [a]
              GROUP BY  [a].[INTERNAL_NAME],
                        [a].[CLUSTER_RESOURCE_URN],
                        [a].[BASE_ROW_COUNT]
            ) [SOURCE]
        ON [SOURCE].[INTERNAL_NAME] COLLATE Latin1_General_CI_AS = [TARGET].[INTERNAL_NAME] COLLATE Latin1_General_CI_AS
            AND [SOURCE].[CLUSTER_RESOURCE_URN] = [TARGET].[CLUSTER_RESOURCE_URN]
            AND [SOURCE].[TYPE] = [TARGET].[TYPE]
        WHEN MATCHED THEN
            UPDATE SET
                    [TARGET].[BASE_ROW_COUNT] = ISNULL([SOURCE].[BASE_ROW_COUNT], 0),
                    [TARGET].[BASE_SPACE_PER_ROW] = ISNULL([SOURCE].[Space per row(MB)], 0),
                    [TARGET].[CALCULATION_DATE] = SYSUTCDATETIME()
        WHEN NOT MATCHED THEN
            INSERT ( [TYPE],
                     [INTERNAL_NAME],
                     [CLUSTER_RESOURCE_URN],
                     [BASE_ROW_COUNT],
                     [BASE_SPACE_PER_ROW]
                   )
            VALUES ( [SOURCE].[TYPE],
                     [SOURCE].[INTERNAL_NAME],
                     [SOURCE].[CLUSTER_RESOURCE_URN],
                     ISNULL([SOURCE].[BASE_ROW_COUNT], 0),
                     ISNULL([SOURCE].[Space per row(MB)], 0)
                   );
        -- GET THE SPACE PER ROW FOR PKEY EACH TYPE
        MERGE INTO [dbo].[TS_SYS_TABLE_SPACE_USED] [TARGET]
        USING
            ( SELECT    [a].[INTERNAL_NAME],
                        [a].[CLUSTER_RESOURCE_URN],
                        [a].[PKEY_ROW_COUNT],
                        'D' AS [TYPE],
                        SUM([a].[Space per row(MB)]) AS [Space per row(MB)]
              FROM      ( SELECT    [table].[INTERNAL_NAME],
                                    [table].[CLUSTER_RESOURCE_URN],
                                    [table].[PKEY_ROW_COUNT],
                                    CASE WHEN [partitions].[rows] = 0 THEN 0
                                         ELSE CONVERT(DECIMAL(22, 6), ( SUM([space].[used_pages]) * 8 / 1024.0 ) / [partitions].[rows])
                                    END AS [Space per row(MB)]
                          FROM      [#TS_SYS_TABLE_SPACE_USED] [table]
                          INNER JOIN [sys].[indexes] [indexes] ON OBJECT_ID([table].[PKEY_TABLE_NAME]) = [indexes].[object_id]
                          INNER JOIN [sys].[partitions] [partitions] ON [indexes].[object_id] = [partitions].[OBJECT_ID]
                                                                        AND [indexes].[index_id] = [partitions].[index_id]
                          INNER JOIN [sys].[allocation_units] [space] ON [partitions].[partition_id] = [space].[container_id]
                          GROUP BY  [table].[INTERNAL_NAME],
                                    [table].[CLUSTER_RESOURCE_URN],
                                    [table].[PKEY_ROW_COUNT],
                                    [partitions].[rows]
                        ) [a]
              GROUP BY  [a].[INTERNAL_NAME],
                        [a].[CLUSTER_RESOURCE_URN],
                        [a].[PKEY_ROW_COUNT]
            ) [SOURCE]
        ON [SOURCE].[INTERNAL_NAME] COLLATE Latin1_General_CI_AS = [TARGET].[INTERNAL_NAME] COLLATE Latin1_General_CI_AS
            AND [SOURCE].[CLUSTER_RESOURCE_URN] = [TARGET].[CLUSTER_RESOURCE_URN]
            AND [SOURCE].[TYPE] = [TARGET].[TYPE]
        WHEN MATCHED THEN
            UPDATE SET
                    [TARGET].[PKEY_ROW_COUNT] = ISNULL([SOURCE].[PKEY_ROW_COUNT], 0),
                    [TARGET].[PKEY_SPACE_PER_ROW] = ISNULL([SOURCE].[Space per row(MB)], 0),
                    [TARGET].[CALCULATION_DATE] = SYSUTCDATETIME();
        DROP TABLE IF EXISTS [#TS_SYS_TABLE_SPACE_USED];
        DROP TABLE IF EXISTS #tableInformation;
        DROP TABLE IF EXISTS [#TS_SYS_TABLE_SPACE_USED2];
        DROP TABLE IF EXISTS #tableInformation2;
        -- GRAB INITIAL TABLE INFORMATION
        SELECT  [BASE_TABLE_NAME],
                [a].[PKEY_TABLE_NAME],
                [INTERNAL_NAME],
                CAST(NULL AS CHAR(2)) AS [CLUSTER_IDENTIFIER],
                CAST(NULL AS VARCHAR(512)) AS [RELATIONSHIP]
        INTO    [#tableInformation2]
        FROM    ( SELECT    [TABLE_NAME] AS [BASE_TABLE_NAME],
                            CONCAT([TABLE_NAME], '_PKEY_MAP') AS [PKEY_TABLE_NAME],
                            [INTERNAL_NAME]
                  FROM      [dbo].[TE_DIM_MEMBER_TYPE]
                  WHERE     [TABLE_NAME] IS NOT NULL
                ) [a]
        -- Make sure that the table and the pkey table exist
        WHERE   EXISTS ( SELECT 1
                         FROM   [sys].[objects] [b]
                         WHERE  [b].[object_id] = OBJECT_ID([a].[BASE_TABLE_NAME]) )
                AND EXISTS ( SELECT 1
                             FROM   [sys].[objects] [p]
                             WHERE  [p].[object_id] = OBJECT_ID([a].[PKEY_TABLE_NAME]) );
        -- WHAT'S THE CLUSTER IDENTIFIER?
        MERGE INTO [#tableInformation2] [TARGET]
        USING
            ( SELECT    [BASE_TABLE_NAME],
                        [tb].[PKEY_TABLE_NAME],
                        MAX(CASE WHEN [c].[NAME] = 'CLUSTER_RESOURCE_URN' THEN 'BC'
                                 WHEN [c].[NAME] = 'RESOURCE_URN' THEN 'BR'
                                 WHEN [c].[NAME] = 'RESOURCE_ID' THEN 'BS'
                                 WHEN [c].[NAME] = 'CLUSTER_RESOURCE_ID' THEN 'BI'
                                 WHEN [d].[NAME] = 'CLUSTER_RESOURCE_URN' THEN 'PC'
                                 WHEN [d].[NAME] = 'RESOURCE_URN' THEN 'PR'
                                 WHEN [d].[NAME] = 'RESOURCE_ID' THEN 'PS'
                                 WHEN [d].[NAME] = 'CLUSTER_RESOURCE_ID' THEN 'PI'
                                 ELSE NULL
                            END) AS [CLUSTER_IDENTIFIER]
              FROM      [#tableInformation2] [tb]
              INNER JOIN [sys].[columns] [c] ON [c].[object_id] = OBJECT_ID([tb].[BASE_TABLE_NAME])
              INNER JOIN [sys].[columns] [d] ON [d].[object_id] = OBJECT_ID([tb].[PKEY_TABLE_NAME])
              GROUP BY  [BASE_TABLE_NAME],
                        [tb].[PKEY_TABLE_NAME]
            ) [SOURCE]
        ON [TARGET].[BASE_TABLE_NAME] = [SOURCE].[BASE_TABLE_NAME]
            AND [TARGET].[PKEY_TABLE_NAME] = [SOURCE].[PKEY_TABLE_NAME]
        WHEN MATCHED THEN
            UPDATE SET
                    [TARGET].[CLUSTER_IDENTIFIER] = [SOURCE].[CLUSTER_IDENTIFIER];
        -- BUILD THE RELATIONSHIP BETWEEN BASE AND PKEY TABLE
        MERGE INTO [#tableInformation2] [TARGET]
        USING
            ( SELECT    [BASE_TABLE_NAME],
                        [a].[PKEY_TABLE_NAME],
                        [ca].[key_join]
              FROM      [#tableInformation2] [a]
              INNER JOIN [sys].[foreign_keys] [fk] ON [fk].[parent_object_id] = OBJECT_ID([a].[PKEY_TABLE_NAME])
                                                      AND [fk].[referenced_object_id] = OBJECT_ID([a].[BASE_TABLE_NAME])
              CROSS APPLY ( SELECT  STUFF((SELECT   CONCAT(CHAR(13), CHAR(10), 'AND [p].[', COL_NAME([fkc].[parent_object_id], [fkc].[parent_column_id]),
                                                           '] = [b].[', COL_NAME([fkc].[referenced_object_id], [fkc].[constraint_column_id]), ']')
                                           FROM     [sys].[foreign_key_columns] [fkc]
                                           WHERE    [fkc].[constraint_object_id] = [fk].[object_id]
                                    FOR   XML PATH(''),
                                              TYPE).[value]('.', 'NVARCHAR(MAX)'), 1, 6, '')
                          ) [ca] ( [key_join] )
            ) [SOURCE]
        ON [TARGET].[BASE_TABLE_NAME] = [SOURCE].[BASE_TABLE_NAME]
            AND [TARGET].[PKEY_TABLE_NAME] = [SOURCE].[PKEY_TABLE_NAME]
        WHEN MATCHED THEN
            UPDATE SET
                    [TARGET].[RELATIONSHIP] = [SOURCE].[key_join];
        DELETE  FROM [#tableInformation2]
        WHERE   [CLUSTER_IDENTIFIER] IS NULL
                OR [CLUSTER_IDENTIFIER] = '';
        -- BUILD THE DYNAMIC ROW COUNT PER CLUSTER PER TYPE
        DROP TABLE IF EXISTS #dynamic2;
        SELECT  CONCAT('SELECT ', CHAR(39), [INTERNAL_NAME], CHAR(39), ' AS [INTERNAL_NAME], [BASE_RECORDS], [PKEY_RECORDS], ',
                       CASE WHEN [CLUSTER_IDENTIFIER] IN ( 'BC', 'PC' ) THEN '[CLUSTER_RESOURCE_URN]'
                            WHEN [CLUSTER_IDENTIFIER] IN ( 'BR', 'PR' ) THEN '[RESOURCE_URN]'
                            WHEN [CLUSTER_IDENTIFIER] IN ( 'BS', 'PS' ) THEN '[RESOURCE_ID]'
                            WHEN [CLUSTER_IDENTIFIER] IN ( 'BI', 'PI' ) THEN '[CLUSTER_RESOURCE_ID]'
                       END, ', ', CHAR(39), [BASE_TABLE_NAME], CHAR(39), ', ', CHAR(39), [PKEY_TABLE_NAME], CHAR(39), CHAR(13), CHAR(10), 'FROM (', CHAR(13),
                       CHAR(10), 'SELECT COUNT(DISTINCT [b].[MEMBER_URN]) AS [BASE_RECORDS], COUNT(DISTINCT [p].[PKEY_MAP_URN]) AS [PKEY_RECORDS], ',
                       CASE WHEN [CLUSTER_IDENTIFIER] = 'BC' THEN '[b].[CLUSTER_RESOURCE_URN]'
                            WHEN [CLUSTER_IDENTIFIER] = 'BR' THEN '[b].[RESOURCE_URN]'
                            WHEN [CLUSTER_IDENTIFIER] = 'BS' THEN '[b].[RESOURCE_ID]'
                            WHEN [CLUSTER_IDENTIFIER] = 'BI' THEN '[b].[CLUSTER_RESOURCE_ID]'
                            WHEN [CLUSTER_IDENTIFIER] = 'PC' THEN '[p].[CLUSTER_RESOURCE_URN]'
                            WHEN [CLUSTER_IDENTIFIER] = 'PR' THEN '[p].[RESOURCE_URN]'
                            WHEN [CLUSTER_IDENTIFIER] = 'PS' THEN '[p].[RESOURCE_ID]'
                            WHEN [CLUSTER_IDENTIFIER] = 'PI' THEN '[p].[CLUSTER_RESOURCE_ID]'
                       END, CHAR(13), CHAR(10), 'FROM [', [BASE_TABLE_NAME], '] [b]', CHAR(13), CHAR(10), 'INNER JOIN [', [PKEY_TABLE_NAME], '] [p] ON ',
                       [RELATIONSHIP], CHAR(13), CHAR(10), 'GROUP BY ', CASE WHEN [CLUSTER_IDENTIFIER] = 'BC' THEN '[b].[CLUSTER_RESOURCE_URN]'
                                                                             WHEN [CLUSTER_IDENTIFIER] = 'BR' THEN '[b].[RESOURCE_URN]'
                                                                             WHEN [CLUSTER_IDENTIFIER] = 'BS' THEN '[b].[RESOURCE_ID]'
                                                                             WHEN [CLUSTER_IDENTIFIER] = 'BI' THEN '[b].[CLUSTER_RESOURCE_ID]'
                                                                             WHEN [CLUSTER_IDENTIFIER] = 'PC' THEN '[p].[CLUSTER_RESOURCE_URN]'
                                                                             WHEN [CLUSTER_IDENTIFIER] = 'PR' THEN '[p].[RESOURCE_URN]'
                                                                             WHEN [CLUSTER_IDENTIFIER] = 'PS' THEN '[p].[RESOURCE_ID]'
                                                                             WHEN [CLUSTER_IDENTIFIER] = 'PI' THEN '[p].[CLUSTER_RESOURCE_ID]'
                                                                        END, ')a', CHAR(13), CHAR(10), ';') AS [SQL],
                [INTERNAL_NAME]
        INTO    [#dynamic2]
        FROM    [#tableInformation2];
        DROP TABLE IF EXISTS [#tableInformation2];
        DROP TABLE IF EXISTS [#TS_SYS_TABLE_SPACE_USED2];
        CREATE TABLE [#TS_SYS_TABLE_SPACE_USED2]
            (
              [INTERNAL_NAME] VARCHAR(255) NOT NULL,
              [BASE_ROW_COUNT] INT NOT NULL,
              [PKEY_ROW_COUNT] INT NOT NULL,
              [CLUSTER_RESOURCE] VARCHAR(36) NULL,
              [CLUSTER_RESOURCE_URN] INT NULL,
              [BASE_TABLE_NAME] VARCHAR(255) NULL,
              [PKEY_TABLE_NAME] VARCHAR(255) NULL
            );
        SET @SQL = NULL;
        SET @INTERNAL_NAME = NULL;
        -- INSERT THE ROWCOUNTS PER CLUSTER PER TYPE
        WHILE EXISTS ( SELECT   1
                       FROM     [#dynamic2] )
        BEGIN
            SELECT  @SQL = [a].[SQL],
                    @INTERNAL_NAME = [INTERNAL_NAME]
            FROM    ( SELECT TOP 1
                                [SQL],
                                [INTERNAL_NAME]
                      FROM      [#dynamic2]
                      ORDER BY  [INTERNAL_NAME]
                    ) [a];
            INSERT  INTO [#TS_SYS_TABLE_SPACE_USED2]
                    ( [INTERNAL_NAME],
                      [BASE_ROW_COUNT],
                      [PKEY_ROW_COUNT],
                      [CLUSTER_RESOURCE],
                      [BASE_TABLE_NAME],
                      [PKEY_TABLE_NAME]
                    )
                    EXECUTE [sp_executesql] @SQL;
            DELETE  FROM [#dynamic2]
            WHERE   [SQL] = @SQL;
        END;
        DROP TABLE IF EXISTS [#dynamic2];
        -- REMOVE ANY COUNTS WHERE WE DON'T HAVE A CLUSTER IDENTIFIER
        DELETE  FROM [#TS_SYS_TABLE_SPACE_USED2]
        WHERE   [CLUSTER_RESOURCE] IS NULL;
        -- FIND THE CLUSTER INTEGER IDENTIFIER
        MERGE INTO [#TS_SYS_TABLE_SPACE_USED2] [TARGET]
        USING
            ( SELECT    [a].[INTERNAL_NAME],
                        [a].[BASE_ROW_COUNT],
                        [a].[PKEY_ROW_COUNT],
                        [a].[CLUSTER_RESOURCE],
                        [a].[CLUSTER_RESOURCE_URN]
              FROM      ( SELECT    [u].[INTERNAL_NAME],
                                    [u].[BASE_ROW_COUNT],
                                    [u].[PKEY_ROW_COUNT],
                                    [u].[CLUSTER_RESOURCE],
                                    ISNULL([r].[RESOURCE_URN], TRY_CAST([u].[CLUSTER_RESOURCE] AS INT)) AS [CLUSTER_RESOURCE_URN]
                          FROM      [#TS_SYS_TABLE_SPACE_USED2] [u]
                          LEFT OUTER JOIN [dbo].[TB_CLU_RESOURCE] [r] ON TRY_CAST([u].[CLUSTER_RESOURCE] AS UNIQUEIDENTIFIER) = [r].[RESOURCE_ID]
                        ) [a]
              WHERE     [a].[CLUSTER_RESOURCE_URN] IS NOT NULL
            ) [SOURCE]
        ON [SOURCE].[INTERNAL_NAME] = [TARGET].[INTERNAL_NAME]
            AND [SOURCE].[CLUSTER_RESOURCE] = [TARGET].[CLUSTER_RESOURCE]
        WHEN MATCHED THEN
            UPDATE SET
                    [TARGET].[CLUSTER_RESOURCE_URN] = [SOURCE].[CLUSTER_RESOURCE_URN];
        -- GET THE SPACE PER ROW FOR BASE EACH TYPE
        MERGE INTO [dbo].[TS_SYS_TABLE_SPACE_USED] [TARGET]
        USING
            ( SELECT    [a].[INTERNAL_NAME],
                        [a].[CLUSTER_RESOURCE_URN],
                        [a].[BASE_ROW_COUNT],
                        'M' AS [TYPE],
                        SUM([a].[Space per row(MB)]) AS [Space per row(MB)]
              FROM      ( SELECT    [table].[INTERNAL_NAME],
                                    [table].[CLUSTER_RESOURCE_URN],
                                    [table].[BASE_ROW_COUNT],
                                    CASE WHEN [partitions].[rows] = 0 THEN 0
                                         ELSE CONVERT(DECIMAL(22, 6), ( SUM([space].[used_pages]) * 8 / 1024.0 ) / [partitions].[rows])
                                    END AS [Space per row(MB)]
                          FROM      [#TS_SYS_TABLE_SPACE_USED2] [table]
                          INNER JOIN [sys].[indexes] [indexes] ON OBJECT_ID([table].[BASE_TABLE_NAME]) = [indexes].[object_id]
                          INNER JOIN [sys].[partitions] [partitions] ON [indexes].[object_id] = [partitions].[OBJECT_ID]
                                                                        AND [indexes].[index_id] = [partitions].[index_id]
                          INNER JOIN [sys].[allocation_units] [space] ON [partitions].[partition_id] = [space].[container_id]
                          GROUP BY  [table].[INTERNAL_NAME],
                                    [table].[CLUSTER_RESOURCE_URN],
                                    [table].[BASE_ROW_COUNT],
                                    [partitions].[rows]
                        ) [a]
              GROUP BY  [a].[INTERNAL_NAME],
                        [a].[CLUSTER_RESOURCE_URN],
                        [a].[BASE_ROW_COUNT]
            ) [SOURCE]
        ON [SOURCE].[INTERNAL_NAME] COLLATE Latin1_General_CI_AS = [TARGET].[INTERNAL_NAME] COLLATE Latin1_General_CI_AS
            AND [SOURCE].[CLUSTER_RESOURCE_URN] = [TARGET].[CLUSTER_RESOURCE_URN]
            AND [SOURCE].[TYPE] = [TARGET].[TYPE]
        WHEN MATCHED THEN
            UPDATE SET
                    [TARGET].[BASE_ROW_COUNT] = ISNULL([SOURCE].[BASE_ROW_COUNT], 0),
                    [TARGET].[BASE_SPACE_PER_ROW] = ISNULL([SOURCE].[Space per row(MB)], 0),
                    [TARGET].[CALCULATION_DATE] = SYSUTCDATETIME()
        WHEN NOT MATCHED THEN
            INSERT ( [TYPE],
                     [INTERNAL_NAME],
                     [CLUSTER_RESOURCE_URN],
                     [BASE_ROW_COUNT],
                     [BASE_SPACE_PER_ROW]
                   )
            VALUES ( [SOURCE].[TYPE],
                     [SOURCE].[INTERNAL_NAME],
                     [SOURCE].[CLUSTER_RESOURCE_URN],
                     ISNULL([SOURCE].[BASE_ROW_COUNT], 0),
                     ISNULL([SOURCE].[Space per row(MB)], 0)
                   );
        -- GET THE SPACE PER ROW FOR PKEY EACH TYPE
        MERGE INTO [dbo].[TS_SYS_TABLE_SPACE_USED] [TARGET]
        USING
            ( SELECT    [a].[INTERNAL_NAME],
                        [a].[CLUSTER_RESOURCE_URN],
                        [a].[PKEY_ROW_COUNT],
                        'M' AS [TYPE],
                        SUM([a].[Space per row(MB)]) AS [Space per row(MB)]
              FROM      ( SELECT    [table].[INTERNAL_NAME],
                                    [table].[CLUSTER_RESOURCE_URN],
                                    [table].[PKEY_ROW_COUNT],
                                    CASE WHEN [partitions].[rows] = 0 THEN 0
                                         ELSE CONVERT(DECIMAL(22, 6), ( SUM([space].[used_pages]) * 8 / 1024.0 ) / [partitions].[rows])
                                    END AS [Space per row(MB)]
                          FROM      [#TS_SYS_TABLE_SPACE_USED2] [table]
                          INNER JOIN [sys].[indexes] [indexes] ON OBJECT_ID([table].[PKEY_TABLE_NAME]) = [indexes].[object_id]
                          INNER JOIN [sys].[partitions] [partitions] ON [indexes].[object_id] = [partitions].[OBJECT_ID]
                                                                        AND [indexes].[index_id] = [partitions].[index_id]
                          INNER JOIN [sys].[allocation_units] [space] ON [partitions].[partition_id] = [space].[container_id]
                          GROUP BY  [table].[INTERNAL_NAME],
                                    [table].[CLUSTER_RESOURCE_URN],
                                    [table].[PKEY_ROW_COUNT],
                                    [partitions].[rows]
                        ) [a]
              GROUP BY  [a].[INTERNAL_NAME],
                        [a].[CLUSTER_RESOURCE_URN],
                        [a].[PKEY_ROW_COUNT]
            ) [SOURCE]
        ON [SOURCE].[INTERNAL_NAME] COLLATE Latin1_General_CI_AS = [TARGET].[INTERNAL_NAME] COLLATE Latin1_General_CI_AS
            AND [SOURCE].[CLUSTER_RESOURCE_URN] = [TARGET].[CLUSTER_RESOURCE_URN]
            AND [SOURCE].[TYPE] = [TARGET].[TYPE]
        WHEN MATCHED THEN
            UPDATE SET
                    [TARGET].[PKEY_ROW_COUNT] = ISNULL([SOURCE].[PKEY_ROW_COUNT], 0),
                    [TARGET].[PKEY_SPACE_PER_ROW] = ISNULL([SOURCE].[Space per row(MB)], 0),
                    [TARGET].[CALCULATION_DATE] = SYSUTCDATETIME();
        DROP TABLE IF EXISTS #tableInformation2;
        DROP TABLE IF EXISTS [#TS_SYS_TABLE_SPACE_USED2];
        DROP TABLE IF EXISTS [#tableInformation3];
        SELECT  [PARTITION_TABLE_NAME],
                MAX(CASE WHEN [col].[NAME] = 'CLUSTER_RESOURCE_URN' THEN 'BC'
                         WHEN [col].[NAME] = 'RESOURCE_URN' THEN 'BR'
                         WHEN [col].[NAME] = 'RESOURCE_ID' THEN 'BS'
                         WHEN [col].[NAME] = 'CLUSTER_RESOURCE_ID' THEN 'BI'
                    END) AS [CLUSTER_IDENTIFIER],
                [meta].[IDENTITY_FIELD]
        INTO    [#tableInformation3]
        FROM    [dbo].[TB_IMP_FCT_PARTITION] [part]
        INNER JOIN [dbo].[TB_IMP_FCT_PARTITION_METADATA] [meta] ON [meta].[FACT_PARTITION_METADATA_ID] = [part].[FACT_PARTITION_METADATA_ID]
        INNER JOIN [sys].[objects] [obj] ON [obj].[object_id] = OBJECT_ID([part].[PARTITION_TABLE_NAME])
        INNER JOIN [sys].[columns] [col] ON [col].[object_id] = [obj].[object_id]
        GROUP BY [PARTITION_TABLE_NAME],
                [IDENTITY_FIELD];
        DELETE  FROM [#tableInformation3]
        WHERE   [CLUSTER_IDENTIFIER] IS NULL
                OR [CLUSTER_IDENTIFIER] = '';
        -- BUILD THE DYNAMIC ROW COUNT PER CLUSTER PER TYPE
        DROP TABLE IF EXISTS [#dynamic3];
        SELECT  CONCAT('SELECT ', CHAR(39), [PARTITION_TABLE_NAME], CHAR(39), ' AS [INTERNAL_NAME], [BASE_RECORDS], ',
                       CASE WHEN [CLUSTER_IDENTIFIER] IN ( 'BC' ) THEN '[CLUSTER_RESOURCE_URN]'
                            WHEN [CLUSTER_IDENTIFIER] IN ( 'BR' ) THEN '[RESOURCE_URN]'
                            WHEN [CLUSTER_IDENTIFIER] IN ( 'BS' ) THEN '[RESOURCE_ID]'
                            WHEN [CLUSTER_IDENTIFIER] IN ( 'BI' ) THEN '[CLUSTER_RESOURCE_ID]'
                       END, CHAR(13), CHAR(10), 'FROM (', CHAR(13), CHAR(10), 'SELECT COUNT(DISTINCT [b].[', [IDENTITY_FIELD], ']) AS [BASE_RECORDS], ',
                       CASE WHEN [CLUSTER_IDENTIFIER] = 'BC' THEN '[b].[CLUSTER_RESOURCE_URN]'
                            WHEN [CLUSTER_IDENTIFIER] = 'BR' THEN '[b].[RESOURCE_URN]'
                            WHEN [CLUSTER_IDENTIFIER] = 'BS' THEN '[b].[RESOURCE_ID]'
                            WHEN [CLUSTER_IDENTIFIER] = 'BI' THEN '[b].[CLUSTER_RESOURCE_ID]'
                       END, CHAR(13), CHAR(10), 'FROM [', [PARTITION_TABLE_NAME], '] [b]', CHAR(13), CHAR(10), 'GROUP BY ',
                       CASE WHEN [CLUSTER_IDENTIFIER] = 'BC' THEN '[b].[CLUSTER_RESOURCE_URN]'
                            WHEN [CLUSTER_IDENTIFIER] = 'BR' THEN '[b].[RESOURCE_URN]'
                            WHEN [CLUSTER_IDENTIFIER] = 'BS' THEN '[b].[RESOURCE_ID]'
                            WHEN [CLUSTER_IDENTIFIER] = 'BI' THEN '[b].[CLUSTER_RESOURCE_ID]'
                       END, ')a', CHAR(13), CHAR(10), ';') AS [SQL],
                [PARTITION_TABLE_NAME] AS [INTERNAL_NAME]
        INTO    [#dynamic3]
        FROM    [#tableInformation3];
        DROP TABLE IF EXISTS [#tableInformation3];
        DROP TABLE IF EXISTS [#TS_SYS_TABLE_SPACE_USED3];
        CREATE TABLE [#TS_SYS_TABLE_SPACE_USED3]
            (
              [INTERNAL_NAME] VARCHAR(255) NOT NULL,
              [BASE_ROW_COUNT] INT NOT NULL,
              [CLUSTER_RESOURCE] VARCHAR(36) NULL,
              [CLUSTER_RESOURCE_URN] INT NULL
            );
        SET @SQL = NULL;
        SET @INTERNAL_NAME = NULL;
        -- INSERT THE ROWCOUNTS PER CLUSTER PER TYPE
        WHILE EXISTS ( SELECT   1
                       FROM     [#dynamic3] )
        BEGIN
            SELECT  @SQL = [a].[SQL],
                    @INTERNAL_NAME = [INTERNAL_NAME]
            FROM    ( SELECT TOP 1
                                [SQL],
                                [INTERNAL_NAME]
                      FROM      [#dynamic3]
                      ORDER BY  [INTERNAL_NAME]
                    ) [a];
            INSERT  INTO [#TS_SYS_TABLE_SPACE_USED3]
                    ( [INTERNAL_NAME],
                      [BASE_ROW_COUNT],
                      [CLUSTER_RESOURCE]
                    )
                    EXECUTE [sp_executesql] @SQL;
            DELETE  FROM [#dynamic3]
            WHERE   [SQL] = @SQL;
        END;
        DROP TABLE IF EXISTS [#dynamic3];
        -- REMOVE ANY COUNTS WHERE WE DON'T HAVE A CLUSTER IDENTIFIER
        DELETE  FROM [#TS_SYS_TABLE_SPACE_USED3]
        WHERE   [CLUSTER_RESOURCE] IS NULL;
        -- FIND THE CLUSTER INTEGER IDENTIFIER
        MERGE INTO [#TS_SYS_TABLE_SPACE_USED3] [TARGET]
        USING
            ( SELECT    [a].[INTERNAL_NAME],
                        [a].[BASE_ROW_COUNT],
                        [a].[CLUSTER_RESOURCE],
                        [a].[CLUSTER_RESOURCE_URN]
              FROM      ( SELECT    [u].[INTERNAL_NAME],
                                    [u].[BASE_ROW_COUNT],
                                    [u].[CLUSTER_RESOURCE],
                                    ISNULL([r].[RESOURCE_URN], TRY_CAST([u].[CLUSTER_RESOURCE] AS INT)) AS [CLUSTER_RESOURCE_URN]
                          FROM      [#TS_SYS_TABLE_SPACE_USED3] [u]
                          LEFT OUTER JOIN [dbo].[TB_CLU_RESOURCE] [r] ON TRY_CAST([u].[CLUSTER_RESOURCE] AS UNIQUEIDENTIFIER) = [r].[RESOURCE_ID]
                        ) [a]
              WHERE     [a].[CLUSTER_RESOURCE_URN] IS NOT NULL
            ) [SOURCE]
        ON [SOURCE].[INTERNAL_NAME] = [TARGET].[INTERNAL_NAME]
            AND [SOURCE].[CLUSTER_RESOURCE] = [TARGET].[CLUSTER_RESOURCE]
        WHEN MATCHED THEN
            UPDATE SET
                    [TARGET].[CLUSTER_RESOURCE_URN] = [SOURCE].[CLUSTER_RESOURCE_URN];
        -- GET THE SPACE PER ROW FOR EACH TYPE
        MERGE INTO [dbo].[TS_SYS_TABLE_SPACE_USED] [TARGET]
        USING
            ( SELECT    [a].[INTERNAL_NAME],
                        [a].[CLUSTER_RESOURCE_URN],
                        [a].[BASE_ROW_COUNT],
                        CASE WHEN [a].[INTERNAL_NAME] LIKE 'TB\_FCT\_%' ESCAPE '\' THEN 'F'
                             ELSE 'S'
                        END AS [TYPE],
                        SUM([a].[Space per row(MB)]) AS [Space per row(MB)]
              FROM      ( SELECT    [table].[INTERNAL_NAME],
                                    [table].[CLUSTER_RESOURCE_URN],
                                    [table].[BASE_ROW_COUNT],
                                    CASE WHEN [partitions].[rows] = 0 THEN 0
                                         ELSE CONVERT(DECIMAL(22, 6), ( SUM([space].[used_pages]) * 8 / 1024.0 ) / [partitions].[rows])
                                    END AS [Space per row(MB)]
                          FROM      [#TS_SYS_TABLE_SPACE_USED3] [table]
                          INNER JOIN [sys].[indexes] [indexes] ON OBJECT_ID([table].[INTERNAL_NAME]) = [indexes].[object_id]
                          INNER JOIN [sys].[partitions] [partitions] ON [indexes].[object_id] = [partitions].[OBJECT_ID]
                                                                        AND [indexes].[index_id] = [partitions].[index_id]
                          INNER JOIN [sys].[allocation_units] [space] ON [partitions].[partition_id] = [space].[container_id]
                          GROUP BY  [table].[INTERNAL_NAME],
                                    [table].[CLUSTER_RESOURCE_URN],
                                    [table].[BASE_ROW_COUNT],
                                    [partitions].[rows]
                        ) [a]
              GROUP BY  [a].[INTERNAL_NAME],
                        [a].[CLUSTER_RESOURCE_URN],
                        [a].[BASE_ROW_COUNT]
            ) [SOURCE]
        ON [SOURCE].[INTERNAL_NAME] COLLATE Latin1_General_CI_AS = [TARGET].[INTERNAL_NAME] COLLATE Latin1_General_CI_AS
            AND [SOURCE].[CLUSTER_RESOURCE_URN] = [TARGET].[CLUSTER_RESOURCE_URN]
            AND [SOURCE].[TYPE] = [TARGET].[TYPE]
        WHEN MATCHED THEN
            UPDATE SET
                    [TARGET].[BASE_ROW_COUNT] = ISNULL([SOURCE].[BASE_ROW_COUNT], 0),
                    [TARGET].[BASE_SPACE_PER_ROW] = ISNULL([SOURCE].[Space per row(MB)], 0),
                    [TARGET].[CALCULATION_DATE] = SYSUTCDATETIME()
        WHEN NOT MATCHED THEN
            INSERT ( [TYPE],
                     [INTERNAL_NAME],
                     [CLUSTER_RESOURCE_URN],
                     [BASE_ROW_COUNT],
                     [BASE_SPACE_PER_ROW]
                   )
            VALUES ( [SOURCE].[TYPE],
                     [SOURCE].[INTERNAL_NAME],
                     [SOURCE].[CLUSTER_RESOURCE_URN],
                     ISNULL([SOURCE].[BASE_ROW_COUNT], 0),
                     ISNULL([SOURCE].[Space per row(MB)], 0)
                   );
        DROP TABLE IF EXISTS [#TS_SYS_TABLE_SPACE_USED3];
    END;
GO
GRANT EXECUTE
	ON [dbo].[ap_sys_get_space_used]
	TO [portalapp_role]
GO
