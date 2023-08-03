SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_in01_cdr_add_summary] 
(
    @I_SessionUrn       [INTEGER],
    @I_Type             [CHAR](50),
    @I_Sequence         [INTEGER],
    @I_RecordCount      [INTEGER],
    @I_FileName            [VARCHAR](255),
    @O_SummaryUrn       [INTEGER] OUTPUT
) AS
SET NOCOUNT ON;

DECLARE @v_Error INT;

SET @O_SummaryUrn = NULL;

SELECT @O_SummaryUrn = [CDR_SUMMARY_URN]
FROM [dbo].[TB_IMP_CDR_SUMMARY]
WHERE [SEQUENCE] = @I_Sequence
    AND [TYPE] = @I_Type
    AND [CDR_SESSION_URN] = @I_SessionUrn;
    
SELECT @v_Error = @@ERROR;

IF @v_Error = 0
    AND @O_SummaryUrn IS NULL
BEGIN 
    INSERT INTO [dbo].[TB_IMP_CDR_SUMMARY] ([TYPE], [SEQUENCE], [RECORD_COUNT], [CDR_SESSION_URN], [FILENAME])
    VALUES (@I_Type, @I_Sequence, @I_RecordCount, @I_SessionUrn, @I_FileName);

    SELECT @v_Error = @@ERROR, @O_SummaryUrn = SCOPE_IDENTITY();
END;
ELSE BEGIN 
    IF @v_Error = 0
    BEGIN 
        UPDATE [dbo].[TB_IMP_CDR_SUMMARY]
        SET [FILENAME] = @I_FileName, [RECORD_COUNT] = @I_RecordCount, [STATUS] = 'N'
        WHERE [CDR_SUMMARY_URN] = @O_SummaryUrn
            AND [STATUS] IN ('N', 'C', 'E');

        SELECT @v_Error = @@ERROR;
    END;
END;

RETURN @v_Error;
GO
