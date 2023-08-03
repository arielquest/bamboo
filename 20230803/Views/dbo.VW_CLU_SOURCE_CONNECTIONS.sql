SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW dbo.VW_CLU_SOURCE_CONNECTIONS
AS
SELECT  sourceServer.SERVER_NAME AS SOURCE_SERVER,
        sourceResourceType.INTERNAL_NAME AS SOURCE_RESOURCE_TYPE_NAME,
        sourceResource.RESOURCE_ID AS SOURCE_RESOURCE_ID,
        sourceResource.NAME AS SOURCE_RESOURCE_NAME,
        sinkResource.NAME AS SINK_RESOURCE_NAME,
        sinkResource.RESOURCE_ID AS SINK_RESOURCE_ID,
        sinkResourceType.INTERNAL_NAME AS SINK_RESOURCE_TYPE,
        sinkResourceType.CLUSTER_RESOURCE_TYPE_ID AS SINK_RESOURCE_TYPE_ID,
        COALESCE(conn.OVERRIDE_SINK_SERVER_ADDRESS, sinkServer.DEFAULT_ADDRESS,
                 sinkServer.SERVER_NAME) AS SINK_SERVER,
        connStatus.STATUS,
        conn.COST,
        conn.CONNECTION_ID
FROM    dbo.TB_CLU_CONNECTION AS conn
JOIN    dbo.TB_CLU_CONNECTION_STATUS AS connStatus ON conn.CONNECTION_ID = connStatus.CONNECTION_ID
JOIN    dbo.TB_CLU_RESOURCE_INSTANCE_COMPONENT sinkComponent ON sinkComponent.COMPONENT_ID = conn.SINK_COMPONENT_ID
JOIN    dbo.TB_CLU_RESOURCE_INSTANCE AS sinkResourceInstance ON sinkResourceInstance.RESOURCE_INSTANCE_ID = sinkComponent.RESOURCE_INSTANCE_ID
JOIN    dbo.TB_CLU_RESOURCE AS sinkResource ON sinkResource.RESOURCE_ID = sinkResourceInstance.RESOURCE_ID
JOIN    dbo.TE_ADM_CLUSTER_RESOURCE_TYPE AS sinkResourceType ON sinkResourceType.CLUSTER_RESOURCE_TYPE_ID = sinkResource.RESOURCE_TYPE_ID
JOIN    dbo.TB_CLU_SERVER AS sinkServer ON sinkComponent.SERVER_ID = sinkServer.SERVER_ID
JOIN    dbo.TB_CLU_RESOURCE_INSTANCE_COMPONENT sourceComponent ON sourceComponent.COMPONENT_ID = conn.SOURCE_COMPONENT_ID
JOIN    dbo.TB_CLU_RESOURCE_INSTANCE AS sourceResourceInstance ON sourceResourceInstance.RESOURCE_INSTANCE_ID = sourceComponent.RESOURCE_INSTANCE_ID
JOIN    dbo.TB_CLU_RESOURCE AS sourceResource ON sourceResource.RESOURCE_ID = sourceResourceInstance.RESOURCE_ID
JOIN    dbo.TE_ADM_CLUSTER_RESOURCE_TYPE AS sourceResourceType ON sourceResourceType.CLUSTER_RESOURCE_TYPE_ID = sourceResource.RESOURCE_TYPE_ID
JOIN    dbo.TB_CLU_SERVER AS sourceServer ON sourceComponent.SERVER_ID = sourceServer.SERVER_ID
WHERE   sourceServer.SERVER_NAME = CONVERT(NVARCHAR(50), SERVERPROPERTY('machinename'))
        AND sinkResourceType.INTERNAL_NAME IN ( 'CRT_EXONY_RELATIONAL_DB',
                                                'CRT_EXONY_APPLICATION_SERVER',
                                                'CRT_EXWEB' )
        AND sinkResourceType.CLUSTER_RESOURCE_TYPE_ID <> sourceResourceType.CLUSTER_RESOURCE_TYPE_ID
        AND sinkResourceInstance.RESOURCE_INSTANCE_ID <> sourceResourceInstance.RESOURCE_INSTANCE_ID
        AND sinkComponent.ENABLED = 1
        AND sinkResource.DELETED = 0;
GO
GRANT SELECT
	ON [dbo].[VW_CLU_SOURCE_CONNECTIONS]
	TO [portalapp_role]
GO
