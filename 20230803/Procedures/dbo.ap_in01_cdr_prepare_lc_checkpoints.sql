SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_in01_cdr_prepare_lc_checkpoints]
(
    @I_SessionUrn    [INT]
) AS 
SET NOCOUNT ON;

DELETE
FROM [dbo].[TS_IMP_CDR_LC_CHECKPOINT]
WHERE [CDR_SESSION_URN] = @I_SessionUrn;

RETURN @@ERROR;
GO
