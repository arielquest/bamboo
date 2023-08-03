SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_ECC_PAYLOAD_ICM_PROV]
AS
SELECT  eccPayload.CLUSTER_RESOURCE_ID,
        eccPayload.MODIFIED_DATE,
        eccPayload.ITEM_BIZ_URN AS ECC_PAYLOAD_BUSINESS_URN,
        eccPayload.PKEY1 AS ECC_PAYLOAD_ID,
        eccPayload.PKEY_MAP_URN AS PKEY_MAP_URN,
        eccPayload.PKEY_CHANGE_STAMP,
        CASE WHEN eccPayload.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > eccPayload.PKEY_EFFECTIVE_TO
             THEN 'P'
             ELSE eccPayload.STATUS
        END AS STATUS,
        CASE WHEN eccPayload.STATUS NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > eccPayload.PKEY_EFFECTIVE_TO
             THEN CAST(1 AS BIT)
             ELSE CAST(0 AS BIT)
        END AS EXPIRED,
        eccPayload.DESCRIPTION,
        eccPayload.INTERNAL_NAME AS ENTERPRISE_NAME,
        eccPayload.SYSTEM_DEFINED,
        eccPayload.[DEPARTMENT_BIZ_URN],
        department.[PKEY1] AS [DEPARTMENT_ID],
        COALESCE(eccPayload.SOURCE_CHANGE_STAMP, 0) AS SOURCE_CHANGE_STAMP
FROM    VW_DIM_ECC_PAYLOAD_PKEY eccPayload
LEFT JOIN [dbo].[VW_DIM_DEPARTMENT_PKEY] [department] ON [department].[ITEM_BIZ_URN] = [eccPayload].[DEPARTMENT_BIZ_URN]
                                                         AND [department].[CLUSTER_RESOURCE_ID] = [eccPayload].[CLUSTER_RESOURCE_ID]
                                                         AND [department].[LATEST] = 1
                                                         AND [department].[PKEY_LATEST] = 1
                                                         AND [department].[PURGED] = 0
WHERE   (
          (
            eccPayload.STATUS = 'S'
            AND ( GETUTCDATE() BETWEEN eccPayload.PKEY_EFFECTIVE_FROM
                               AND     eccPayload.PKEY_EFFECTIVE_TO )
          )
          OR ( eccPayload.STATUS = 'P' )
          OR (
               eccPayload.STATUS NOT IN ( 'D', 'E' )
               AND GETUTCDATE() > eccPayload.PKEY_EFFECTIVE_TO
             )
        )
        AND eccPayload.LATEST = 1
        AND eccPayload.PKEY_LATEST = 1;
GO
GRANT SELECT
	ON [dbo].[VW_DIM_ECC_PAYLOAD_ICM_PROV]
	TO [portalapp_role]
GO
