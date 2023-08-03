SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_selfcare01_get_dn_status] 
(
    @DialedNumberString AS [VARCHAR](50), 
    @Status AS [INTEGER] OUTPUT
) AS
BEGIN 
    SET NOCOUNT ON;
    SET @Status = 0;

    SELECT TOP 1 @Status = [SELF_CARE_ENABLED]
    FROM [dbo].[VW_DIM_DIALED_NUMBER_PKEY]
    WHERE [DIALEDNUMBER] = @DialedNumberString COLLATE Latin1_General_CS_AS
    ORDER BY [ITEM_URN];

    RETURN @@ERROR;
END;
GO
