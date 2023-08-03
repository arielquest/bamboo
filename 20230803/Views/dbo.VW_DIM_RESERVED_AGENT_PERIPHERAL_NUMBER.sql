SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW dbo.VW_DIM_RESERVED_AGENT_PERIPHERAL_NUMBER
AS
SELECT  CASE ISNUMERIC(cItemPkey.[PERIPHERAL_NUMBER])
          WHEN 1 THEN CAST(LEFT(cItemPkey.[PERIPHERAL_NUMBER], 18) AS BIGINT)
          ELSE 0
        END AS PERIPHERAL_NUMBER,
        pItem.[ITEM_URN] AS [PARENT_ITEM_URN],
        cItemPkey.[CLUSTER_RESOURCE_ID],
        cItem.[OWNER_ID]
FROM    dbo.TB_DIM_PERIPHERAL AS pItem
INNER JOIN dbo.TB_DIM_AGENT_PERIPHERAL_MEMBER AS pMember ON pMember.PARENT_ITEM_BIZ_URN = pItem.ITEM_BIZ_URN
                                                            AND pMember.LATEST = 1
INNER JOIN dbo.TB_DIM_AGENT AS cItem ON pMember.CHILD_ITEM_BIZ_URN = cItem.ITEM_BIZ_URN
                                        AND cItem.LATEST = 1
INNER JOIN dbo.TB_DIM_AGENT_PKEY_MAP AS cItemPkey ON cItem.ITEM_BIZ_URN = cItemPkey.ITEM_BIZ_URN
                                                     AND cItemPkey.LATEST = 1
WHERE   pItem.LATEST = 1
        AND pItem.ITEM_URN > 0
        AND ISNUMERIC(cItemPkey.PERIPHERAL_NUMBER) = 1
UNION
SELECT  CAST(LEFT([RESERVED_NAME], 18) AS BIGINT) AS PERIPHERAL_NUMBER,
        [PARENT_URN] AS [PARENT_ITEM_URN],
        [CLUSTER_RESOURCE_ID],
        [OWNER_ID]
FROM    dbo.TB_DIM_RESERVED_NAME
WHERE   [COLUMN_NAME] = 'PERIPHERAL_NUMBER'
        AND [ITEM_TYPE_ID] = '00001100-1000-0000-0000-000000000010';
GO
GRANT SELECT
	ON [dbo].[VW_DIM_RESERVED_AGENT_PERIPHERAL_NUMBER]
	TO [portalapp_role]
GO
