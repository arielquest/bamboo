SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_EXPANDED_CALL_VARIABLE_ECC_PAYLOAD_MEMBER_ICM_PROV]
AS
SELECT  [eccPayloadMember].[CLUSTER_RESOURCE_ID],
        [eccPayloadMember].[MODIFIED_DATE],
        [eccPayloadMember].[MEMBER_URN],
        [eccPayloadMember].[PKEY_MAP_URN],
        [eccPayloadMember].[PKEY_CHANGE_STAMP],
        CASE WHEN [eccPayloadMember].[STATUS] NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > [eccPayloadMember].[PKEY_EFFECTIVE_TO] THEN 'P'
             ELSE [eccPayloadMember].[STATUS]
        END AS [STATUS],
        CASE WHEN [eccPayloadMember].[STATUS] NOT IN ( 'D', 'E' )
                  AND GETUTCDATE() > [eccPayloadMember].[PKEY_EFFECTIVE_TO] THEN CAST(1 AS BIT)
             ELSE CAST(0 AS BIT)
        END AS [EXPIRED],
        [eccPayloadMember].[PKEY1],
        [eccPayloadMember].[PKEY2],
        [expandedCallVariable].[ITEM_BIZ_URN] AS [EXPANDED_CALL_VARIABLE_BUSINESS_URN],
        [expandedCallVariable].[PKEY1] AS [EXPANDED_CALL_VARIABLE_ID],
        [expandedCallVariable].[PKEY_MAP_URN] AS [EXPANDED_CALL_VARIABLE_PKEY_MAP_URN],
        [expandedCallVariable].[PKEY_CHANGE_STAMP] AS [EXPANDED_CALL_VARIABLE_PKEY_CHANGE_STAMP],
        [eccPayload].[ITEM_BIZ_URN] AS [ECC_PAYLOAD_BUSINESS_URN],
        [eccPayload].[PKEY1] AS [ECC_PAYLOAD_ID],
        [eccPayload].[PKEY_MAP_URN] AS [ECC_PAYLOADPKEY_MAP_URN],
        [eccPayload].[PKEY_CHANGE_STAMP] AS [ECC_PAYLOAD_PKEY_CHANGE_STAMP]
FROM    [dbo].[VW_DIM_EXPANDED_CALL_VARIABLE_ECC_PAYLOAD_MEMBER_PKEY] [eccPayloadMember]
INNER JOIN [dbo].[VW_DIM_EXPANDED_CALL_VARIABLE_PKEY] [expandedCallVariable] ON [expandedCallVariable].[ITEM_BIZ_URN] = [eccPayloadMember].[CHILD_ITEM_BIZ_URN]
                                                AND [expandedCallVariable].[CLUSTER_RESOURCE_ID] = [eccPayloadMember].[CLUSTER_RESOURCE_ID]
INNER JOIN [dbo].[VW_DIM_ECC_PAYLOAD_PKEY] [eccPayload] ON [eccPayload].[ITEM_BIZ_URN] = [eccPayloadMember].[PARENT_ITEM_BIZ_URN]
                                                          AND [eccPayload].[CLUSTER_RESOURCE_ID] = [eccPayloadMember].[CLUSTER_RESOURCE_ID]
WHERE   (
          (
            [eccPayloadMember].[STATUS] = 'S'
            AND ( GETUTCDATE() BETWEEN [eccPayloadMember].[PKEY_EFFECTIVE_FROM]
                               AND     [eccPayloadMember].[PKEY_EFFECTIVE_TO] )
          )
          OR ( [eccPayloadMember].[STATUS] = 'P' )
          OR (
               [eccPayloadMember].[STATUS] NOT IN ( 'D', 'E' )
               AND GETUTCDATE() > [eccPayloadMember].[PKEY_EFFECTIVE_TO]
             )
        )
        AND [eccPayloadMember].[LATEST] = 1
        AND [eccPayloadMember].[PKEY_LATEST] = 1
        AND [expandedCallVariable].[LATEST] = 1
        AND [expandedCallVariable].[PKEY_LATEST] = 1
        AND [eccPayload].[LATEST] = 1
        AND [eccPayload].[PKEY_LATEST] = 1;
GO
GRANT SELECT
	ON [dbo].[VW_DIM_EXPANDED_CALL_VARIABLE_ECC_PAYLOAD_MEMBER_ICM_PROV]
	TO [portalapp_role]
GO
