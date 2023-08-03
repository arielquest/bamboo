SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_in01_cdr_update_summary_status]
(
    @I_SummaryUrn         [INTEGER],
    @I_NewStatus          [CHAR](1)
) AS
SET NOCOUNT ON;

DECLARE @v_Error INT;

UPDATE [dbo].[TB_IMP_CDR_SUMMARY]
SET [STATUS] = @I_NewStatus, [LOADED] = CASE WHEN @I_NewStatus = 'L' THEN GETUTCDATE() ELSE [LOADED] END
WHERE [CDR_SUMMARY_URN] = @I_SummaryUrn;

SELECT @v_Error = @@ERROR;

RETURN @v_Error;
GO
