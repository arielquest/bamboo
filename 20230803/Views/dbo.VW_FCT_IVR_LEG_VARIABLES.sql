SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------
--
-------------------------------------------------------------------------------
CREATE VIEW [dbo].[VW_FCT_IVR_LEG_VARIABLES]
--WITH ENCRYPTION
AS
SELECT  [PARTITION_URN],
        [PARTITION_ID],
        [PARTITION_GLOBAL_URN],
        [IVR_LEG_URN],
        [SEQUENCE_NUMBER],
        [DATE_TIME],
        [CV1],
        [CV2],
        [CV3],
        [CV4],
        [CV5],
        [CV6],
        [CV7],
        [CV8],
        [CV9],
        [CV10],
        [CED],
        [PATH]
FROM    dbo.VW_PARTITIONED_FCT_IVR_LEG_VARIABLES;
GO
GRANT SELECT
	ON [dbo].[VW_FCT_IVR_LEG_VARIABLES]
	TO [portalreporting_role]
GO
