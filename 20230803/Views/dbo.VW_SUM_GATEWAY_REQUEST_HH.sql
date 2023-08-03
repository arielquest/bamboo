SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------
--
-------------------------------------------------------------------------------
CREATE VIEW [dbo].[VW_SUM_GATEWAY_REQUEST_HH]
--WITH ENCRYPTION
AS
SELECT  *,
        1 AS [Row Count]
FROM    [dbo].[VW_PARTITIONED_SUM_GATEWAY_REQUEST_HH];
GO
