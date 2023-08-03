SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------
--
-------------------------------------------------------------------------------
CREATE VIEW [dbo].[VW_FCT_AGENT_LOGOUT]
--WITH ENCRYPTION
AS
    SELECT  [AGENT_LOGOUT_URN],
            [STARTDATE_URN],
            [STARTTIME_URN],
            [STARTDATE_UTC_URN],
            [STARTTIME_UTC_URN],
            [START_DATE_TIME],
            [START_DATE_TIME_UTC],
            DATEADD([ss], -COALESCE([LOGIN_DURATION],0), [START_DATE_TIME]) AS [LOGIN_DATE_TIME],
            [START_UTC_TIMEZONE],
            [AGENT_URN],
            [AGENT_TEAM_URN],
            [SUPERVISOR_AGENT_URN],
            [PERIPHERAL_URN],
            [LOGOUT_REASON_URN],
            [RATING_PERIOD_URN],
            [DURATION_TIMEBAND_URN],
            [PERSON_URN],
            [MEDIA_ROUTING_DOMAIN_URN],
            [CLUSTER_RESOURCE_URN],
            [LOGIN_DURATION],
            [LOGOUT_REASON], 
            [PARTITION_ID], 
            1 AS [Row Count]
    FROM dbo.VW_PARTITIONED_FCT_AGENT_LOGOUT;
GO
GRANT SELECT
	ON [dbo].[VW_FCT_AGENT_LOGOUT]
	TO [portalreporting_role]
GO
