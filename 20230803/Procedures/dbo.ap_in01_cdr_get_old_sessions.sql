SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_in01_cdr_get_old_sessions] AS

DECLARE @v_FirstBad INT, @v_FirstGood INT, @v_Error INT;

SELECT TOP 1 @v_FirstBad = CDR_SESSION_URN
FROM [dbo].[TB_IMP_CDR_SESSION]
WHERE [STATUS] NOT IN ('L', 'Z', 'D')
ORDER BY [RECEIVED] ASC;

SELECT @v_Error = @@ERROR;

IF @v_Error = 0
BEGIN 
    IF @v_FirstBad IS NOT NULL
    BEGIN 
        SELECT TOP 1 @v_FirstGood = CDR_SESSION_URN
        FROM [dbo].[TB_IMP_CDR_SESSION]
        WHERE [RECEIVED] < (
                SELECT [RECEIVED]
                FROM [dbo].[TB_IMP_CDR_SESSION]
                WHERE [CDR_SESSION_URN] = @v_FirstBad
                )
        ORDER BY [RECEIVED] DESC;
    END;
    ELSE BEGIN 
        SELECT TOP 1 @v_FirstGood = CDR_SESSION_URN
        FROM [dbo].[TB_IMP_CDR_SESSION]
        ORDER BY [RECEIVED] DESC;
    END;
END;

SELECT @v_Error = @@ERROR;

IF @v_Error = 0
BEGIN 
    SELECT *
    FROM [dbo].[TB_IMP_CDR_SESSION]
    WHERE [RECEIVED] < COALESCE((
                SELECT [RECEIVED]
                FROM [dbo].[TB_IMP_CDR_SESSION]
                WHERE [CDR_SESSION_URN] = @v_FirstGood
                ), 0)
        AND [STATUS] <> 'D'
        AND (
            DATEDIFF(day, [LOADED], getutcdate()) < 7
            OR [STATUS] = 'L'
            )
    ORDER BY [RECEIVED] ASC;

    SELECT @v_Error = @@ERROR;
END;

RETURN @v_Error;
GO
