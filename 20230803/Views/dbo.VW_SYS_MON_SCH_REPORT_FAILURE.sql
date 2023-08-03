SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[VW_SYS_MON_SCH_REPORT_FAILURE]
AS
    SELECT  [report].[NAME] AS [REPORT_NAME],
            [report].[CONTENT_PATH] AS [REPORT_PATH],
            [task].[NAME] AS [SCHEDULE_NAME],
            [history].[FIRETIME],
            [history].[PREVIOUS_FIRE_TIME],
            [history].[NEXT_FIRE_TIME],
            [history].[RESULT]
    FROM    [dbo].[TB_SCH_TASK] [task]
    INNER JOIN [dbo].[TB_SCH_REPORT] [scheduledReport] ON [scheduledReport].[SCH_REPORT_ID] = [task].[TASK_ID]
    INNER JOIN [dbo].[TB_REP_REPORT] [report] ON [report].[REPORT_ID] = [scheduledReport].[REPORT_ID]
    CROSS APPLY ( SELECT TOP 1
                            [hist].[TASK_HISTORY_ID],
                            [hist].[TASK_ID],
                            [hist].[SESSION_ID],
                            [hist].[FIRETIME],
                            [hist].[TRIGGER],
                            [hist].[PREVIOUS_FIRE_TIME],
                            ISNULL([hist].[NEXT_FIRE_TIME], '2079-01-01 00:00:00') AS [NEXT_FIRE_TIME],
                            [hist].[RESULT]
                  FROM      [dbo].[TB_SCH_TASK_HISTORY] [hist]
                  WHERE     [task].[TASK_ID] = [hist].[TASK_ID]
                  ORDER BY  [hist].[FIRETIME] DESC
                ) [history]
    WHERE   [task].[ENABLED] = 1
            AND ( [history].[NEXT_FIRE_TIME] < GETUTCDATE()
                  OR [history].[RESULT] = 'E'
                );
GO
GRANT SELECT
	ON [dbo].[VW_SYS_MON_SCH_REPORT_FAILURE]
	TO [portalapp_role]
GO
