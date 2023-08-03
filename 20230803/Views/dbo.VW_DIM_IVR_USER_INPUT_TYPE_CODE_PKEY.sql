SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[VW_DIM_IVR_USER_INPUT_TYPE_CODE_PKEY]
WITH SCHEMABINDING
AS
    SELECT fl.[FOLDER_ID],
           fl.[PARENT_ID] AS [FOLDER_PARENT_ID],
           fl.[FOLDER_TYPE],
           fl.[DEPTH] AS [FOLDER_DEPTH],
           fl.[NAME] AS [FOLDER_NAME],
           fl.[PATH] AS [FOLDER_PATH],
           it.[ITEM_URN],
           it.[ITEM_BIZ_URN],
           it.[SKIP_LEVEL],
           it.[OWNER_ID],
           it.[ITEM_SUBTYPE_ID],
           it.[NAME],
           it.[INTERNAL_NAME],
           it.[DESCRIPTION],
           it.[STRING_VAL],
           it.[INT_VAL],
           it.[BIGINT_VAL],
           it.[DATETIME_VAL],
           it.[HIERARCHY_PARENT_URN],
           it.[EFFECTIVE_FROM],
           it.[EFFECTIVE_TO],
           it.[DELETED],
           it.[HIDDEN],
           it.[SYSTEM],
           it.[LATEST],
           it.[CHANGE_STAMP],
           pk.CLUSTER_RESOURCE_ID,
           pk.CLUSTER_RESOURCE_TYPE_ID,
           pk.CLUSTER_VERSION,
           pk.PKEY1,
           pk.PKEY2
    FROM [dbo].[TB_DIM_CODE] it
    JOIN [dbo].[TB_SEC_FOLDER] fl ON fl.[FOLDER_ID] = it.[FOLDER_ID]
    JOIN [dbo].[TB_DIM_CODE_CODE_GROUP_MEMBER] mem ON mem.CHILD_ITEM_BIZ_URN = it.[ITEM_BIZ_URN] AND mem.[LATEST] = 1
    JOIN [dbo].[TB_DIM_CODE_GROUP] AS cg ON cg.[ITEM_BIZ_URN] = mem.[PARENT_ITEM_BIZ_URN] AND cg.[LATEST] = 1
    LEFT JOIN [dbo].[TB_DIM_CODE_PKEY_MAP] as pk on pk.ITEM_BIZ_URN = it.ITEM_BIZ_URN AND pk.LATEST = 1
    WHERE (cg.[INTERNAL_NAME] = 'CG_IVR_USER_INPUT_TYPE' OR it.ITEM_URN IN (-1, -2))
    AND cg.[SYSTEM] = 1
    AND it.[LATEST] = 1;
GO
GRANT SELECT
	ON [dbo].[VW_DIM_IVR_USER_INPUT_TYPE_CODE_PKEY]
	TO [portalapp_role]
GO
