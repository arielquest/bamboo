SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------
--
-------------------------------------------------------------------------------
CREATE VIEW [dbo].[VW_FCT_IVR_LEG_NODE_PATH]
--WITH ENCRYPTION
AS
SELECT  [PARTITION_URN],
        [PARTITION_ID],
        [PARTITION_GLOBAL_URN],
        [DATE_URN],
        [TIME_URN],
        [DATE_UTC_URN],
        [TIME_UTC_URN],
        [DATE_TIME],
        [UTC_TIMEZONE],
        [DIALED_NUMBER_URN],
        [IVR_SCRIPT_NODE_URN],
        [SEQUENCE],
        [PERIOD],
        [DEFLECTION],
        [BARGED_IN],
        1 AS [Occurence]
FROM    dbo.VW_PARTITIONED_FCT_IVR_LEG_NODE_PATH;
GO
GRANT SELECT
	ON [dbo].[VW_FCT_IVR_LEG_NODE_PATH]
	TO [portalreporting_role]
GO
