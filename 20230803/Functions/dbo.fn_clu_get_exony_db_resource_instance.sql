SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION dbo.fn_clu_get_exony_db_resource_instance
    (
      @ServerName AS NVARCHAR(50) = NULL
    )
RETURNS TABLE
--WITH ENCRYPTION
AS
    RETURN
    ( SELECT    ri.RESOURCE_INSTANCE_ID ,
                ri.IS_PUBLISHER ,
                r.RESOURCE_ID ,
                s.SERVER_NAME
      FROM      dbo.TB_CLU_RESOURCE_INSTANCE AS ri
                JOIN dbo.TB_CLU_RESOURCE AS r ON r.RESOURCE_ID = ri.RESOURCE_ID
                JOIN dbo.TE_ADM_CLUSTER_RESOURCE_TYPE AS ct ON ct.CLUSTER_RESOURCE_TYPE_ID = r.RESOURCE_TYPE_ID
                JOIN dbo.TB_CLU_RESOURCE_INSTANCE_COMPONENT
                AS comp ON ri.RESOURCE_INSTANCE_ID = comp.RESOURCE_INSTANCE_ID
                JOIN dbo.TE_CLU_RESOURCE_INSTANCE_COMPONENT_TYPE
                AS rict ON rict.COMPONENT_TYPE_ID = comp.COMPONENT_TYPE_ID
                JOIN dbo.TB_CLU_SERVER AS s ON s.SERVER_ID = comp.SERVER_ID
      WHERE     ct.INTERNAL_NAME = 'CRT_EXONY_RELATIONAL_DB'
                AND rict.INTERNAL_NAME = 'CT_EXONY_RELATIONAL_DB_DEFAULT'
                AND (s.SERVER_NAME = ISNULL(@ServerName,
                                           CONVERT(NVARCHAR(50), SERVERPROPERTY('machinename')))
                                           OR (@ServerName IS NULL AND s.SERVER_NAME IN
                                                                                (SELECT dns_name COLLATE Latin1_General_CI_AS FROM sys.availability_group_listeners)))
    );
GO
GRANT SELECT
	ON [dbo].[fn_clu_get_exony_db_resource_instance]
	TO [portalapp_role]
GO
