SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_AGENT_SKILLGROUP_MEMBER_ICM_PROV]
AS
    SELECT  [skillGroupMember].[CLUSTER_RESOURCE_ID],
            [skillGroupMember].[MODIFIED_DATE],
            [skillGroupMember].[MEMBER_URN],
            [skillGroupMember].[PKEY_MAP_URN],
            [skillGroupMember].[PKEY_CHANGE_STAMP],
            CASE WHEN [skillGroupMember].[STATUS] NOT IN ( 'D', 'E' )
                      AND GETUTCDATE() > [skillGroupMember].[PKEY_EFFECTIVE_TO] THEN 'P'
                 ELSE [skillGroupMember].[STATUS]
            END AS [STATUS],
            CASE WHEN [skillGroupMember].[STATUS] NOT IN ( 'D', 'E' )
                      AND GETUTCDATE() > [skillGroupMember].[PKEY_EFFECTIVE_TO] THEN CAST(1 AS BIT)
                 ELSE CAST(0 AS BIT)
            END AS [EXPIRED],
            [skillGroupMember].[PKEY1],
            [skillGroupMember].[PKEY2],
            [skillGroupMember].[DEFAULT_MEMBER],
            [agent].[ITEM_BIZ_URN] AS [AGENT_BUSINESS_URN],
            [agent].[PKEY1] AS [AGENT_ID],
            [agent].[PKEY_MAP_URN] AS [AGENT_PKEY_MAP_URN],
            [agent].[PKEY_CHANGE_STAMP] AS [AGENT_PKEY_CHANGE_STAMP],
            [skillGroup].[ITEM_BIZ_URN] AS [SKILLGROUP_BUSINESS_URN],
            [skillGroup].[PKEY1] AS [SKILLGROUP_ID],
            [skillGroup].[PKEY_MAP_URN] AS [SKILLGROUP_PKEY_MAP_URN],
            [skillGroup].[PKEY_CHANGE_STAMP] AS [SKILLGROUP_PKEY_CHANGE_STAMP],
            [sgm2].[PARENT_ITEM_BIZ_URN] AS [AGENT_DEFAULT_SKILLGROUP_URN],
            [peripheral].[CLIENT_TYPE]
    FROM    [dbo].[VW_DIM_AGENT_SKILLGROUP_MEMBER_PKEY] [skillGroupMember]
    INNER JOIN [dbo].[VW_DIM_AGENT_PKEY] [agent] ON [agent].[ITEM_BIZ_URN] = [skillGroupMember].[CHILD_ITEM_BIZ_URN]
                                                    AND [agent].[CLUSTER_RESOURCE_ID] = [skillGroupMember].[CLUSTER_RESOURCE_ID]
    INNER JOIN [dbo].[VW_DIM_SKILLGROUP_PKEY] [skillGroup] ON [skillGroup].[ITEM_BIZ_URN] = [skillGroupMember].[PARENT_ITEM_BIZ_URN]
                                                              AND [skillGroup].[CLUSTER_RESOURCE_ID] = [skillGroupMember].[CLUSTER_RESOURCE_ID]
    INNER JOIN [dbo].[VW_DIM_SKILLGROUP_PERIPHERAL_MEMBER_PKEY] [skillgroupPeripheralMember] ON [skillGroup].[ITEM_BIZ_URN] = [skillgroupPeripheralMember].[CHILD_ITEM_BIZ_URN]
                                                                                                AND [skillgroupPeripheralMember].[CLUSTER_RESOURCE_ID] = [skillGroup].[CLUSTER_RESOURCE_ID]
                                                                                                AND [skillgroupPeripheralMember].[PURGED] = 0
    INNER JOIN [dbo].[VW_DIM_PERIPHERAL_PKEY] [peripheral] ON [skillgroupPeripheralMember].[PARENT_ITEM_BIZ_URN] = [peripheral].[ITEM_BIZ_URN]
                                                              AND [peripheral].[CLUSTER_RESOURCE_ID] = [skillGroup].[CLUSTER_RESOURCE_ID]
    LEFT OUTER JOIN [dbo].[VW_DIM_AGENT_SKILLGROUP_MEMBER_PKEY] [sgm2] ON [skillGroupMember].[CHILD_ITEM_BIZ_URN] = [sgm2].[CHILD_ITEM_BIZ_URN]
                                                                          AND [sgm2].[DEFAULT_MEMBER] = 1
                                                                          AND [skillGroupMember].[CLUSTER_RESOURCE_ID] = [sgm2].[CLUSTER_RESOURCE_ID]
                                                                          AND [sgm2].[LATEST] = 1
                                                                          AND [sgm2].[PKEY_LATEST] = 1
                                                                          AND ( ( [sgm2].[STATUS] IN ( 'R', 'S' ) )
                                                                                OR ( [sgm2].[STATUS] = 'E'
                                                                                     AND [sgm2].[PKEY1] IS NOT NULL
                                                                                   )
                                                                              )
    WHERE   ( ( [skillGroupMember].[STATUS] = 'S'
                AND ( GETUTCDATE() BETWEEN [skillGroupMember].[PKEY_EFFECTIVE_FROM]
                                   AND     [skillGroupMember].[PKEY_EFFECTIVE_TO] )
              )
              OR ( [skillGroupMember].[STATUS] = 'P' )
              OR ( [skillGroupMember].[STATUS] NOT IN ( 'D', 'E' )
                   AND GETUTCDATE() > [skillGroupMember].[PKEY_EFFECTIVE_TO]
                 )
            )
            AND [skillGroupMember].[LATEST] = 1
            AND [skillGroupMember].[PKEY_LATEST] = 1
            AND [agent].[LATEST] = 1
            AND [agent].[PKEY_LATEST] = 1
            AND [skillGroup].[LATEST] = 1
            AND [skillGroup].[PKEY_LATEST] = 1;
GO
GRANT SELECT
	ON [dbo].[VW_DIM_AGENT_SKILLGROUP_MEMBER_ICM_PROV]
	TO [portalapp_role]
GO
