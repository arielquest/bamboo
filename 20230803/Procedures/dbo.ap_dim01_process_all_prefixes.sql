SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_dim01_process_all_prefixes]  AS
BEGIN 
    SET NOCOUNT ON;
    BEGIN TRY;
        DECLARE @error INT = 0, @systemUserId UNIQUEIDENTIFIER;
        
        --Check if prefix management is active      
        IF EXISTS (SELECT 1
                   FROM dbo.TB_CLU_RESOURCE_INSTANCE AS ri
                   INNER JOIN dbo.TB_CLU_RESOURCE AS r ON r.RESOURCE_ID = ri.RESOURCE_ID
                   INNER JOIN dbo.TE_ADM_CLUSTER_RESOURCE_TYPE AS ct ON ct.CLUSTER_RESOURCE_TYPE_ID = r.RESOURCE_TYPE_ID
                   INNER JOIN dbo.TB_CLU_RESOURCE_INSTANCE_COMPONENT AS comp ON ri.RESOURCE_INSTANCE_ID = comp.RESOURCE_INSTANCE_ID
                   INNER JOIN dbo.TE_CLU_RESOURCE_INSTANCE_COMPONENT_TYPE AS rict ON rict.COMPONENT_TYPE_ID = comp.COMPONENT_TYPE_ID
                   INNER JOIN dbo.TB_CLU_SERVER AS s ON s.SERVER_ID =  comp.SERVER_ID
                   WHERE ct.INTERNAL_NAME = 'CRT_EXONY_RELATIONAL_DB' AND rict.INTERNAL_NAME = 'CT_EXONY_RELATIONAL_DB_DEFAULT'                   
                   AND ri.XML_DATA.exist('/Columns/Column[@Name="PREFIX_MANAGEMENT_ENABLED"]/text()[contains(.,"True")]') = 1
                   AND (s.SERVER_NAME = CONVERT(NVARCHAR(50),SERVERPROPERTY('machinename'))
                        OR EXISTS(SELECT 1
                                    FROM sys.dm_hadr_database_replica_states AS rep
                                    INNER JOIN sys.availability_databases_cluster AS db ON db.group_database_id = rep.group_database_id
                                    WHERE db.database_name = DB_NAME() AND rep.is_primary_replica = 1 AND rep.is_local = 1))
                   )
        BEGIN 
            -- Get system user
            SELECT @systemUserId = USER_ID 
            FROM dbo.TB_SEC_USER 
            WHERE LOGIN_NAME = 'System';
        
            -- Perform moves
            DECLARE @SQL NVARCHAR(MAX);

            SELECT @SQL = STUFF((SELECT CHAR(13)+CHAR(10)+
            'UPDATE i'+CHAR(13)+CHAR(10)+
            'SET FOLDER_ID = [changes].TARGET_FOLDER_ID,'+CHAR(13)+CHAR(10)+
            'OWNER_ID = [changes].TARGET_TENANT_ID,'+CHAR(13)+CHAR(10)+
            'MODIFIED_BY_ID = @SP_IN_systemUserId,'+CHAR(13)+CHAR(10)+
            'MODIFIED_DATE = GETUTCDATE()'+CHAR(13)+CHAR(10)+
            'FROM dbo.'+TABLE_NAME+' i'+CHAR(13)+CHAR(10)+
            'INNER JOIN (SELECT dim.ITEM_URN, match.TARGET_FOLDER_ID, match.TARGET_TENANT_ID'+CHAR(13)+CHAR(10)+SPACE(12)+
                        'FROM dbo.'+TABLE_NAME+' dim'+CHAR(13)+CHAR(10)+SPACE(12)+
                        'INNER JOIN dbo.TB_SEC_FOLDER sec ON sec.FOLDER_ID = dim.FOLDER_ID'+CHAR(13)+CHAR(10)+SPACE(12)+
                        'CROSS APPLY (SELECT TOP 1 px.TARGET_FOLDER_ID, ft.TENANT_ID AS TARGET_TENANT_ID'+CHAR(13)+CHAR(10)+SPACE(25)+
                                     'FROM dbo.TB_DIM_PREFIX_MAPPING px'+CHAR(13)+CHAR(10)+SPACE(25)+
                                     'INNER JOIN dbo.VW_SEC_FOLDER_TENANT ft ON ft.FOLDER_ID = px.TARGET_FOLDER_ID'+CHAR(13)+CHAR(10)+SPACE(25)+
                                     
                                     (CASE WHEN INTERNAL_NAME = 'IT_PRECISION_QUEUE_STEP' THEN -- Precision Queue Steps need to use the Precision Queue Internal_Name
                                     'INNER JOIN (SELECT ca.INTERNAL_NAME, pkeymap.ITEM_TYPE_ID, pkeymap.ITEM_BIZ_URN, pkeymap.LATEST, pkeymap.CLUSTER_RESOURCE_ID'+CHAR(13)+CHAR(10)+SPACE(37)+
                                                 'FROM dbo.VW_DIM_ITEM_PKEY_MAP pkeymap'+CHAR(13)+CHAR(10)+SPACE(37)+
                                                 'CROSS APPLY (SELECT INTERNAL_NAME'+CHAR(13)+CHAR(10)+SPACE(50)+
                                                              'FROM dbo.VW_DIM_ITEM_PKEY_MAP ipkey'+CHAR(13)+CHAR(10)+SPACE(50)+
                                                              'WHERE ipkey.ITEM_TYPE_URN = '+CAST(PARENT_TYPE_URN AS VARCHAR(3))+CHAR(13)+CHAR(10)+SPACE(50)+
                                                              'AND EXISTS (SELECT 1'+CHAR(13)+CHAR(10)+SPACE(62)+
                                                                          'FROM dbo.VW_DIM_MEMBER mem'+CHAR(13)+CHAR(10)+SPACE(62)+
                                                                          'WHERE CHILD_ITEM_TYPE_URN = pkeymap.ITEM_TYPE_URN AND PARENT_ITEM_TYPE_URN = '+CAST(PARENT_TYPE_URN AS VARCHAR(3))+CHAR(13)+CHAR(10)+SPACE(62)+
                                                                          'AND CHILD_ITEM_BIZ_URN = pkeymap.ITEM_BIZ_URN'+CHAR(13)+CHAR(10)+SPACE(62)+
                                                                          'AND ipkey.ITEM_BIZ_URN = mem.PARENT_ITEM_BIZ_URN'+CHAR(13)+CHAR(10)+SPACE(62)+
                                                                          'AND mem.DELETED = 0)'+CHAR(13)+CHAR(10)+SPACE(50)+
                                                              ')ca'+CHAR(13)+CHAR(10)+SPACE(37)+
                                                 ')pkey ON pkey.INTERNAL_NAME COLLATE Latin1_General_CI_AS LIKE px.PREFIX'
                                           WHEN INTERNAL_NAME = 'IT_PERSON' THEN -- Persons need to use the Agent Internal_Name
                                     'INNER JOIN (SELECT ca.INTERNAL_NAME, pkeymap.ITEM_TYPE_ID, pkeymap.ITEM_BIZ_URN, pkeymap.LATEST, pkeymap.CLUSTER_RESOURCE_ID'+CHAR(13)+CHAR(10)+SPACE(37)+
                                                 'FROM dbo.VW_DIM_ITEM_PKEY_MAP pkeymap'+CHAR(13)+CHAR(10)+SPACE(37)+
                                                 'CROSS APPLY (SELECT TOP 1 INTERNAL_NAME'+CHAR(13)+CHAR(10)+SPACE(50)+
                                                              'FROM dbo.VW_DIM_ITEM_PKEY_MAP ipkey'+CHAR(13)+CHAR(10)+SPACE(50)+
                                                              'WHERE ipkey.ITEM_TYPE_URN = '+CAST(PARENT_TYPE_URN AS VARCHAR(3))+CHAR(13)+CHAR(10)+SPACE(50)+
                                                              'AND EXISTS (SELECT 1'+CHAR(13)+CHAR(10)+SPACE(62)+
                                                                          'FROM dbo.VW_DIM_MEMBER mem'+CHAR(13)+CHAR(10)+SPACE(62)+
                                                                          'WHERE mem.PARENT_ITEM_TYPE_URN = pkeymap.ITEM_TYPE_URN AND mem.CHILD_ITEM_TYPE_URN = '+CAST(PARENT_TYPE_URN AS VARCHAR(3))+CHAR(13)+CHAR(10)+SPACE(62)+
                                                                          'AND mem.PARENT_ITEM_BIZ_URN = pkeymap.ITEM_BIZ_URN'+CHAR(13)+CHAR(10)+SPACE(62)+
                                                                          'AND ipkey.ITEM_BIZ_URN = mem.CHILD_ITEM_BIZ_URN'+CHAR(13)+CHAR(10)+SPACE(62)+
                                                                          'AND mem.DELETED = 0'+CHAR(13)+CHAR(10)+SPACE(62)+
                                                                          ')'+CHAR(13)+CHAR(10)+SPACE(50)+
                                                              'AND ipkey.LATEST = 1'+CHAR(13)+CHAR(10)+SPACE(50)+
                                                              'ORDER BY ipkey.EFFECTIVE_FROM DESC'+CHAR(13)+CHAR(10)+SPACE(37)+
                                                              ')ca'+CHAR(13)+CHAR(10)+SPACE(37)+
                                                 ')pkey ON pkey.INTERNAL_NAME COLLATE Latin1_General_CI_AS LIKE px.PREFIX'
                                           ELSE -- Otherwise, use the dimension Internal_Name
                                     'INNER JOIN dbo.VW_DIM_ITEM_PKEY_MAP pkey ON pkey.INTERNAL_NAME COLLATE Latin1_General_CI_AS LIKE px.PREFIX'
                                           END
                                     )+CHAR(13)+CHAR(10)+SPACE(25)+
                                     
                                     (CASE WHEN INTERNAL_NAME IN ('IT_DIALED_NUMBER', 'IT_LABEL', 'IT_CALL_TYPE', 'IT_ROUTING_SCRIPT', 'IT_NETWORK_VRU_SCRIPT', 'IT_SCHEDULED_TARGET') THEN
                                     'INNER JOIN dbo.VW_CLU_FOLDER_TENANT_MAPPING targetRemoteTenantMap ON px.TARGET_FOLDER_ID = targetRemoteTenantMap.FOLDER_ID'+CHAR(13)+CHAR(10)+SPACE(25)
                                     ELSE '' END)+
                                     'INNER JOIN dbo.VW_CLU_TENANT_MAPPING ctm ON ctm.OWNER_ID = ft.TENANT_ID'+CHAR(13)+CHAR(10)+SPACE(25)+   
                                     'WHERE pkey.ITEM_TYPE_ID = '+CHAR(39)+CAST(ITEM_TYPE_ID AS VARCHAR(36))+CHAR(39)+CHAR(13)+CHAR(10)+SPACE(25)+
                                     'AND px.ITEM_TYPE_ID = '+CHAR(39)+CAST(ITEM_TYPE_ID AS VARCHAR(36))+CHAR(39)+' AND (sec.PATH LIKE '+CHAR(39)+'/Unallocated/%'+CHAR(39)+CHAR(13)+CHAR(10)+SPACE(25)+
                                     'AND pkey.CLUSTER_RESOURCE_ID = ctm.RESOURCE_ID'+CHAR(13)+CHAR(10)+SPACE(25)+
                                     'OR dim.FOLDER_ID = px.FOLDER_ID)'+CHAR(13)+CHAR(10)+SPACE(25)+
                                     
                                     (CASE WHEN INTERNAL_NAME IN ('IT_DIALED_NUMBER', 'IT_LABEL', 'IT_CALL_TYPE', 'IT_ROUTING_SCRIPT', 'IT_NETWORK_VRU_SCRIPT', 'IT_SCHEDULED_TARGET') THEN
                                     ' AND (
                                            (targetRemoteTenantMap.REMOTE_TENANT_BUSINESS_URN IS NULL 
                                                AND (dim.TENANT_BIZ_URN IS NULL OR dim.TENANT_BIZ_URN NOT IN (SELECT REMOTE_TENANT_BUSINESS_URN
                                                                                                              FROM TB_CLU_RESOURCE_FOLDER_MAPPING
                                                                                                              WHERE CLUSTER_RESOURCE_ID = pkey.CLUSTER_RESOURCE_ID
                                                                                                              AND REMOTE_TENANT_BUSINESS_URN IS NOT NULL))
                                            ) 
                                            OR targetRemoteTenantMap.REMOTE_TENANT_BUSINESS_URN = dim.TENANT_BIZ_URN
                                        )'+CHAR(13)+CHAR(10)+SPACE(25)
                                     ELSE '' END) +

                                     'AND dim.ITEM_BIZ_URN = pkey.ITEM_BIZ_URN AND pkey.LATEST = 1'+CHAR(13)+CHAR(10)+SPACE(25)+
                                     'ORDER BY PRIORITY ASC'+CHAR(13)+CHAR(10)+SPACE(25)+
                                     ') match'+CHAR(13)+CHAR(10)+SPACE(12)+
                        'WHERE dim.ITEM_URN > 0 AND dim.LATEST = 1 AND dim.FOLDER_ID <> match.TARGET_FOLDER_ID'+CHAR(13)+CHAR(10)+SPACE(12)+
                        ') [changes] ON i.ITEM_URN = [changes].ITEM_URN;'
            FROM dbo.TE_DIM_ITEM_TYPE typ
            LEFT OUTER JOIN (VALUES('IT_PRECISION_QUEUE', 'IT_PRECISION_QUEUE_STEP'),
                                   ('IT_AGENT', 'IT_PERSON')
                            )hierarchy(parent, child) ON typ.INTERNAL_NAME = hierarchy.child
            OUTER APPLY (SELECT INTERNAL_NAME AS PARENT_INTERNAL_NAME, ITEM_TYPE_URN AS PARENT_TYPE_URN
                         FROM dbo.TE_DIM_ITEM_TYPE it
                         WHERE it.INTERNAL_NAME = hierarchy.parent
                        )oa
            WHERE typ.PREFIXED = 1 AND EXISTS (SELECT 1
                                               FROM dbo.TB_DIM_PREFIX_MAPPING pre
                                               WHERE pre.ITEM_TYPE_ID = typ.ITEM_TYPE_ID)
            FOR XML PATH(''), TYPE).value('.','NVARCHAR(MAX)'),1,2,'');

            EXECUTE sp_executesql @SQL, N'@SP_IN_systemUserId UNIQUEIDENTIFIER', @SP_IN_systemUserId = @systemUserId;
        END;
    END TRY

    BEGIN CATCH;
        SELECT @error = ERROR_NUMBER();
    END CATCH;

    RETURN @error;
END;
GO
GRANT EXECUTE
	ON [dbo].[ap_dim01_process_all_prefixes]
	TO [portalapp_role]
GO
