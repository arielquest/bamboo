SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_ADM_RELEASE_INFO]
AS
    SELECT  [releaseInfo].[ID],
            [releaseInfo].[BUILD],
            [releaseInfo].[RELEASE_VERSION],
            [releaseInfo].[PRODUCT_NAME],
            [releaseInfo].[COMPONENT_ID],
            COALESCE([releaseInfo].[COMPONENT_NAME], [resourceType].[NAME]) AS [COMPONENT_NAME],
            COALESCE([releaseInfo].[COMPONENT_SERVER_NAME], [server].[SERVER_NAME]) AS [COMPONENT_SERVER_NAME],
            [releaseInfo].[REGISTERED_DATE],
            [releaseInfo].[RELEASE_NAME],
            [releaseInfo].[RELEASE_DESCRIPTION],
            [releaseInfo].[RELEASE_MAJOR_VERSION],
            [releaseInfo].[RELEASE_MINOR_VERSION],
            [releaseInfo].[RELEASE_HOTFIX_NUMBER],
            [releaseInfo].[RELEASE_ONE_OFF_NUMBER],
            [releaseInfo].[MAJOR_VERSION],
            [releaseInfo].[MINOR_VERSION],
            [releaseInfo].[BUILD_VERSION],
            [releaseInfo].[REVISION_NUMBER]
    FROM    [dbo].[TB_ADM_RELEASE_INFO] [releaseInfo]
    LEFT OUTER JOIN [dbo].[TB_CLU_RESOURCE_INSTANCE_COMPONENT] [instanceComponent] ON [releaseInfo].[COMPONENT_ID] = [instanceComponent].[COMPONENT_ID]
    INNER JOIN [dbo].[TE_CLU_RESOURCE_INSTANCE_COMPONENT_TYPE] [instanceComponentType] ON [instanceComponentType].[COMPONENT_TYPE_ID] = [instanceComponent].[COMPONENT_TYPE_ID]
    INNER JOIN [dbo].[TB_CLU_SERVER] [server] ON [server].[SERVER_ID] = [instanceComponent].[SERVER_ID]
    INNER JOIN [dbo].[TB_CLU_RESOURCE_INSTANCE] [resourceInstance] ON [resourceInstance].[RESOURCE_INSTANCE_ID] = [instanceComponent].[RESOURCE_INSTANCE_ID]
    INNER JOIN [dbo].[TB_CLU_RESOURCE] [clusterResource] ON [clusterResource].[RESOURCE_ID] = [resourceInstance].[RESOURCE_ID]
    INNER JOIN [dbo].[TE_ADM_CLUSTER_RESOURCE_TYPE] [resourceType] ON [resourceType].[CLUSTER_RESOURCE_TYPE_ID] = [clusterResource].[RESOURCE_TYPE_ID];
GO
GRANT SELECT
	ON [dbo].[VW_ADM_RELEASE_INFO]
	TO [portalapp_role]
GO
