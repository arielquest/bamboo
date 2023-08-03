SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_dim01_soft_purge_member_pkey]
(
    @PkeyMapsUrns            [dbo].[IntegerTableType] READONLY,
    @MemberTypeUrn          [INTEGER]
)
AS
    SET NOCOUNT ON;

    DECLARE @v_Members TABLE
    (
        MEMBER_URN int NOT NULL,
        MEMBER_BIZ_URN int NOT NULL,
        PKEY_MAP_URN int not null,
        CLUSTER_RESOURCE_ID uniqueidentifier NOT NULL,
        TOTAL_PKEYS_NOT_TO_DELETE int NOT NULL
    );

    DECLARE @v_TypeTableName AS NVARCHAR(255);
                
    SELECT @v_TypeTableName = TABLE_NAME FROM TE_DIM_MEMBER_TYPE WHERE MEMBER_TYPE_URN = @MemberTypeUrn;

    INSERT INTO @v_Members (MEMBER_URN, MEMBER_BIZ_URN, PKEY_MAP_URN, CLUSTER_RESOURCE_ID, TOTAL_PKEYS_NOT_TO_DELETE)
    SELECT toDeleteMembers.MEMBER_URN, toDeleteMembers.MEMBER_BIZ_URN, toDeleteMembers.PKEY_MAP_URN, toDeleteMembers.CLUSTER_RESOURCE_ID, COALESCE(notToDeletePkeyMaps.TOTAL_PKEYS_NOT_TO_DELETE, 0) AS TOTAL_PKEYS_NOT_TO_DELETE
    FROM     (SELECT MEMBER_URN, MEMBER_BIZ_URN, PKEY_MAP_URN, CLUSTER_RESOURCE_ID
                FROM dbo.VW_DIM_MEMBER_PKEY
                WHERE PKEY_MAP_URN IN (SELECT INTEGER_1 FROM @PkeyMapsUrns)
                AND MEMBER_TYPE_URN = @MemberTypeUrn) AS toDeleteMembers
    LEFT JOIN (SELECT MEMBER_BIZ_URN, COUNT(*) AS TOTAL_PKEYS_NOT_TO_DELETE
                FROM dbo.VW_DIM_MEMBER_PKEY_MAP
                WHERE PKEY_MAP_URN NOT IN (SELECT INTEGER_1 FROM @PkeyMapsUrns)
                AND MEMBER_TYPE_URN = @MemberTypeUrn                
                AND STATUS <> 'D'
                GROUP BY MEMBER_BIZ_URN) AS notToDeletePkeyMaps ON notToDeletePkeyMaps.MEMBER_BIZ_URN = toDeleteMembers.MEMBER_BIZ_URN    
    OPTION (RECOMPILE);
    
    SET QUOTED_IDENTIFIER ON;
    
    DECLARE @SQL NVARCHAR(MAX);
        
    -- Set member deleted only if there is only one pkey associated with it
    SELECT @SQL = (SELECT sqlCode
                    FROM 
                    (    
                        SELECT DISTINCT 
                                'UPDATE dbo.' + @v_TypeTableName + '
                                SET DELETED = 1, EFFECTIVE_TO = GETUTCDATE()
                                WHERE MEMBER_URN = ' + CAST(MEMBER_URN AS VARCHAR(10))+ ';' +CHAR(13)+CHAR(10)
                        FROM @v_Members
                        WHERE TOTAL_PKEYS_NOT_TO_DELETE = 0
                        FOR XML PATH(''),TYPE) a (sqlCode)
                     ).value('.','NVARCHAR(MAX)');
                
    EXECUTE sp_executesql @SQL;
        
        
    SELECT @SQL = (SELECT sqlCode
                    FROM 
                    (    
                        SELECT 'UPDATE dbo.' + @v_TypeTableName + '_PKEY_MAP
                                SET EFFECTIVE_TO = GETUTCDATE(), STATUS = ''D'', PURGED = 1
                                WHERE PKEY_MAP_URN = ' + CAST(PKEY_MAP_URN AS VARCHAR(10))+ ';' +CHAR(13)+CHAR(10)
                        FROM @v_Members
                        FOR XML PATH(''),TYPE) a (sqlCode)
                     ).value('.','NVARCHAR(MAX)');        
                    
    EXECUTE sp_executesql @SQL;
    
    
    SET QUOTED_IDENTIFIER OFF;
GO
GRANT EXECUTE
	ON [dbo].[ap_dim01_soft_purge_member_pkey]
	TO [portalapp_role]
GO
