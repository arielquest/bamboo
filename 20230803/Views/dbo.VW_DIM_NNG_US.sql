SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------
--
-------------------------------------------------------------------------------
CREATE VIEW [dbo].[VW_DIM_NNG_US]
--WITH ENCRYPTION
AS
SELECT  g.[NNG_URN] AS [NNG_URN],
        a.[MEMBER] AS [Continent],
        b.[MEMBER] AS [Country],
        d.[MEMBER] AS [State],
        e.[MEMBER] AS [County],
        f.[MEMBER] AS [Town],
        g.[MEMBER] AS [Area Code],
        g.[DESCRIPTION] AS [Description],
        f.[OSGRID] AS [OS Grid],
        f.[LAT_LONG] AS [Lat Long],
        1 AS [SUMMARIZED]
FROM    [dbo].[TB_DIM_NNG] a
JOIN    [dbo].[TB_DIM_NNG] b ON a.[NNG_URN] = b.[PARENT_URN]
JOIN    [dbo].[TB_DIM_NNG] d ON b.[NNG_URN] = d.[PARENT_URN]
JOIN    [dbo].[TB_DIM_NNG] e ON d.[NNG_URN] = e.[PARENT_URN]
JOIN    [dbo].[TB_DIM_NNG] f ON e.[NNG_URN] = f.[PARENT_URN]
JOIN    [dbo].[TB_DIM_NNG] g ON f.[NNG_URN] = g.[PARENT_URN]
WHERE   f.[SKIP_LEVEL] = 0
        AND b.[NNG_URN] = 4024 -- Corresponds to Country => United States
UNION
SELECT  f.[NNG_URN] AS [NNG_URN],
        a.[MEMBER] AS [Continent],
        b.[MEMBER] AS [Country],
        d.[MEMBER] AS [State],
        d.[MEMBER] AS [County],
        e.[MEMBER] AS [Town],
        f.[MEMBER] AS [NNG Code],
        f.[DESCRIPTION] AS [Description],
        e.[OSGRID] AS [OS Grid],
        e.[LAT_LONG] AS [Lat Long],
        1 AS [SUMMARIZED]
FROM    [dbo].[TB_DIM_NNG] a
JOIN    [dbo].[TB_DIM_NNG] b ON a.[NNG_URN] = b.[PARENT_URN]
JOIN    [dbo].[TB_DIM_NNG] d ON b.[NNG_URN] = d.[PARENT_URN]
JOIN    [dbo].[TB_DIM_NNG] e ON d.[NNG_URN] = e.[PARENT_URN]
JOIN    [dbo].[TB_DIM_NNG] f ON e.[NNG_URN] = f.[PARENT_URN]
WHERE   e.[SKIP_LEVEL] > 0
        AND b.[NNG_URN] = 4024 -- Corresponds to Country => United States
UNION
SELECT  [NNG_URN] AS [NNG_URN],
        [MEMBER] AS [Continent],
        [MEMBER] AS [Country],
        [MEMBER] AS [State],
        [MEMBER] AS [County],
        [MEMBER] AS [Town],
        [MEMBER] AS [NNG Code],
        [DESCRIPTION] AS [Description],
        [OSGRID] AS [OS Grid],
        [LAT_LONG] AS [Lat Long],
        1 AS [SUMMARIZED]
FROM    [dbo].[TB_DIM_NNG] a
WHERE   [NNG_URN] = 0;
 -- Corresponds to Default Member
GO
GRANT SELECT
	ON [dbo].[VW_DIM_NNG_US]
	TO [portalapp_role]
GO
