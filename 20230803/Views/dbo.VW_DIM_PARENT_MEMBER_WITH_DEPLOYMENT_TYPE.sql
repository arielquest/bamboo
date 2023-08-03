SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------
--VW_DIM_PARENT_MEMBER_WITH_DEPLOYMENT_TYPE
-------------------------------------------------------------------------------
CREATE VIEW [dbo].[VW_DIM_PARENT_MEMBER_WITH_DEPLOYMENT_TYPE]
AS
SELECT  it.ITEM_URN AS CHILD_ITEM_URN,
        mp.ITEM_TYPE_ID AS CHILD_ITEM_TYPE_ID,
        mb.MEMBER_TYPE_ID AS MEMBER_TYPE_ID,
        latestParent.ITEM_TYPE_ID AS PARENT_ITEM_TYPE_ID,
        CAST(r.XML_DATA.query('/Columns/Column[@Name="DEPLOYMENT_TYPE"]/text()') AS NVARCHAR(50)) AS DEPLOYMENT_TYPE,
        latestParent.ITEM_URN AS PARENT_ITEM_URN
FROM    TB_CLU_RESOURCE r
JOIN    VW_DIM_ITEM_PKEY_MAP mp ON r.RESOURCE_ID = mp.CLUSTER_RESOURCE_ID
                                   AND mp.LATEST = 1
JOIN    VW_DIM_ITEM it ON it.ITEM_BIZ_URN = mp.ITEM_BIZ_URN
                          AND it.LATEST = 1
                          AND mp.ITEM_TYPE_ID = it.ITEM_TYPE_ID
JOIN    VW_DIM_MEMBER mb ON mb.CHILD_ITEM_BIZ_URN = it.ITEM_BIZ_URN
                            AND mb.LATEST = 1
JOIN    VW_DIM_MEMBER_PKEY_MAP mbPkey ON mb.MEMBER_BIZ_URN = mbPkey.MEMBER_BIZ_URN
                                         AND mbPkey.CLUSTER_RESOURCE_ID = r.RESOURCE_ID
                                         AND mbPkey.LATEST = 1
                                         AND mbPkey.MEMBER_TYPE_ID = mb.MEMBER_TYPE_ID
JOIN    VW_DIM_ITEM latestParent ON mb.PARENT_ITEM_BIZ_URN = latestParent.ITEM_BIZ_URN
                                    AND latestParent.LATEST = 1
WHERE   mbPkey.STATUS NOT IN ( 'D', 'P' );
GO
GRANT SELECT
	ON [dbo].[VW_DIM_PARENT_MEMBER_WITH_DEPLOYMENT_TYPE]
	TO [portalapp_role]
GO
