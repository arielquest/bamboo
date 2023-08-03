SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DIM_NNG]
AS
SELECT  [NNG_URN],
        [PARENT_URN],
        [SKIP_LEVEL],
        [MEMBER],
        [DESCRIPTION],
        [MEMBER_LENGTH],
        [OSGRID],
        LAT_LONG,
        [EFFECTIVE_FROM],
        [EFFECTIVE_TO],
        [ARCHIVED],
        [DELETED],
        [ENABLED],
        [EXPORT],
        [HIDDEN],
        [LATEST],
        [SYSTEM]
FROM    [dbo].[TB_DIM_NNG];
GO
GRANT SELECT
	ON [dbo].[VW_DIM_NNG]
	TO [portalapp_role]
GO
