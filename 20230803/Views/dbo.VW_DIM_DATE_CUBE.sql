SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
/*SELECT WEEK, WEEK_TEXT, CURRENT_WEEK, CURRENT_WEEK_TEXT, * FROM VW_DIM_DATE_CUBE 
SELECT YEAR, YEAR, CURRENT_YEAR, CURRENT_YEAR_TEXT, * FROM VW_DIM_DATE_CUBE 

SELECT YEAR, WEEK, CURRENT_YEAR, CURRENT_YEAR_TEXT, * FROM VW_DIM_DATE_CUBE ORDER BY YEAR,WEEK

SELECT Top 5 MONTH, MONTH_TEXT, CURRENT_MONTH, CURRENT_MONTH_TEXT, * FROM VW_DIM_DATE_CUBE ORDER BY 1

SELECT Top 5 QUARTER, QUARTER_TEXT, CURRENT_QUARTER, CURRENT_QUARTER_TEXT, * FROM VW_DIM_DATE_CUBE ORDER BY 1
*/



CREATE VIEW dbo.VW_DIM_DATE_CUBE
AS
--NOTE: The WEEKEND calculation will not work if the language settings of SQL Server is other than English
    
    SELECT  d.DATE_URN,
            d.YEAR,
            d.MONTH,
            DATENAME(MONTH, d.DATE_VALUE) AS MONTH_TEXT,
            w.WEEK,
            'W' + CAST(w.WEEK AS NVARCHAR) AS WEEK_TEXT,
            d.DAY,
            CASE WHEN d.DAY < 10
                 THEN ' ' + CAST(d.DAY AS NVARCHAR) + ' ' + DATENAME(dw,
                                                              d.DATE_VALUE)
                 ELSE CAST(d.DAY AS NVARCHAR) + ' ' + DATENAME(dw,
                                                              d.DATE_VALUE)
            END AS DAY_TEXT,
            CASE WHEN d.MONTH < 4 THEN d.YEAR - 1
                 ELSE d.YEAR
            END AS [FYEAR],
            q.QUARTER,
            'Q' + CAST(q.QUARTER AS NVARCHAR) AS QUARTER_TEXT,
            CASE WHEN DATENAME(dw, d.DATE_VALUE) = 'Saturday'
                      OR DATENAME(dw, d.DATE_VALUE) = 'Sunday' --THIS CASE WILL NOT WORK IF THE LANGUAGE SETTINGS ARE OTHER THAN US ENGLISH
                      THEN 1
                 ELSE 0
            END AS WEEKEND,
            0 AS HOLIDAY,
            d.DATE_VALUE AS DATE,
            REPLACE(d.INTERNAL_NAME, '/', '-') AS TEXT,
            FISCAL_YEAR_URN,
            FISCAL_QUARTER_URN,
            FISCAL_MONTH_URN,
            FISCAL_WEEK_URN,
            CASE WHEN DATEDIFF(yy, DATE_VALUE, GETDATE()) = 0 THEN 1
                 ELSE 0
            END AS [CURRENT_YEAR],
            CASE WHEN DATEDIFF(yy, DATE_VALUE, GETDATE()) = 0
                 THEN 'Current Year'
                 ELSE 'All Prior Years'
            END AS [CURRENT_YEAR_TEXT],
            CASE WHEN DATEDIFF(qq, DATE_VALUE, GETDATE()) = 0 THEN 1
                 ELSE 0
            END AS [CURRENT_QUARTER],
            CASE WHEN DATEDIFF(qq, DATE_VALUE, GETDATE()) = 0
                 THEN 'Current Quarter'
                 ELSE 'All Prior Quarters'
            END AS [CURRENT_QUARTER_TEXT],
            CASE WHEN DATEDIFF(mm, DATE_VALUE, GETDATE()) = 0 THEN 1
                 ELSE 0
            END AS [CURRENT_MONTH],
            CASE WHEN DATEDIFF(mm, DATE_VALUE, GETDATE()) = 0
                 THEN 'Current Month'
                 ELSE 'All Prior Months'
            END AS [CURRENT_MONTH_TEXT],
            CASE WHEN DATEDIFF(wk, DATE_VALUE, GETDATE()) = 0 THEN 1
                 ELSE 0
            END AS [CURRENT_WEEK],
            CASE WHEN DATEDIFF(wk, DATE_VALUE, GETDATE()) = 0
                 THEN 'Current Week'
                 ELSE 'All Prior Weeks'
            END AS [CURRENT_WEEK_TEXT],
            CASE WHEN DATEDIFF(dd, DATE_VALUE, GETDATE()) = 0 THEN 1
                 ELSE 0
            END AS [CURRENT_DAY],
            CASE WHEN DATEDIFF(dd, DATE_VALUE, GETDATE()) = 0 THEN 'Today'
                 ELSE 'All Prior Days'
            END AS [CURRENT_DAY_TEXT],
            CASE WHEN DATEDIFF(mm, DATE_VALUE, GETDATE()) BETWEEN 0 AND 13
                 THEN 1
                 ELSE 0
            END AS [CURRENT_13_MONTHS],
            CASE WHEN DATEDIFF(mm, DATE_VALUE, GETDATE()) BETWEEN 0 AND 13
                 THEN 'Current 13 Months'
                 ELSE 'All Prior 13 Months'
            END AS [CURRENT_13_MONTHS_TEXT],
            CASE WHEN DATEDIFF(d, DATE_VALUE, GETDATE()) BETWEEN 0 AND 6
                 THEN 1
                 ELSE 0
            END AS [CURRENT_7_DAYS],
            CASE WHEN DATEDIFF(d, DATE_VALUE, GETDATE()) BETWEEN 0 AND 6
                 THEN 'Current 7 Days'
                 ELSE 'All Prior 7 Days'
            END AS [CURRENT_7_DAYS_TEXT],
            CASE WHEN DATEDIFF(wk, DATE_VALUE, GETDATE()) BETWEEN 0 AND 4
                 THEN 1
                 ELSE 0
            END AS [CURRENT_5_WEEKS],
            CASE WHEN DATEDIFF(wk, DATE_VALUE, GETDATE()) BETWEEN 0 AND 4
                 THEN 'Current 5 Weeks'
                 ELSE 'All Prior 5 Weeks'
            END AS [CURRENT_5_WEEKS_TEXT]
    FROM    dbo.TB_DIM_DATE AS d
    JOIN    dbo.TB_DIM_DATE_STD_MONTH AS m ON m.MONTH_ID = d.STD_MONTH_ID
    JOIN    dbo.TB_DIM_DATE_STD_WEEK AS w ON w.WEEK_ID = d.STD_WEEK_ID
    JOIN    dbo.TB_DIM_DATE_STD_QUARTER AS q ON q.QUARTER_ID = m.QUARTER_ID;

        -- XX WHERE d.DATE_VALUE < DATEADD(mm, 1, GETUTCDATE())
GO
GRANT SELECT
	ON [dbo].[VW_DIM_DATE_CUBE]
	TO [portalapp_role]
GO
