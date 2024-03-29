SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[VW_SYS_MON_ETL_TIDEMARK_PROGRESS]
AS
    SELECT  med.SERVER_NAME AS MEDIATOR_SERVER_NAME, 
            etlComp.COMPONENT_ID, 
            etlComp.NAME AS COMPONENT_NAME, 
            srcRes.RESOURCE_ID, 
            srcRes.NAME AS RESOURCE_NAME, 
            ct.NAME AS RESOURCE_TYPE_NAME, 
            ct.INTERNAL_NAME AS RESOURCE_TYPE_INTERNAL_NAME,
            p.TIDEMARK_NAME, 
            p.TIDEMARK_VALUE1 AS PROCESSED_TIDEMARK, 
            p.DATE_TIME AS PROCESSED_LAST_UPDATE_DATE_TIME, 
            w.TIDEMARK_VALUE1 AS WRITTEN_TIDEMARK, 
            w.DATE_TIME AS WRITTEN_LAST_UPDATE_DATE_TIME
    FROM dbo.TB_ETL_TIDEMARK AS p
    INNER JOIN dbo.TB_ETL_COMPONENT AS etlComp ON etlComp.COMPONENT_ID = p.COMPONENT_ID
    INNER JOIN dbo.TB_CLU_RESOURCE AS srcRes ON srcRes.RESOURCE_ID = p.CLUSTER_RESOURCE_ID
    INNER JOIN dbo.TE_ADM_CLUSTER_RESOURCE_TYPE AS ct ON ct.CLUSTER_RESOURCE_TYPE_ID = srcRes.RESOURCE_TYPE_ID
    CROSS APPLY (SELECT s.SERVER_NAME
                FROM dbo.TB_CLU_RESOURCE_INSTANCE_COMPONENT AS cmp
                INNER JOIN dbo.TB_CLU_SERVER AS s ON s.SERVER_ID = cmp.SERVER_ID
                INNER JOIN dbo.TE_CLU_RESOURCE_INSTANCE_COMPONENT_TYPE AS ct ON ct.COMPONENT_TYPE_ID = cmp.COMPONENT_TYPE_ID
                WHERE cmp.RESOURCE_INSTANCE_ID = p.MEDIATOR_RESOURCE_INSTANCE_ID AND ct.INTERNAL_NAME = 'CT_EXONY_MEDIATOR_DEFAULT') AS med
    OUTER APPLY (SELECT TIDEMARK_VALUE1, DATE_TIME
                FROM dbo.TB_ETL_TIDEMARK
                WHERE MEDIATOR_RESOURCE_INSTANCE_ID = p.MEDIATOR_RESOURCE_INSTANCE_ID
                AND COMPONENT_ID = p.COMPONENT_ID
                AND CLUSTER_RESOURCE_ID = p.CLUSTER_RESOURCE_ID
                AND TIDEMARK_NAME = p.TIDEMARK_NAME
                AND TIDEMARK_TYPE = 'W') AS w
    WHERE p.TIDEMARK_TYPE = 'P';
GO
GRANT SELECT
	ON [dbo].[VW_SYS_MON_ETL_TIDEMARK_PROGRESS]
	TO [portalapp_role]
GO
