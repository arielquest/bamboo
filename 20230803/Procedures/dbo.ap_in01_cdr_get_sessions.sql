SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_in01_cdr_get_sessions] 
(
    @I_Status          [CHAR](1) = NULL
) AS
SET NOCOUNT ON;

SELECT *
FROM [dbo].[TB_IMP_CDR_SESSION]
WHERE COALESCE(@I_Status, [STATUS]) = [STATUS]
ORDER BY [RECEIVED] ASC;

RETURN @@ERROR;
GO
