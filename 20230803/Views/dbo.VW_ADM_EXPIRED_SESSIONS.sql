SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_ADM_EXPIRED_SESSIONS]
AS
    SELECT  [sess].[SESSION_ID],
            [sess].[SESSION_TYPE_ID],
            [sess].[SESSION_COMPUTER],
            [sess].[SESSION_CLIENT_COMPUTER],
            [sess].[SESSION_USER_NAME],
            [sess].[SESSION_USER_ID],
            [sess].[SESSION_USER_AGENT],
            [sess].[msrepl_tran_version]
    FROM    [dbo].[TB_ADM_SESSION] [sess]
    WHERE   EXISTS ( SELECT 1
                     FROM   ( SELECT    [SESSION_TYPE_ID] AS [SESSIONS]
                              FROM      [dbo].[TE_ADM_SESSION_TYPE]
                              WHERE     [INTERNAL_NAME] NOT IN ( 'ST_DATA_IMPORT_SERVER', 'ST_MEDIATOR', 'ST_PROVISIONING' )
                            ) AS [st]
                     WHERE  [st].[SESSIONS] = [sess].[SESSION_TYPE_ID] )
            AND NOT EXISTS ( SELECT 1
                             FROM   [dbo].[VW_FCT_AUDIT] [aud]
                             WHERE  [sess].[SESSION_ID] = [aud].[SESSION_ID] )
            AND NOT EXISTS ( SELECT 1
                             FROM   [dbo].[TB_SCH_TASK_HISTORY] [tsk]
                             WHERE  [sess].[SESSION_ID] = [tsk].[SESSION_ID] )
            AND NOT EXISTS ( SELECT 1
                             FROM   [dbo].[TB_IMP_EXCEPTION] [exc]
                             WHERE  [sess].[SESSION_ID] = [exc].[SESSION_ID] );
GO
GRANT DELETE
	ON [dbo].[VW_ADM_EXPIRED_SESSIONS]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[VW_ADM_EXPIRED_SESSIONS]
	TO [portalapp_role]
GO
