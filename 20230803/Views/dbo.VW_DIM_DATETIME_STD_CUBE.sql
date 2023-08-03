SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_DATETIME_STD_CUBE]
AS
SELECT  CAST(CONVERT(VARCHAR(20), [DATE_VALUE], 112) + REPLACE(LEFT(qt.NAME, 5),
                                                              ':', '') AS BIGINT) AS [DATETIME_UTC_URN],
        CAST(CONVERT(VARCHAR(20), [DATE_VALUE], 112) + REPLACE(LEFT(tt.NAME, 5),
                                                              ':', '') AS BIGINT) AS [HALFHOUR_UTC_URN],
        [DATE_URN] AS [DATE_URN],
        [QUARTER_HOUR_URN] AS [TIME_URN],
        [YEAR] AS [YEAR],
        CAST([YEAR] AS CHAR(4)) + CASE WHEN [MONTH] BETWEEN 1 AND 3 THEN '-01'
                                       WHEN [MONTH] BETWEEN 4 AND 6 THEN '-02'
                                       WHEN [MONTH] BETWEEN 7 AND 9 THEN '-03'
                                       ELSE '-04'
                                  END AS [QUARTER],
        [STD_MONTH_ID] AS [MONTH],
        REPLACE([STD_WEEK_ID], 'W', '-') AS [WEEK],
        REPLACE(CONVERT(VARCHAR(20), [DATE_VALUE], 102), '.', '-') AS [DATE],
        REPLACE(CONVERT(VARCHAR(20), [DATE_VALUE], 102), '.', '-') + ' '
        + LEFT(t.[NAME], 2) + ':00' AS [HOUR],
        REPLACE(CONVERT(VARCHAR(20), [DATE_VALUE], 102), '.', '-') + ' '
        + LEFT(tt.[NAME], 5) AS [HALFHOUR],
        REPLACE(CONVERT(VARCHAR(20), [DATE_VALUE], 102), '.', '-') + ' '
        + LEFT(qt.[NAME], 5) AS [QUARTERHOUR],
        CASE WHEN [MONTH] BETWEEN 1 AND 3 THEN '1'
             WHEN [MONTH] BETWEEN 4 AND 6 THEN '2'
             WHEN [MONTH] BETWEEN 7 AND 9 THEN '3'
             ELSE '4'
        END AS [QUARTER_NUMBER],
        [MONTH] AS [MONTH_NUMBER],
        CAST(SUBSTRING([STD_WEEK_ID], 6, 2) AS INT) AS [WEEK_NUMBER],
        [DAY] AS [DAY_NUMBER_OF_MONTH],
        t.[HOUR] AS [HOUR_NUMBER_OF_DAY],
        tt.[MINUTE] AS [HALFHOUR_NUMBER_OF_HOUR],
        qt.[MINUTE] AS [QUARTERHOUR_NUMBER_OF_HOUR],
        LEFT(t.NAME, 2) + ':00' AS [HOUR_OF_DAY],
        LEFT(tt.NAME, 5) AS [HALFHOUR_OF_HOUR],
        LEFT(qt.NAME, 5) AS [QUARTERHOUR_OF_HOUR],
        CAST([YEAR] AS CHAR(4)) + ' Q'
        + CASE WHEN [MONTH] BETWEEN 1 AND 3 THEN '1'
               WHEN [MONTH] BETWEEN 4 AND 6 THEN '2'
               WHEN [MONTH] BETWEEN 7 AND 9 THEN '3'
               ELSE '4'
          END AS [QUARTER_TEXT],
        DATENAME(MONTH, [DATE_VALUE]) + ' ' + CAST([YEAR] AS CHAR(4)) AS [MONTH_TEXT],
        CASE LEN(CAST(( CASE WHEN (
                                    ( CASE WHEN ( DATEPART(dw, [DATE_VALUE])
                                                  - 1 ) < 1 THEN 7
                                           ELSE ( DATEPART(dw, [DATE_VALUE])
                                                  - 1 )
                                      END ) >= ( SELECT COALESCE(CAST(PROPERTY_VALUE AS INT),
                                                              7)
                                                 FROM   dbo.TB_ADM_PROPERTY
                                                 WHERE  PROPERTY_KEY = 'PROP_FIRST_DAY_OF_WEEK'
                                               )
                                    AND (
                                          ( SELECT  COALESCE(CAST(PROPERTY_VALUE AS INT),
                                                             7)
                                            FROM    dbo.TB_ADM_PROPERTY
                                            WHERE   PROPERTY_KEY = 'PROP_FIRST_DAY_OF_WEEK'
                                          ) <> 7
                                          AND ( CASE WHEN ( DATEPART(dw,
                                                              [DATE_VALUE])
                                                            - 1 ) < 1 THEN 7
                                                     ELSE ( DATEPART(dw,
                                                              [DATE_VALUE])
                                                            - 1 )
                                                END ) < 7
                                        )
                                  )
                                  OR ( SELECT   COALESCE(CAST(PROPERTY_VALUE AS INT),
                                                         7)
                                       FROM     dbo.TB_ADM_PROPERTY
                                       WHERE    PROPERTY_KEY = 'PROP_FIRST_DAY_OF_WEEK'
                                     ) = 7
                             THEN CAST(SUBSTRING([STD_WEEK_ID], 6, 2) AS INT)
                             ELSE CAST(SUBSTRING([STD_WEEK_ID], 6, 2) AS INT)
                                  - 1
                        END ) AS NVARCHAR))
          WHEN 1
          THEN CAST([YEAR] AS CHAR(4)) + ' W0'
               + CAST(( CASE WHEN (
                                    ( CASE WHEN ( DATEPART(dw, [DATE_VALUE])
                                                  - 1 ) < 1 THEN 7
                                           ELSE ( DATEPART(dw, [DATE_VALUE])
                                                  - 1 )
                                      END ) >= ( SELECT COALESCE(CAST(PROPERTY_VALUE AS INT),
                                                              7)
                                                 FROM   dbo.TB_ADM_PROPERTY
                                                 WHERE  PROPERTY_KEY = 'PROP_FIRST_DAY_OF_WEEK'
                                               )
                                    AND (
                                          ( SELECT  COALESCE(CAST(PROPERTY_VALUE AS INT),
                                                             7)
                                            FROM    dbo.TB_ADM_PROPERTY
                                            WHERE   PROPERTY_KEY = 'PROP_FIRST_DAY_OF_WEEK'
                                          ) <> 7
                                          AND ( CASE WHEN ( DATEPART(dw,
                                                              [DATE_VALUE])
                                                            - 1 ) < 1 THEN 7
                                                     ELSE ( DATEPART(dw,
                                                              [DATE_VALUE])
                                                            - 1 )
                                                END ) < 7
                                        )
                                  )
                                  OR ( SELECT   COALESCE(CAST(PROPERTY_VALUE AS INT),
                                                         7)
                                       FROM     dbo.TB_ADM_PROPERTY
                                       WHERE    PROPERTY_KEY = 'PROP_FIRST_DAY_OF_WEEK'
                                     ) = 7
                             THEN CAST(SUBSTRING([STD_WEEK_ID], 6, 2) AS INT)
                             ELSE CAST(SUBSTRING([STD_WEEK_ID], 6, 2) AS INT)
                                  - 1
                        END ) AS NVARCHAR)
          ELSE CAST([YEAR] AS CHAR(4)) + ' W'
               + CAST(( CASE WHEN (
                                    ( CASE WHEN ( DATEPART(dw, [DATE_VALUE])
                                                  - 1 ) < 1 THEN 7
                                           ELSE ( DATEPART(dw, [DATE_VALUE])
                                                  - 1 )
                                      END ) >= ( SELECT COALESCE(CAST(PROPERTY_VALUE AS INT),
                                                              7)
                                                 FROM   dbo.TB_ADM_PROPERTY
                                                 WHERE  PROPERTY_KEY = 'PROP_FIRST_DAY_OF_WEEK'
                                               )
                                    AND (
                                          ( SELECT  COALESCE(CAST(PROPERTY_VALUE AS INT),
                                                             7)
                                            FROM    dbo.TB_ADM_PROPERTY
                                            WHERE   PROPERTY_KEY = 'PROP_FIRST_DAY_OF_WEEK'
                                          ) <> 7
                                          AND ( CASE WHEN ( DATEPART(dw,
                                                              [DATE_VALUE])
                                                            - 1 ) < 1 THEN 7
                                                     ELSE ( DATEPART(dw,
                                                              [DATE_VALUE])
                                                            - 1 )
                                                END ) < 7
                                        )
                                  )
                                  OR ( SELECT   COALESCE(CAST(PROPERTY_VALUE AS INT),
                                                         7)
                                       FROM     dbo.TB_ADM_PROPERTY
                                       WHERE    PROPERTY_KEY = 'PROP_FIRST_DAY_OF_WEEK'
                                     ) = 7
                             THEN CAST(SUBSTRING([STD_WEEK_ID], 6, 2) AS INT)
                             ELSE CAST(SUBSTRING([STD_WEEK_ID], 6, 2) AS INT)
                                  - 1
                        END ) AS NVARCHAR)
        END AS [WEEK_TEXT],
        CONVERT(VARCHAR(20), [DATE_VALUE], 106) AS [DATE_TEXT],
        DATENAME(WEEKDAY, d.[DATE_VALUE]) AS [WEEKDAY_TEXT],
        DATEPART(DW, d.[DATE_VALUE]) AS [WEEKDAY_NUMBER],
        REPLACE(CONVERT(VARCHAR(20), [DATE_VALUE], 106), '.', '-') + ' '
        + LEFT(t.[NAME], 2) + ':00' AS [HOUR_TEXT],
        REPLACE(CONVERT(VARCHAR(20), [DATE_VALUE], 106), '.', '-') + ' '
        + LEFT(tt.[NAME], 5) AS [HALFHOUR_TEXT],
        REPLACE(CONVERT(VARCHAR(20), [DATE_VALUE], 106), '.', '-') + ' '
        + LEFT(qt.[NAME], 5) AS [QUARTERHOUR_TEXT],
        d.[NAME] AS [DATE_NAME],
        t.[NAME] AS [TIME_NAME],
        [DATE_VALUE] AS [DATE_VALUE],
        t.[PERIOD_START] AS [TIME_VALUE],
        [DATE_VALUE] + t.[PERIOD_START] AS [DATETIME_VALUE],
        qt.[SHIFT] AS [SHIFT],
        qt.[EVENING] AS [EVENING],
        [HOLIDAY] AS [HOLIDAY],
        fiscalYear.[FISCAL_YEAR_URN],
        fiscalYear.[FISCAL_YEAR],
        fiscalYear.[FISCAL_YEAR] AS [FISCAL_YEAR_TEXT], 
        fiscalYear.[FISCAL_QUARTER_URN],
        fiscalYear.[FISCAL_QUARTER],
        fiscalYear.[FISCAL_YEAR] + ' ' + fiscalYear.[FISCAL_QUARTER] AS [FISCAL_QUARTER_TEXT],
        fiscalYear.[FISCAL_MONTH_URN],
        fiscalYear.[FISCAL_MONTH],
        fiscalYear.[FISCAL_MONTH_TEXT]
FROM    [dbo].[TB_DIM_DATE] d
OUTER APPLY (
                SELECT 
                [fy].[FISCAL_YEAR_URN],
                [fy].[NAME] AS [FISCAL_YEAR],
                [fq].[FISCAL_QUARTER_URN],
                [fq].[QUARTER_TEXT] AS [FISCAL_QUARTER],
                [fm].[FISCAL_MONTH_URN],
                [fm].[NAME] AS [FISCAL_MONTH],
                CONVERT(VARCHAR(7), [fm].[START_DATE_TIME], 21) AS [FISCAL_MONTH_TEXT]
                FROM [dbo].[TB_DIM_FISCAL_YEAR] [fy]
                JOIN [dbo].[TB_DIM_FISCAL_QUARTER] [fq] ON [fy].[FISCAL_YEAR_URN] = [fq].[FISCAL_YEAR_URN]
                JOIN [dbo].[TB_DIM_FISCAL_MONTH] [fm] ON [fq].[FISCAL_QUARTER_URN] = [fm].[FISCAL_QUARTER_URN]
                WHERE [fy].[FISCAL_YEAR_URN] = d.[FISCAL_YEAR_URN]
                AND [fq].[FISCAL_QUARTER_URN] = d.[FISCAL_QUARTER_URN]
                AND [fm].[FISCAL_MONTH_URN] = d.[FISCAL_MONTH_URN]
) as fiscalYear
CROSS JOIN [dbo].[TB_DIM_TIME_QH] t
JOIN    [dbo].[TB_DIM_TIME_HH] tt ON t.[HALF_HOUR_URN] = tt.[HALF_HOUR_URN]
JOIN    [dbo].[TB_DIM_TIME] qt ON t.[QUARTER_HOUR_URN] = qt.[TIME_URN]
WHERE   [DATE_VALUE] < DATEADD(MONTH, 7, GETUTCDATE())
        AND [DATE_VALUE] > DATEADD(MONTH, -60, GETUTCDATE());
GO
GRANT SELECT
	ON [dbo].[VW_DIM_DATETIME_STD_CUBE]
	TO [portalapp_role]
GO
