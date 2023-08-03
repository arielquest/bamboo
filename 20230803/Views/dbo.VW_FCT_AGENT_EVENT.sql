SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------
--
-------------------------------------------------------------------------------
CREATE VIEW [dbo].[VW_FCT_AGENT_EVENT]
--WITH ENCRYPTION
AS
    SELECT    [AGENT_EVENT_URN],
            [EVENT_DATE_URN],
            [EVENT_TIME_URN],
            [EVENT_DATE_UTC_URN],
            [EVENT_TIME_UTC_URN],
            [EVENT_DATE_TIME],
            [LOGIN_DATE_URN],
            [LOGIN_TIME_URN],
            [LOGIN_DATE_UTC_URN],
            [LOGIN_TIME_UTC_URN],
            [LOGIN_DATE_TIME],
            [UTC_TIMEZONE],
            [MEDIA_CLASS_URN],
            [MEDIA_ROUTING_DOMAIN_URN],
            [AGENT_URN],
            [AGENT_TEAM_URN],
            [SUPERVISOR_AGENT_URN],
            [PERIPHERAL_URN],
            [PERSON_URN],
            [REASON_CODE_URN],
            [DURATION_TIMEBAND_URN],
            [CLUSTER_RESOURCE_URN],
            [DURATION],
            [EVENT],
            [PARTITION_ID],
            1 AS [Row Count]
    FROM dbo.VW_PARTITIONED_FCT_AGENT_EVENT;
GO
GRANT SELECT
	ON [dbo].[VW_FCT_AGENT_EVENT]
	TO [portalreporting_role]
GO
