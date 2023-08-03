SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_sec01_resync_folder_ownership]
AS
    BEGIN
        DISABLE TRIGGER ALL ON [dbo].[TB_SEC_FOLDER];
        ENABLE TRIGGER [dbo].[tr_sec_folder_updated_gc] ON [dbo].[TB_SEC_FOLDER]; 

        WITH    [CTE]
                  AS ( SELECT   [FOLDER_ID],
                                [PARENT_ID],
                                [FOLDER_ID] AS [OWNER_ID],
                                CAST('/' + [NAME] AS NVARCHAR(450)) AS [PATH]
                       FROM     [dbo].[TB_SEC_FOLDER]
                       WHERE    [FOLDER_TYPE] = 'T'
                       UNION ALL
                       SELECT   [child].[FOLDER_ID],
                                [child].[PARENT_ID],
                                [parent].[OWNER_ID],
                                CAST([parent].[PATH] + '/' + [child].[NAME] AS NVARCHAR(450)) AS [PATH]
                       FROM     [CTE] [parent]
                       INNER JOIN [dbo].[TB_SEC_FOLDER] [child] ON [child].[PARENT_ID] = [parent].[FOLDER_ID]
                     ),
                [CTE2]
                  AS ( SELECT   [folder].[FOLDER_ID],
                                [folder].[OWNER_ID],
                                [c].[OWNER_ID] AS [NEW_OWNER_ID],
                                [folder].[PATH],
                                [c].[PATH] AS [NEW_PATH],
                                [folder].[DEPTH]
                       FROM     [dbo].[TB_SEC_FOLDER] [folder]
                       LEFT OUTER JOIN [CTE] [c] ON [c].[FOLDER_ID] = [folder].[FOLDER_ID]
                     )
            UPDATE  [CTE2]
            SET     [CTE2].[OWNER_ID] = [CTE2].[NEW_OWNER_ID],
                    [CTE2].[DEPTH] = LEN([CTE2].[PATH]) - LEN(REPLACE([CTE2].[PATH], '/', '')),
                    [CTE2].[PATH] = ISNULL([CTE2].[NEW_PATH], [CTE2].[PATH]);

        ENABLE TRIGGER ALL ON [dbo].[TB_SEC_FOLDER];
    END;
GO
GRANT EXECUTE
	ON [dbo].[ap_sec01_resync_folder_ownership]
	TO [portalapp_role]
GO
