SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[ap_dim01_reinitialise_category_paths]
AS
    BEGIN
        -- DISABLE TRIGGERS FOR CURRENT SCOPE
        SET CONTEXT_INFO 0x0; 

        SET NOCOUNT ON;

        WITH    [CTE]
                  AS ( SELECT   [ITEM_URN],
                                CAST('/' + REPLACE([NAME], '/', '|') + '/' AS NVARCHAR(4000)) AS [PATH]
                       FROM     [dbo].[TB_DIM_CATEGORY]
                       WHERE    ( [ROOT_CATEGORY_BIZ_URN] = -1
                                  OR [HIERARCHY_PARENT_URN] IS NULL
                                )
                                AND [ITEM_URN] > 0
                       UNION ALL
                       SELECT   [child].[ITEM_URN],
                                [parent].[PATH] + CAST(REPLACE([child].[NAME], '/', '|') + '/' AS NVARCHAR(4000))
                       FROM     [CTE] [parent]
                       INNER JOIN [dbo].[TB_DIM_CATEGORY] [child] ON [child].[HIERARCHY_PARENT_URN] = [parent].[ITEM_URN]
                     )
            UPDATE  [TARGET]
            SET     [TARGET].[PATH] = [SOURCE].[PATH]
            FROM    [dbo].[TB_DIM_CATEGORY] [TARGET]
            INNER JOIN [CTE] [SOURCE] ON [TARGET].[ITEM_URN] = [SOURCE].[ITEM_URN]
            WHERE   ( [SOURCE].[PATH] <> [TARGET].[PATH]
                      OR ( [TARGET].[PATH] IS NULL
                           AND [SOURCE].[PATH] IS NOT NULL
                         )
                      OR ( [TARGET].[PATH] IS NOT NULL
                           AND [SOURCE].[PATH] IS NULL
                         )
                    );

        -- RE-ENABLE TRIGGERS FOR CURRENT SCOPE
        SET CONTEXT_INFO 0x1; 

    END;
GO
GRANT EXECUTE
	ON [dbo].[ap_dim01_reinitialise_category_paths]
	TO [portalapp_role]
GO
