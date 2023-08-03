SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------
--
-------------------------------------------------------------------------------
CREATE VIEW [dbo].[VW_SUM_IN_CALL_VOLUME_HH_CUBE]
--WITH ENCRYPTION
AS
SELECT  *
FROM    dbo.VW_SUM_IN_CALL_VOLUME_HH;
GO
