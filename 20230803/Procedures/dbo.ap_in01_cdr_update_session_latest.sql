SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_in01_cdr_update_session_latest]
(
    @I_SessionUrn         [INTEGER],
    @I_Latest              [DATETIME]
) AS
SET NOCOUNT ON;

UPDATE [dbo].[TB_IMP_CDR_SESSION]
SET [LATEST] = @I_Latest
WHERE [CDR_SESSION_URN] = @I_SessionUrn;

RETURN @@ERROR;
GO
