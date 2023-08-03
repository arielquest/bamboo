SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_FCT_AGENT_SKILLGROUP_LOGOUT]
AS
    SELECT  [PARTITION_URN],
            [PARTITION_ID],
            [PARTITION_GLOBAL_URN],
            [LOGOUT_DATE_TIME],
            [LOGOUT_DATE_URN],
            [LOGOUT_TIME_URN],
            [LOGOUT_DATE_UTC_URN],
            [LOGOUT_TIME_UTC_URN],
            [LOGOUT_UTC_TIMEZONE],
            [AGENT_URN],
            [AGENT_TEAM_URN],
            [SUPERVISOR_AGENT_URN],
            [PERIPHERAL_URN],
            [SKILLGROUP_URN],
            [PERSON_URN],
            [REASON_CODE_URN],
            [RATING_PERIOD_URN],
            [DURATION_TIMEBAND_URN],
            [CLUSTER_RESOURCE_URN],
            [LOGIN_DURATION],
            [LOGOUT_REASON],            
            1     AS [Row Count]
    FROM dbo.VW_PARTITIONED_FCT_AGENT_SKILLGROUP_LOGOUT;
GO
GRANT SELECT
	ON [dbo].[VW_FCT_AGENT_SKILLGROUP_LOGOUT]
	TO [portalreporting_role]
GO
