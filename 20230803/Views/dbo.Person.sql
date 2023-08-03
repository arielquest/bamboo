SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Person]
AS
SELECT  CAST([person].[PKEY1] AS INT) AS [PersonID],
        [person].[FIRST_NAME] AS [FirstName],
        [person].[LAST_NAME] AS [LastName],
        [person].[LOGIN_NAME] AS [LoginName],
        UPPER([person].[LOGIN_NAME]) AS [LoginNameShadow],
        [person].[PASS_PHRASE] AS [Password],
        0 AS PasswordChangeRequired,
        NULL AS PasswordLastChangedTime,
        CASE [person].[LOGIN_ENABLED]
          WHEN 1 THEN 'Y'
          ELSE 'N'
        END AS [LoginEnabled],
        [person].[DESCRIPTION] AS [Description],
        CASE [person].[DELETED]
          WHEN 1 THEN 'Y'
          ELSE 'N'
        END AS [Deleted],
        [person].[SOURCE_CHANGE_STAMP] AS [ChangeStamp]
FROM    [dbo].[VW_DIM_PERSON_PKEY] person
JOIN    [dbo].[TB_CLU_RESOURCE] cluResource ON [cluResource].[RESOURCE_ID] = [person].[CLUSTER_RESOURCE_ID]
JOIN    [dbo].[TE_ADM_CLUSTER_RESOURCE_TYPE] resourceType ON [resourceType].[CLUSTER_RESOURCE_TYPE_ID] = [cluResource].[RESOURCE_TYPE_ID]
WHERE   [resourceType].[INTERNAL_NAME] <> 'CRT_CISCO_CALL_MANAGER'
        AND [person].[PKEY_LATEST] = 1
        AND [person].[ITEM_URN] = [person].[ITEM_BIZ_URN];
GO
