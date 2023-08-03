SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------
--
-------------------------------------------------------------------------------
CREATE VIEW [dbo].[VW_SUM_IN_BUSY_MINUTE_BY_DNIS_TLI_CUBE]
--WITH ENCRYPTION
AS
SELECT  *
FROM    dbo.VW_SUM_IN_BUSY_MINUTE_BY_DNIS_TLI;
GO
