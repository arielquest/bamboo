SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------
--
-------------------------------------------------------------------------------
CREATE PROCEDURE [dbo].[ap_in01_imp_get_dnis]
--WITH ENCRYPTION
AS
    SET NOCOUNT ON;

    SELECT    [i].[ITEM_URN] AS [DIALED_NUMBER_URN],
        [pkey].[DIALEDNUMBER] AS [DIALED_NUMBER_STRING]
    FROM    [dbo].[TB_DIM_DIALED_NUMBER] i
    JOIN     [dbo].[TB_DIM_DIALED_NUMBER_PKEY_MAP] pkey ON [pkey].[ITEM_BIZ_URN] = [i].[ITEM_BIZ_URN]
    WHERE    GETUTCDATE() BETWEEN [i].[EFFECTIVE_FROM] AND [i].[EFFECTIVE_TO];

    RETURN @@ERROR;
GO
