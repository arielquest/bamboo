SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [tr_sec_folder_inserted_updated] ON [dbo].[TB_SEC_FOLDER]
    FOR INSERT, UPDATE
    NOT FOR REPLICATION
AS
    BEGIN 
        SET XACT_ABORT OFF;
        SET NOCOUNT ON;

        IF UPDATE([PATH])
        BEGIN 
            -- Ensure that the PARENT_ID, DEPTH, NAME, CONTAINER and OWNER_ID is correct based on PATH
            MERGE INTO [dbo].[TB_SEC_FOLDER] [TARGET]
            USING
                ( SELECT    [folder].[FOLDER_ID],
                            [folder].[PATH],
                            NULLIF([parent].[FOLDER_ID], [folder].[FOLDER_ID]) AS [PARENT_ID],
                            LEN([folder].[PATH]) - LEN(REPLACE([folder].[PATH], '/', '')) AS [DEPTH],
                            CASE WHEN [folder].[FOLDER_TYPE] IN ( 'T', 'F', 'S' ) THEN 1
                                 ELSE 0
                            END AS [CONTAINER],
                            CASE WHEN CHARINDEX('/', REVERSE([folder].[PATH])) = 0 THEN [folder].[PATH]
                                 ELSE RIGHT([folder].[PATH], CHARINDEX('/', REVERSE([folder].[PATH])) - 1)
                            END AS [NAME],
                            CASE WHEN [folder].[FOLDER_TYPE] = 'T' THEN [folder].[FOLDER_ID]
                                 ELSE [parent].[OWNER_ID]
                            END AS [OWNER_ID]
                  FROM      [Inserted] [folder]
                  LEFT OUTER JOIN [dbo].[TB_SEC_FOLDER] [parent] ON [parent].[PATH] = LEFT([folder].[PATH],
                                                                                           LEN([folder].[PATH]) - CHARINDEX('/', REVERSE([folder].[PATH])))
                ) [SOURCE]
            ON [TARGET].[FOLDER_ID] = [SOURCE].[FOLDER_ID]
            WHEN MATCHED THEN
                UPDATE SET
                         [TARGET].[DEPTH] = [SOURCE].[DEPTH],
                         [TARGET].[PARENT_ID] = [SOURCE].[PARENT_ID],
                         [TARGET].[NAME] = [SOURCE].[NAME],
                         [TARGET].[CONTAINER] = [SOURCE].[CONTAINER],
                         [TARGET].[OWNER_ID] = [SOURCE].[OWNER_ID];

            -- Ensure that the PATH is correct based on the PARENT_ID
            WITH    [CTE]
                      AS ( SELECT   [current].[FOLDER_ID],
                                    [current].[OWNER_ID],
                                    [current].[PARENT_ID],
                                    [current].[PATH] AS [CHANGING_PATH],
                                    [Old].[PATH] AS [PATH],
                                    [current].[PATH] AS [NEW_PATH]
                           FROM     [Inserted] [current]
                           INNER JOIN [Deleted] [Old] ON [Old].[FOLDER_ID] = [current].[FOLDER_ID]
                           UNION ALL
                           SELECT   [child].[FOLDER_ID],
                                    [parent].[OWNER_ID],
                                    [child].[PARENT_ID],
                                    [parent].[CHANGING_PATH],
                                    [parent].[PATH],
                                    CAST(CONCAT([parent].[CHANGING_PATH], STUFF([child].[PATH], 1, NULLIF(LEN([parent].[PATH]), 0), '')) AS NVARCHAR(450))
                           FROM     [CTE] [parent]
                           INNER JOIN [dbo].[TB_SEC_FOLDER] [child] ON [child].[PARENT_ID] = [parent].[FOLDER_ID]
                         ),
                    [CTE2]
                      AS ( SELECT   [base].[FOLDER_ID],
                                    [base].[PATH],
                                    [calculated].[NEW_PATH]
                           FROM     [dbo].[TB_SEC_FOLDER] [base]
                           INNER JOIN [CTE] [calculated] ON [calculated].[FOLDER_ID] = [base].[FOLDER_ID]
                         )
                UPDATE  [CTE2]
                SET     [CTE2].[PATH] = [CTE2].[NEW_PATH];

            --Change the content path of the reports associated with the updated/inserted folders.
            UPDATE  [dbo].[TB_REP_REPORT]
            SET     [CONTENT_PATH] = [f].[PATH] + '/' + [r].[NAME]
            FROM    [dbo].[TB_SEC_FOLDER] AS [f]
            INNER JOIN [dbo].[TB_REP_REPORT] AS [r] ON [r].[FOLDER_ID] = [f].[FOLDER_ID]
            WHERE   [f].[FOLDER_ID] IN ( SELECT [Inserted].[FOLDER_ID]
                                         FROM   [Inserted] );
        END;
    END;
GO
EXEC sp_settriggerorder @triggername= '[dbo].[tr_sec_folder_inserted_updated]', @order='Last', @stmttype='INSERT'
GO
