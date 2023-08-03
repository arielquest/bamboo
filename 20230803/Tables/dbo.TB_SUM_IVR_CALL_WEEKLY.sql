SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_SUM_IVR_CALL_WEEKLY] (
		[PARTITION_URN]            [int] NOT NULL,
		[PARTITION_GLOBAL_URN]     [bigint] NOT NULL,
		[PARTITION_ID]             [int] NOT NULL,
		[DATE_URN]                 [int] NULL,
		[TIME_URN]                 [smallint] NULL,
		[DATE_TIME]                [datetime] NULL,
		[SUBSYSTEM_CODE_URN]       [int] NULL,
		[CALL_TYPE_CODE_URN]       [int] NOT NULL,
		[AVG_CALL_DURATION]        [int] NULL,
		[TOTAL_OPT_OUT]            [int] NULL,
		[TOTAL_HOLD]               [int] NULL,
		[TOTAL_TIMEOUT]            [int] NULL,
		[TOTAL_ERROR]              [int] NULL,
		[TOTAL_APPS_VISITED]       [int] NULL,
		[TOTAL_TRANSFER]           [int] NULL,
		[TOTAL_CALLS]              [int] NULL,
		[CLUSTER_RESOURCE_URN]     [int] NOT NULL,
		[CUSTOM_DIMENSION_0]       [int] NOT NULL,
		[CUSTOM_DIMENSION_1]       [int] NOT NULL,
		[CUSTOM_DIMENSION_2]       [int] NOT NULL,
		[CUSTOM_DIMENSION_3]       [int] NOT NULL,
		[CUSTOM_DIMENSION_4]       [int] NOT NULL,
		[CUSTOM_DIMENSION_5]       [int] NOT NULL,
		[CUSTOM_DIMENSION_6]       [int] NOT NULL,
		[CUSTOM_DIMENSION_7]       [int] NOT NULL,
		[CUSTOM_DIMENSION_8]       [int] NOT NULL,
		[CUSTOM_DIMENSION_9]       [int] NOT NULL,
		[CUSTOM_MEASURE_0]         [int] NULL,
		[CUSTOM_MEASURE_1]         [int] NULL,
		[CUSTOM_MEASURE_2]         [int] NULL,
		[CUSTOM_MEASURE_3]         [int] NULL,
		[CUSTOM_MEASURE_4]         [int] NULL,
		[CUSTOM_MEASURE_5]         [int] NULL,
		[CUSTOM_MEASURE_6]         [int] NULL,
		[CUSTOM_MEASURE_7]         [int] NULL,
		[CUSTOM_MEASURE_8]         [int] NULL,
		[CUSTOM_MEASURE_9]         [int] NULL,
		[TIDEMARK_VALUE1]          [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
		[TIDEMARK_VALUE2]          [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
		[TIDEMARK_VALUE3]          [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
		[TIDEMARK_VALUE4]          [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
		[TIDEMARK_VALUE5]          [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
		CONSTRAINT [PK_SUM_IVR_CALL_WEEKLY]
		PRIMARY KEY
		CLUSTERED
		([PARTITION_URN], [PARTITION_ID])
	ON [SUMIVRGROUP]
) ON [SUMIVRGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_SUM_IVR_CALL_WEEKLY_DATE_TIME]
	ON [dbo].[TB_SUM_IVR_CALL_WEEKLY] ([DATE_TIME])
	ON [SUMIVRIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_CALL_WEEKLY', 'INDEX', N'IX_SUM_IVR_CALL_WEEKLY_DATE_TIME'
GO
CREATE NONCLUSTERED INDEX [IX_SUM_IVR_CALL_WEEKLY_DATE_URN]
	ON [dbo].[TB_SUM_IVR_CALL_WEEKLY] ([DATE_URN])
	ON [SUMIVRIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_CALL_WEEKLY', 'INDEX', N'IX_SUM_IVR_CALL_WEEKLY_DATE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the template table for the historical Weekly statistics of IVR Calls. This table is created at install time and the partitioning service creates various partition tables with the same schema. These partition tables are prefixed as TB_SUM_IVR_CALL_WEEKLY_ followed by the partition identifier. The partition identifier is created depending on the partition configuration, for example monthly, weekly etc. All currently active partitions are included VW_PARTITONED_SUM_IVR_CALL_WEEKLY view. Since the partitioned tables are generated at runtime and that they have the same schema no separate documentations are required for each partition table. In case of a configured Cisco Unified Customer Voice Portal (CVP) the data in these partition tables are sourced from the Call_Weekly table in CVP Report Server Core Database.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_CALL_WEEKLY', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_CALL_WEEKLY', 'COLUMN', N'PARTITION_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column holds a value that uniquely identifies a row across all the partition tables for this partition type.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_CALL_WEEKLY', 'COLUMN', N'PARTITION_GLOBAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number for the current partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_CALL_WEEKLY', 'COLUMN', N'PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the UTC date indicating the start of the interval. This is calculated based on DATE_TIME.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_CALL_WEEKLY', 'COLUMN', N'DATE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the UTC time of UTC date indicating the start of the interval. This is calculated based on DATE_TIME.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_CALL_WEEKLY', 'COLUMN', N'TIME_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the UTC Date Time indicating the start of the interval. This maps to the DBDateTime column in Cisco CVP.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_CALL_WEEKLY', 'COLUMN', N'DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_CODE of type IT_CODE. This Code will be a member of the Code Group IVR Subsystem Type. This is looked up based on the SubSystemTypeID column in Cisco CVP.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_CALL_WEEKLY', 'COLUMN', N'SUBSYSTEM_CODE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_CODE of type IT_CODE. This Code will be a member of the Code Group IVR Call Type. This is looked up based on the CallTypeID column in Cisco CVP.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_CALL_WEEKLY', 'COLUMN', N'CALL_TYPE_CODE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the average duration (in seconds) of the calls during the collection interval. This maps to the AvgCallLength column in Cisco CVP.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_CALL_WEEKLY', 'COLUMN', N'AVG_CALL_DURATION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of opt outs during the collection interval. This maps to the TotalOptOut column in Cisco CVP.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_CALL_WEEKLY', 'COLUMN', N'TOTAL_OPT_OUT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of holds during the collection interval. This maps to the TotalOnHold column in Cisco CVP.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_CALL_WEEKLY', 'COLUMN', N'TOTAL_HOLD'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of time outs during the collection interval. This maps to the TotalTimeOut column in Cisco CVP.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_CALL_WEEKLY', 'COLUMN', N'TOTAL_TIMEOUT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of errors during the collection interval. This maps to the TotalError column in Cisco CVP.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_CALL_WEEKLY', 'COLUMN', N'TOTAL_ERROR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of IVR Scripts visited during the collection interval. This maps to the TotalAppVisited column in Cisco CVP.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_CALL_WEEKLY', 'COLUMN', N'TOTAL_APPS_VISITED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of transfers during the collection interval. This maps to TotalTransfer column in Cisco CVP.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_CALL_WEEKLY', 'COLUMN', N'TOTAL_TRANSFER'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls during the collection interval. This maps to the NumCalls column in Cisco CVP.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_CALL_WEEKLY', 'COLUMN', N'TOTAL_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from the table dbo.TB_CLU_RESOURCE indicating the source of the data.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_CALL_WEEKLY', 'COLUMN', N'CLUSTER_RESOURCE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_CALL_WEEKLY', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM0', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_CALL_WEEKLY', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_CALL_WEEKLY', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM1', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_CALL_WEEKLY', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_CALL_WEEKLY', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM2', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_CALL_WEEKLY', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_CALL_WEEKLY', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM3', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_CALL_WEEKLY', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_CALL_WEEKLY', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM4', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_CALL_WEEKLY', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_CALL_WEEKLY', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM5', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_CALL_WEEKLY', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_CALL_WEEKLY', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM6', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_CALL_WEEKLY', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_CALL_WEEKLY', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM7', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_CALL_WEEKLY', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_CALL_WEEKLY', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM8', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_CALL_WEEKLY', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_CALL_WEEKLY', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM9', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_CALL_WEEKLY', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_CALL_WEEKLY', 'COLUMN', N'CUSTOM_MEASURE_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_CALL_WEEKLY', 'COLUMN', N'CUSTOM_MEASURE_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_CALL_WEEKLY', 'COLUMN', N'CUSTOM_MEASURE_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_CALL_WEEKLY', 'COLUMN', N'CUSTOM_MEASURE_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_CALL_WEEKLY', 'COLUMN', N'CUSTOM_MEASURE_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_CALL_WEEKLY', 'COLUMN', N'CUSTOM_MEASURE_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_CALL_WEEKLY', 'COLUMN', N'CUSTOM_MEASURE_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_CALL_WEEKLY', 'COLUMN', N'CUSTOM_MEASURE_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_CALL_WEEKLY', 'COLUMN', N'CUSTOM_MEASURE_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_CALL_WEEKLY', 'COLUMN', N'CUSTOM_MEASURE_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_CALL_WEEKLY', 'COLUMN', N'TIDEMARK_VALUE1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_CALL_WEEKLY', 'COLUMN', N'TIDEMARK_VALUE2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_CALL_WEEKLY', 'COLUMN', N'TIDEMARK_VALUE3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_CALL_WEEKLY', 'COLUMN', N'TIDEMARK_VALUE4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_IVR_CALL_WEEKLY', 'COLUMN', N'TIDEMARK_VALUE5'
GO
GRANT SELECT
	ON [dbo].[TB_SUM_IVR_CALL_WEEKLY]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_SUM_IVR_CALL_WEEKLY]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_SUM_IVR_CALL_WEEKLY]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_SUM_IVR_CALL_WEEKLY] SET (LOCK_ESCALATION = TABLE)
GO
