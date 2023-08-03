SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_SCH_REPORT_TASKS]
--WITH SCHEMABINDING
AS
SELECT  task.TASK_ID,
        report.REPORT_ID,
        repItem.NAME AS REPORT_NAME,
        repFolder.PATH AS REPORT_PATH,
        folder.FOLDER_ID,
        folder.PATH,
        task.NAME,
        task.DESCRIPTION,
        task.DELETED,
        task.CREATION_DATE_TIME,
        creator.LOGIN_NAME AS CREATED_BY_USER,
        creator.USER_ID AS CREATED_BY_USER_ID,
        assigned.LOGIN_NAME AS ASSIGNED_TO_USER,
        assigned.USER_ID AS ASSIGNED_TO_USER_ID,
        assigned.ENABLED AS ASSIGNED_TO_USER_ENABLED,
        task.MODIFIED_DATE_TIME,
        task.ENABLED,
        hist.RESULT AS LAST_RUN_RESULT,
        hist.FIRETIME AS LAST_RUN_TIME,
        dbo.fn_convert_ticks_to_datetime(MIN(trig.NEXT_FIRE_TIME)) AS NEXT_RUN_TIME
FROM    TB_SCH_REPORT report
JOIN    TB_SCH_TASK task ON task.TASK_ID = report.SCH_REPORT_ID
JOIN    TB_SEC_FOLDER folder ON task.FOLDER_ID = folder.FOLDER_ID
JOIN    TB_REP_REPORT repItem ON repItem.REPORT_ID = report.REPORT_ID
JOIN    TB_SEC_FOLDER repFolder ON repFolder.FOLDER_ID = repItem.FOLDER_ID
JOIN    TB_SEC_USER creator ON creator.USER_ID = task.CREATED_BY_USER_ID
JOIN    TB_SEC_USER assigned ON assigned.USER_ID = task.ASSIGNED_TO_USER_ID
LEFT JOIN TB_SCH_QRTZ_TRIGGERS trig ON trig.JOB_NAME = task.TASK_ID
LEFT JOIN ( SELECT  h.TASK_ID,
                    h.FIRETIME,
                    h.RESULT
            FROM    TB_SCH_TASK_HISTORY h
            JOIN    ( SELECT    TASK_ID,
                                MAX(FIRETIME) AS MAX_FIRETIME
                      FROM      TB_SCH_TASK_HISTORY
                      GROUP BY  TASK_ID
                    ) AS maxFireTimes ON h.TASK_ID = maxFireTimes.TASK_ID
                                         AND h.FIRETIME = maxFireTimes.MAX_FIRETIME
          ) hist ON hist.TASK_ID = task.TASK_ID
GROUP BY task.TASK_ID,
        report.REPORT_ID,
        repItem.NAME,
        repFolder.PATH,
        folder.FOLDER_ID,
        folder.PATH,
        task.NAME,
        task.DESCRIPTION,
        task.DELETED,
        task.CREATION_DATE_TIME,
        creator.LOGIN_NAME,
        creator.USER_ID,
        assigned.LOGIN_NAME,
        assigned.USER_ID,
        assigned.ENABLED,
        task.MODIFIED_DATE_TIME,
        task.ENABLED,
        hist.RESULT,
        hist.FIRETIME;
GO
GRANT SELECT
	ON [dbo].[VW_SCH_REPORT_TASKS]
	TO [portalapp_role]
GO
