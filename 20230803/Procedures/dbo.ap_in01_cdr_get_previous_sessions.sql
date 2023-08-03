SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_in01_cdr_get_previous_sessions]
(
    @I_SessionUrn          [INTEGER],
    @I_Latest              [DATETIME]
) AS 
SET NOCOUNT ON;

SELECT *
FROM [dbo].[TB_IMP_CDR_SESSION]
WHERE [STATUS] <> 'D'
    AND [RECEIVED] <= (
        SELECT [RECEIVED]
        FROM [dbo].[TB_IMP_CDR_SESSION]
        WHERE [CDR_SESSION_URN] = @I_SessionUrn
        )
    AND [LATEST] >= @I_Latest
ORDER BY [RECEIVED] ASC;

RETURN @@ERROR;
GO
