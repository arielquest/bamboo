SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE dbo.ap_adm01_get_last_provisioning_error_message (@AuditItems AS dbo.AuditKeyTableType READONLY) AS
SET NOCOUNT ON;

SELECT INT_VAL_1, INT_VAL_2, INT_VAL_3, INT_VAL_4, GUID_VAL_1, GUID_VAL_2, EVENT_DESCRIPTION, EVENT_RAW_DESCRIPTION
FROM @AuditItems items
CROSS APPLY (
    SELECT TOP 1 INT_VAL_1, INT_VAL_2, INT_VAL_3, INT_VAL_4, GUID_VAL_1, GUID_VAL_2, EVENT_DESCRIPTION, EVENT_RAW_DESCRIPTION
    FROM dbo.VW_FCT_AUDIT a
    INNER JOIN dbo.TE_ADM_AUDIT_TYPE t ON a.AUDIT_TYPE_ID = t.AUDIT_TYPE_ID
    WHERE GUID_VAL_1 IS NOT NULL -- a cluster audit    
    AND 
    (        
        (
            -- User provisioning audits
            GUID_VAL_2 = items.GUID_2 -- User Id
            AND t.INTERNAL_NAME IN ('AT_USER_UPDATE_COMMITTED_ON_EQUIPMENT', 'AT_USER_DELETE_COMMITTED_ON_EQUIPMENT' ,'AT_USER_INSERT_COMMITTED_ON_EQUIPMENT', 'AT_GENERIC')
        )
        OR 
        (
            -- Dimension and Member provisioning audits
            INT_VAL_1 = items.INTEGER_1 
            AND (
                    (
                        items.INTEGER_2 IS NULL
                        AND INT_VAL_2 IS NULL
                    )
                 OR (
                        INT_VAL_2 = items.INTEGER_2
                        AND INT_VAL_4 = items.INTEGER_4
                    )
                )
            AND INT_VAL_3 = items.INTEGER_3            
            AND (t.INTERNAL_NAME LIKE 'AT_DIMENSION%' OR 
                 t.INTERNAL_NAME LIKE 'AT_MEMBER%')
        )
    )
    AND EVENT_OUTCOME = 'F' 
    ORDER BY EVENT_UTC_DATE_TIME DESC
    ) lastError;
GO
GRANT EXECUTE
	ON [dbo].[ap_adm01_get_last_provisioning_error_message]
	TO [portalapp_role]
GO
