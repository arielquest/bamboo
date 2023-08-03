SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_clu01_get_parent_cluster_resources]
    (
      @ChildClusterResourceId AS UNIQUEIDENTIFIER,
      @ParentClusterResourceTypeInternalName AS NVARCHAR(50) = NULL -- optional
    )
AS
    SET NOCOUNT ON;

    SELECT  [pr].[RESOURCE_ID],
            [pr].[RESOURCE_TYPE_ID],
            [pr].[NAME],
            [pr].[VERSION],
            [pr].[PROVISIONABLE],
            [pr].[XML_DATA]
    FROM    [dbo].[TB_CLU_RESOURCE_MEMBER] [mem]
    INNER JOIN [dbo].[TB_CLU_RESOURCE] [pr] ON [pr].[RESOURCE_ID] = [mem].[PARENT_RESOURCE_ID]
    INNER JOIN [dbo].[TE_ADM_CLUSTER_RESOURCE_TYPE] [prt] ON [prt].[CLUSTER_RESOURCE_TYPE_ID] = [pr].[RESOURCE_TYPE_ID]
    WHERE   [mem].[CHILD_RESOURCE_ID] = @ChildClusterResourceId
            AND ( @ParentClusterResourceTypeInternalName IS NULL
                  OR [prt].[INTERNAL_NAME] = @ParentClusterResourceTypeInternalName
                )
            AND [pr].[DELETED] = 0
    OPTION  ( RECOMPILE );

    RETURN 0;
GO
GRANT EXECUTE
	ON [dbo].[ap_clu01_get_parent_cluster_resources]
	TO [portalapp_role]
GO
