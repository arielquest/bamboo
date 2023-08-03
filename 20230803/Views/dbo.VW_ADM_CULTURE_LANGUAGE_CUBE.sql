SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_ADM_CULTURE_LANGUAGE_CUBE]
AS

SELECT -1 AS [CULTURE_URN], 'Unknown' AS [CULTURE_DISPLAY_NAME], 'Unknown'  AS [CULTURE_NAME], -1 AS [CULTURE_LANGUAGE_URN], 'Unknown' AS [LANGUAGE_NAME], -1 AS [CULTURE_COUNTRY_URN], 'Unknown' AS [COUNTRY_NAME]
UNION
SELECT -2 AS [CULTURE_URN], 'None' AS [CULTURE_DISPLAY_NAME], 'None'  AS [CULTURE_NAME], -2 AS [CULTURE_LANGUAGE_URN], 'None' AS [LANGUAGE_NAME], -2 AS [CULTURE_COUNTRY_URN], 'None' AS [COUNTRY_NAME]
UNION
SELECT  [a].[CULTURE_URN],
        [a].[CULTURE_DISPLAY_NAME],
        [a].[CULTURE_NAME],
        [a].[CULTURE_LANGUAGE_URN],
        [a].[LANGUAGE_NAME],
        [a].[CULTURE_COUNTRY_URN],
        [a].[COUNTRY_NAME]
FROM    ( SELECT    UPPER(SUBSTRING([tacl].[NAME], 1, 1))
                    + STUFF(LOWER([tacl].[NAME]), 1, 1, '') + ' ('
                    + UPPER([tacc].[TWO_LETTER_CODE]) + ')' AS [CULTURE_DISPLAY_NAME],
                    [tac].[CULTURE_URN],
                    [tac].[CULTURE_LANGUAGE_URN],
                    [tacl].[NAME] AS [LANGUAGE_NAME],
                    [tac].[CULTURE_COUNTRY_URN],
                    [tacc].[NAME] AS [COUNTRY_NAME],
                    [tac].[CULTURE_NAME],
                    ROW_NUMBER() OVER ( PARTITION BY [tac].[CULTURE_NAME] ORDER BY [tac].[CULTURE_URN] ) AS RN
          FROM      [dbo].[TE_ADM_CULTURE] AS [tac]
          INNER JOIN [dbo].[TE_ADM_CULTURE_COUNTRY] AS [tacc] ON [tac].[CULTURE_COUNTRY_URN] = [tacc].[COUNTRY_URN]
          INNER JOIN [dbo].[TE_ADM_CULTURE_LANGUAGE] AS [tacl] ON [tac].[CULTURE_LANGUAGE_URN] = [tacl].[LANGUAGE_URN]
        ) a
WHERE   RN = 1;
GO
GRANT SELECT
	ON [dbo].[VW_ADM_CULTURE_LANGUAGE_CUBE]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[VW_ADM_CULTURE_LANGUAGE_CUBE]
	TO [portal_default_mediator_role]
GO
