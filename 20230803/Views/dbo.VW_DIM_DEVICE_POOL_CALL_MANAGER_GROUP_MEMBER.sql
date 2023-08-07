SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[VW_DIM_DEVICE_POOL_CALL_MANAGER_GROUP_MEMBER]
WITH SCHEMABINDING
AS
    SELECT
        i.[MEMBER_URN],
        i.[MEMBER_BIZ_URN],
        CAST('00000057-1000-0000-0000-0000000000c0' AS UNIQUEIDENTIFIER) AS [MEMBER_TYPE_ID],
        i.[PARENT_ITEM_BIZ_URN],
        i.[CHILD_ITEM_BIZ_URN],
        i.[EFFECTIVE_FROM],
        i.[EFFECTIVE_TO],
        i.[DELETED],
        i.[HIDDEN],
        i.[SYSTEM],
        i.[LATEST],
        i.[CHANGE_STAMP]
    FROM [dbo].[TB_DIM_DEVICE_POOL_CALL_MANAGER_GROUP_MEMBER] i;
GO
GRANT SELECT
	ON [dbo].[VW_DIM_DEVICE_POOL_CALL_MANAGER_GROUP_MEMBER]
	TO [portalapp_role]
GO