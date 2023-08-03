SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_dim01_get_dimension_ownership] 
(
    @ItemTypeId    AS [UNIQUEIDENTIFIER],
    @ItemUrns AS [dbo].[IntegerTableType]    READONLY
)
AS
    -- Define CTE for all items which have a reference to a routing script (via the script item member)
    -- which has a customer definition
    WITH ItemsWithCustomerAwareScriptReferences (ITEM_BIZ_URN, ITEM_TYPE_ID)
    AS
    (
        SELECT -1 AS ITEM_BIZ_URN, NEWID() AS ITEM_TYPE_ID-- TODO: SHARDING SCRIPT_ITEM
    /*
        SELECT im.PARENT_ITEM_BIZ_URN AS ITEM_BIZ_URN, NEWID() AS ITEM_TYPE_ID 
        FROM dbo.VW_DIM_SCRIPT_ITEM_MEMBER im
        JOIN dbo.VW_DIM_SCRIPT_ROUTING_SCRIPT_MEMBER sm
        ON im.CHILD_ITEM_BIZ_URN = sm.CHILD_ITEM_BIZ_URN AND sm.LATEST = 1
        JOIN dbo.VW_DIM_ROUTING_SCRIPT rs
        ON rs.ITEM_BIZ_URN = sm.PARENT_ITEM_BIZ_URN AND rs.LATEST = 1
        WHERE im.MEMBER_BIZ_URN  > 0
        AND im.DELETED = 0
        AND sm.DELETED = 0
        AND rs.DELETED = 0    
        AND rs.TENANT_BIZ_URN <> -1    
    */
    )

    -- Get results
    SELECT 
    i.ITEM_URN,
    i.ITEM_BIZ_URN, 
    i.ITEM_TYPE_ID, 
    i.FOLDER_ID, 
    i.OWNER_ID, 
    i.DELETED, 
    i.CHANGE_STAMP, 
    i.EFFECTIVE_FROM, 
    i.EFFECTIVE_TO, 
    i.TENANT_BIZ_URN,
    map.PKEY_MAP_URN,
    map.CHANGE_STAMP AS PKEY_MAP_CHANGE_STAMP,
    map.STATUS,
    it.PROVISIONABLE AS ITEM_TYPE_PROVISIONABLE, 
    r.RESOURCE_ID AS CLUSTER_RESOURCE_ID, 
    r.PROVISIONABLE AS CLUSTER_PROVISIONABLE, 
    rt.INTERNAL_NAME AS CLUSTER_TYPE,

    CASE @ItemTypeId
    WHEN '00002400-1000-0000-0000-000000000010' --IT_DIALED_NUMBER
        THEN 
        (
            CASE WHEN EXISTS(
                SELECT 1
                FROM VW_DIM_DIALED_NUMBER_CALL_TYPE_MEMBER_PKEY mem
                JOIN VW_DIM_CALL_TYPE d
                ON d.ITEM_BIZ_URN = mem.PARENT_ITEM_BIZ_URN    
                WHERE mem.STATUS IN ('R', 'S')
                AND mem.CHILD_ITEM_BIZ_URN = i.ITEM_BIZ_URN
                AND d.TENANT_BIZ_URN <> -1
                
                UNION ALL
                
                SELECT 1
                FROM VW_DIM_LABEL_DIALED_NUMBER_MEMBER_PKEY mem
                JOIN VW_DIM_LABEL d
                ON d.ITEM_BIZ_URN = mem.CHILD_ITEM_BIZ_URN    
                WHERE mem.STATUS IN ('R', 'S')
                AND mem.PARENT_ITEM_BIZ_URN = i.ITEM_BIZ_URN
                AND d.TENANT_BIZ_URN <> -1
                
                UNION ALL
                
                SELECT 1
                FROM ItemsWithCustomerAwareScriptReferences scripts
                WHERE scripts.ITEM_BIZ_URN = i.ITEM_BIZ_URN
                AND scripts.ITEM_TYPE_ID = i.ITEM_TYPE_ID
            )
            THEN CAST(1 AS BIT) ELSE CAST(0 AS BIT) END        
        )
    WHEN '00004700-1000-0000-0000-000000000010' -- IT_LABEL
        THEN
        (
            CASE WHEN EXISTS(
                SELECT 1
                FROM VW_DIM_LABEL_DIALED_NUMBER_MEMBER_PKEY mem
                JOIN VW_DIM_DIALED_NUMBER d
                ON d.ITEM_BIZ_URN = mem.PARENT_ITEM_BIZ_URN    
                WHERE mem.STATUS IN ('R', 'S')
                AND mem.CHILD_ITEM_BIZ_URN = i.ITEM_BIZ_URN
                AND d.TENANT_BIZ_URN <> -1
                
                UNION ALL
                
                SELECT 1
                FROM ItemsWithCustomerAwareScriptReferences scripts
                WHERE scripts.ITEM_BIZ_URN = i.ITEM_BIZ_URN
                AND scripts.ITEM_TYPE_ID = i.ITEM_TYPE_ID
            )
            THEN CAST(1 AS BIT) ELSE CAST(0 AS BIT) END
        )
    WHEN '00001500-1000-0000-0000-000000000010' -- IT_CALL_TYPE
        THEN
        (
            CASE WHEN EXISTS(
                SELECT 1
                FROM VW_DIM_DIALED_NUMBER_CALL_TYPE_MEMBER_PKEY mem
                JOIN VW_DIM_DIALED_NUMBER d
                ON d.ITEM_BIZ_URN = mem.CHILD_ITEM_BIZ_URN
                WHERE mem.STATUS IN ('R', 'S')
                AND mem.PARENT_ITEM_BIZ_URN = i.ITEM_BIZ_URN
                AND d.TENANT_BIZ_URN <> -1
                
                UNION ALL
                
                SELECT 1
                FROM VW_DIM_CALL_TYPE_ROUTING_SCRIPT_MEMBER_PKEY mem
                JOIN VW_DIM_ROUTING_SCRIPT d
                ON d.ITEM_BIZ_URN = mem.PARENT_ITEM_BIZ_URN
                WHERE mem.STATUS IN ('R', 'S')
                AND mem.CHILD_ITEM_BIZ_URN = i.ITEM_BIZ_URN
                AND d.TENANT_BIZ_URN <> -1
                
                UNION ALL
                
                SELECT 1
                FROM ItemsWithCustomerAwareScriptReferences scripts
                WHERE scripts.ITEM_BIZ_URN = i.ITEM_BIZ_URN
                AND scripts.ITEM_TYPE_ID = i.ITEM_TYPE_ID
            )
            THEN CAST(1 AS BIT) ELSE CAST(0 AS BIT) END
        )    
    WHEN '00007200-1000-0000-0000-000000000010' -- IT_ROUTING_SCRIPT
        THEN
        (
            CASE WHEN EXISTS(
                SELECT 1
                FROM VW_DIM_CALL_TYPE_ROUTING_SCRIPT_MEMBER_PKEY mem
                JOIN VW_DIM_CALL_TYPE d
                ON d.ITEM_BIZ_URN = mem.CHILD_ITEM_BIZ_URN
                WHERE mem.STATUS IN ('R', 'S')
                AND mem.PARENT_ITEM_BIZ_URN = i.ITEM_BIZ_URN
                AND d.TENANT_BIZ_URN <> -1
                
                UNION ALL
                
                SELECT 1
                FROM ItemsWithCustomerAwareScriptReferences scripts
                WHERE scripts.ITEM_BIZ_URN = i.ITEM_BIZ_URN
                AND scripts.ITEM_TYPE_ID = i.ITEM_TYPE_ID
            )
            THEN CAST(1 AS BIT) ELSE CAST(0 AS BIT) END
        )
    WHEN '00007400-1000-0000-0000-000000000010' -- 'IT_SCHEDULED_TARGET'
        THEN
        (
            CASE WHEN EXISTS(                
                SELECT 1
                FROM ItemsWithCustomerAwareScriptReferences scripts
                WHERE scripts.ITEM_BIZ_URN = i.ITEM_BIZ_URN
                AND scripts.ITEM_TYPE_ID = '00007400-1000-0000-0000-000000000010'
            )
            THEN CAST(1 AS BIT) ELSE CAST(0 AS BIT) END
        )
        
    WHEN 'AAF3357B-5222-416D-887F-2E6678C73910' -- 'IT_NETWORK_VRU_SCRIPT'
        THEN
        (
            CASE WHEN EXISTS(                
                SELECT 1
                FROM ItemsWithCustomerAwareScriptReferences scripts
                WHERE scripts.ITEM_BIZ_URN = i.ITEM_BIZ_URN
                AND scripts.ITEM_TYPE_ID = 'AAF3357B-5222-416D-887F-2E6678C73910'
            )
            THEN CAST(1 AS BIT) ELSE CAST(0 AS BIT) END
        )
    ELSE
        CAST(0 AS BIT)
    END AS HAS_MEMBERS_WITH_CUSTOMER_DEFINITIONS


    FROM VW_DIM_ITEM i
    INNER JOIN TE_DIM_ITEM_TYPE it ON it.ITEM_TYPE_ID = i.ITEM_TYPE_ID
    LEFT OUTER JOIN VW_DIM_ITEM_PKEY_MAP map ON map.ITEM_BIZ_URN = i.ITEM_BIZ_URN AND map.ITEM_TYPE_ID = i.ITEM_TYPE_ID AND map.STATUS NOT IN ('P', 'D') AND map.LATEST = 1
    LEFT OUTER JOIN TB_CLU_RESOURCE r ON r.RESOURCE_ID = map.CLUSTER_RESOURCE_ID
    LEFT OUTER JOIN TE_ADM_CLUSTER_RESOURCE_TYPE rt ON rt.CLUSTER_RESOURCE_TYPE_ID = r.RESOURCE_TYPE_ID

    WHERE i.LATEST = 1
    AND i.ITEM_TYPE_ID = @ItemTypeId
    AND i.ITEM_URN IN (SELECT INTEGER_1 FROM @ItemUrns)
    OPTION (RECOMPILE); -- Makes @ItemTypeId parameter only hit one table
GO
GRANT EXECUTE
	ON [dbo].[ap_dim01_get_dimension_ownership]
	TO [portalapp_role]
GO
