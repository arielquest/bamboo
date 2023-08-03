SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[VW_SYS_MON_SYSTEM_AUDIT]
AS
    
    WITH    [min]
            AS ( SELECT   top 1 [EVENT_UTC_DATE_TIME] AS [MIN_EVENT_UTC_DATE_TIME]
                FROM     [dbo].[TB_FCT_SYSTEM_AUDIT]
                ORDER BY [EVENT_UTC_DATE_TIME] ASC
                ),
    [max] AS 
    (SELECT TOP 1 CAST([EVENT_UTC_DATE_TIME] AS DATE) AS [MAX_EVENT_UTC_DATE]
    FROM     [dbo].[TB_FCT_SYSTEM_AUDIT]
    ORDER BY [EVENT_UTC_DATE_TIME] DESC)
        SELECT  [aggregate].[MAX_EVENT_UTC_DATE],
                COUNT(*) AS [MAX_DATA_AVAILABLE_COUNT],
                [min].[MIN_EVENT_UTC_DATE_TIME]
        FROM    [dbo].[TB_FCT_SYSTEM_AUDIT] [audit]
        INNER JOIN [max] [aggregate] ON [aggregate].[MAX_EVENT_UTC_DATE] = CAST([audit].[EVENT_UTC_DATE_TIME] AS DATE)
        OUTER APPLY [min] 
        GROUP BY [aggregate].[MAX_EVENT_UTC_DATE],
                [min].[MIN_EVENT_UTC_DATE_TIME];
GO
GRANT SELECT
	ON [dbo].[VW_SYS_MON_SYSTEM_AUDIT]
	TO [portalapp_role]
GO
