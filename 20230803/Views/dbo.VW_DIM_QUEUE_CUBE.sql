SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_QUEUE_CUBE]
WITH SCHEMABINDING
AS
SELECT  it.[ITEM_URN],
        it.[ITEM_BIZ_URN],
        CAST('61A20821-AE86-4D50-B6A9-502D89453907' AS UNIQUEIDENTIFIER) AS [ITEM_TYPE_ID],
        it.[ITEM_SUBTYPE_ID],
        it.[OWNER_ID],
        it.[FOLDER_ID],
        fl.[PARENT_ID] AS [FOLDER_PARENT_ID],
        fl.[FOLDER_TYPE],
        fl.[DEPTH] AS [FOLDER_DEPTH],
        fl.[NAME] AS [FOLDER_NAME],
        fl.[FOLDER_URN],
        it.[NAME],
        COALESCE(NULLIF(RTRIM(LTRIM(pk.[INTERNAL_NAME])), ''), pk.[PKEY1],
                 'Not Known') AS [INTERNAL_NAME],
        COALESCE(pk.[PKEY1], '') AS [PKEY1],
        COALESCE(pk.[STATE], -1) AS [STATE],
        COALESCE(pk.[EMAIL_ROUTING_TYPE], -1) AS [EMAIL_ROUTING_TYPE],
        COALESCE(pk.[CHAT_ROUTING_TYPE], -1) AS [CHAT_ROUTING_TYPE],
        COALESCE(pk.[SOCIAL_ROUTING_TYPE], -1) AS [SOCIAL_ROUTING_TYPE],
        it.[DIALED_NUMBER_BIZ_URN],
        it.[SKILLGROUP_BIZ_URN],
        COALESCE(REPLACE(REPLACE(REPLACE(it.[DESCRIPTION], CHAR(9), ''),
                                 CHAR(13), ''), CHAR(10), ''), '') COLLATE Latin1_General_100_CI_AS_SC AS [DESCRIPTION],
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
        it.[EFFECTIVE_FROM],
        it.[EFFECTIVE_TO],
        it.[HIERARCHY_PARENT_URN],
        it.[TIME_ZONE_URN],
        it.[SKIP_LEVEL],
        it.[DELETED],
        it.[HIDDEN],
        it.[SYSTEM],
        it.[LATEST],
        it.[CHANGE_STAMP]
FROM    [dbo].[TB_DIM_QUEUE] it
OUTER APPLY ( SELECT TOP 1
                        [qPkey].[PKEY_MAP_URN],
                        [qPkey].[PKEY_MAP_BIZ_URN],
                        [qPkey].[ITEM_BIZ_URN],
                        [qPkey].[CLUSTER_RESOURCE_ID],
                        MAX(CASE WHEN [OBJ_COLUMN_NAME] = 'CUSTOM_ITEM_ATT_0' THEN [qPkey].[attributeValue]
                                 ELSE ''
                            END) AS [CUSTOM_ITEM_ATT_0],
                        MAX(CASE WHEN [OBJ_COLUMN_NAME] = 'CUSTOM_ITEM_ATT_1' THEN [qPkey].[attributeValue]
                                 ELSE ''
                            END) AS [CUSTOM_ITEM_ATT_1],
                        MAX(CASE WHEN [OBJ_COLUMN_NAME] = 'CUSTOM_ITEM_ATT_2' THEN [qPkey].[attributeValue]
                                 ELSE ''
                            END) AS [CUSTOM_ITEM_ATT_2],
                        MAX(CASE WHEN [OBJ_COLUMN_NAME] = 'CUSTOM_ITEM_ATT_3' THEN [qPkey].[attributeValue]
                                 ELSE ''
                            END) AS [CUSTOM_ITEM_ATT_3],
                        MAX(CASE WHEN [OBJ_COLUMN_NAME] = 'CUSTOM_ITEM_ATT_4' THEN [qPkey].[attributeValue]
                                 ELSE ''
                            END) AS [CUSTOM_ITEM_ATT_4],
                        MAX(CASE WHEN [OBJ_COLUMN_NAME] = 'CUSTOM_ITEM_ATT_5' THEN [qPkey].[attributeValue]
                                 ELSE ''
                            END) AS [CUSTOM_ITEM_ATT_5],
                        MAX(CASE WHEN [OBJ_COLUMN_NAME] = 'CUSTOM_ITEM_ATT_6' THEN [qPkey].[attributeValue]
                                 ELSE ''
                            END) AS [CUSTOM_ITEM_ATT_6],
                        MAX(CASE WHEN [OBJ_COLUMN_NAME] = 'CUSTOM_ITEM_ATT_7' THEN [qPkey].[attributeValue]
                                 ELSE ''
                            END) AS [CUSTOM_ITEM_ATT_7],
                        MAX(CASE WHEN [OBJ_COLUMN_NAME] = 'CUSTOM_ITEM_ATT_8' THEN [qPkey].[attributeValue]
                                 ELSE ''
                            END) AS [CUSTOM_ITEM_ATT_8],
                        MAX(CASE WHEN [OBJ_COLUMN_NAME] = 'CUSTOM_ITEM_ATT_9' THEN [qPkey].[attributeValue]
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
                                                AND [OBJ_TYPE] = 'IT_QUEUE'
                                    ) [a]
                          WHERE     [a].[OBJ_INDEX] > -1
                        ) [customAttributes]
              INNER JOIN ( SELECT   [PKEY_MAP_URN],
                                    [PKEY_MAP_BIZ_URN],
                                    [ITEM_BIZ_URN],
                                    [CLUSTER_RESOURCE_ID],
                                    [customAttributes].[customAttribute].[value](N'@Name[1]', N'nvarchar(MAX)') AS [attributeName],
                                    ISNULL([customAttributes].[customAttribute].[value](N'text()[1]', N'nvarchar(MAX)'), '') AS [attributeValue]
                           FROM     [dbo].[TB_DIM_QUEUE_PKEY_MAP]
                           CROSS APPLY [CUSTOM_XML_DATA].[nodes](N'/Columns/Column') AS [customAttributes] ( [customAttribute] )
                           WHERE    [CUSTOM_XML_DATA] IS NOT NULL
                         ) [qPkey] ON [customAttributes].[CLUSTER_RESOURCE_ID] = [qPkey].[CLUSTER_RESOURCE_ID]
                                          AND [customAttributes].[SOURCE_ATT_NAME] = [qPkey].[attributeName]
              WHERE     [qPkey].[ITEM_BIZ_URN] = [it].[ITEM_BIZ_URN]
              GROUP BY  [qPkey].[PKEY_MAP_URN],
                        [qPkey].[PKEY_MAP_BIZ_URN],
                        [qPkey].[ITEM_BIZ_URN],
                        [qPkey].[CLUSTER_RESOURCE_ID]
              ORDER BY [qPkey].[PKEY_MAP_URN]
            ) [customAttributes]
LEFT JOIN [dbo].[TB_DIM_QUEUE_PKEY_MAP] pk ON it.[ITEM_BIZ_URN] = pk.[ITEM_BIZ_URN] AND pk.[LATEST] = 1
JOIN [dbo].[TB_SEC_FOLDER] fl ON fl.[FOLDER_ID] = it.[FOLDER_ID]
UNION ALL
SELECT  e.[ITEM_BIZ_URN] AS [ITEM_URN],
        e.[ITEM_BIZ_URN] AS [ITEM_BIZ_URN],
        e.[ITEM_TYPE_ID] AS [ITEM_TYPE_ID],
        NULL AS [ITEM_SUBTYPE_ID],
        NULL AS [OWNER_ID],
        NULL AS [FOLDER_ID],
        NULL AS [FOLDER_PARENT_ID],
        '' AS [FOLDER_TYPE],
        CAST(0 AS TINYINT) AS [FOLDER_DEPTH],
        'Deleted Dimensions' AS [FOLDER_NAME],
        -1 AS [FOLDER_URN],
        'Deleted Queue ' + CAST(e.[ITEM_BIZ_URN] AS NVARCHAR(10)) AS [NAME],
        'Deleted Queue ' + CAST(e.[ITEM_BIZ_URN] AS NVARCHAR(10)) AS [INTERNAL_NAME],
        '' AS [PKEY1],
        -1 AS [STATE],
        -1 AS [EMAIL_ROUTING_TYPE],
        -1 AS [CHAT_ROUTING_TYPE],
        -1 AS [SOCIAL_ROUTING_TYPE],
        -1 AS [DIALED_NUMBER_BIZ_URN],
        -1 AS [SKILLGROUP_BIZ_URN],
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
FROM    [dbo].[TS_IMP_OLAP_DIMENSION_IN_ERROR] AS e
WHERE   e.[ITEM_TYPE_URN] = 113;
GO
GRANT SELECT
	ON [dbo].[VW_DIM_QUEUE_CUBE]
	TO [portalapp_role]
GO
