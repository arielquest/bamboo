SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_in01_cdr_add_session] 
(
    @I_Sequence             [INTEGER],
    @I_SwitchCode           [INTEGER],
    @I_SwitchType           [CHAR](4),    
    @I_ExpectedRecordCount  [INTEGER],
    @I_Created              [DATETIME],
    @O_Status               [CHAR](1) OUTPUT,
    @O_SessionUrn           [INTEGER] OUTPUT
) AS
SET NOCOUNT ON;

DECLARE @v_Error INT;

SET @O_Status = 'N';
SET @O_SessionUrn = NULL;

SELECT @O_Status = [STATUS], @O_SessionUrn = [CDR_SESSION_URN]
FROM [dbo].[TB_IMP_CDR_SESSION]
WHERE [SEQUENCE] = @I_Sequence
    AND [SWITCH_CODE] = @I_SwitchCode
    AND [SWITCH_TYPE] = @I_SwitchType;

SELECT @v_Error = @@ERROR;

IF @O_Status <> 'N'
BEGIN 
    SET @O_Status = 'D';
    SET @O_SessionUrn = NULL;
END;

IF @v_Error = 0
    AND @O_SessionUrn IS NULL
BEGIN 
    INSERT INTO [dbo].[TB_IMP_CDR_SESSION] ([SEQUENCE], [SWITCH_CODE], [SWITCH_TYPE], [EXPECTED_RECORD_COUNT], [CREATED], [STATUS])
    VALUES (@I_Sequence, @I_SwitchCode, @I_SwitchType, @I_ExpectedRecordCount, @I_Created, @O_Status);

    SELECT @v_Error = @@ERROR, @O_SessionUrn = SCOPE_IDENTITY();
END;

RETURN @v_Error;
GO
