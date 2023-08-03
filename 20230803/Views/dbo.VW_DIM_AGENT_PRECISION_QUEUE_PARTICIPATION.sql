SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_AGENT_PRECISION_QUEUE_PARTICIPATION]
AS
SELECT DISTINCT
        apaMem.CHILD_ITEM_BIZ_URN AS AGENT_BIZ_URN,
        pqspqMem.PARENT_ITEM_BIZ_URN AS PRECISION_QUEUE_BIZ_URN,
        pqs.ITEM_BIZ_URN AS PRECISION_QUEUE_STEP_BIZ_URN,
        apaMemPkey.CLUSTER_RESOURCE_ID,
        apaMemPkey.EFFECTIVE_FROM,
        apaMemPkey.EFFECTIVE_TO
FROM    TB_DIM_AGENT_PRECISION_ATTRIBUTE_MEMBER apaMem
JOIN    TB_DIM_AGENT_PRECISION_ATTRIBUTE_MEMBER_PKEY_MAP apaMemPkey ON apaMemPkey.MEMBER_BIZ_URN = apaMem.MEMBER_BIZ_URN
JOIN    TB_DIM_PRECISION_QUEUE_STEP_PRECISION_ATTRIBUTE_MEMBER pqspaMem ON pqspaMem.PARENT_ITEM_BIZ_URN = apaMem.PARENT_ITEM_BIZ_URN
JOIN    TB_DIM_PRECISION_QUEUE_STEP_PRECISION_ATTRIBUTE_MEMBER_PKEY_MAP pqspaMemPkey ON pqspaMemPkey.MEMBER_BIZ_URN = pqspaMem.MEMBER_BIZ_URN
JOIN    TB_DIM_PRECISION_QUEUE_STEP pqs ON pqs.ITEM_BIZ_URN = pqspaMem.CHILD_ITEM_BIZ_URN
JOIN    TB_DIM_PRECISION_QUEUE_STEP_PRECISION_QUEUE_MEMBER pqspqMem ON pqspqMem.CHILD_ITEM_BIZ_URN = pqs.ITEM_BIZ_URN
WHERE   apaMem.DELETED = 0
        AND pqspaMem.DELETED = 0
        AND pqs.DELETED = 0
        AND pqspqMem.DELETED = 0
        AND CASE pqspaMemPkey.ATTRIBUTE_RELATION
              WHEN 1
              THEN ( CASE WHEN apaMemPkey.ATTRIBUTE_VALUE = pqspaMemPkey.VALUE_1
                          THEN 1
                          ELSE 0
                     END )
              WHEN 2
              THEN ( CASE WHEN apaMemPkey.ATTRIBUTE_VALUE = pqspaMemPkey.VALUE_1
                          THEN 0
                          ELSE 1
                     END )
              WHEN 3
              THEN ( CASE WHEN ISNUMERIC(apaMemPkey.ATTRIBUTE_VALUE) = 1
                               AND ISNUMERIC(pqspaMemPkey.VALUE_1) = 1
                               AND CAST(apaMemPkey.ATTRIBUTE_VALUE AS INT) < CAST(pqspaMemPkey.VALUE_1 AS INT)
                          THEN 1
                          ELSE 0
                     END )
              WHEN 4
              THEN ( CASE WHEN ISNUMERIC(apaMemPkey.ATTRIBUTE_VALUE) = 1
                               AND ISNUMERIC(pqspaMemPkey.VALUE_1) = 1
                               AND CAST(apaMemPkey.ATTRIBUTE_VALUE AS INT) <= CAST(pqspaMemPkey.VALUE_1 AS INT)
                          THEN 1
                          ELSE 0
                     END )
              WHEN 5
              THEN ( CASE WHEN ISNUMERIC(apaMemPkey.ATTRIBUTE_VALUE) = 1
                               AND ISNUMERIC(pqspaMemPkey.VALUE_1) = 1
                               AND CAST(apaMemPkey.ATTRIBUTE_VALUE AS INT) > CAST(pqspaMemPkey.VALUE_1 AS INT)
                          THEN 1
                          ELSE 0
                     END )
              WHEN 6
              THEN ( CASE WHEN ISNUMERIC(apaMemPkey.ATTRIBUTE_VALUE) = 1
                               AND ISNUMERIC(pqspaMemPkey.VALUE_1) = 1
                               AND CAST(apaMemPkey.ATTRIBUTE_VALUE AS INT) >= CAST(pqspaMemPkey.VALUE_1 AS INT)
                          THEN 1
                          ELSE 0
                     END )
            END = 1;
GO
GRANT SELECT
	ON [dbo].[VW_DIM_AGENT_PRECISION_QUEUE_PARTICIPATION]
	TO [portalapp_role]
GO
