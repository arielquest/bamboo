SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_DEVICE_PROFILE_CM_PROV]
AS
SELECT  [dp].[CLUSTER_RESOURCE_ID],
        [dp].[MODIFIED_DATE],
        [dp].[ITEM_BIZ_URN] AS [DEVICE_PROFILE_BUSINESS_URN],
        [dp].[PKEY_MAP_URN],
        [dp].[PKEY1] AS [DEVICE_PROFILE_ID],
        CASE WHEN [dp].[STATUS] NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > [dp].[PKEY_EFFECTIVE_TO] THEN 'P'
             ELSE [dp].[STATUS]
        END AS [STATUS],
        CASE WHEN [dp].[STATUS] NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > [dp].[PKEY_EFFECTIVE_TO] THEN CAST(1 AS BIT)
             ELSE CAST(0 AS BIT)
        END AS [EXPIRED],
        [dp].[INTERNAL_NAME],
        [dp].[DESCRIPTION],
        [dp].[PKEY_CHANGE_STAMP],
        [pkeyMap].[XML_DATA],
        [buttonTemplate].[PKEY1] AS [BUTTON_TEMPLATE_ID],
        [deviceProfileButtonTemplateMember].[PKEY_MAP_URN] AS [DEVICE_PROFILE_BUTTON_TEMPLATE_MEMBER_PKEY_MAP_URN],
        [deviceProfileButtonTemplateMember].[PKEY_CHANGE_STAMP] AS [DEVICE_PROFILE_BUTTON_TEMPLATE_MEMBER_CHANGE_STAMP],
        [buttonTemplate].[ITEM_BIZ_URN] AS [BUTTON_TEMPLATE_BUSINESS_URN],
        CAST(CASE WHEN [preemptionFeature].[CLUSTER_RESOURCE_ID] IS NOT NULL THEN 1
                  ELSE 0
             END AS BIT) AS [SUPPORTS_PREEMPTION],
        [productCode].[NAME] AS [PRODUCT_NAME],
        [protocolCode].[NAME] AS [PROTOCOL_NAME],
        [codeHierarchy].[PARENT_CODE_NAME] AS [MODEL_NAME]
FROM    [dbo].[VW_DIM_DEVICE_PROFILE_PKEY] [dp]
LEFT OUTER JOIN ( SELECT TOP 1
                            [features].[CLUSTER_RESOURCE_ID],
                            [features].[PRODUCT_CODE_URN],
                            [features].[PROTOCOL_CODE_URN]
                  FROM      [dbo].[TB_CCM_PRODUCT_FEATURE_MAP] [features]
                  JOIN      [dbo].[TB_CLU_RESOURCE] [cluster] ON [cluster].[RESOURCE_ID] = [features].[CLUSTER_RESOURCE_ID]
                  JOIN      [dbo].[VW_DIM_DEVICE_FEATURE_CODE_PKEY] [featureCode] ON [featureCode].[CLUSTER_RESOURCE_TYPE_ID] = [featureCode].[CLUSTER_RESOURCE_TYPE_ID]
                                                                                     AND [featureCode].[CLUSTER_VERSION] = [cluster].[VERSION]
                                                                                     AND [featureCode].[ITEM_BIZ_URN] = [features].[FEATURE_CODE_URN]
                  WHERE     [featureCode].[INTERNAL_NAME] = 'CALL_PRE-EMPTION_(FOR_MLPP)'
                  ORDER BY  [features].[CCM_PRODUCT_FEATURE_MAP_URN]
                ) [preemptionFeature] ON [preemptionFeature].[CLUSTER_RESOURCE_ID] = [dp].[CLUSTER_RESOURCE_ID]
                                         AND [preemptionFeature].[PRODUCT_CODE_URN] = [dp].[PRODUCT_CODE_BIZ_URN]
                                         AND [preemptionFeature].[PROTOCOL_CODE_URN] = [dp].[PROTOCOL_CODE_BIZ_URN]
INNER JOIN [dbo].[TB_DIM_DEVICE_PROFILE_PKEY_MAP] [pkeyMap] ON [dp].[PKEY_MAP_URN] = [pkeyMap].[PKEY_MAP_URN]
INNER JOIN [dbo].[TB_DIM_CODE] [productCode] ON [productCode].[ITEM_BIZ_URN] = [dp].[PRODUCT_CODE_BIZ_URN]
                                                AND [productCode].[LATEST] = 1
INNER JOIN [dbo].[TB_DIM_CODE] [protocolCode] ON [protocolCode].[ITEM_BIZ_URN] = [dp].[PROTOCOL_CODE_BIZ_URN]
                                                 AND [protocolCode].[LATEST] = 1
INNER JOIN [dbo].[VW_DIM_CODE_HIERARCHY] [codeHierarchy] ON [codeHierarchy].[CHILD_CODE_URN] = [productCode].[ITEM_BIZ_URN]
                                                            AND [codeHierarchy].[PARENT_CODE_GROUP_INTERNAL_NAME] = 'CG_DEVICE_MODEL'
                                                            AND [codeHierarchy].[CHILD_CODE_GROUP_INTERNAL_NAME] = 'CG_DEVICE_PRODUCT'
LEFT OUTER JOIN [dbo].[VW_DIM_DEVICE_PROFILE_IP_ENDPOINT_BUTTON_TEMPLATE_MEMBER_PKEY] AS [deviceProfileButtonTemplateMember] ON [dp].[ITEM_BIZ_URN] = [deviceProfileButtonTemplateMember].[CHILD_ITEM_BIZ_URN]
                                                                                                                                AND [dp].[CLUSTER_RESOURCE_ID] = [deviceProfileButtonTemplateMember].[CLUSTER_RESOURCE_ID]
                                                                                                                                AND [deviceProfileButtonTemplateMember].[STATUS] = 'S'
                                                                                                                                AND ( GETUTCDATE() BETWEEN [deviceProfileButtonTemplateMember].[PKEY_EFFECTIVE_FROM]
                                                                                                                                                AND
                                                                                                                                                [deviceProfileButtonTemplateMember].[PKEY_EFFECTIVE_TO] )
                                                                                                                                AND [deviceProfileButtonTemplateMember].[LATEST] = 1
                                                                                                                                AND [deviceProfileButtonTemplateMember].[PKEY_LATEST] = 1
LEFT OUTER JOIN [dbo].[VW_DIM_IP_ENDPOINT_BUTTON_TEMPLATE_PKEY] AS [buttonTemplate] ON [buttonTemplate].[ITEM_BIZ_URN] = [deviceProfileButtonTemplateMember].[PARENT_ITEM_BIZ_URN]
                                                                                       AND [buttonTemplate].[CLUSTER_RESOURCE_ID] = [deviceProfileButtonTemplateMember].[CLUSTER_RESOURCE_ID]
                                                                                       AND [buttonTemplate].[LATEST] = 1
                                                                                       AND [buttonTemplate].[PKEY_LATEST] = 1
WHERE   (
          (
            [dp].[STATUS] = 'S'
            AND ( GETUTCDATE() BETWEEN [dp].[PKEY_EFFECTIVE_FROM] AND [dp].[PKEY_EFFECTIVE_TO] )
          )
          OR ( [dp].[STATUS] = 'P' )
          OR (
               [dp].[STATUS] NOT IN ( 'D', 'E' )
               AND GETUTCDATE() > [dp].[PKEY_EFFECTIVE_TO]
             )
        )
        AND [dp].[LATEST] = 1
        AND [dp].[PKEY_LATEST] = 1;
GO
GRANT SELECT
	ON [dbo].[VW_DIM_DEVICE_PROFILE_CM_PROV]
	TO [portalapp_role]
GO
