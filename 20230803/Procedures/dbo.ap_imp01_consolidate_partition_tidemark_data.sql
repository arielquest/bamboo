SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_imp01_consolidate_partition_tidemark_data]
    (
      @ServerName AS NVARCHAR(200),
      @PartitionTableName AS NVARCHAR(1000) = NULL
    )
AS
    BEGIN
        SET NOCOUNT ON;
        BEGIN TRY
            DECLARE @error INT = 0,
                @InitialTransactionCount INT = @@TRANCOUNT,
                @v_PortalDBComponentType NVARCHAR(100) = 'CT_EXONY_RELATIONAL_DB_DEFAULT',
                @ErrorMessage NVARCHAR(2000) = N'',
                @ErrorHolder NVARCHAR(2000),
                @DynamicSQL NVARCHAR(MAX);

            -- Get the Resource Instance Id of the @ServerName.
            DECLARE @v_ResourceInstanceID AS UNIQUEIDENTIFIER;

            SELECT  @v_ResourceInstanceID = [ri].[RESOURCE_INSTANCE_ID]
            FROM    [dbo].[TB_CLU_RESOURCE_INSTANCE] AS [ri]
            INNER JOIN [dbo].[TB_CLU_RESOURCE_INSTANCE_COMPONENT] AS [co] ON [ri].[RESOURCE_INSTANCE_ID] = [co].[RESOURCE_INSTANCE_ID]
            INNER JOIN [dbo].[TE_CLU_RESOURCE_INSTANCE_COMPONENT_TYPE] AS [ct] ON [co].[COMPONENT_TYPE_ID] = [ct].[COMPONENT_TYPE_ID]
            INNER JOIN [dbo].[TB_CLU_SERVER] AS [s] ON [co].[SERVER_ID] = [s].[SERVER_ID]
            WHERE   [ct].[INTERNAL_NAME] = @v_PortalDBComponentType
                    AND [s].[SERVER_NAME] = @ServerName;

            -- Check if the Resource Instance IDs have been found to proceed further
            IF ( @v_ResourceInstanceID IS NULL )
            BEGIN 
                SET @error = -1;
                RAISERROR ('Resource Instance Id not found. Please check the Server Name: [%s] exists. Error [%d]', 16, 1, @ServerName, @error);
            END;

            -- If the @PartitionTableName has been passed the following check will apply.
            DECLARE @PartitionTableId UNIQUEIDENTIFIER;

            IF @PartitionTableName IS NOT NULL
            BEGIN 
                IF NOT EXISTS ( SELECT  [FACT_PARTITION_ID]
                                FROM    [dbo].[TB_IMP_FCT_PARTITION]
                                WHERE   [PARTITION_TABLE_NAME] = @PartitionTableName
                                        AND [RESOURCE_INSTANCE_ID] = @v_ResourceInstanceID )
                BEGIN 
                    SET @error = -1;
                    RAISERROR ('Partition Table Name: [%s] does not exist. Error [%d]', 16, 1, @PartitionTableName, @error);
                END;
                ELSE
                BEGIN 
                    SELECT  @PartitionTableId = [FACT_PARTITION_ID]
                    FROM    [dbo].[TB_IMP_FCT_PARTITION]
                    WHERE   [PARTITION_TABLE_NAME] = @PartitionTableName
                            AND [RESOURCE_INSTANCE_ID] = @v_ResourceInstanceID;
                END;
            END;

            IF OBJECT_ID('tempdb..##PartitionedTables') IS NOT NULL
            BEGIN
                DROP TABLE [##PartitionedTables];
            END;

            SELECT  @DynamicSQL = CONCAT('SELECT  IDENTITY( INT,1,1 ) AS [ROW_URN],
        [part].[FACT_PARTITION_ID],
        [tide].[CLUSTER_RESOURCE_ID],
        [res].[RESOURCE_URN] AS [CLUSTER_RESOURCE_URN],
        [meta].[CUBE_VIEW_NAME],
        [part].[PARTITION_TABLE_NAME],
        [meta].[IDENTITY_FIELD],
        [meta].[GLOBAL_IDENTITY_FIELD],
        [part].[START_DATE_TIME], 
        DATEADD(s, - 1, [part].[END_DATE_TIME]) AS [END_DATE_TIME],
        CAST(CASE WHEN [obj].[object_id] IS NOT NULL THEN 1
                  ELSE 0
             END AS INT) AS [EXISTS],
        CAST(MAX(CASE WHEN [col].[name] = ', CHAR(39), 'CLUSTER_RESOURCE_URN', CHAR(39), ' THEN 1
                      ELSE 0
                 END) AS INT) AS [IS_CLUSTER_RESOURCE_URN],
        CAST(MAX(CASE WHEN [col].[name] = ', CHAR(39), 'CLUSTER_RESOURCE_ID', CHAR(39), ' THEN 1
                      ELSE 0
                 END) AS INT) AS [IS_CLUSTER_RESOURCE_ID],
        CAST(MAX(CASE WHEN [col].[name] = ', CHAR(39), 'RESOURCE_URN', CHAR(39), ' THEN 1
                      ELSE 0
                 END) AS INT) AS [IS_RESOURCE_URN],
        CAST(MAX(CASE WHEN [col].[name] = ', CHAR(39), 'RESOURCE_ID', CHAR(39), ' THEN 1
                      ELSE 0
                 END) AS INT) AS [IS_RESOURCE_ID],
        CAST(MAX(CASE WHEN [portalSource].[PORTAL_CLUSTER_RESOURCE_ID] IS NOT NULL THEN 1
                      ELSE 0
                 END) AS INT) AS [IS_PORTAL_CLUSTER_RESOURCE_ID],
        MAX([portalSource].[PORTAL_CLUSTER_RESOURCE_ID]) AS [PORTAL_CLUSTER_RESOURCE_ID],
        CAST(0 AS BIGINT) AS [MIN_PARTITION_URN],
        CAST(0 AS BIGINT) AS [MAX_PARTITION_URN],
        CAST(0 AS BIGINT) AS [MIN_GLOBAL_PARTITION_URN],
        CAST(0 AS BIGINT) AS [MAX_GLOBAL_PARTITION_URN],
        CAST(', CHAR(39), CHAR(39), ' AS NVARCHAR(128)) AS [SLICE_COLUMN],
        ca2.csv2 AS [SLICE_KEYS],
        CAST(', CHAR(39), CHAR(39), ' AS NVARCHAR(MAX)) AS [SQL]
INTO ##PartitionedTables
FROM    [dbo].[TB_IMP_FCT_PARTITION] [part]
INNER JOIN [dbo].[TB_IMP_FCT_PARTITION_METADATA] [meta] ON [meta].[FACT_PARTITION_METADATA_ID] = [part].[FACT_PARTITION_METADATA_ID]
LEFT OUTER JOIN [dbo].[TB_IMP_FCT_PARTITION_TIDEMARK] [tide] ON [part].[FACT_PARTITION_ID] = [tide].[FACT_PARTITION_ID]
INNER JOIN [dbo].[TB_CLU_RESOURCE] [res] ON [res].[RESOURCE_ID] = [tide].[CLUSTER_RESOURCE_ID]
LEFT OUTER JOIN [sys].[objects] [obj] ON [obj].[name] = [part].[PARTITION_TABLE_NAME]
LEFT OUTER JOIN [sys].[columns] [col] ON [col].[object_id] = [obj].[object_id]
CROSS APPLY (SELECT ', CHAR(39), ',', CHAR(39), '+CAST(DATE_URN AS VARCHAR(MAX))
             FROM [dbo].[TB_DIM_DATE] [date]
             WHERE [date].[DATE_VALUE] BETWEEN [part].[START_DATE_TIME] AND DATEADD(s, - 1, [part].[END_DATE_TIME]) 
             FOR XML PATH(', CHAR(39), CHAR(39), '), TYPE
            ) ca(csv)
CROSS APPLY (SELECT STUFF(ca.csv.value(', CHAR(39), '.', CHAR(39), ',', CHAR(39), 'VARCHAR(MAX)', CHAR(39), '),1,1,', CHAR(39), '', CHAR(39), ')
            )ca2(csv2)
LEFT OUTER JOIN ( SELECT    [portalSource].[FACT_PARTITION_METADATA_ID],
                            [portalSource].[NAME],
                            [portalSource].[TEMPLATE_TABLE_NAME],
                            [ca].[RESOURCE_ID] AS [PORTAL_CLUSTER_RESOURCE_ID]
                  FROM      [dbo].[TB_IMP_FCT_PARTITION_METADATA] [portalSource]
                  CROSS APPLY ( SELECT  [RESOURCE_ID]
                                FROM    [dbo].[TB_CLU_RESOURCE]
                                WHERE   [RESOURCE_TYPE_ID] = ', CHAR(39), '00000000-0000-0000-0000-000000000020', CHAR(39), '
                              ) [ca]
                  -- IMPORTANT! THIS LIST MUST BE MAINTAINED! IT IS A LIST OF PARTITIONS THAT HAVE THEIR SOURCE AS PORTAL, RATHER THAN AS THE ACTUAL SOURCE
                  WHERE     [portalSource].[FACT_PARTITION_METADATA_ID] IN ( ', CHAR(39), 'EFA8EE93-A94F-465A-B5DB-9DF276A707EA', CHAR(39), ', ', CHAR(39),
                                         '827B05C3-37A1-4683-85D8-FF4CA0112858', CHAR(39), ',
                                                                             ', CHAR(39), '25EE5DF2-A0AE-4BFF-9DE5-6639006178E1', CHAR(39), ', ', CHAR(39),
                                         '7FE1048C-0497-47EB-A6CC-469E742C64BE', CHAR(39), ',
                                                                             ', CHAR(39), 'A18A18B6-4EA0-467D-B9DC-3C650610AAFD', CHAR(39), ', ', CHAR(39),
                                         '4253C8EC-E549-47C3-9205-2D75902D05E8', CHAR(39), ',
                                                                             ', CHAR(39), '99422FA5-8B6A-4788-B46F-37ACF3EA79D8', CHAR(39), ', ', CHAR(39),
                                         '7DC928FF-CAB0-49DD-9E2D-22C31A00BB3B', CHAR(39), ',
                                                                             ', CHAR(39), 'F14422ED-0408-48EA-8486-3E2D3F1D59BB', CHAR(39), ', ', CHAR(39),
                                         '83AC7368-F8B2-49E5-B695-AE2CBEEBE758', CHAR(39), ',
                                                                             ', CHAR(39), '2C9A9F4C-5638-4432-8E73-80033DD1E0A7', CHAR(39), ', ', CHAR(39),
                                         '186E36DC-82D4-4C21-9B7E-C27DC8C89F97', CHAR(39), ',
                                                                             ', CHAR(39), 'D98E8359-F3E5-4326-89E9-7E8674ABAB26', CHAR(39), ', ', CHAR(39),
                                         '11B8095C-F964-4859-85E4-DCCE3A8BF287', CHAR(39), ' )
                ) [portalSource] ON [portalSource].[FACT_PARTITION_METADATA_ID] = [part].[FACT_PARTITION_METADATA_ID]
WHERE   [part].[RESOURCE_INSTANCE_ID] = @v_ResourceInstanceID
                        ', CASE WHEN @PartitionTableId IS NOT NULL THEN 'AND [part].[FACT_PARTITION_ID] = @PartitionTableId'
                                ELSE ''
                           END, '
                        AND ( [part].[START_DATE_TIME] < ', CHAR(39), '9999-01-01 00:00:00.000', CHAR(39), '
                              OR [part].[END_DATE_TIME] < ', CHAR(39), '9999-01-01 00:00:00.000', CHAR(39), '
                            )
GROUP BY [part].[FACT_PARTITION_ID],
        [tide].[CLUSTER_RESOURCE_ID],
        [res].[RESOURCE_URN],
        [meta].[CUBE_VIEW_NAME],
        [part].[PARTITION_TABLE_NAME],
        [meta].[IDENTITY_FIELD],
        [meta].[GLOBAL_IDENTITY_FIELD],
        [part].[START_DATE_TIME], 
        [part].[END_DATE_TIME],
        ca2.csv2,
        [obj].[object_id];');

            EXEC [sys].[sp_executesql] @DynamicSQL, N'@v_ResourceInstanceID UNIQUEIDENTIFIER, @PartitionTableId UNIQUEIDENTIFIER',
                @v_ResourceInstanceID = @v_ResourceInstanceID, @PartitionTableId = @PartitionTableId;

            IF NOT EXISTS ( SELECT  1
                            FROM    [##PartitionedTables] )
            BEGIN 
                SET @error = -1;
                IF @PartitionTableId IS NOT NULL
                BEGIN 
                    RAISERROR ('Please check the partition information for: [%s] of server: [%s]. Information such as [START_DATE_TIME] and/or [END_DATE_TIME] or metadata information may not be appropriate to generate tidemark information. Error [%d]', 16, 1, @PartitionTableName, @ServerName, @error);
                END;
                ELSE
                BEGIN 
                    RAISERROR ('Please check the partition information for partition tables of server: [%s]. Information such as [START_DATE_TIME] and/or [END_DATE_TIME] or metadata information may not be appropriate to generate tidemark information. Error [%d]', 16, 1, @ServerName, @error);
                END;
            END;

            -- Not all the fact/summary tables are meant for OLAP processing (not present in TB_ADM_OLAP_OBJECT)
            -- Hence we need to know the SLICE_COLUMN information of such tables.
            IF OBJECT_ID('tempdb..#NonOLAPSliceColumns') IS NOT NULL
            BEGIN
                DROP TABLE [#NonOLAPSliceColumns];
            END;
            SELECT  IDENTITY( INT,1,1 ) AS [ROW_URN],
                    [a].[CUBE_VIEW_NAME],
                    [a].[SLICE_COLUMN]
            INTO    [#NonOLAPSliceColumns]
            FROM    ( SELECT DISTINCT
                                [d].[CUBE_VIEW_NAME],
                                [a].[SLICE_COLUMN]
                      FROM      [dbo].[TB_IMP_FCT_PARTITION_TIDEMARK_SLICE] [a]
                      JOIN      [dbo].[TB_IMP_FCT_PARTITION_TIDEMARK] [b] ON [a].[PARTITION_TIDEMARK_ID] = [b].[PARTITION_TIDEMARK_ID]
                      JOIN      [dbo].[TB_IMP_FCT_PARTITION] [c] ON [b].[FACT_PARTITION_ID] = [c].[FACT_PARTITION_ID]
                      JOIN      [dbo].[TB_IMP_FCT_PARTITION_METADATA] [d] ON [c].[FACT_PARTITION_METADATA_ID] = [d].[FACT_PARTITION_METADATA_ID]
                      WHERE     [d].[CUBE_VIEW_NAME] NOT IN ( SELECT    [PRIMARY_TABLE]
                                                              FROM      [dbo].[TB_ADM_OLAP_OBJECT]
                                                              WHERE     [OLAP_OBJECT_TYPE] = 'C' )
                    ) [a];

            -- Get the High Water Before and After for the Partitioned Table
            MERGE INTO [##PartitionedTables] [TARGET]
            USING
                ( SELECT    [ROW_URN],
                            CONCAT('
MERGE INTO ##PartitionedTables [TARGET]
USING (
SELECT ', CHAR(39), [PARTITION_TABLE_NAME], CHAR(39), 'AS [PARTITION_TABLE_NAME], ',
                                   CASE WHEN [IS_PORTAL_CLUSTER_RESOURCE_ID] = 1
                                        THEN CONCAT(CHAR(39), [PORTAL_CLUSTER_RESOURCE_ID], CHAR(39), ' AS [PORTAL_CLUSTER_RESOURCE_ID], ')
                                        ELSE CONCAT('[', CASE WHEN [IS_CLUSTER_RESOURCE_URN] = 1 THEN 'CLUSTER_RESOURCE_URN'
                                                              WHEN [IS_CLUSTER_RESOURCE_ID] = 1 THEN 'CLUSTER_RESOURCE_ID'
                                                              WHEN [IS_RESOURCE_URN] = 1 THEN 'RESOURCE_URN'
                                                              WHEN [IS_RESOURCE_ID] = 1 THEN 'RESOURCE_ID'
                                                              ELSE 'ERROR'
                                                         END, '],')
                                   END, ' MAX([', [IDENTITY_FIELD], ']) AS MAX_PARTITION_URN, MIN([', [IDENTITY_FIELD], ']) AS MIN_PARTITION_URN, ',
                                   CASE WHEN [GLOBAL_IDENTITY_FIELD] IS NULL THEN '0'
                                        ELSE CONCAT('MAX([', [GLOBAL_IDENTITY_FIELD], '])')
                                   END, ' AS MAX_GLOBAL_PARTITION_URN, ', CASE WHEN [GLOBAL_IDENTITY_FIELD] IS NULL THEN '0'
                                                                               ELSE CONCAT('MIN([', [GLOBAL_IDENTITY_FIELD], '])')
                                                                          END, ' AS MIN_GLOBAL_PARTITION_URN
FROM [dbo].[', [PARTITION_TABLE_NAME], ']
', CASE WHEN [IS_PORTAL_CLUSTER_RESOURCE_ID] = 1 THEN ''
        ELSE CONCAT('GROUP BY [', CASE WHEN [IS_CLUSTER_RESOURCE_URN] = 1 THEN 'CLUSTER_RESOURCE_URN'
                                       WHEN [IS_CLUSTER_RESOURCE_ID] = 1 THEN 'CLUSTER_RESOURCE_ID'
                                       WHEN [IS_RESOURCE_URN] = 1 THEN 'RESOURCE_URN'
                                       WHEN [IS_RESOURCE_ID] = 1 THEN 'RESOURCE_ID'
                                       ELSE 'ERROR'
                                  END, ']')
   END, '
) [SOURCE] ON [TARGET].[PARTITION_TABLE_NAME] = [SOURCE].[PARTITION_TABLE_NAME] AND [TARGET].[',
                                   CASE WHEN [IS_PORTAL_CLUSTER_RESOURCE_ID] = 1 THEN 'PORTAL_CLUSTER_RESOURCE_ID'
                                        WHEN [IS_CLUSTER_RESOURCE_URN] = 1 THEN 'CLUSTER_RESOURCE_URN'
                                        WHEN [IS_CLUSTER_RESOURCE_ID] = 1 THEN 'CLUSTER_RESOURCE_ID'
                                        WHEN [IS_RESOURCE_URN] = 1 THEN 'RESOURCE_URN'
                                        WHEN [IS_RESOURCE_ID] = 1 THEN 'RESOURCE_ID'
                                        ELSE 'ERROR'
                                   END, '] = [SOURCE].[', CASE WHEN [IS_PORTAL_CLUSTER_RESOURCE_ID] = 1 THEN 'PORTAL_CLUSTER_RESOURCE_ID'
                                                               WHEN [IS_CLUSTER_RESOURCE_URN] = 1 THEN 'CLUSTER_RESOURCE_URN'
                                                               WHEN [IS_CLUSTER_RESOURCE_ID] = 1 THEN 'CLUSTER_RESOURCE_ID'
                                                               WHEN [IS_RESOURCE_URN] = 1 THEN 'RESOURCE_URN'
                                                               WHEN [IS_RESOURCE_ID] = 1 THEN 'RESOURCE_ID'
                                                               ELSE 'ERROR'
                                                          END,
                                   ']
WHEN MATCHED THEN UPDATE SET [TARGET].[MIN_PARTITION_URN] = [SOURCE].[MIN_PARTITION_URN], [TARGET].[MAX_PARTITION_URN] = [SOURCE].[MAX_PARTITION_URN], [TARGET].[MIN_GLOBAL_PARTITION_URN] = [SOURCE].[MIN_GLOBAL_PARTITION_URN], [TARGET].[MAX_GLOBAL_PARTITION_URN] = [SOURCE].[MAX_GLOBAL_PARTITION_URN];') AS [SQL]
                  FROM      ( SELECT    [ROW_URN],
                                        [PARTITION_TABLE_NAME],
                                        [IS_CLUSTER_RESOURCE_URN],
                                        [IS_CLUSTER_RESOURCE_ID],
                                        [IS_RESOURCE_URN],
                                        [IS_RESOURCE_ID],
                                        [IS_PORTAL_CLUSTER_RESOURCE_ID],
                                        [PORTAL_CLUSTER_RESOURCE_ID],
                                        [IDENTITY_FIELD],
                                        [GLOBAL_IDENTITY_FIELD]
                              FROM      ( SELECT    [ROW_URN],
                                                    [PARTITION_TABLE_NAME],
                                                    [IS_CLUSTER_RESOURCE_URN],
                                                    [IS_CLUSTER_RESOURCE_ID],
                                                    [IS_RESOURCE_URN],
                                                    [IS_RESOURCE_ID],
                                                    [IS_PORTAL_CLUSTER_RESOURCE_ID],
                                                    [PORTAL_CLUSTER_RESOURCE_ID],
                                                    [IDENTITY_FIELD],
                                                    [GLOBAL_IDENTITY_FIELD],
                                                    ROW_NUMBER() OVER ( PARTITION BY [PARTITION_TABLE_NAME] ORDER BY ( SELECT   NULL
                                                                                                                     ) ) AS [RN]
                                          FROM      [##PartitionedTables]
                                          WHERE     ( [IS_CLUSTER_RESOURCE_URN] = 1
                                                      OR [IS_CLUSTER_RESOURCE_ID] = 1
                                                      OR [IS_RESOURCE_URN] = 1
                                                      OR [IS_RESOURCE_ID] = 1
                                                    )
                                                    AND [EXISTS] = 1
                                        ) [a]
                              WHERE     [a].[RN] = 1
                            ) [a]
                ) [SOURCE]
            ON [SOURCE].[ROW_URN] = [TARGET].[ROW_URN]
            WHEN MATCHED THEN
                UPDATE SET
                         [TARGET].[SQL] = [SOURCE].[SQL];
            
            DECLARE @cwaterPartitionTableName NVARCHAR(256),
                @cwaterClusterResourceID UNIQUEIDENTIFIER,
                @cwaterClusterResourceUrn INT,
                @cwaterSQL NVARCHAR(MAX);

            DECLARE [water] CURSOR LOCAL FAST_FORWARD
            FOR
                SELECT  [PARTITION_TABLE_NAME],
                        [CLUSTER_RESOURCE_ID],
                        [CLUSTER_RESOURCE_URN],
                        [SQL]
                FROM    [##PartitionedTables]
                WHERE   NULLIF(LTRIM(RTRIM([SQL])), '') IS NOT NULL
                ORDER BY [ROW_URN];
            OPEN [water];
            FETCH [water] INTO @cwaterPartitionTableName, @cwaterClusterResourceID, @cwaterClusterResourceUrn, @cwaterSQL;
            WHILE ( @@FETCH_STATUS = 0 )
            BEGIN
                EXECUTE [sys].[sp_executesql] @cwaterSQL;

                FETCH [water] INTO @cwaterPartitionTableName, @cwaterClusterResourceID, @cwaterClusterResourceUrn, @cwaterSQL;
            END;
            CLOSE [water];
            DEALLOCATE [water];

            -- Get rid of rows from ##PartitionedTables where there is no data for that Partitioned table
            DELETE  FROM [##PartitionedTables]
            WHERE   [MAX_PARTITION_URN] = 0
                    OR [MIN_PARTITION_URN] = 0;

            -- Update the slice column / keys
            WITH    [CTE]
                      AS ( SELECT   [SLICE_FACT_KEY] AS [SLICE_COLUMN],
                                    [PRIMARY_TABLE] AS [CUBE_VIEW_NAME],
                                    1 AS [PREF]
                           FROM     [dbo].[TB_ADM_OLAP_OBJECT]
                           WHERE    [OLAP_OBJECT_TYPE] = 'C'
                           UNION ALL
                           SELECT   [SLICE_COLUMN],
                                    [CUBE_VIEW_NAME],
                                    2 AS [PREF]
                           FROM     [#NonOLAPSliceColumns]
                         )
                MERGE INTO [##PartitionedTables] [TARGET]
                USING
                    ( SELECT    [a].[SLICE_COLUMN],
                                [a].[CUBE_VIEW_NAME]
                      FROM      [CTE] [a]
                      INNER JOIN ( SELECT   MIN([CTE].[PREF]) AS [PREF],
                                            [CTE].[CUBE_VIEW_NAME]
                                   FROM     [CTE]
                                   GROUP BY [CTE].[CUBE_VIEW_NAME]
                                 ) [b] ON [b].[PREF] = [a].[PREF]
                                          AND [b].[CUBE_VIEW_NAME] = [a].[CUBE_VIEW_NAME]
                    ) [SOURCE]
                ON [TARGET].[CUBE_VIEW_NAME] = [SOURCE].[CUBE_VIEW_NAME]
                WHEN MATCHED THEN
                    UPDATE SET [TARGET].[SLICE_COLUMN] = [SOURCE].[SLICE_COLUMN] ;

            -- If there are any rows in ##PartitionedTables then proceed
            -- Please note that ##PartitionedTables may also have less rows.
            -- This is because of DELETEs that took place in the previous BEGIN END (some Partitioned tables will not have any data)
            IF NOT EXISTS ( SELECT  1
                            FROM    [##PartitionedTables] )
            BEGIN 
                SET @error = -1;
                IF @PartitionTableId IS NOT NULL
                BEGIN 
                    RAISERROR ('The partition table: [%s] of server: [%s] does not have any data. The tidemark information will not be generated. Error [%d]', 16, 1, @PartitionTableName, @ServerName, @error);
                END;
                ELSE
                BEGIN
                    RAISERROR ('The partition tables of server: [%s] does not have any data. The tidemark information will not be generated. Error [%d]', 16, 1, @ServerName, @error);
                END;
            END;
            BEGIN TRANSACTION [ConsOlapTideTransaction];
                
            -------------------------
            -- Tidemark DELETE Starts
            -------------------------
            -- Delete existing records from TB_IMP_FCT_PARTITION_TIDEMARK. Cascade delete applies to TB_IMP_FCT_PARTITION_TIDEMARK_SLICE
            IF @PartitionTableId IS NOT NULL
            BEGIN 
                BEGIN TRY
                    DELETE  [dbo].[TB_IMP_FCT_PARTITION_TIDEMARK]
                    FROM    [dbo].[TB_IMP_FCT_PARTITION_TIDEMARK] AS [ti]
                    INNER JOIN [dbo].[TB_IMP_FCT_PARTITION] [ft] ON [ti].[FACT_PARTITION_ID] = [ft].[FACT_PARTITION_ID]
                    WHERE   [ft].[RESOURCE_INSTANCE_ID] = @v_ResourceInstanceID
                            AND [ft].[FACT_PARTITION_ID] = @PartitionTableId;
                END TRY
                BEGIN CATCH
                    SET @error = @@ERROR;
                    RAISERROR ('Failed to delete records from TB_IMP_FCT_PARTITION_TIDEMARK for partition table name: [%s] of server: [%s]. Error [%d].', 16, 1, @PartitionTableName, @ServerName, @error);
                END CATCH;
            END;
            ELSE
            BEGIN 
                BEGIN TRY;
                    DELETE  [dbo].[TB_IMP_FCT_PARTITION_TIDEMARK]
                    FROM    [dbo].[TB_IMP_FCT_PARTITION_TIDEMARK] AS [ti]
                    INNER JOIN [dbo].[TB_IMP_FCT_PARTITION] [ft] ON [ti].[FACT_PARTITION_ID] = [ft].[FACT_PARTITION_ID]
                    WHERE   [ft].[RESOURCE_INSTANCE_ID] = @v_ResourceInstanceID;
                END TRY
                BEGIN CATCH
                    SET @error = @@ERROR;
                    RAISERROR ('Failed to delete records from TB_IMP_FCT_PARTITION_TIDEMARK for all partition tables of server: [%s]. Error [%d].', 16, 1, @ServerName, @error);
                END CATCH;
            END;

            -------------------------
            -- Tidemark INSERT Starts
            -------------------------
            INSERT  INTO [dbo].[TB_IMP_FCT_PARTITION_TIDEMARK]
                    ( [FACT_PARTITION_ID],
                      [HIGH_WATER_BEFORE],
                      [HIGH_WATER_AFTER],
                      [IMPORT_COMPLETE_DATE],
                      [CLUSTER_RESOURCE_ID],
                      [MIN_GLOBAL_PARTITION_URN],
                      [MAX_GLOBAL_PARTITION_URN]
                    )
            SELECT  [FACT_PARTITION_ID],
                    [MIN_PARTITION_URN],
                    [MAX_PARTITION_URN],
                    GETUTCDATE(),
                    [CLUSTER_RESOURCE_ID],
                    [MIN_GLOBAL_PARTITION_URN],
                    [MAX_GLOBAL_PARTITION_URN]
            FROM    [##PartitionedTables];

            INSERT  INTO [dbo].[TB_IMP_FCT_PARTITION_TIDEMARK_SLICE]
                    ( [PARTITION_TIDEMARK_ID],
                      [SLICE_COLUMN],
                      [SLICE_KEYS]
                    )
            SELECT  [b].[PARTITION_TIDEMARK_ID],
                    [a].[SLICE_COLUMN],
                    [a].[SLICE_KEYS]
            FROM    [##PartitionedTables] [a]
            INNER JOIN [dbo].[TB_IMP_FCT_PARTITION_TIDEMARK] [b] ON [a].[FACT_PARTITION_ID] = [b].[FACT_PARTITION_ID]
                                                                    AND [a].[CLUSTER_RESOURCE_ID] = [b].[CLUSTER_RESOURCE_ID]
            WHERE   NOT EXISTS ( SELECT 1
                                 FROM   [dbo].[TB_IMP_FCT_PARTITION_TIDEMARK_SLICE] [c]
                                 WHERE  [b].[PARTITION_TIDEMARK_ID] = [c].[PARTITION_TIDEMARK_ID]
                                        AND [c].[SLICE_COLUMN] = [a].[SLICE_COLUMN] );

            IF @InitialTransactionCount = 0
            BEGIN 
                COMMIT TRANSACTION [ConsOlapTideTransaction];
            END;
            ELSE
            BEGIN 
                WHILE @@TRANCOUNT > @InitialTransactionCount
                BEGIN 
                    COMMIT TRANSACTION;
                END;
            END;
            IF OBJECT_ID('tempdb..##PartitionedTables') IS NOT NULL
            BEGIN
                DROP TABLE [##PartitionedTables];
            END;
        END TRY
        BEGIN CATCH
            SELECT  @error = CASE WHEN @error IN ( -1, -2 ) THEN @error
                                  ELSE ERROR_NUMBER()
                             END,
                    @ErrorHolder = CASE WHEN @ErrorHolder IS NULL THEN ERROR_MESSAGE()
                                        ELSE @ErrorHolder
                                   END;

            IF @InitialTransactionCount = 0
                AND @@TRANCOUNT > 0
            BEGIN 
                ROLLBACK TRANSACTION;
            END;
            ELSE
                IF @InitialTransactionCount <> 0
                    AND @@TRANCOUNT > @InitialTransactionCount
                BEGIN 
                    IF ( XACT_STATE() ) = -1
                    BEGIN 
                        SET @ErrorMessage = ISNULL(NULLIF(@ErrorMessage, ''), OBJECT_NAME(@@PROCID)) + ' [Uncommittable Transaction!]';
                        ROLLBACK TRANSACTION;
                    -- THIS IS TO AVOID TRANSACTION MISMATCHES IN THE CALLING APPLICATION
                        DECLARE @transactionFake INT = @@TRANCOUNT;
                        WHILE @transactionFake < @InitialTransactionCount
                        BEGIN 
                            BEGIN TRANSACTION;
                            SET @transactionFake = @transactionFake + 1;
                        END;
                    END;
                    ELSE
                    BEGIN 
                        WHILE @@TRANCOUNT > @InitialTransactionCount
                        BEGIN 
                            COMMIT TRANSACTION;
                        END;
                    END;
                END;

            IF @error = 1205
            BEGIN 
                SET @ErrorMessage = OBJECT_NAME(@@PROCID) + ': ' + 'A deadlock occured and this transaction was the deadlock-victim. Error = [%d]';                                  
            END;
            ELSE
            BEGIN 
                SET @ErrorMessage = OBJECT_NAME(@@PROCID) + ': ' + 'An error occured during the tidemark consolidation' + ISNULL(' SQLMessage[' + @ErrorHolder
                                                                                                                                 + '] ', '') + 'SQLError = [%d]';
            END;

            RAISERROR(@ErrorMessage, 16, 1, @error) WITH LOG;
        END CATCH;
        
        RETURN @error;
    END;

-- Grant permissions.
GRANT EXECUTE ON [dbo].[ap_imp01_consolidate_partition_tidemark_data] TO [portalapp_role];
GO
