SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[VW_DIM_EXPANDED_CALL_VARIABLE_ECC_PAYLOAD_MEMBER]
WITH SCHEMABINDING
AS
    SELECT
        i.[MEMBER_URN],
        i.[MEMBER_BIZ_URN],
        CAST('b2284560-77a2-4f51-a6a3-c65fce2a903b' AS UNIQUEIDENTIFIER) AS [MEMBER_TYPE_ID],
        i.[PARENT_ITEM_BIZ_URN],
        i.[CHILD_ITEM_BIZ_URN],
        i.[EFFECTIVE_FROM],
        i.[EFFECTIVE_TO],
        i.[DELETED],
        i.[HIDDEN],
        i.[SYSTEM],
        i.[LATEST],
        i.[CHANGE_STAMP]
    FROM [dbo].[TB_DIM_EXPANDED_CALL_VARIABLE_ECC_PAYLOAD_MEMBER] i;
GO
GRANT SELECT
	ON [dbo].[VW_DIM_EXPANDED_CALL_VARIABLE_ECC_PAYLOAD_MEMBER]
	TO [portalapp_role]
GO
