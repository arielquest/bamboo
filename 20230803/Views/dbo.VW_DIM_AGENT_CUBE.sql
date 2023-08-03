SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_AGENT_CUBE]
WITH SCHEMABINDING
AS
SELECT  [it].[ITEM_URN],
        [it].[ITEM_BIZ_URN],
        CAST('00001100-1000-0000-0000-000000000010' AS UNIQUEIDENTIFIER) AS [ITEM_TYPE_ID],
        [it].[ITEM_SUBTYPE_ID],
        [it].[OWNER_ID],
        [it].[FOLDER_ID],
        [fl].[PARENT_ID] AS [FOLDER_PARENT_ID],
        [fl].[FOLDER_TYPE],
        [fl].[DEPTH] AS [FOLDER_DEPTH],
        [fl].[NAME] AS [FOLDER_NAME],
        [fl].[FOLDER_URN],
        [it].[NAME],
        COALESCE([icmAgent].[INTERNAL_NAME], '') AS [ICM_INTERNAL_NAME],
        COALESCE([icmAgent].[PKEY1], '') AS [ICM_AGENT_ID],
        COALESCE([icmAgent].[PERIPHERAL_NUMBER], '') AS [ICM_PERIPHERAL_NUMBER],
        COALESCE([icmAgent].[PERIPHERAL_NAME], '') AS [ICM_PERIPHERAL_NAME],
        COALESCE([icmAgent].[SUPERVISOR], '') AS [ICM_SUPERVISOR],
        COALESCE([icmAgent].[AGENT_STATE_TRACE], '') AS [ICM_AGENT_STATE_TRACE],
        COALESCE([icmAgent].[DOMAIN_NAME], '') AS [ICM_DOMAIN_NAME],
        COALESCE([icmAgent].[DOMAIN_LOGIN_NAME], '') AS [ICM_DOMAIN_LOGIN_NAME],
        COALESCE([icmAgent].[DOMAIN_USER_NAME], '') AS [ICM_DOMAIN_USER_NAME],
        COALESCE([icmAgent].[DOMAIN_USER_GUID], '') AS [ICM_DOMAIN_USER_GUID],
        COALESCE([icmAgent].[USER_DELETABLE], '') AS [ICM_USER_DELETABLE],
        COALESCE([icmAgent].[USER_GROUP_ID], '') AS [ICM_USER_GROUP_ID],
        COALESCE([icmAgent].[FIRST_NAME], '') AS [ICM_FIRST_NAME],
        COALESCE([icmAgent].[LAST_NAME], '') AS [ICM_LAST_NAME],
        COALESCE([avayaAgent].[PERIPHERAL_NUMBER], '') AS [AVAYA_PERIPHERAL_NUMBER],
        COALESCE([avayaAgent].[PERIPHERAL_NAME], '') AS [AVAYA_PERIPHERAL_NAME],
        COALESCE([avayaAgent].[INTERNAL_NAME], '') AS [AVAYA_INTERNAL_NAME],
        COALESCE([eGainAgent].[INTERNAL_NAME], 'Unknown') AS [EGAIN_INTERNAL_NAME],
        COALESCE(REPLACE(REPLACE(REPLACE([it].[DESCRIPTION], CHAR(9), ''), CHAR(13), ''), CHAR(10), ''), '') COLLATE Latin1_General_100_CI_AS_SC AS [DESCRIPTION],
        COALESCE([customAttributes].[CUSTOM_ITEM_ATT_0], '') AS [CUSTOM_ITEM_ATT_0],
        COALESCE([customAttributes].[CUSTOM_ITEM_ATT_1], '') AS [CUSTOM_ITEM_ATT_1],
        COALESCE([customAttributes].[CUSTOM_ITEM_ATT_2], '') AS [CUSTOM_ITEM_ATT_2],
        COALESCE([customAttributes].[CUSTOM_ITEM_ATT_3], '') AS [CUSTOM_ITEM_ATT_3],
        COALESCE([customAttributes].[CUSTOM_ITEM_ATT_4], '') AS [CUSTOM_ITEM_ATT_4],
        COALESCE([customAttributes].[CUSTOM_ITEM_ATT_5], '') AS [CUSTOM_ITEM_ATT_5],
        COALESCE([customAttributes].[CUSTOM_ITEM_ATT_6], '') AS [CUSTOM_ITEM_ATT_6],
        COALESCE([customAttributes].[CUSTOM_ITEM_ATT_7], '') AS [CUSTOM_ITEM_ATT_7],
        COALESCE([customAttributes].[CUSTOM_ITEM_ATT_8], '') AS [CUSTOM_ITEM_ATT_8],
        COALESCE([customAttributes].[CUSTOM_ITEM_ATT_9], '') AS [CUSTOM_ITEM_ATT_9],
        [it].[EFFECTIVE_FROM],
        [it].[EFFECTIVE_TO],
        [it].[HIERARCHY_PARENT_URN],
        [it].[TIME_ZONE_URN],
        [it].[SKIP_LEVEL],
        [it].[DELETED],
        [it].[HIDDEN],
        [it].[SYSTEM],
        [it].[LATEST],
        [it].[CHANGE_STAMP]
FROM    [dbo].[TB_DIM_AGENT] [it]
OUTER APPLY ( SELECT TOP 1
                        [agentPkey].[PKEY_MAP_URN],
                        [agentPkey].[PKEY_MAP_BIZ_URN],
                        [agentPkey].[ITEM_BIZ_URN],
                        [agentPkey].[CLUSTER_RESOURCE_ID],
                        MAX(CASE WHEN [OBJ_COLUMN_NAME] = 'CUSTOM_ITEM_ATT_0' THEN [agentPkey].[attributeValue]
                                 ELSE ''
                            END) AS [CUSTOM_ITEM_ATT_0],
                        MAX(CASE WHEN [OBJ_COLUMN_NAME] = 'CUSTOM_ITEM_ATT_1' THEN [agentPkey].[attributeValue]
                                 ELSE ''
                            END) AS [CUSTOM_ITEM_ATT_1],
                        MAX(CASE WHEN [OBJ_COLUMN_NAME] = 'CUSTOM_ITEM_ATT_2' THEN [agentPkey].[attributeValue]
                                 ELSE ''
                            END) AS [CUSTOM_ITEM_ATT_2],
                        MAX(CASE WHEN [OBJ_COLUMN_NAME] = 'CUSTOM_ITEM_ATT_3' THEN [agentPkey].[attributeValue]
                                 ELSE ''
                            END) AS [CUSTOM_ITEM_ATT_3],
                        MAX(CASE WHEN [OBJ_COLUMN_NAME] = 'CUSTOM_ITEM_ATT_4' THEN [agentPkey].[attributeValue]
                                 ELSE ''
                            END) AS [CUSTOM_ITEM_ATT_4],
                        MAX(CASE WHEN [OBJ_COLUMN_NAME] = 'CUSTOM_ITEM_ATT_5' THEN [agentPkey].[attributeValue]
                                 ELSE ''
                            END) AS [CUSTOM_ITEM_ATT_5],
                        MAX(CASE WHEN [OBJ_COLUMN_NAME] = 'CUSTOM_ITEM_ATT_6' THEN [agentPkey].[attributeValue]
                                 ELSE ''
                            END) AS [CUSTOM_ITEM_ATT_6],
                        MAX(CASE WHEN [OBJ_COLUMN_NAME] = 'CUSTOM_ITEM_ATT_7' THEN [agentPkey].[attributeValue]
                                 ELSE ''
                            END) AS [CUSTOM_ITEM_ATT_7],
                        MAX(CASE WHEN [OBJ_COLUMN_NAME] = 'CUSTOM_ITEM_ATT_8' THEN [agentPkey].[attributeValue]
                                 ELSE ''
                            END) AS [CUSTOM_ITEM_ATT_8],
                        MAX(CASE WHEN [OBJ_COLUMN_NAME] = 'CUSTOM_ITEM_ATT_9' THEN [agentPkey].[attributeValue]
                                 ELSE ''
                            END) AS [CUSTOM_ITEM_ATT_9]
              FROM      ( SELECT    [a].[SOURCE_ATT_NAME],
                                    CONCAT('CUSTOM_ITEM_ATT_', [a].[OBJ_INDEX]) AS [OBJ_COLUMN_NAME],
                                    [a].[OBJ_INDEX],
                                    [a].[CLUSTER_RESOURCE_ID]
                          FROM      ( 
                                      SELECT    [SOURCE_ATT_NAME],
                                                [OBJ_INDEX],
                                                [CLUSTER_RESOURCE_ID]
                                      FROM      [dbo].[TB_ADM_CUSTOM_ATTRIBUTE]
                                      WHERE     [ATTRIBUTE_TYPE] = 'D'
                                                AND [OBJ_TYPE] = 'IT_AGENT'
                                    ) [a]
                          WHERE     [a].[OBJ_INDEX] > -1
                        ) [customAttributes]
              INNER JOIN ( SELECT   [PKEY_MAP_URN],
                                    [PKEY_MAP_BIZ_URN],
                                    [ITEM_BIZ_URN],
                                    [CLUSTER_RESOURCE_ID],
                                    [customAttributes].[customAttribute].[value](N'@Name[1]', N'nvarchar(MAX)') AS [attributeName],
                                    ISNULL([customAttributes].[customAttribute].[value](N'text()[1]', N'nvarchar(MAX)'), '') AS [attributeValue]
                           FROM     [dbo].[TB_DIM_AGENT_PKEY_MAP]
                           CROSS APPLY [CUSTOM_XML_DATA].[nodes](N'/Columns/Column') AS [customAttributes] ( [customAttribute] )
                           WHERE    [CUSTOM_XML_DATA] IS NOT NULL
                         ) [agentPkey] ON [customAttributes].[CLUSTER_RESOURCE_ID] = [agentPkey].[CLUSTER_RESOURCE_ID]
                                          AND [customAttributes].[SOURCE_ATT_NAME] = [agentPkey].[attributeName]
              WHERE     [agentPkey].[ITEM_BIZ_URN] = [it].[ITEM_BIZ_URN]
              GROUP BY  [agentPkey].[PKEY_MAP_URN],
                        [agentPkey].[PKEY_MAP_BIZ_URN],
                        [agentPkey].[ITEM_BIZ_URN],
                        [agentPkey].[CLUSTER_RESOURCE_ID]
            ) [customAttributes]
OUTER APPLY ( SELECT TOP 1
                        [icmAgentPkey].[INTERNAL_NAME],
                        [icmAgentPkey].[PKEY1],
                        [icmAgentPkey].[PERIPHERAL_NUMBER],
                        [icmAgentPkey].[PERIPHERAL_NAME],
                        [icmAgentPkey].[SUPERVISOR],
                        [icmAgentPkey].[AGENT_STATE_TRACE],
                        [icmAgentPkey].[DOMAIN_NAME],
                        [icmAgentPkey].[DOMAIN_LOGIN_NAME],
                        [icmAgentPkey].[DOMAIN_USER_NAME],
                        [icmAgentPkey].[DOMAIN_USER_GUID],
                        [icmAgentPkey].[USER_DELETABLE],
                        [icmAgentPkey].[USER_GROUP_ID],
                        [person].[FIRST_NAME],
                        [person].[LAST_NAME]
              FROM      [dbo].[TB_DIM_AGENT_PKEY_MAP] [icmAgentPkey]
              JOIN      [dbo].[TB_CLU_RESOURCE] [r] ON [icmAgentPkey].[CLUSTER_RESOURCE_ID] = [r].[RESOURCE_ID]
              JOIN      [dbo].[TE_ADM_CLUSTER_RESOURCE_TYPE] [crt] ON [r].[RESOURCE_TYPE_ID] = [crt].[CLUSTER_RESOURCE_TYPE_ID]
              OUTER APPLY ( SELECT TOP 1
                                    [pPkey].[FIRST_NAME],
                                    [pPkey].[LAST_NAME]
                            FROM    [dbo].[TB_DIM_AGENT_PERSON_MEMBER] [pMem]
                            JOIN    [dbo].[TB_DIM_PERSON] [p] ON [p].[ITEM_BIZ_URN] = [pMem].[PARENT_ITEM_BIZ_URN]
                                                                 AND [p].[LATEST] = 1
                            JOIN    [dbo].[TB_DIM_PERSON_PKEY_MAP] [pPkey] ON [pPkey].[ITEM_BIZ_URN] = [p].[ITEM_BIZ_URN]
                                                                              AND [pPkey].[LATEST] = 1
                            WHERE   [pMem].[CHILD_ITEM_BIZ_URN] = [icmAgentPkey].[ITEM_BIZ_URN]
                                    AND [pPkey].[CLUSTER_RESOURCE_ID] = [icmAgentPkey].[CLUSTER_RESOURCE_ID]
                                    AND [pMem].[LATEST] = 1
                            ORDER BY [pMem].[EFFECTIVE_FROM] DESC
                          ) [person]
              WHERE     [icmAgentPkey].[ITEM_BIZ_URN] = [it].[ITEM_BIZ_URN]
                        AND [crt].[INTERNAL_NAME] = 'CRT_CISCO_CICM'
              ORDER BY  [icmAgentPkey].[ITEM_BIZ_URN]
            ) [icmAgent]
OUTER APPLY ( SELECT TOP 1
                        [itPkey].[PERIPHERAL_NUMBER],
                        [itPkey].[PERIPHERAL_NAME],
                        [itPkey].[INTERNAL_NAME]
              FROM      [dbo].[TB_DIM_AGENT_PKEY_MAP] [itPkey]
              JOIN      [dbo].[TB_CLU_RESOURCE] [r] ON [itPkey].[CLUSTER_RESOURCE_ID] = [r].[RESOURCE_ID]
              JOIN      [dbo].[TE_ADM_CLUSTER_RESOURCE_TYPE] [crt] ON [r].[RESOURCE_TYPE_ID] = [crt].[CLUSTER_RESOURCE_TYPE_ID]
              WHERE     [itPkey].[ITEM_BIZ_URN] = [it].[ITEM_BIZ_URN]
                        AND [crt].[INTERNAL_NAME] = 'CRT_AVAYA'
              ORDER BY  [itPkey].[ITEM_BIZ_URN]
            ) [avayaAgent]
OUTER APPLY ( SELECT TOP 1
                        [itPkey].[INTERNAL_NAME]
              FROM      [dbo].[TB_DIM_AGENT_PKEY_MAP] [itPkey]
              JOIN      [dbo].[TB_CLU_RESOURCE] [r] ON [itPkey].[CLUSTER_RESOURCE_ID] = [r].[RESOURCE_ID]
              JOIN      [dbo].[TE_ADM_CLUSTER_RESOURCE_TYPE] [crt] ON [r].[RESOURCE_TYPE_ID] = [crt].[CLUSTER_RESOURCE_TYPE_ID]
              WHERE     [itPkey].[ITEM_BIZ_URN] = [it].[ITEM_BIZ_URN]
                        AND [crt].[INTERNAL_NAME] = 'CRT_EGAIN_SERVER'
              ORDER BY  [itPkey].[ITEM_BIZ_URN]
            ) [eGainAgent]
INNER JOIN [dbo].[TB_SEC_FOLDER] [fl] ON [fl].[FOLDER_ID] = [it].[FOLDER_ID]
UNION ALL
SELECT  [e].[ITEM_BIZ_URN] AS [ITEM_URN],
        [e].[ITEM_BIZ_URN] AS [ITEM_BIZ_URN],
        [e].[ITEM_TYPE_ID] AS [ITEM_TYPE_ID],
        NULL AS [ITEM_SUBTYPE_ID],
        NULL AS [OWNER_ID],
        NULL AS [FOLDER_ID],
        NULL AS [FOLDER_PARENT_ID],
        '' AS [FOLDER_TYPE],
        CAST(0 AS TINYINT) AS [FOLDER_DEPTH],
        'Deleted Dimensions' AS [FOLDER_NAME],
        -1 AS [FOLDER_URN],
        'Deleted Agent ' + CAST([e].[ITEM_BIZ_URN] AS NVARCHAR(10)) AS [NAME],
        '' AS [ICM_INTERNAL_NAME],
        '' AS [ICM_AGENT_ID],
        '' AS [ICM_PERIPHERAL_NUMBER],
        '' AS [ICM_PERIPHERAL_NAME],
        '' AS [ICM_SUPERVISOR],
        '' AS [ICM_AGENT_STATE_TRACE],
        '' AS [ICM_DOMAIN_NAME],
        '' AS [ICM_DOMAIN_LOGIN_NAME],
        '' AS [ICM_DOMAIN_USER_NAME],
        '' AS [ICM_DOMAIN_USER_GUID],
        '' AS [ICM_USER_DELETABLE],
        '' AS [ICM_USER_GROUP_ID],
        '' AS [ICM_FIRST_NAME],
        '' AS [ICM_LAST_NAME],
        '' AS [AVAYA_PERIPHERAL_NUMBER],
        '' AS [AVAYA_PERIPHERAL_NAME],
        '' AS [AVAYA_INTERNAL_NAME],
        '' AS [EGAIN_INTERNAL_NAME],
        'This dimension does not exist in VIM anymore.' AS [DESCRIPTION],
        '' AS [CUSTOM_ITEM_ATT_0],
        '' AS [CUSTOM_ITEM_ATT_1],
        '' AS [CUSTOM_ITEM_ATT_2],
        '' AS [CUSTOM_ITEM_ATT_3],
        '' AS [CUSTOM_ITEM_ATT_4],
        '' AS [CUSTOM_ITEM_ATT_5],
        '' AS [CUSTOM_ITEM_ATT_6],
        '' AS [CUSTOM_ITEM_ATT_7],
        '' AS [CUSTOM_ITEM_ATT_8],
        '' AS [CUSTOM_ITEM_ATT_9],
        '1900-01-01 00:00:00.000' AS [EFFECTIVE_FROM],
        '2079-06-06 00:00:00.000' AS [EFFECTIVE_TO],
        NULL AS [HIERARCHY_PARENT_URN],
        2 AS [TIME_ZONE_URN],
        NULL AS [SKIP_LEVEL],
        CAST(0 AS BIT) AS [DELETED],
        CAST(0 AS BIT) AS [HIDDEN],
        CAST(0 AS BIT) AS [SYSTEM],
        CAST(0 AS BIT) AS [LATEST],
        0 AS [CHANGE_STAMP]
FROM    [dbo].[TS_IMP_OLAP_DIMENSION_IN_ERROR] AS [e]
WHERE   [e].[ITEM_TYPE_URN] = 1;
GO
GRANT SELECT
	ON [dbo].[VW_DIM_AGENT_CUBE]
	TO [portalapp_role]
GO
