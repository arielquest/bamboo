SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_in01_cdr_get_max_sequence_id] 
(
    @O_Sequence    [INT] OUTPUT
) AS
SET NOCOUNT ON;

SELECT TOP 1 @O_Sequence = [SEQUENCE]
FROM TB_IMP_CDR_SESSION
WHERE [STATUS] <> 'N'
ORDER BY [RECEIVED] DESC;

SELECT @O_Sequence = COALESCE(@O_Sequence, 0);

RETURN @@ERROR;
GO