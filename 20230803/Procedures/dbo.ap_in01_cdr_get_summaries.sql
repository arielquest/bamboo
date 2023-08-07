SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_in01_cdr_get_summaries] 
(
    @I_SessionUrn      [INTEGER] = NULL,
    @I_Status          [CHAR](1) = NULL
) AS
SET NOCOUNT ON;

IF @I_Status IS NOT NULL
BEGIN 
    SELECT *
    FROM [dbo].[TB_IMP_CDR_SUMMARY]
    WHERE COALESCE(@I_SessionUrn, [CDR_SESSION_URN]) = [CDR_SESSION_URN]
        AND [STATUS] = @I_Status
    ORDER BY [CDR_SESSION_URN] ASC, [TYPE] ASC, [SEQUENCE] ASC;
END;
ELSE BEGIN 
    SELECT *
    FROM [dbo].[TB_IMP_CDR_SUMMARY]
    WHERE COALESCE(@I_SessionUrn, [CDR_SESSION_URN]) = [CDR_SESSION_URN]
        AND [STATUS] NOT IN ('L', 'Z')
    ORDER BY [CDR_SESSION_URN] ASC, [TYPE] ASC, [SEQUENCE] ASC;
END;

RETURN @@ERROR;
GO