SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_adm_get_table_definition] ( @Table NVARCHAR(255) )
RETURNS TABLE
AS
 RETURN
    WITH    [Indexes]
              AS ( SELECT   CASE WHEN [a].[type_desc] <> 'HEAP'
                                 THEN CASE WHEN [a].[is_primary_key] = 1
                                                OR [a].[is_unique] = 1
                                           THEN CHAR(13) + CHAR(10) + 'CONSTRAINT [' + [a].[index_name] + '] '
                                                + CASE WHEN [a].[is_primary_key] = 1 THEN ' PRIMARY KEY '
                                                       ELSE CASE WHEN [a].[is_unique] = 1 THEN ' UNIQUE '
                                                                 ELSE ''
                                                            END
                                                  END + [a].[type_desc] COLLATE Latin1_General_CI_AS + CASE WHEN [a].[type_desc] = 'NONCLUSTERED' THEN ''
                                                                                                            ELSE ' '
                                                                                                       END + ' (' + [a].[index_columns_key] + ')'
                                                + CASE WHEN [a].[index_columns_include] <> '---' THEN ' INCLUDE (' + [a].[index_columns_include] + ')'
                                                       ELSE ''
                                                  END + CASE WHEN [a].[fill_factor] <> 0 THEN ' WITH FILLFACTOR = ' + CONVERT(VARCHAR(30), [a].[fill_factor])
                                                             ELSE ''
                                                        END + ','
                                           ELSE CHAR(13) + CHAR(10) + 'CREATE INDEX [' + [a].[index_name] + '] ' + ' ON [' + [a].[object_name] + ']' + ' ('
                                                + [a].[index_columns_key] + ')' + CASE WHEN [a].[index_columns_include] <> '---'
                                                                                       THEN ' INCLUDE (' + [a].[index_columns_include] + ')'
                                                                                       ELSE ''
                                                                                  END + CASE WHEN [a].[fill_factor] <> 0
                                                                                             THEN ' WITH FILLFACTOR = ' + CONVERT(VARCHAR(30), [a].[fill_factor])
                                                                                             ELSE ''
                                                                                        END + ';'
                                      END
                                 ELSE ''
                            END AS [INDEX_DEF],
                            CASE WHEN [a].[type_desc] <> 'HEAP' THEN CASE WHEN [a].[is_primary_key] = 1
                                                                               OR [a].[is_unique] = 1 THEN 'CONSTRAINT'
                                                                          ELSE 'INDEX'
                                                                     END
                                 ELSE ''
                            END AS [TYPE],
                            [a].[object_id]
                   FROM     ( SELECT    [conObj].[object_id],
                                        [conObj].[name] AS [object_name],
                                        [conInde].[index_id],
                                        ISNULL([conInde].[name], '---') AS [index_name],
                                        [partitions].[Rows],
                                        [partitions].[SizeMB],
                                        INDEXPROPERTY([conObj].[object_id], [conInde].[name], 'IndexDepth') AS [IndexDepth],
                                        [conInde].[type],
                                        [conInde].[type_desc],
                                        [conInde].[fill_factor],
                                        [conInde].[is_unique],
                                        [conInde].[is_primary_key],
                                        [conInde].[is_unique_constraint],
                                        ISNULL([Index_Columns].[index_columns_key], '---') AS [index_columns_key],
                                        ISNULL([Index_Columns].[index_columns_include], '---') AS [index_columns_include]
                              FROM      [sys].[objects] [conObj]
                              JOIN      [sys].[indexes] [conInde] ON [conObj].[object_id] = [conInde].[object_id]
                              JOIN      ( SELECT    [object_id],
                                                    [index_id],
                                                    SUM([row_count]) AS [Rows],
                                                    CONVERT(NUMERIC(19, 3), CONVERT(NUMERIC(19, 3), SUM([in_row_reserved_page_count] + [lob_reserved_page_count]
                                                                                                        + [row_overflow_reserved_page_count]))
                                                    / CONVERT(NUMERIC(19, 3), 128)) AS [SizeMB]
                                          FROM      [sys].[dm_db_partition_stats]
                                          GROUP BY  [object_id],
                                                    [index_id]
                                        ) AS [partitions] ON [conInde].[object_id] = [partitions].[object_id]
                                                             AND [conInde].[index_id] = [partitions].[index_id]
                              CROSS APPLY ( SELECT  LEFT([Index_Columns].[index_columns_key], LEN([Index_Columns].[index_columns_key]) - 1) AS [index_columns_key],
                                                    LEFT([Index_Columns].[index_columns_include], LEN([Index_Columns].[index_columns_include]) - 1) AS [index_columns_include]
                                            FROM    ( SELECT    ( SELECT    [name] + ',' + ' '
                                                                  FROM      [sys].[index_columns]
                                                                  JOIN      [sys].[columns] ON [Index_Columns].[column_id] = [columns].[column_id]
                                                                                               AND [Index_Columns].[object_id] = [columns].[object_id]
                                                                  WHERE     [is_included_column] = 0
                                                                            AND [conInde].[object_id] = [Index_Columns].[object_id]
                                                                            AND [conInde].[index_id] = [index_id]
                                                                  ORDER BY  [key_ordinal]
                                                                FOR
                                                                  XML PATH('')
                                                                ) AS [index_columns_key],
                                                                ( SELECT    [name] + ',' + ' '
                                                                  FROM      [sys].[index_columns]
                                                                  JOIN      [sys].[columns] ON [Index_Columns].[column_id] = [columns].[column_id]
                                                                                               AND [Index_Columns].[object_id] = [columns].[object_id]
                                                                  WHERE     [is_included_column] = 1
                                                                            AND [conInde].[object_id] = [Index_Columns].[object_id]
                                                                            AND [conInde].[index_id] = [index_id]
                                                                  ORDER BY  [index_column_id]
                                                                FOR
                                                                  XML PATH('')
                                                                ) AS [index_columns_include]
                                                    ) AS [Index_Columns]
                                          ) AS [Index_Columns]
                              WHERE     [conObj].[object_id] = OBJECT_ID(@Table)
                            ) [a]
                 ),
            [tables]
              AS ( SELECT   SCHEMA_NAME([tab].[schema_id]) AS 'Schema',
                            [tab].[name] AS 'Name',
                            ISNULL([prop].[value], '') AS 'Description',
                            SUBSTRING([creat].[def], 1, LEN([creat].[def]) - 1) + ');' + CHAR(13) + CHAR(10) + ISNULL([ind].[def], '') + ISNULL([trig].[def], '')
                            + ISNULL(CHAR(13) + CHAR(10) + [extabprop].[def], '') AS 'Definition',
                            [tab].[object_id]
                   FROM     [sys].[objects] [tab]
                   CROSS APPLY ( SELECT ( (SELECT   CASE WHEN [col].[is_computed] = 1
                                                         THEN CHAR(13) + CHAR(10) + '[' + UPPER([col].[name]) + '] ' + 'AS ' + UPPER([col].[name])
                                                         ELSE CHAR(13) + CHAR(10) + '[' + UPPER([col].[name]) + '] ' + UPPER(TYPE_NAME([col].[system_type_id]))
                                                              + CASE WHEN TYPE_NAME([col].[system_type_id]) IN ( 'decimal', 'numeric' )
                                                                     THEN '(' + CONVERT(VARCHAR, [col].[precision]) + ',' + CONVERT(VARCHAR, [col].[scale])
                                                                          + ') ' + CASE WHEN [col].[is_nullable] = 0 THEN ' NOT NULL'
                                                                                        ELSE ' NULL'
                                                                                   END
                                                                     WHEN TYPE_NAME([col].[system_type_id]) IN ( 'float', 'real' )
                                                                     THEN CASE WHEN [col].[precision] = 53
                                                                               THEN CASE WHEN [col].[is_nullable] = 0 THEN ' NOT NULL'
                                                                                         ELSE ' NULL'
                                                                                    END
                                                                               ELSE '(' + CONVERT(VARCHAR, [col].[precision]) + ') '
                                                                                    + CASE WHEN [col].[is_nullable] = 0 THEN ' NOT NULL'
                                                                                           ELSE ' NULL'
                                                                                      END
                                                                          END
                                                                     WHEN TYPE_NAME([col].[system_type_id]) IN ( 'char', 'varchar' )
                                                                     THEN CASE WHEN [col].[max_length] = -1
                                                                               THEN '(max)' + CASE WHEN [col].[is_nullable] = 0 THEN ' NOT NULL'
                                                                                                   ELSE ' NULL'
                                                                                              END
                                                                               ELSE '(' + CONVERT(VARCHAR, [col].[max_length]) + ') '
                                                                                    + CASE WHEN [col].[is_nullable] = 0 THEN ' NOT NULL'
                                                                                           ELSE ' NULL'
                                                                                      END
                                                                          END
                                                                     WHEN TYPE_NAME([col].[system_type_id]) IN ( 'nchar', 'nvarchar' )
                                                                     THEN CASE WHEN [col].[max_length] = -1
                                                                               THEN '(max)' + CASE WHEN [col].[is_nullable] = 0 THEN ' NOT NULL'
                                                                                                   ELSE ' NULL'
                                                                                              END
                                                                               ELSE '(' + CONVERT(VARCHAR, ( [col].[max_length] / 2 )) + ') '
                                                                                    + CASE WHEN [col].[is_nullable] = 0 THEN ' NOT NULL'
                                                                                           ELSE ' NULL'
                                                                                      END
                                                                          END
                                                                     WHEN TYPE_NAME([col].[system_type_id]) IN ( 'datetime', 'money', 'text', 'image' )
                                                                     THEN ' ' + CASE WHEN [col].[is_nullable] = 0 THEN ' NOT NULL'
                                                                                     ELSE ' NULL'
                                                                                END
                                                                     ELSE +CASE WHEN COLUMNPROPERTY([col].[object_id], [col].[name], 'IsIdentity') = 0 THEN ' '
                                                                                ELSE ' IDENTITY('
                                                                                     + CONVERT(VARCHAR, ISNULL(IDENT_SEED(OBJECT_NAME([col].[object_id])), 1))
                                                                                     + ',' + CONVERT(VARCHAR, ISNULL(IDENT_INCR(OBJECT_NAME([col].[object_id])),
                                                                                                                     1)) + ')'
                                                                           END + CASE WHEN [col].[is_nullable] = 0 THEN ' NOT NULL'
                                                                                      ELSE ' NULL'
                                                                                 END
                                                                END + CASE WHEN [col].[default_object_id] = 0 THEN ''
                                                                           ELSE ' CONSTRAINT [' + [DEF].[name] + '] DEFAULT ' + ISNULL([DEF].[definition], '')
                                                                      END
                                                    END + ','
                                           FROM     [sys].[columns] [col]
                                           LEFT OUTER JOIN [sys].[default_constraints] [DEF] ON [col].[default_object_id] = [DEF].[object_id]
                                           WHERE    [col].[object_id] = [tab].[object_id]
                                           ORDER BY [col].[column_id]
                                        FOR
                                          XML PATH(''),
                                              TYPE
).[value]('.', 'NVARCHAR(MAX)') )
                               ) [cols] ( [def] )
                   OUTER APPLY ( SELECT ( (SELECT   [allCons].[INDEX_DEF]
                                           FROM     [indexes] AS [allCons]
                                           WHERE    [allCons].[TYPE] = 'CONSTRAINT'
                                                    AND [allCons].[object_id] = [tab].[object_id]
                                        FOR
                                          XML PATH(''),
                                              TYPE).[value]('.', 'NVARCHAR(MAX)') )
                               ) [cons] ( [def] )
                   OUTER APPLY ( SELECT ( (SELECT   CHAR(13) + CHAR(10) + ISNULL('CONSTRAINT [' + [objects].[name] + '] ' + ' CHECK ' + ISNULL([definition], '')
                                                                                 + ',', '')
                                           FROM     [sys].[objects]
                                           INNER JOIN [sys].[check_constraints] ON [objects].[object_id] = [check_constraints].[object_id]
                                           WHERE    [objects].[type] = 'C'
                                                    AND [objects].[parent_object_id] = [tab].[object_id]
                                        FOR
                                          XML PATH(''),
                                              TYPE).[value]('.', 'NVARCHAR(MAX)') )
                               ) [chec] ( [def] )
                   OUTER APPLY ( SELECT ( (    SELECT   CHAR(13) + CHAR(10) + 'CONSTRAINT [' + OBJECT_NAME([constid]) + ']' + ' FOREIGN KEY ('
                                                        + COL_NAME([fkeyid], [fkey]) + ') REFERENCES [' + OBJECT_SCHEMA_NAME([rkeyid]) + '].['
                                                        + OBJECT_NAME([rkeyid]) + ']' + '(' + COL_NAME([rkeyid], [rkey]) + '),'
                                               FROM     [sys].[sysforeignkeys]
                                               WHERE    [fkeyid] = [tab].[object_id]
                                        FOR
                                          XML PATH(''),
                                              TYPE).[value]('.', 'NVARCHAR(MAX)') )
                               ) [fk] ( [def] )
                   OUTER APPLY ( SELECT ( (SELECT   [allCons].[INDEX_DEF]
                                           FROM     [indexes] AS [allCons]
                                           WHERE    [allCons].[TYPE] = 'INDEX'
                                                    AND [allCons].[object_id] = [tab].[object_id]
                                        FOR
                                          XML PATH(''),
                                              TYPE).[value]('.', 'NVARCHAR(MAX)') )
                               ) [ind] ( [def] )
                   CROSS APPLY ( SELECT 'CREATE TABLE [' + OBJECT_SCHEMA_NAME([tab].[object_id]) + '].[' + OBJECT_NAME([tab].[object_id]) + '] ( '
                                        + [cols].[def] + ISNULL([cons].[def], '') + ISNULL([chec].[def], '') + ISNULL([fk].[def], '')
                               ) [creat] ( [def] )
                   OUTER APPLY ( SELECT ( (SELECT   CHAR(13) + CHAR(10) + CHAR(13) + CHAR(10) + CHAR(13) + CHAR(10) + OBJECT_DEFINITION([o].[object_id])
                                                    + CHAR(13) + CHAR(10)
                                           FROM     [sys].[objects] [o]
                                           WHERE    [o].[type] = 'TR'
                                                    AND [o].[parent_object_id] = [tab].[object_id]
                                        FOR
                                          XML PATH(''),
                                              TYPE).[value]('.', 'NVARCHAR(MAX)') )
                               ) [trig] ( [def] )
                   OUTER APPLY ( SELECT ( (SELECT   CASE WHEN [a].[minor_id] = 0
                                                         THEN '-- Table Description' + CHAR(13) + CHAR(10) + 'IF EXISTS (SELECT 1 ' + CHAR(13) + CHAR(10)
                                                              + '           FROM sys.objects ' + CHAR(13) + CHAR(10) + '           WHERE name = ' + CHAR(39)
                                                              + OBJECT_NAME([tab].[object_id]) + CHAR(39) + CHAR(13) + CHAR(10) + '           AND type = '
                                                              + CHAR(39) + 'U' + CHAR(39) + CHAR(13) + CHAR(10) + '          )' + CHAR(13) + CHAR(10) + 'BEGIN '
                                                              + CHAR(13) + CHAR(10) + '    IF EXISTS (SELECT 1 ' + CHAR(13) + CHAR(10)
                                                              + '               FROM sys.extended_properties a' + CHAR(13) + CHAR(10)
                                                              + '               WHERE a.major_id = OBJECT_ID(' + CHAR(39) + OBJECT_NAME([tab].[object_id])
                                                              + CHAR(39) + ')' + CHAR(13) + CHAR(10) + '               )' + CHAR(13) + CHAR(10) + '    BEGIN '
                                                              + CHAR(13) + CHAR(10) + '        EXEC sp_dropextendedproperty N' + CHAR(39) + [a].[name] + CHAR(39)
                                                              + ', N' + CHAR(39) + 'USER' + CHAR(39) + ', N' + CHAR(39) + 'dbo' + CHAR(39) + ', N' + CHAR(39)
                                                              + 'TABLE' + CHAR(39) + ', N' + CHAR(39) + OBJECT_NAME([tab].[object_id]) + CHAR(39) + ';'
                                                              + CHAR(13) + CHAR(10) + '    END;' + CHAR(13) + CHAR(10)
                                                              + '    EXEC sp_addextendedproperty @name=N' + CHAR(39) + [a].[name] + CHAR(39) + ', @value=N'
                                                              + CHAR(39) + CAST([a].[value] AS NVARCHAR(MAX)) + CHAR(39) + ',' + CHAR(13) + CHAR(10)
                                                              + '        @level0type=N' + CHAR(39) + 'SCHEMA' + CHAR(39) + ', @level0name=N' + CHAR(39) + 'dbo'
                                                              + CHAR(39) + ', @level1type=N' + CHAR(39) + 'TABLE' + CHAR(39) + ', @level1name=N' + CHAR(39)
                                                              + OBJECT_NAME([tab].[object_id]) + CHAR(39) + ';' + CHAR(13) + CHAR(10) + 'END;' + CHAR(13)
                                                              + CHAR(10) + CHAR(13) + CHAR(10)
                                                         ELSE CASE WHEN [a].[name] = 'XNY_PARTITION_COLUMN_ITEM_TYPE'
                                                                   THEN '-- ' + [b].[name] + ': ' + CAST([a].[value] AS NVARCHAR(MAX)) + CHAR(13) + CHAR(10)
                                                                   WHEN [a].[class] = 1 THEN '-- ' + [b].[name] + CHAR(13) + CHAR(10)
                                                                   ELSE '-- ' + [c].[name] + CHAR(13) + CHAR(10)
                                                              END + 'IF EXISTS ( SELECT  1' + CHAR(13) + CHAR(10)
                                                              + CASE WHEN [a].[class] = 1
                                                                     THEN '            FROM    sys.columns' + CHAR(13) + CHAR(10)
                                                                          + '            WHERE   OBJECT_NAME(object_id) = ' + CHAR(39)
                                                                          + OBJECT_NAME([tab].[object_id]) + CHAR(39) + CHAR(13) + CHAR(10)
                                                                          + '                    AND name = ' + CHAR(39) + [b].[name] + CHAR(39) + ' )'
                                                                          + CHAR(13) + CHAR(10)
                                                                     ELSE '            FROM    sys.indexes' + CHAR(13) + CHAR(10)
                                                                          + '            WHERE   OBJECT_NAME(object_id) = ' + CHAR(39)
                                                                          + OBJECT_NAME([tab].[object_id]) + CHAR(39) + CHAR(13) + CHAR(10)
                                                                          + '                    AND name = ' + CHAR(39) + [c].[name] + CHAR(39) + ' )'
                                                                          + CHAR(13) + CHAR(10)
                                                                END + 'BEGIN' + CHAR(13) + CHAR(10) + '    IF EXISTS ( SELECT  1' + CHAR(13) + CHAR(10)
                                                              + '                FROM    sys.extended_properties a' + CHAR(13) + CHAR(10)
                                                              + CASE WHEN [a].[class] = 1
                                                                     THEN +'                INNER JOIN sys.columns c ON a.major_id = c.object_id' + CHAR(13)
                                                                          + CHAR(10)
                                                                          + '                                            AND a.minor_id = c.column_id' + CHAR(13)
                                                                          + CHAR(10)
                                                                     ELSE +'                INNER JOIN sys.indexes c ON a.major_id = c.object_id' + CHAR(13)
                                                                          + CHAR(10) + '                                            AND a.minor_id = c.index_id'
                                                                          + CHAR(13) + CHAR(10)
                                                                END + '                WHERE   a.major_id = OBJECT_ID(' + CHAR(39)
                                                              + OBJECT_NAME([tab].[object_id]) + CHAR(39) + ')' + CHAR(13) + CHAR(10)
                                                              + '                        AND a.name = N' + CHAR(39) + [a].[name] + CHAR(39) + CHAR(13) + CHAR(10)
                                                              + '                        AND c.name = ' + CHAR(39) + ISNULL([b].[name], [c].[name]) + CHAR(39)
                                                              + CHAR(13) + CHAR(10) + '                        AND a.class = '
                                                              + CAST([a].[class] AS NVARCHAR(2)) + ' )' + CHAR(13) + CHAR(10) + '    BEGIN' + CHAR(13) + CHAR(10)
                                                              + '        EXECUTE sys.sp_dropextendedproperty N' + CHAR(39) + [a].[name] + CHAR(39) + ', N'
                                                              + CHAR(39) + 'USER' + CHAR(39) + ', N' + CHAR(39) + 'dbo' + CHAR(39) + ',' + CHAR(13) + CHAR(10)
                                                              + '            N' + CHAR(39) + 'TABLE' + CHAR(39) + ', N' + CHAR(39)
                                                              + OBJECT_NAME([tab].[object_id]) + CHAR(39) + ', N' + CHAR(39)
                                                              + CASE WHEN [a].[class] = 1 THEN 'COLUMN'
                                                                     ELSE 'INDEX'
                                                                END + CHAR(39) + ',' + CHAR(13) + CHAR(10) + '            N' + CHAR(39) + ISNULL([b].[name],
                                                                                                                                                [c].[name])
                                                              + CHAR(39) + ';' + CHAR(13) + CHAR(10) + '    END;' + CHAR(13) + CHAR(10)
                                                              + '    EXECUTE sys.sp_addextendedproperty @name = N' + CHAR(39) + [a].[name] + CHAR(39) + ','
                                                              + CHAR(13) + CHAR(10) + '        @value = N' + CHAR(39) + CAST([a].[value] AS NVARCHAR(MAX))
                                                              + CHAR(39) + ',' + CHAR(13) + CHAR(10) + '        @level0type = N' + CHAR(39) + 'SCHEMA' + CHAR(39)
                                                              + ', @level0name = N' + CHAR(39) + 'dbo' + CHAR(39) + ', @level1type = N' + CHAR(39) + 'TABLE'
                                                              + CHAR(39) + ',' + CHAR(13) + CHAR(10) + '        @level1name = N' + CHAR(39)
                                                              + OBJECT_NAME([tab].[object_id]) + CHAR(39) + ',' + CHAR(13) + CHAR(10)
                                                              + '        @level2type = N' + CHAR(39) + CASE WHEN [a].[class] = 1 THEN 'COLUMN'
                                                                                                            ELSE 'INDEX'
                                                                                                       END + CHAR(39) + ', @level2name = N' + CHAR(39)
                                                              + ISNULL([b].[name], [c].[name]) + CHAR(39) + ';' + CHAR(13) + CHAR(10) + 'END;' + CHAR(13)
                                                              + CHAR(10) + CHAR(13) + CHAR(10)
                                                    END
                                           FROM     [sys].[extended_properties] [a]
                                           OUTER APPLY ( SELECT [col].[name]
                                                         FROM   [sys].[columns] [col]
                                                         WHERE  [a].[major_id] = [col].[object_id]
                                                                AND [a].[minor_id] = [col].[column_id]
                                                                AND [a].[class] = 1
                                                                AND [a].[minor_id] > 0
                                                       ) [b]
                                           OUTER APPLY ( SELECT [ind].[name]
                                                         FROM   [sys].[indexes] [ind]
                                                         WHERE  [a].[major_id] = [ind].[object_id]
                                                                AND [a].[minor_id] = [ind].[index_id]
                                                                AND [a].[class] = 7
                                                                AND [a].[minor_id] > 0
                                                       ) [c]
                                           WHERE    [a].[major_id] = [tab].[object_id]
                                           ORDER BY [a].[class],
                                                    [a].[minor_id]
                                        FOR
                                          XML PATH(''),
                                              TYPE).[value]('.', 'NVARCHAR(MAX)') )
                               ) [extabprop] ( [def] )
                   OUTER APPLY ( SELECT CAST([value] AS NVARCHAR(MAX))
                                 FROM   [sys].[extended_properties] [a]
                                 WHERE  [a].[major_id] = [tab].[object_id]
                                        AND [a].[minor_id] = 0
                               ) [prop] ( [value] )
                   WHERE    [tab].[type] = 'U'
                            AND [tab].[name] <> 'dtproperties'
                            AND [tab].[object_id] = OBJECT_ID(@Table)
                 )
    SELECT  [tables].[Schema],
            [tables].[Name],
            [tables].[Description],
            [tables].[Definition],
            [tables].[object_id]
    FROM    [tables];
GO
GRANT SELECT
	ON [dbo].[fn_adm_get_table_definition]
	TO [portalapp_role]
GO
