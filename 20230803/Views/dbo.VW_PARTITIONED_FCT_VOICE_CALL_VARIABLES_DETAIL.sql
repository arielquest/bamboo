SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_PARTITIONED_FCT_VOICE_CALL_VARIABLES_DETAIL]
AS
    SELECT  *
    FROM    [dbo].[TB_FCT_VOICE_CALL_VARIABLES_DETAIL];
GO
GRANT SELECT
	ON [dbo].[VW_PARTITIONED_FCT_VOICE_CALL_VARIABLES_DETAIL]
	TO [portalreporting_role]
GO