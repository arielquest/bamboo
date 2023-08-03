SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_in01_cdr_validate_imports]
(
    @I_SessionUrn      [INTEGER] = NULL,
    @O_NewStatus       [CHAR](1) OUTPUT
) AS
DECLARE @v_Error INT;

SET NOCOUNT ON;

SELECT @v_Error = 0;

IF NOT EXISTS (
        SELECT CDR_SUMMARY_URN
        FROM TB_IMP_CDR_SUMMARY
        WHERE CDR_SESSION_URN = @I_SessionUrn
            AND STATUS <> 'L'
        )
BEGIN 
    EXEC @v_Error = ap_in01_cdr_update_session_status @I_SessionUrn = @I_SessionUrn, @I_NewStatus = 'L';
END;
ELSE BEGIN 
    IF EXISTS (
            SELECT CDR_SUMMARY_URN
            FROM TB_IMP_CDR_SUMMARY
            WHERE CDR_SESSION_URN = @I_SessionUrn
                AND STATUS = 'E'
            )
    BEGIN 
        -- If there is a single error within the imports then we need to revisit this session
        -- therefore flag it as an error
        EXEC @v_Error = ap_in01_cdr_update_session_status @I_SessionUrn = @I_SessionUrn, @I_NewStatus = 'E'
    END;
END;

IF @v_Error = 0
BEGIN 
    SELECT @O_NewStatus = STATUS
    FROM TB_IMP_CDR_SESSION
    WHERE CDR_SESSION_URN = @I_SessionUrn;

    SELECT @v_Error = @@ERROR;
END;

RETURN @v_Error;
GO
