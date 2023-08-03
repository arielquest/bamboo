SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
--SELECT * FROM [dbo].[VW_DIM_NNG_UK_CUBE]
--SELECT COUNT(DISTINCT(NNG_URN)) FROM [dbo].[VW_DIM_NNG_UK_CUBE]
--SELECT COUNT(DISTINCT(NNG_URN)) FROM [dbo].[TB_DIM_NNG]
-------------------------------------------------------------------------------
--
-------------------------------------------------------------------------------
CREATE VIEW [dbo].[VW_DIM_NNG_UK_CUBE]
AS
-- Select all members who are part of the required country
    SELECT  [NNG_URN],
            [Continent],
            [Country],
            [TV Region],
            [County Council],
            [Unitary Authority],
            [Town],
            [Area Code],
            [Description],
            [OS Grid],
            [Lat Long]
    FROM    dbo.VW_DIM_NNG_UK
    UNION

    -- Select all members who are not part of the required country and default their levels so that the aggregate forms a single total.
    SELECT  [NNG_URN] AS [NNG_URN],
            'Other' AS [Continent],
            'Other' AS [Country],
            'Other' AS [TV Region],
            'Other' AS [County Council],
            'Other' AS [Unitary Authority],
            'Other' AS [Town],
            'Other' AS [Area Code],
            '' AS [Description],
            '' AS [OS Grid],
            '' AS [Lat Long]
    FROM    dbo.VW_DIM_NNG
    WHERE   [NNG_URN] NOT IN ( SELECT   [NNG_URN]
                               FROM     dbo.VW_DIM_NNG_UK );
GO
GRANT SELECT
	ON [dbo].[VW_DIM_NNG_UK_CUBE]
	TO [portalapp_role]
GO
