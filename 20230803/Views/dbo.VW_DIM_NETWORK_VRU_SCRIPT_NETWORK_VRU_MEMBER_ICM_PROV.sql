SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_NETWORK_VRU_SCRIPT_NETWORK_VRU_MEMBER_ICM_PROV]
AS
SELECT  sNetworkVruMember.CLUSTER_RESOURCE_ID,
        sNetworkVruMember.MODIFIED_DATE,
        sNetworkVruMember.MEMBER_URN AS S_MEMBER_URN,
        sNetworkVruMember.PKEY_MAP_URN AS S_PKEY_MAP_URN,
        sNetworkVruMember.PKEY_CHANGE_STAMP AS S_PKEY_CHANGE_STAMP,
        CASE WHEN sNetworkVruMember.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > sNetworkVruMember.PKEY_EFFECTIVE_TO
             THEN 'P'
             ELSE sNetworkVruMember.STATUS
        END AS S_MEMBER_STATUS,
        CASE WHEN sNetworkVruMember.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > sNetworkVruMember.PKEY_EFFECTIVE_TO
             THEN CAST(1 AS BIT)
             ELSE CAST(0 AS BIT)
        END AS S_MEMBER_EXPIRED,
        sNetworkVruMember.PKEY1 AS S_PKEY1,
        sNetworkVruMember.PKEY2 AS S_PKEY2,
        pNetworkVruMember.MEMBER_URN AS P_MEMBER_URN,
        pNetworkVruMember.PKEY_MAP_URN AS P_PKEY_MAP_URN,
        pNetworkVruMember.PKEY_CHANGE_STAMP AS P_PKEY_CHANGE_STAMP,
        CASE WHEN pNetworkVruMember.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > pNetworkVruMember.PKEY_EFFECTIVE_TO
             THEN 'P'
             ELSE pNetworkVruMember.STATUS
        END AS P_MEMBER_STATUS,
        CASE WHEN pNetworkVruMember.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > pNetworkVruMember.PKEY_EFFECTIVE_TO
             THEN CAST(1 AS BIT)
             ELSE CAST(0 AS BIT)
        END AS P_MEMBER_EXPIRED,
        pNetworkVruMember.PKEY1,
        pNetworkVruMember.PKEY2,
        networkVruScript.ITEM_BIZ_URN AS NETWORK_VRU_SCRIPT_BUSINESS_URN,
        networkVruScript.PKEY1 AS NETWORK_VRU_SCRIPT_ID,
        networkVruScript.PKEY_MAP_URN AS NETWORK_VRU_SCRIPT_PKEY_MAP_URN,
        networkVruScript.PKEY_CHANGE_STAMP AS NETWORK_VRU_SCRIPT_CHANGE_STAMP,
        networkVruScript.STATUS AS NETWORK_VRU_SCRIPT_STATUS,
        COALESCE(networkVruScript.SOURCE_CHANGE_STAMP, 0) AS NETWORK_VRU_SCRIPT_SOURCE_CHANGE_STAMP,
        sNetworkVru.ITEM_BIZ_URN AS S_NETWORK_VRU_BUSINESS_URN,
        sNetworkVru.PKEY1 AS S_NETWORK_VRU_ID,
        pNetworkVru.ITEM_BIZ_URN AS P_NETWORK_VRU_BUSINESS_URN,
        pNetworkVru.PKEY1 AS P_NETWORK_VRU_ID
FROM    VW_DIM_NETWORK_VRU_SCRIPT_NETWORK_VRU_MEMBER_PKEY AS sNetworkVruMember
JOIN    VW_DIM_NETWORK_VRU_SCRIPT_NETWORK_VRU_MEMBER_PKEY pNetworkVruMember ON pNetworkVruMember.CHILD_ITEM_BIZ_URN = sNetworkVruMember.CHILD_ITEM_BIZ_URN
                                                              AND sNetworkVruMember.MEMBER_URN <> pNetworkVruMember.MEMBER_URN
JOIN    VW_DIM_NETWORK_VRU_SCRIPT_PKEY AS networkVruScript ON sNetworkVruMember.CHILD_ITEM_BIZ_URN = networkVruScript.ITEM_BIZ_URN
                                                              AND networkVruScript.CLUSTER_RESOURCE_ID = sNetworkVruMember.CLUSTER_RESOURCE_ID
JOIN    VW_DIM_NETWORK_VRU_PKEY AS sNetworkVru ON sNetworkVruMember.PARENT_ITEM_BIZ_URN = sNetworkVru.ITEM_BIZ_URN
                                                  AND sNetworkVruMember.CLUSTER_RESOURCE_ID = sNetworkVruMember.CLUSTER_RESOURCE_ID
JOIN    VW_DIM_NETWORK_VRU_PKEY AS pNetworkVru ON pNetworkVruMember.PARENT_ITEM_BIZ_URN = pNetworkVru.ITEM_BIZ_URN
                                                  AND pNetworkVru.CLUSTER_RESOURCE_ID = pNetworkVruMember.CLUSTER_RESOURCE_ID
WHERE   sNetworkVruMember.STATUS = 'P'
        AND pNetworkVruMember.STATUS = 'S'
        OR sNetworkVruMember.STATUS = 'S'
        AND pNetworkVruMember.STATUS = 'P'
        AND sNetworkVruMember.LATEST = 1
        AND pNetworkVruMember.LATEST = 1
        AND sNetworkVruMember.PKEY_LATEST = 1
        AND pNetworkVruMember.PKEY_LATEST = 1
        AND networkVruScript.LATEST = 1
        AND networkVruScript.PKEY_LATEST = 1
        AND sNetworkVru.LATEST = 1
        AND sNetworkVru.PKEY_LATEST = 1
        AND pNetworkVru.LATEST = 1
        AND pNetworkVru.PKEY_LATEST = 1;
GO
GRANT SELECT
	ON [dbo].[VW_DIM_NETWORK_VRU_SCRIPT_NETWORK_VRU_MEMBER_ICM_PROV]
	TO [portalapp_role]
GO
