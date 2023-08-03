SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[VW_DIM_DIALED_NUMBER_ROUTING_CLIENT_MEMBER]
WITH SCHEMABINDING
AS
    SELECT
        i.[MEMBER_URN],
        i.[MEMBER_BIZ_URN],
        CAST('00000011-1000-0000-0000-0000000000c0' AS UNIQUEIDENTIFIER) AS [MEMBER_TYPE_ID],
        i.[PARENT_ITEM_BIZ_URN],
        i.[CHILD_ITEM_BIZ_URN],
        i.[EFFECTIVE_FROM],
        i.[EFFECTIVE_TO],
        i.[DELETED],
        i.[HIDDEN],
        i.[SYSTEM],
        i.[LATEST],
        i.[CHANGE_STAMP]
    FROM [dbo].[TB_DIM_DIALED_NUMBER_ROUTING_CLIENT_MEMBER] i;
GO
GRANT SELECT
	ON [dbo].[VW_DIM_DIALED_NUMBER_ROUTING_CLIENT_MEMBER]
	TO [portalapp_role]
GO
