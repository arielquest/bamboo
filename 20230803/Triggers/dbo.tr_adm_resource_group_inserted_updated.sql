SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [tr_adm_resource_group_inserted_updated] ON [dbo].[TB_ADM_RESOURCE_GROUP]
    FOR INSERT, UPDATE
    NOT FOR REPLICATION
AS
    BEGIN
        SET XACT_ABORT OFF;
        SET NOCOUNT ON;

        IF UPDATE([PATH])
        BEGIN
            DECLARE @Depth INT;
            DECLARE @Path NVARCHAR(255);

            SELECT  @Depth = [PROPERTY_VALUE]
            FROM    [dbo].[TB_ADM_PROPERTY]
            WHERE   [PROPERTY_KEY] = 'PROP_MAX_RESOURCE_GROUP_DEPTH';
        
            SELECT  @Path = [PATH]
            FROM    [inserted];

            IF @Depth IS NOT NULL
                AND LEN(@Path) - LEN(REPLACE(@Path, '/', '')) > @Depth
            BEGIN
                RAISERROR(55572, 16, 1, @Depth);
            END;

            -- Ensure that the PARENT_ID and NAME are correct based on PATH
            MERGE INTO [dbo].[TB_ADM_RESOURCE_GROUP] [TARGET]
            USING
                ( SELECT    [resouceGroup].[ID],
                            [resouceGroup].[PATH],
                            NULLIF([parent].[ID], [resouceGroup].[ID]) AS [PARENT_ID],
                            CASE WHEN CHARINDEX('/', REVERSE([resouceGroup].[PATH])) = 0 THEN [resouceGroup].[PATH]
                                 ELSE RIGHT([resouceGroup].[PATH], CHARINDEX('/', REVERSE([resouceGroup].[PATH])) - 1)
                            END AS [NAME]
                  FROM      [Inserted] [resouceGroup]
                  LEFT OUTER JOIN [dbo].[TB_ADM_RESOURCE_GROUP] [parent] ON [parent].[PATH] = LEFT([resouceGroup].[PATH],
                                                                                                   LEN([resouceGroup].[PATH]) - CHARINDEX('/',
                                                                                                                                          REVERSE([resouceGroup].[PATH])))
                ) [SOURCE]
            ON [TARGET].[ID] = [SOURCE].[ID]
            WHEN MATCHED THEN
                UPDATE SET
                         [TARGET].[PARENT_ID] = [SOURCE].[PARENT_ID],
                         [TARGET].[NAME] = [SOURCE].[NAME],
                         [TARGET].[CHANGE_STAMP] = [TARGET].[CHANGE_STAMP] + 1;

            -- Ensure that the PATH is correct based on the PARENT_ID
            WITH    [CTE]
                      AS ( SELECT   [current].[ID],
                                    [current].[PARENT_ID],
                                    [current].[PATH] AS [CHANGING_PATH],
                                    [Old].[PATH] AS [PATH],
                                    [current].[PATH] AS [NEW_PATH]
                           FROM     [Inserted] [current]
                           INNER JOIN [Deleted] [Old] ON [Old].[ID] = [current].[ID]
                           UNION ALL
                           SELECT   [child].[ID],
                                    [child].[PARENT_ID],
                                    [parent].[CHANGING_PATH],
                                    [parent].[PATH],
                                    CAST(CONCAT([parent].[CHANGING_PATH], STUFF([child].[PATH], 1, NULLIF(LEN([parent].[PATH]), 0), '')) AS NVARCHAR(2020))
                           FROM     [CTE] [parent]
                           INNER JOIN [dbo].[TB_ADM_RESOURCE_GROUP] [child] ON [child].[PARENT_ID] = [parent].[ID]
                         ),
                    [CTE2]
                      AS ( SELECT   [base].[ID],
                                    [base].[PATH],
                                    [base].[CHANGE_STAMP],
                                    [calculated].[NEW_PATH]
                           FROM     [dbo].[TB_ADM_RESOURCE_GROUP] [base]
                           INNER JOIN [CTE] [calculated] ON [calculated].[ID] = [base].[ID]
                         )
                UPDATE  [CTE2]
                SET     [CTE2].[PATH] = [CTE2].[NEW_PATH],
                        [CTE2].[CHANGE_STAMP] = [CTE2].[CHANGE_STAMP] + 1;
        END;
    END;
GO
EXEC sp_settriggerorder @triggername= '[dbo].[tr_adm_resource_group_inserted_updated]', @order='Last', @stmttype='INSERT'
GO
