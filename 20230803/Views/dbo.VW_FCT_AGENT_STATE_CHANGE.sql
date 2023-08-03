SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------
--
-------------------------------------------------------------------------------
CREATE VIEW [dbo].[VW_FCT_AGENT_STATE_CHANGE]
--WITH ENCRYPTION
AS
    SELECT  [AGENT_STATE_CHANGE_URN], 
            [STARTDATE_URN], 
            [STARTTIME_URN], 
            [STARTDATE_UTC_URN], 
            [STARTTIME_UTC_URN], 
            [START_DATE_TIME], 
            [START_UTC_TIMEZONE], 
            [AGENT_URN], 
            [PERSON_URN],
            [CLUSTER_RESOURCE_URN],  
            [EVENT], 
            [REASON], 
            [STATE], 
            [DIRECTION],
            [PARTITION_ID],
            1 AS [Row Count]
    FROM dbo.VW_PARTITIONED_FCT_AGENT_STATE_CHANGE;
GO
GRANT SELECT
	ON [dbo].[VW_FCT_AGENT_STATE_CHANGE]
	TO [portalreporting_role]
GO
