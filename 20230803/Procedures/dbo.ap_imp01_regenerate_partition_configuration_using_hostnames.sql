SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE PROCEDURE [dbo].[ap_imp01_regenerate_partition_configuration_using_hostnames]
    (
      @FromHostName AS NVARCHAR(200),
      @ToHostName AS NVARCHAR(200)
    )
AS 
------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------
--     ap_imp01_regenerate_partition_configuration_using_hostnames.sql
--     This stored procedure
--     1. Checks the Mediator and OLAP resource instances associated with each of the stored procedure parameters.
--    2. Updates the processed tidemarks in TB_ETL_TIDEMARK with the corresponding written tidemarks for Mediator Resource Instances relating to @FromHostName
--    3. Deletes any processed tidemarks in TB_ETL_TIDEMARK for which there are no written tidemarks for Mediator Resource Instances relating to @FromHostName
--    4. Deletes all entries related to @ToHostName for 
--        Associated tidemark entries in TB_ETL_TIDEMARK 
--        Associated OLAP Map entries in TB_IMP_FCT_OLAP_PARTITION_MAP and TB_IMP_FCT_OLAP_PARTITION
--        TB_IMP_FCT_PARTITION_TIDEMARK_SLICE
--        TB_IMP_FCT_PARTITION_TIDEMARK
--        TB_IMP_FCT_PARTITION
--    5. Recreates (essentially duplicating) @ToHostName entries in the above mentioned tables based on @FromHostName records. 
--       The order in which the records are created is
--           TB_IMP_FCT_PARTITION
--           TB_IMP_FCT_PARTITION_TIDEMARK
--           TB_IMP_FCT_PARTITION_TIDEMARK_SLICE
--           TB_ETL_TIDEMARK
--           TB_IMP_FCT_OLAP_PARTITION
--           TB_IMP_FCT_OLAP_PARTITION_MAP
--    6. Reset seed value and database table identities
------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------
    BEGIN
        SET NOCOUNT ON;
        BEGIN TRY
            DECLARE @error INT = 0,
                @InitialTransactionCount INT = @@TRANCOUNT,
                @ErrorMessage NVARCHAR(2000) = N'',
                @ErrorHolder NVARCHAR(2000),
                @v_PortalDBComponentType NVARCHAR(100) = 'CT_EXONY_RELATIONAL_DB_DEFAULT',
                @v_PortalOLAPDBComponentType NVARCHAR(100) = 'CT_EXONY_OLAP_DB_CORE',
                @v_PortalOLAPProcessorComponentType NVARCHAR(100) = 'CT_EXONY_OLAP_PROCESSOR_DEFAULT',
                @v_PortalMediatorComponentType NVARCHAR(100) = 'CT_EXONY_MEDIATOR_DEFAULT',
                @v_FromResourceInstanceID UNIQUEIDENTIFIER,
                @v_ToResourceInstanceID UNIQUEIDENTIFIER;

            ---------------------------------------------------------------------
            -- Get RDBMS resource instance IDs for @FromHostName and @ToHostName.
            ---------------------------------------------------------------------
            SELECT  @v_FromResourceInstanceID = MAX(CASE WHEN [s].[SERVER_NAME] = @FromHostName THEN [ri].[RESOURCE_INSTANCE_ID]
                                                         ELSE NULL
                                                    END),
                    @v_ToResourceInstanceID = MAX(CASE WHEN [s].[SERVER_NAME] = @ToHostName THEN [ri].[RESOURCE_INSTANCE_ID]
                                                       ELSE NULL
                                                  END)
            FROM    [dbo].[TB_CLU_RESOURCE_INSTANCE] AS [ri]
            INNER JOIN [dbo].[TB_CLU_RESOURCE_INSTANCE_COMPONENT] AS [co] ON [ri].[RESOURCE_INSTANCE_ID] = [co].[RESOURCE_INSTANCE_ID]
            INNER JOIN [dbo].[TE_CLU_RESOURCE_INSTANCE_COMPONENT_TYPE] AS [ct] ON [co].[COMPONENT_TYPE_ID] = [ct].[COMPONENT_TYPE_ID]
            INNER JOIN [dbo].[TB_CLU_SERVER] AS [s] ON [co].[SERVER_ID] = [s].[SERVER_ID]
            WHERE   [ct].[INTERNAL_NAME] = @v_PortalDBComponentType
                    AND [s].[SERVER_NAME] IN ( @FromHostName, @ToHostName );

            -- Check if the Resource Instance IDs have been found to proceed further
            IF ( @v_FromResourceInstanceID IS NULL
                 OR @v_ToResourceInstanceID IS NULL
               )
            BEGIN 
                IF ( @v_FromResourceInstanceID IS NULL )
                BEGIN 
                    SET @error = -1;
                    RAISERROR ('Resource Instance Id of Host Name in the FIRST parameter not found. Please check the Host Name: [%s] exists. Error [%d]', 16, 1, @FromHostName, @error);
                END;

                IF ( @v_ToResourceInstanceID IS NULL )
                BEGIN 
                    SET @error = -1;
                    RAISERROR ('Resource Instance Id of Host Name in the SECOND parameter not found. Please check the Host Name: [%s] exists. Error [%d]', 16, 1, @ToHostName, @error);
                END;
            END;

            ------------------------------------------------------------------------
            -- Get Mediator resource instance IDs for @FromHostName and @ToHostName.
            ------------------------------------------------------------------------
            IF OBJECT_ID('tempdb..#MediatorResourceInstances') IS NOT NULL
            BEGIN
                DROP TABLE [#MediatorResourceInstances];
            END;

            SELECT  IDENTITY( INT,1,1 ) AS [ROW_URN],
                    [riSource].[RESOURCE_INSTANCE_ID] AS [FROM_MEDIATOR_RESOURCE_INSTANCE_ID],
                    [riTarget].[RESOURCE_INSTANCE_ID] AS [TO_MEDIATOR_RESOURCE_INSTANCE_ID]
            INTO    [#MediatorResourceInstances]
            FROM    [dbo].[TB_CLU_RESOURCE_INSTANCE] [riSource]
            INNER JOIN [dbo].[TB_CLU_RESOURCE_INSTANCE_COMPONENT] [compSource] ON [riSource].[RESOURCE_INSTANCE_ID] = [compSource].[RESOURCE_INSTANCE_ID]
            INNER JOIN [dbo].[TE_CLU_RESOURCE_INSTANCE_COMPONENT_TYPE] [compSourceType] ON [compSource].[COMPONENT_TYPE_ID] = [compSourceType].[COMPONENT_TYPE_ID]
            INNER JOIN [dbo].[TB_CLU_CONNECTION] AS [conn] ON [conn].[SOURCE_COMPONENT_ID] = [compSource].[COMPONENT_ID]
            INNER JOIN [dbo].[TB_CLU_RESOURCE_INSTANCE_COMPONENT] [compSink] ON [conn].[SINK_COMPONENT_ID] = [compSink].[COMPONENT_ID]
            INNER JOIN [dbo].[TE_CLU_RESOURCE_INSTANCE_COMPONENT_TYPE] [compSinkType] ON [compSink].[COMPONENT_TYPE_ID] = [compSinkType].[COMPONENT_TYPE_ID]
            INNER JOIN [dbo].[TB_CLU_RESOURCE_INSTANCE] [riSink] ON [compSink].[RESOURCE_INSTANCE_ID] = [riSink].[RESOURCE_INSTANCE_ID]
            INNER JOIN [dbo].[TB_CLU_SERVER] AS [s] ON [compSink].[SERVER_ID] = [s].[SERVER_ID]
            LEFT OUTER JOIN [dbo].[TB_CLU_RESOURCE_INSTANCE] [riTarget] ON [riTarget].[RESOURCE_ID] = [riSource].[RESOURCE_ID]
                                                                           AND [riTarget].[RESOURCE_INSTANCE_ID] <> [riSource].[RESOURCE_INSTANCE_ID]
            WHERE   [compSourceType].[INTERNAL_NAME] = @v_PortalMediatorComponentType
                    AND [compSinkType].[INTERNAL_NAME] = @v_PortalDBComponentType
                    AND [s].[SERVER_NAME] = @FromHostName;

            -- Check if the Mediator Resource Instance IDs have been found to proceed further
            IF NOT EXISTS ( SELECT  1
                            FROM    [#MediatorResourceInstances] )
            BEGIN
                SET @error = -1;
                RAISERROR ('Mediator Resource Instance Id linked to RDBMS Host Name in the FIRST parameter not found. Please check if the Mediator Resource Instance for: [%s] exists. Error [%d]', 16, 1, @FromHostName, @error);
            END;
            IF EXISTS ( SELECT  1
                        FROM    [#MediatorResourceInstances]
                        WHERE   [TO_MEDIATOR_RESOURCE_INSTANCE_ID] IS NULL )
            BEGIN
                SET @error = -1;
                RAISERROR ('Mediator Resource Instance Id linked to RDBMS Host Name in the SECOND parameter not found. Please check if the Mediator Resource Instance for: [%s] exists. Error [%d]', 16, 1, @ToHostName, @error);
            END;

            --------------------------------------------------------------------
            -- Get OLAP resource instance IDs for @FromHostName and @ToHostName.
            --------------------------------------------------------------------
            IF OBJECT_ID('tempdb..#OLAPResourceInstances') IS NOT NULL
            BEGIN
                DROP TABLE [#OLAPResourceInstances];
            END;

            SELECT  IDENTITY( INT,1,1 ) AS [ROW_URN],
                    [riCentral].[RESOURCE_INSTANCE_ID] AS [FROM_OLAP_RESOURCE_INSTANCE_ID],
                    [ri2].[RESOURCE_INSTANCE_ID] AS [TO_OLAP_RESOURCE_INSTANCE_ID]
            INTO    [#OLAPResourceInstances]
            FROM    [dbo].[TB_CLU_RESOURCE_INSTANCE] [riSource]
            INNER JOIN [dbo].[TB_CLU_RESOURCE_INSTANCE_COMPONENT] [compSource] ON [riSource].[RESOURCE_INSTANCE_ID] = [compSource].[RESOURCE_INSTANCE_ID]
            INNER JOIN [dbo].[TE_CLU_RESOURCE_INSTANCE_COMPONENT_TYPE] [compSourceType] ON [compSource].[COMPONENT_TYPE_ID] = [compSourceType].[COMPONENT_TYPE_ID]
            INNER JOIN [dbo].[TB_CLU_CONNECTION] AS [conn] ON [conn].[SOURCE_COMPONENT_ID] = [compSource].[COMPONENT_ID]
            INNER JOIN [dbo].[TB_CLU_RESOURCE_INSTANCE_COMPONENT] [compCentral] ON [conn].[SINK_COMPONENT_ID] = [compCentral].[COMPONENT_ID]
            INNER JOIN [dbo].[TE_CLU_RESOURCE_INSTANCE_COMPONENT_TYPE] [compCentralType] ON [compCentral].[COMPONENT_TYPE_ID] = [compCentralType].[COMPONENT_TYPE_ID]
            INNER JOIN [dbo].[TB_CLU_RESOURCE_INSTANCE] [riCentral] ON [compCentral].[RESOURCE_INSTANCE_ID] = [riCentral].[RESOURCE_INSTANCE_ID]
            INNER JOIN [dbo].[TB_CLU_CONNECTION] AS [conn2] ON [conn2].[SOURCE_COMPONENT_ID] = [compSource].[COMPONENT_ID]
            INNER JOIN [dbo].[TB_CLU_RESOURCE_INSTANCE_COMPONENT] [compSink] ON [conn2].[SINK_COMPONENT_ID] = [compSink].[COMPONENT_ID]
            INNER JOIN [dbo].[TE_CLU_RESOURCE_INSTANCE_COMPONENT_TYPE] [compSinkType] ON [compSink].[COMPONENT_TYPE_ID] = [compSinkType].[COMPONENT_TYPE_ID]
            INNER JOIN [dbo].[TB_CLU_RESOURCE_INSTANCE] [riSink] ON [compSink].[RESOURCE_INSTANCE_ID] = [riSink].[RESOURCE_INSTANCE_ID]
            INNER JOIN [dbo].[TB_CLU_SERVER] AS [s] ON [compSink].[SERVER_ID] = [s].[SERVER_ID]
            LEFT OUTER JOIN [dbo].[TB_CLU_RESOURCE_INSTANCE] [ri2] ON [ri2].[RESOURCE_ID] = [riCentral].[RESOURCE_ID]
                                                                      AND [riCentral].[RESOURCE_INSTANCE_ID] <> [ri2].[RESOURCE_INSTANCE_ID]
            WHERE   [compSourceType].[INTERNAL_NAME] = @v_PortalOLAPProcessorComponentType
                    AND [compCentralType].[INTERNAL_NAME] = @v_PortalOLAPDBComponentType
                    AND [compSinkType].[INTERNAL_NAME] = @v_PortalDBComponentType
                    AND [s].[SERVER_NAME] = @FromHostName;

            -- Check if the OLAP Resource Instance IDs have been found to proceed further
            IF NOT EXISTS ( SELECT  1
                            FROM    [#OLAPResourceInstances] )
            BEGIN
                SET @error = -1;
                RAISERROR ('OLAP Resource Instance Id linked to RDBMS Host Name in the FIRST parameter not found. Please check if the OLAP Resource Instance for: [%s] exists. Error [%d]', 16, 1, @FromHostName, @error);
            END;
            IF EXISTS ( SELECT  1
                        FROM    [#OLAPResourceInstances]
                        WHERE   [TO_OLAP_RESOURCE_INSTANCE_ID] IS NULL )
            BEGIN
                SET @error = -1;
                RAISERROR ('OLAP Resource Instance Id linked to RDBMS Host Name in the SECOND parameter not found. Please check if the OLAP Resource Instance for: [%s] exists. Error [%d]', 16, 1, @ToHostName, @error);
            END;

            ----------------------------------
            -- RECOVERY START
            ----------------------------------
            BEGIN TRANSACTION [RegenHostTransaction];
            -------------------------------------------
            -- Mediator Resource Instance DELETE Starts
            -------------------------------------------
            -- Update the processed tidemarks in TB_ETL_TIDEMARK with the corresponding written tidemarks for From Mediator Resource Instances
            BEGIN TRY
                UPDATE  [dbo].[TB_ETL_TIDEMARK]
                    SET [TIDEMARK_VALUE1] = IsNull([pr].[TIDEMARK_VALUE1],[wr].[TIDEMARK_VALUE1]),
                        [TIDEMARK_VALUE2] = IsNull([pr].[TIDEMARK_VALUE2],[wr].[TIDEMARK_VALUE2]),
                        [TIDEMARK_VALUE3] = IsNull([pr].[TIDEMARK_VALUE3],[wr].[TIDEMARK_VALUE3]),
                        [TIDEMARK_VALUE4] = IsNull([pr].[TIDEMARK_VALUE4],[wr].[TIDEMARK_VALUE4])
                FROM    [dbo].[TB_ETL_TIDEMARK] AS [pr]
                INNER JOIN ( SELECT [COMPONENT_ID],
                                    [MEDIATOR_RESOURCE_INSTANCE_ID],
                                    [CLUSTER_RESOURCE_ID],
                                    [TIDEMARK_NAME],
                                    [TIDEMARK_TYPE],
                                    [TIDEMARK_VALUE1],
                                    [TIDEMARK_VALUE2],
                                    [TIDEMARK_VALUE3],
                                    [TIDEMARK_VALUE4]
                             FROM   [dbo].[TB_ETL_TIDEMARK]
                           ) AS [wr] ON [pr].[COMPONENT_ID] = [wr].[COMPONENT_ID]
                                        AND [pr].[MEDIATOR_RESOURCE_INSTANCE_ID] = [wr].[MEDIATOR_RESOURCE_INSTANCE_ID]
                                        AND [pr].[CLUSTER_RESOURCE_ID] = [wr].[CLUSTER_RESOURCE_ID]
                                        AND [pr].[TIDEMARK_NAME] = [wr].[TIDEMARK_NAME]
                INNER JOIN [#MediatorResourceInstances] [m] ON [pr].[MEDIATOR_RESOURCE_INSTANCE_ID] = [m].[FROM_MEDIATOR_RESOURCE_INSTANCE_ID]
                WHERE   [pr].[TIDEMARK_TYPE] = 'P'
                        AND [wr].[TIDEMARK_TYPE] = 'W';
            END TRY
            BEGIN CATCH;
                SET @error = @@ERROR;
                RAISERROR ('Failed to update processed tidemarks in TB_ETL_TIDEMARK with the corresponding written tidemarks for Mediator Resource Instance Ids. Error [%d].', 16, 1, @error);
            END CATCH;
            -- Delete any processed tidemarks in TB_ETL_TIDEMARK for which there are no written tidemarks for From Mediator Resource Instances
            BEGIN TRY
                DELETE  [dbo].[TB_ETL_TIDEMARK]
                WHERE   [TIDEMARK_ID] IN (
                        SELECT  [pr].[TIDEMARK_ID]
                        FROM    [dbo].[TB_ETL_TIDEMARK] AS [pr]
                        INNER JOIN [#MediatorResourceInstances] [m] ON [pr].[MEDIATOR_RESOURCE_INSTANCE_ID] = [m].[FROM_MEDIATOR_RESOURCE_INSTANCE_ID]
                        WHERE   [pr].[TIDEMARK_TYPE] = 'P'
                                AND NOT EXISTS ( SELECT *
                                                 FROM   [dbo].[TB_ETL_TIDEMARK] AS [wr]
                                                 WHERE  [pr].[COMPONENT_ID] = [wr].[COMPONENT_ID]
                                                        AND [pr].[CLUSTER_RESOURCE_ID] = [wr].[CLUSTER_RESOURCE_ID]
                                                        AND [pr].[TIDEMARK_NAME] = [wr].[TIDEMARK_NAME]
                                                        AND [pr].[MEDIATOR_RESOURCE_INSTANCE_ID] = [wr].[MEDIATOR_RESOURCE_INSTANCE_ID]
                                                        AND [wr].[TIDEMARK_TYPE] = 'W' ) );
            END TRY
            BEGIN CATCH;
                SET @error = @@ERROR;
                RAISERROR ('Failed to delete processed tidemarks in TB_ETL_TIDEMARK for which there are no written tidemarks corresponding to Mediator Resource Instance Ids. Error [%d].', 16, 1, @error);
            END CATCH;
            -- Delete tridmark entries in TB_ETL_TIDEMARK for Mediator Resource Instance linked to @ToHostName
            BEGIN TRY
                DELETE  [dbo].[TB_ETL_TIDEMARK]
                FROM    [dbo].[TB_ETL_TIDEMARK] [t]
                INNER JOIN [#MediatorResourceInstances] [m] ON [t].[MEDIATOR_RESOURCE_INSTANCE_ID] = [m].[TO_MEDIATOR_RESOURCE_INSTANCE_ID];
            END TRY
            BEGIN CATCH;
                SET @error = @@ERROR;
                RAISERROR ('Failed to delete record from TB_ETL_TIDEMARK for Mediator Resource Instance Ids linked to RDBMS Host Name [%s]. Error [%d].', 16, 1, @ToHostName, @error);
            END CATCH;
            ---------------------------------------
            -- OLAP Resource Instance DELETE Starts
            ---------------------------------------
            -- Delete OLAP Partition Map entries in TB_IMP_FCT_OLAP_PARTITION_MAP for OLAP Server's Resource Instance linked to @ToHostName
            BEGIN TRY
                DELETE  [dbo].[TB_IMP_FCT_OLAP_PARTITION_MAP]
                FROM    [dbo].[TB_IMP_FCT_OLAP_PARTITION_MAP] [pm]
                INNER JOIN [dbo].[TB_IMP_FCT_OLAP_PARTITION] [op] ON [pm].[OLAP_PARTITION_ID] = [op].[OLAP_PARTITION_ID]
                INNER JOIN [#OLAPResourceInstances] [ri] ON [op].[RESOURCE_INSTANCE_ID] = [ri].[TO_OLAP_RESOURCE_INSTANCE_ID];
            END TRY
            BEGIN CATCH;
                SET @error = @@ERROR;
                RAISERROR ('Failed to delete record from TB_IMP_FCT_OLAP_PARTITION_MAP for OLAP Server Resource Instance Ids linked to RDBMS Host Name [%s]. Error [%d].', 16, 1, @ToHostName, @error);
            END CATCH;
            -- Delete OLAP Partition entries in TB_IMP_FCT_OLAP_PARTITION for OLAP Server's Resource Instance linked to @ToHostName
            BEGIN TRY
                DELETE  [dbo].[TB_IMP_FCT_OLAP_PARTITION]
                FROM    [dbo].[TB_IMP_FCT_OLAP_PARTITION] [op]
                INNER JOIN [#OLAPResourceInstances] [ri] ON [op].[RESOURCE_INSTANCE_ID] = [ri].[TO_OLAP_RESOURCE_INSTANCE_ID];
            END TRY
            BEGIN CATCH;
                SET @error = @@ERROR;
                RAISERROR ('Failed to delete record from TB_IMP_FCT_OLAP_PARTITION for OLAP Server Resource Instance Ids linked to RDBMS Host Name [%s]. Error [%d].', 16, 1, @ToHostName, @error);
            END CATCH;
            ----------------------------------------
            -- RDBMS Resource Instance DELETE Starts
            ----------------------------------------
            -- Delete @ToHostName FACT PARTITIONS. Cascade delete applies to TIDEMARK and TIDEMARK SLICE.
            BEGIN TRY
                DELETE  [dbo].[TB_IMP_FCT_PARTITION]
                WHERE   [RESOURCE_INSTANCE_ID] = @v_ToResourceInstanceID;
            END TRY
            BEGIN CATCH;
                SET @error = @@ERROR;
                RAISERROR ('Failed to delete record from TB_IMP_FCT_PARTITION (Cascade delete applied to TB_IMP_FCT_PARTITION_TIDEMARK and TB_IMP_FCT_PARTITION_TIDEMARK_SLICE) for RDBMS Host Name [%s]. Error [%d]', 16, 1, @ToHostName, @error);
            END CATCH;
            -------------------------------------------------
            -- RDBMS Resource Instance Recovery INSERT Starts
            -------------------------------------------------
            BEGIN TRY
                -- Insert Fact Partition records in TB_IMP_FCT_PARTITION for @ToHostName. (Duplicating @FromHostName Fact Partition records on @ToHostName)
                INSERT  INTO [dbo].[TB_IMP_FCT_PARTITION]
                        ( [RESOURCE_INSTANCE_ID],
                          [PARTITION_ID],
                          [PARTITION_TABLE_NAME],
                          [START_DATE_TIME],
                          [END_DATE_TIME],
                          [ONLINE_DATE],
                          [OFFLINE_DATE],
                          [DROP_DATE],
                          [NEXT_AVAILABLE_IDENTITY],
                          [FACT_PARTITION_METADATA_ID]
                        )
                SELECT  @v_ToResourceInstanceID,
                        [PARTITION_ID],
                        [PARTITION_TABLE_NAME],
                        [START_DATE_TIME],
                        [END_DATE_TIME],
                        [ONLINE_DATE],
                        [OFFLINE_DATE],
                        [DROP_DATE],
                        [NEXT_AVAILABLE_IDENTITY],
                        [FACT_PARTITION_METADATA_ID]
                FROM    [dbo].[TB_IMP_FCT_PARTITION]
                WHERE   [RESOURCE_INSTANCE_ID] = @v_FromResourceInstanceID;
            END TRY
            BEGIN CATCH;
                SET @error = @@ERROR;
                RAISERROR ('Failed to insert record into TB_IMP_FCT_PARTITION for RDBMS Host Name [%s]. Error [%d]', 16, 1, @ToHostName, @error);
            END CATCH;
            -- Insert Tidemark records in TB_IMP_FCT_PARTITION_TIDEMARK for @ToHostName
            BEGIN TRY
                INSERT  INTO [dbo].[TB_IMP_FCT_PARTITION_TIDEMARK]
                        ( [FACT_PARTITION_ID],
                          [HIGH_WATER_BEFORE],
                          [HIGH_WATER_AFTER],
                          [MIN_GLOBAL_PARTITION_URN],
                          [MAX_GLOBAL_PARTITION_URN]
                        )
                SELECT  [a].[SUBSCRIBER_PARTITION_ID],
                        [pt].[HIGH_WATER_BEFORE],
                        [pt].[HIGH_WATER_AFTER],
                        [pt].[MIN_GLOBAL_PARTITION_URN],
                        [pt].[MAX_GLOBAL_PARTITION_URN]
                FROM    [dbo].[TB_IMP_FCT_PARTITION_TIDEMARK] [pt]
                INNER JOIN ( SELECT [p1].[FACT_PARTITION_ID],
                                    [p2].[FACT_PARTITION_ID]
                             FROM   [dbo].[TB_IMP_FCT_PARTITION] [p1]
                             INNER JOIN [dbo].[TB_IMP_FCT_PARTITION] [p2] ON [p2].[PARTITION_ID] = [p1].[PARTITION_ID]
                                                                             AND [p2].[FACT_PARTITION_METADATA_ID] = [p1].[FACT_PARTITION_METADATA_ID]
                             WHERE  [p1].[RESOURCE_INSTANCE_ID] = @v_FromResourceInstanceID
                                    AND [p2].[RESOURCE_INSTANCE_ID] = @v_ToResourceInstanceID
                           ) [a] ( [PUBLISHER_PARTITION_ID], [SUBSCRIBER_PARTITION_ID] ) ON [a].[PUBLISHER_PARTITION_ID] = [pt].[FACT_PARTITION_ID];
            END TRY
            BEGIN CATCH;
                SET @error = @@ERROR;
                RAISERROR ('Failed to insert record into TB_IMP_FCT_PARTITION_TIDEMARK for RDBMS Host Name [%s]. Error [%d]', 16, 1, @ToHostName, @error);
            END CATCH;
            -- Insert Tidemark Slice records in TB_IMP_FCT_PARTITION_TIDEMARK_SLICE for @ToHostName
            BEGIN TRY
                INSERT  INTO [dbo].[TB_IMP_FCT_PARTITION_TIDEMARK_SLICE]
                        ( [PARTITION_TIDEMARK_ID],
                          [SLICE_COLUMN],
                          [SLICE_KEYS]
                        )
                SELECT  [b].[SUBSCRIBER_PARTITION_TIDEMARK_ID],
                        [pts].[SLICE_COLUMN],
                        [pts].[SLICE_KEYS]
                FROM    [dbo].[TB_IMP_FCT_PARTITION_TIDEMARK_SLICE] [pts]
                INNER JOIN ( SELECT [pt1].[PARTITION_TIDEMARK_ID],
                                    [pt2].[PARTITION_TIDEMARK_ID]
                             FROM   [dbo].[TB_IMP_FCT_PARTITION] [p1]
                             INNER JOIN [dbo].[TB_IMP_FCT_PARTITION] [p2] ON [p2].[PARTITION_ID] = [p1].[PARTITION_ID]
                                                                             AND [p2].[FACT_PARTITION_METADATA_ID] = [p1].[FACT_PARTITION_METADATA_ID]
                             INNER JOIN [dbo].[TB_IMP_FCT_PARTITION_TIDEMARK] [pt1] ON [pt1].[FACT_PARTITION_ID] = [p1].[FACT_PARTITION_ID]
                             INNER JOIN [dbo].[TB_IMP_FCT_PARTITION_TIDEMARK] [pt2] ON [pt2].[FACT_PARTITION_ID] = [p2].[FACT_PARTITION_ID]
                             WHERE  [p1].[RESOURCE_INSTANCE_ID] = @v_FromResourceInstanceID
                                    AND [p2].[RESOURCE_INSTANCE_ID] = @v_ToResourceInstanceID
                           ) [b] ( [PUBLISHER_PARTITION_TIDEMARK_ID], [SUBSCRIBER_PARTITION_TIDEMARK_ID] ) ON [b].[PUBLISHER_PARTITION_TIDEMARK_ID] = [pts].[PARTITION_TIDEMARK_ID];
            END TRY
            BEGIN CATCH;
                SET @error = @@ERROR;
                RAISERROR ('Failed to insert record into TB_IMP_FCT_PARTITION_TIDEMARK_SLICE for RDBMS Host Name [%s]. Error [%d]', 16, 1, @ToHostName, @error);
            END CATCH;
            -----------------------------------------------------
            -- Mediator Resource Instance Recovery INSERTS Starts
            -----------------------------------------------------
            -- Insert Mediator Tidemark records in TB_ETL_TIDEMARK for Mediator Resource Instance linked to @ToHostName
            BEGIN TRY
                INSERT  INTO [dbo].[TB_ETL_TIDEMARK]
                        ( [MEDIATOR_RESOURCE_INSTANCE_ID],
                          [COMPONENT_ID],
                          [CLUSTER_RESOURCE_ID],
                          [TIDEMARK_TYPE],
                          [TIDEMARK_NAME],
                          [TIDEMARK_VALUE1],
                          [TIDEMARK_VALUE2],
                          [TIDEMARK_VALUE3],
                          [TIDEMARK_VALUE4],
                          [DATE_TIME]
                        )
                SELECT  [m].[TO_MEDIATOR_RESOURCE_INSTANCE_ID],
                        [t].[COMPONENT_ID],
                        [t].[CLUSTER_RESOURCE_ID],
                        [t].[TIDEMARK_TYPE],
                        [t].[TIDEMARK_NAME],
                        [t].[TIDEMARK_VALUE1],
                        [t].[TIDEMARK_VALUE2],
                        [t].[TIDEMARK_VALUE3],
                        [t].[TIDEMARK_VALUE4],
                        [t].[DATE_TIME]
                FROM    [dbo].[TB_ETL_TIDEMARK] [t]
                INNER JOIN [#MediatorResourceInstances] [m] ON [t].[MEDIATOR_RESOURCE_INSTANCE_ID] = [m].[FROM_MEDIATOR_RESOURCE_INSTANCE_ID];
            END TRY
            BEGIN CATCH;
                SET @error = @@ERROR;
                RAISERROR ('Failed to insert record into TB_ETL_TIDEMARK for Mediator Resource Instance Ids linked to RDBMS Host Name [%s]. Error [%d].', 16, 1, @ToHostName, @error);
            END CATCH;
            -------------------------------------------------
            -- OLAP Resource Instance Recovery INSERTS Starts
            -------------------------------------------------
            -- Insert OLAP Partition records in TB_IMP_FCT_OLAP_PARTITION for OLAP Resource Instance linked to @ToHostName
            BEGIN TRY
                INSERT  INTO [dbo].[TB_IMP_FCT_OLAP_PARTITION]
                        ( [RESOURCE_INSTANCE_ID],
                          [OLAP_OBJECT_URN],
                          [OLAP_PARTITION_NAME],
                          [STATUS]
                        )
                SELECT  [ri].[TO_OLAP_RESOURCE_INSTANCE_ID],
                        [op].[OLAP_OBJECT_URN],
                        [op].[OLAP_PARTITION_NAME],
                        [op].[STATUS]
                FROM    [dbo].[TB_IMP_FCT_OLAP_PARTITION] [op]
                INNER JOIN [#OLAPResourceInstances] [ri] ON [op].[RESOURCE_INSTANCE_ID] = [ri].[FROM_OLAP_RESOURCE_INSTANCE_ID];
            END TRY
            BEGIN CATCH;
                SET @error = @@ERROR;
                RAISERROR ('Failed to insert record into TB_IMP_FCT_OLAP_PARTITION for OLAP Server Resource Instance Ids linked to RDBMS Host Name [%s]. Error [%d].', 16, 1, @ToHostName, @error);
            END CATCH;
            -----------------------------------------------------------------------------------------------------------------    
            -- Finally Insert OLAP Partition records in TB_IMP_FCT_OLAP_PARTITION_MAP for OLAP Resource Instance linked to @ToHostName
            BEGIN TRY
                INSERT  INTO [dbo].[TB_IMP_FCT_OLAP_PARTITION_MAP]
                        ( [FACT_PARTITION_ID],
                          [LAST_HIGH_WATER],
                          [OLAP_PARTITION_ID]
                        )
                SELECT  [f].[SUBSCRIBER_PARTITION_ID],
                        [m].[LAST_HIGH_WATER],
                        [o].[SUBSCRIBER_OLAP_PARTITION_ID]
                FROM    [dbo].[TB_IMP_FCT_OLAP_PARTITION_MAP] [m]
                INNER JOIN ( SELECT [p1].[FACT_PARTITION_ID],
                                    [p2].[FACT_PARTITION_ID]
                             FROM   [dbo].[TB_IMP_FCT_PARTITION] [p1]
                             INNER JOIN [dbo].[TB_IMP_FCT_PARTITION] [p2] ON [p2].[PARTITION_ID] = [p1].[PARTITION_ID]
                                                                             AND [p2].[FACT_PARTITION_METADATA_ID] = [p1].[FACT_PARTITION_METADATA_ID]
                             WHERE  [p1].[RESOURCE_INSTANCE_ID] = @v_FromResourceInstanceID
                                    AND [p2].[RESOURCE_INSTANCE_ID] = @v_ToResourceInstanceID
                           ) [f] ( [PUBLISHER_PARTITION_ID], [SUBSCRIBER_PARTITION_ID] ) ON [m].[FACT_PARTITION_ID] = [f].[PUBLISHER_PARTITION_ID]
                INNER JOIN ( SELECT [o1].[OLAP_PARTITION_ID],
                                    [o2].[OLAP_PARTITION_ID]
                             FROM   [dbo].[TB_IMP_FCT_OLAP_PARTITION] [o1]
                             INNER JOIN [dbo].[TB_IMP_FCT_OLAP_PARTITION] [o2] ON [o2].[OLAP_OBJECT_URN] = [o1].[OLAP_OBJECT_URN]
                                                                                  AND [o2].[OLAP_PARTITION_NAME] = [o1].[OLAP_PARTITION_NAME]
                             INNER JOIN [#OLAPResourceInstances] [r1] ON [o1].[RESOURCE_INSTANCE_ID] = [r1].[FROM_OLAP_RESOURCE_INSTANCE_ID]
                             INNER JOIN [#OLAPResourceInstances] [r2] ON [o2].[RESOURCE_INSTANCE_ID] = [r2].[TO_OLAP_RESOURCE_INSTANCE_ID]
                           ) [o] ( [PUBLISHER_OLAP_PARTITION_ID], [SUBSCRIBER_OLAP_PARTITION_ID] ) ON [m].[OLAP_PARTITION_ID] = [o].[PUBLISHER_OLAP_PARTITION_ID];
            END TRY
            BEGIN CATCH;
                SET @error = @@ERROR;
                RAISERROR ('Failed to insert record into TB_IMP_FCT_OLAP_PARTITION_MAP for OLAP Server Resource Instance Ids linked to RDBMS Host Name [%s]. Error [%d].', 16, 1, @ToHostName, @error);
            END CATCH;
            -------------------------------------------------
            -- Reseed Identities
            -------------------------------------------------
            -- Reset seed value
            BEGIN TRY
                UPDATE  [dbo].[TB_ADM_SEED]
                SET     [SEED] = 1;
            END TRY
            BEGIN CATCH;
                SET @error = @@ERROR;
                RAISERROR ('Failed to updated SEED value in TB_ADM_SEED for RDBMS Host Name [%s]. Error [%d].', 16, 1, @FromHostName, @error);
            END CATCH;
            -----------------------------------------------------------------------------------------------------------------
            -- Reset database table identities
            BEGIN TRY
                EXEC [dbo].[ap_adm01_reseed_table];
            END TRY
            BEGIN CATCH;
                SET @error = @@ERROR;
                RAISERROR ('Failed to reset database table identities for Host Name [%s]. Error [%d].', 16, 1, @FromHostName, @error);
            END CATCH;
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
GO
GRANT EXECUTE
	ON [dbo].[ap_imp01_regenerate_partition_configuration_using_hostnames]
	TO [portalapp_role]
GO
