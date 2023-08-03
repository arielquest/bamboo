SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_SUM_IVR_APPLICATION_DAILY] (
		[PARTITION_URN]                      [int] NOT NULL,
		[PARTITION_GLOBAL_URN]               [bigint] NOT NULL,
		[PARTITION_ID]                       [int] NOT NULL,
		[DATE_URN]                           [int] NOT NULL,
		[TIME_URN]                           [int] NOT NULL,
		[DATE_TIME]                          [datetime] NOT NULL,
		[IVR_SCRIPT_URN]                     [int] NOT NULL,
		[SOURCE_IVR_SCRIPT_URN]              [int] NOT NULL,
		[IVR_SCRIPT_NODE_URN]                [int] NOT NULL,
		[IVR_SCRIPT_NODE_EXIT_STATE_URN]     [int] NOT NULL,
		[APPLICATION_NAME]                   [nvarchar](51) COLLATE Latin1_General_CI_AS NULL,
		[ELEMENT_TYPE_CODE_URN]              [int] NOT NULL,
		[RESULT_CODE_URN]                    [int] NULL,
		[CAUSE_CODE_URN]                     [int] NOT NULL,
		[SOURCE_APPLICATION_NAME]            [nvarchar](51) COLLATE Latin1_General_CI_AS NULL,
		[SCRIPT_ELEMENT_NAME]                [nvarchar](51) COLLATE Latin1_General_CI_AS NOT NULL,
		[EXIT_STATE]                         [nvarchar](51) COLLATE Latin1_General_CI_AS NULL,
		[OCCURRENCE]                         [int] NULL,
		[AVG_ELAPSED]                        [int] NULL,
		[CLUSTER_RESOURCE_URN]               [int] NOT NULL,
		[CUSTOM_DIMENSION_0]                 [int] NOT NULL,
		[CUSTOM_DIMENSION_1]                 [int] NOT NULL,
		[CUSTOM_DIMENSION_2]                 [int] NOT NULL,
		[CUSTOM_DIMENSION_3]                 [int] NOT NULL,
		[CUSTOM_DIMENSION_4]                 [int] NOT NULL,
		[CUSTOM_DIMENSION_5]                 [int] NOT NULL,
		[CUSTOM_DIMENSION_6]                 [int] NOT NULL,
		[CUSTOM_DIMENSION_7]                 [int] NOT NULL,
		[CUSTOM_DIMENSION_8]                 [int] NOT NULL,
		[CUSTOM_DIMENSION_9]                 [int] NOT NULL,
		[CUSTOM_MEASURE_0]                   [int] NULL,
		[CUSTOM_MEASURE_1]                   [int] NULL,
		[CUSTOM_MEASURE_2]                   [int] NULL,
		[CUSTOM_MEASURE_3]                   [int] NULL,
		[CUSTOM_MEASURE_4]                   [int] NULL,
		[CUSTOM_MEASURE_5]                   [int] NULL,
		[CUSTOM_MEASURE_6]                   [int] NULL,
		[CUSTOM_MEASURE_7]                   [int] NULL,
		[CUSTOM_MEASURE_8]                   [int] NULL,
		[CUSTOM_MEASURE_9]                   [int] NULL,
		[TIDEMARK_VALUE1]                    [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
		[TIDEMARK_VALUE2]                    [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
		[TIDEMARK_VALUE3]                    [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
		[TIDEMARK_VALUE4]                    [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
		[TIDEMARK_VALUE5]                    [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
		CONSTRAINT [PK_SUM_IVR_APPLICATION_DAILY]
		PRIMARY KEY
		CLUSTERED
		([PARTITION_URN], [PARTITION_ID])
	ON [SUMIVRGROUP]
) ON [SUMIVRGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_SUM_IVR_APPLICATION_DAILY_DATE_TIME]
	ON [dbo].[TB_SUM_IVR_APPLICATION_DAILY] ([DATE_TIME])
	ON [SUMIVRIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_APPLICATION_DAILY', 'INDEX', N'IX_SUM_IVR_APPLICATION_DAILY_DATE_TIME'
GO
CREATE NONCLUSTERED INDEX [IX_SUM_IVR_APPLICATION_DAILY_DATE_URN]
	ON [dbo].[TB_SUM_IVR_APPLICATION_DAILY] ([DATE_URN])
	ON [SUMIVRIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_APPLICATION_DAILY', 'INDEX', N'IX_SUM_IVR_APPLICATION_DAILY_DATE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the template table for the historical Daily statistics of IVR Scripts. This table is created at install time and the partitioning service creates various partition tables with the same schema. These partition tables are prefixed as TB_SUM_IVR_APPLICATION_DAILY_ followed by the partition identifier. The partition identifier is created depending on the partition configuration, for example monthly, weekly etc. All currently active partitions are included VW_PARTITONED_SUM_IVR_APPLICATION_DAILY view. Since the partitioned tables are generated at runtime and that they have the same schema no separate documentations are required for each partition table. In case of a configured Cisco Unified Customer Voice Portal (CVP) the data in these partition tables are sourced from the ApplicationSummary_Daily table in CVP Report Server Core Database.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_APPLICATION_DAILY', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_APPLICATION_DAILY', 'COLUMN', N'PARTITION_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column holds a value that uniquely identifies a row across all the partition tables for this partition type.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_APPLICATION_DAILY', 'COLUMN', N'PARTITION_GLOBAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number for the current partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_APPLICATION_DAILY', 'COLUMN', N'PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the UTC date indicating the start of the interval. This is calculated based on DATE_TIME.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_APPLICATION_DAILY', 'COLUMN', N'DATE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the UTC time of UTC date indicating the start of the interval. This is calculated based on DATE_TIME.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_APPLICATION_DAILY', 'COLUMN', N'TIME_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the UTC Date Time indicating the start of the interval. This maps to the DBDateTime column in Cisco CVP.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_APPLICATION_DAILY', 'COLUMN', N'DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_IVR_SCRIPT of type IT_IVR_SCRIPT. This corresponds to the IVR Script associated with the record. This is looked up or generated based on AppName column in Cisco CVP.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_APPLICATION_DAILY', 'COLUMN', N'IVR_SCRIPT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_IVR_SCRIPT', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_APPLICATION_DAILY', 'COLUMN', N'IVR_SCRIPT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_IVR_SCRIPT of type IT_IVR_SCRIPT. This corresponds to the Source IVR Script for the IVR Script associated with the record. This is looked up or generated based on SourceAppName column in Cisco CVP.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_APPLICATION_DAILY', 'COLUMN', N'SOURCE_IVR_SCRIPT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_IVR_SCRIPT', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_APPLICATION_DAILY', 'COLUMN', N'SOURCE_IVR_SCRIPT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_IVR_SCRIPT_NODE of type IT_IVR_SCRIPT_NODE. This corresponds to the IVR Script Node within the IVR Script associated with the record. This is looked up or generated based on ElementName column in Cisco CVP.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_APPLICATION_DAILY', 'COLUMN', N'IVR_SCRIPT_NODE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_IVR_SCRIPT_NODE', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_APPLICATION_DAILY', 'COLUMN', N'IVR_SCRIPT_NODE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_IVR_SCRIPT_NODE_EXIT_STATE of type IT_IVR_SCRIPT_NODE_EXIT_STATE. This corresponds to the Exit state of IVR Script Node within the IVR Script associated with the record. This is looked up or generated based on ExitState column in Cisco CVP.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_APPLICATION_DAILY', 'COLUMN', N'IVR_SCRIPT_NODE_EXIT_STATE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_IVR_SCRIPT_NODE_EXIT_STATE', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_APPLICATION_DAILY', 'COLUMN', N'IVR_SCRIPT_NODE_EXIT_STATE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This corresponds to the IVR Script associated with the record. This maps to AppName column in Cisco CVP.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_APPLICATION_DAILY', 'COLUMN', N'APPLICATION_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_CODE of type IT_CODE. This Code will be a member of the Code Group IVR Element Type. This is looked up based on the ElementTypeID column in Cisco CVP.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_APPLICATION_DAILY', 'COLUMN', N'ELEMENT_TYPE_CODE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_CODE of type IT_CODE. This Code will be a member of the Code Group IVR Result Type. This is looked up based on the ResultID column in Cisco CVP.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_APPLICATION_DAILY', 'COLUMN', N'RESULT_CODE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_CODE of type IT_CODE. This Code will be a member of the Code Group IVR Cause. This is looked up based on the CauseID column in Cisco CVP.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_APPLICATION_DAILY', 'COLUMN', N'CAUSE_CODE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This corresponds to the Source IVR Script for the IVR Script associated with the record. This maps to SourceAppName column in Cisco CVP.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_APPLICATION_DAILY', 'COLUMN', N'SOURCE_APPLICATION_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This corresponds to the IVR Script Node within the IVR Script associated with the record. This maps to ElementName column in Cisco CVP.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_APPLICATION_DAILY', 'COLUMN', N'SCRIPT_ELEMENT_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This corresponds to the Exit state of IVR Script Node within the IVR Script associated with the record. This maps to ExitState column in Cisco CVP.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_APPLICATION_DAILY', 'COLUMN', N'EXIT_STATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number of occurances during the collection interval. This maps to the Count column in Cisco CVP.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_APPLICATION_DAILY', 'COLUMN', N'OCCURRENCE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is average elapsed time for the IVR Script Node. This maps to the Avg_elapsed column in Cisco CVP.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_APPLICATION_DAILY', 'COLUMN', N'AVG_ELAPSED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from the table dbo.TB_CLU_RESOURCE indicating the source of the data.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_APPLICATION_DAILY', 'COLUMN', N'CLUSTER_RESOURCE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_APPLICATION_DAILY', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM0', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_APPLICATION_DAILY', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_APPLICATION_DAILY', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM1', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_APPLICATION_DAILY', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_APPLICATION_DAILY', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM2', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_APPLICATION_DAILY', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_APPLICATION_DAILY', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM3', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_APPLICATION_DAILY', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_APPLICATION_DAILY', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM4', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_APPLICATION_DAILY', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_APPLICATION_DAILY', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM5', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_APPLICATION_DAILY', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_APPLICATION_DAILY', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM6', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_APPLICATION_DAILY', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_APPLICATION_DAILY', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM7', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_APPLICATION_DAILY', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_APPLICATION_DAILY', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM8', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_APPLICATION_DAILY', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_APPLICATION_DAILY', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM9', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_APPLICATION_DAILY', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_APPLICATION_DAILY', 'COLUMN', N'CUSTOM_MEASURE_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_APPLICATION_DAILY', 'COLUMN', N'CUSTOM_MEASURE_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_APPLICATION_DAILY', 'COLUMN', N'CUSTOM_MEASURE_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_APPLICATION_DAILY', 'COLUMN', N'CUSTOM_MEASURE_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_APPLICATION_DAILY', 'COLUMN', N'CUSTOM_MEASURE_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_APPLICATION_DAILY', 'COLUMN', N'CUSTOM_MEASURE_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_APPLICATION_DAILY', 'COLUMN', N'CUSTOM_MEASURE_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_APPLICATION_DAILY', 'COLUMN', N'CUSTOM_MEASURE_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_APPLICATION_DAILY', 'COLUMN', N'CUSTOM_MEASURE_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_APPLICATION_DAILY', 'COLUMN', N'CUSTOM_MEASURE_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_APPLICATION_DAILY', 'COLUMN', N'TIDEMARK_VALUE1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_APPLICATION_DAILY', 'COLUMN', N'TIDEMARK_VALUE2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_APPLICATION_DAILY', 'COLUMN', N'TIDEMARK_VALUE3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_APPLICATION_DAILY', 'COLUMN', N'TIDEMARK_VALUE4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_APPLICATION_DAILY', 'COLUMN', N'TIDEMARK_VALUE5'
GO
GRANT SELECT
	ON [dbo].[TB_SUM_IVR_APPLICATION_DAILY]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_SUM_IVR_APPLICATION_DAILY]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_SUM_IVR_APPLICATION_DAILY]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_SUM_IVR_APPLICATION_DAILY] SET (LOCK_ESCALATION = TABLE)
GO
