SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_FCT_IVR_CALL_EVENT] (
		[PARTITION_URN]               [int] NOT NULL,
		[PARTITION_GLOBAL_URN]        [bigint] NOT NULL,
		[PARTITION_ID]                [int] NOT NULL,
		[EVENT_DATE_TIME]             [datetime] NOT NULL,
		[UTC_TIMEZONE]                [int] NOT NULL,
		[EVENT_DATE_URN]              [int] NOT NULL,
		[EVENT_TIME_URN]              [smallint] NOT NULL,
		[EVENT_DATE_UTC_URN]          [int] NOT NULL,
		[EVENT_TIME_UTC_URN]          [smallint] NOT NULL,
		[EVENT_TYPE_CODE_URN]         [int] NULL,
		[SUBSYSTEM_TYPE_CODE_URN]     [int] NOT NULL,
		[TRANSFER_TYPE_CODE_URN]      [int] NOT NULL,
		[CAUSE_CODE_URN]              [int] NOT NULL,
		[IVR_SERVER_URN]              [int] NOT NULL,
		[DIALED_NUMBER_URN]           [int] NOT NULL,
		[SUBSYSTEM_NAME]              [varchar](100) COLLATE Latin1_General_CI_AS NULL,
		[SERVER_NAME]                 [varchar](100) COLLATE Latin1_General_CI_AS NULL,
		[TRANSFER_LABEL]              [varchar](300) COLLATE Latin1_General_CI_AS NULL,
		[DB_DATETIME]                 [datetime] NULL,
		[CALL_KEY1]                   [varchar](50) COLLATE Latin1_General_CI_AS NULL,
		[CALL_KEY2]                   [varchar](50) COLLATE Latin1_General_CI_AS NULL,
		[CALL_LEG_KEY]                [varchar](255) COLLATE Latin1_General_CI_AS NULL,
		[MEDIA_FILE_NAME]             [varchar](255) COLLATE Latin1_General_CI_AS NULL,
		[CLUSTER_RESOURCE_URN]        [int] NOT NULL,
		[CUSTOM_DIMENSION_0]          [int] NOT NULL,
		[CUSTOM_DIMENSION_1]          [int] NOT NULL,
		[CUSTOM_DIMENSION_2]          [int] NOT NULL,
		[CUSTOM_DIMENSION_3]          [int] NOT NULL,
		[CUSTOM_DIMENSION_4]          [int] NOT NULL,
		[CUSTOM_DIMENSION_5]          [int] NOT NULL,
		[CUSTOM_DIMENSION_6]          [int] NOT NULL,
		[CUSTOM_DIMENSION_7]          [int] NOT NULL,
		[CUSTOM_DIMENSION_8]          [int] NOT NULL,
		[CUSTOM_DIMENSION_9]          [int] NOT NULL,
		[CUSTOM_MEASURE_0]            [int] NULL,
		[CUSTOM_MEASURE_1]            [int] NULL,
		[CUSTOM_MEASURE_2]            [int] NULL,
		[CUSTOM_MEASURE_3]            [int] NULL,
		[CUSTOM_MEASURE_4]            [int] NULL,
		[CUSTOM_MEASURE_5]            [int] NULL,
		[CUSTOM_MEASURE_6]            [int] NULL,
		[CUSTOM_MEASURE_7]            [int] NULL,
		[CUSTOM_MEASURE_8]            [int] NULL,
		[CUSTOM_MEASURE_9]            [int] NULL,
		[TIDEMARK_VALUE1]             [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
		[TIDEMARK_VALUE2]             [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
		[TIDEMARK_VALUE3]             [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
		[TIDEMARK_VALUE4]             [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
		[TIDEMARK_VALUE5]             [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
		CONSTRAINT [PK_FCT_IVR_CALL_EVENT]
		PRIMARY KEY
		CLUSTERED
		([PARTITION_URN], [PARTITION_ID])
	ON [FCTIVRGROUP]
) ON [FCTIVRGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_FCT_IVR_CALL_EVENT_TRANSFER_TYPE_CODE_URN]
	ON [dbo].[TB_FCT_IVR_CALL_EVENT] ([TRANSFER_TYPE_CODE_URN])
	ON [FCTIVRIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_EVENT', 'INDEX', N'IX_FCT_IVR_CALL_EVENT_TRANSFER_TYPE_CODE_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_IVR_CALL_EVENT_SUBSYSTEM_TYPE_CODE_URN]
	ON [dbo].[TB_FCT_IVR_CALL_EVENT] ([SUBSYSTEM_TYPE_CODE_URN])
	ON [FCTIVRIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_EVENT', 'INDEX', N'IX_FCT_IVR_CALL_EVENT_SUBSYSTEM_TYPE_CODE_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_IVR_CALL_EVENT_CAUSE_CODE_URN]
	ON [dbo].[TB_FCT_IVR_CALL_EVENT] ([CAUSE_CODE_URN])
	ON [FCTIVRIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_EVENT', 'INDEX', N'IX_FCT_IVR_CALL_EVENT_CAUSE_CODE_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_IVR_CALL_EVENT_EVENT_DATE_TIME]
	ON [dbo].[TB_FCT_IVR_CALL_EVENT] ([EVENT_DATE_TIME])
	ON [FCTIVRIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_EVENT', 'INDEX', N'IX_FCT_IVR_CALL_EVENT_EVENT_DATE_TIME'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_IVR_CALL_EVENT_EVENT_DATE_URN]
	ON [dbo].[TB_FCT_IVR_CALL_EVENT] ([EVENT_DATE_URN])
	ON [FCTIVRIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_EVENT', 'INDEX', N'IX_FCT_IVR_CALL_EVENT_EVENT_DATE_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_IVR_CALL_EVENT_EVENT_DATE_UTC_URN]
	ON [dbo].[TB_FCT_IVR_CALL_EVENT] ([EVENT_DATE_UTC_URN])
	ON [FCTIVRIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_EVENT', 'INDEX', N'IX_FCT_IVR_CALL_EVENT_EVENT_DATE_UTC_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_IVR_CALL_KEY1_CALL_KEY2]
	ON [dbo].[TB_FCT_IVR_CALL_EVENT] ([CALL_KEY1], [CALL_KEY2])
	ON [FCTIVRIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_EVENT', 'INDEX', N'IX_FCT_IVR_CALL_KEY1_CALL_KEY2'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_IVR_CALL_EVENT_DIALED_NUMBER_URN]
	ON [dbo].[TB_FCT_IVR_CALL_EVENT] ([DIALED_NUMBER_URN])
	ON [FCTIVRIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_EVENT', 'INDEX', N'IX_FCT_IVR_CALL_EVENT_DIALED_NUMBER_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the template table for the historical data for ivr call event statistics. This table is created at install time and the partitioning service creates various partition tables with the same schema. These partition tables are prefixed as TB_FCT_IVR_CALL_EVENT_ followed by the partition identifier. The partition identifier is created depending on the partition configuration, for example monthly, weekly etc. All currently active partitions are included VW_PARTITONED_FCT_IVR_CALL_EVENT view. Since the partitioned tables are generated at runtime and that they have the same schema no separate documentations are required for each partition table. In case of a configured Cisco Unified Customer Voice Portal (CVP) the data in these partition tables are sourced from the CallEvent table in CVP Report Server Core Database.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_EVENT', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_EVENT', 'COLUMN', N'PARTITION_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column holds a value that uniquely identifies a row across all the partition tables for this partition type.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_EVENT', 'COLUMN', N'PARTITION_GLOBAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number for the current partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_EVENT', 'COLUMN', N'PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the date time in UTC indicating the date and time of the event. This is mapped to EventDateTime column in Cisco CVP.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_EVENT', 'COLUMN', N'EVENT_DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the offset from UTC in minutes. This maps to the LocalTimeZoneOffset column in Cisco CVP.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_EVENT', 'COLUMN', N'UTC_TIMEZONE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the date of the event. This is calculated based on EVENT_DATE_TIME and UTC_TIMEZONE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_EVENT', 'COLUMN', N'EVENT_DATE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the time of the event. This is calculated based on EVENT_DATE_TIME and UTC_TIMEZONE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_EVENT', 'COLUMN', N'EVENT_TIME_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the UTC date of the event. This is calculated based on EVENT_DATE_TIME.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_EVENT', 'COLUMN', N'EVENT_DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the UTC time of UTC date of the event. This is calculated based on EVENT_DATE_TIME.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_EVENT', 'COLUMN', N'EVENT_TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_CODE of type IT_CODE. This Code will be a member of the Code Group IVR Event Type. This is looked up based on the EventTypeID column in Cisco CVP.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_EVENT', 'COLUMN', N'EVENT_TYPE_CODE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_CODE of type IT_CODE. This Code will be a member of the Code Group IVR Subsystem Type. This is looked up based on the SubSystemTypeID column in Cisco CVP.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_EVENT', 'COLUMN', N'SUBSYSTEM_TYPE_CODE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_CODE of type IT_CODE. This Code will be a member of the Code Group IVR Transfer Type. This is looked up based on the TransferTypeID column in Cisco CVP.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_EVENT', 'COLUMN', N'TRANSFER_TYPE_CODE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_CODE of type IT_CODE. This Code will be a member of the Code Group IVR Cause. This is looked up based on the CauseID column in Cisco CVP.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_EVENT', 'COLUMN', N'CAUSE_CODE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_IVR_SERVER of type IT_IVR_SERVER. This corresponds to the IVR Server associated with the call event. This is looked up or generated based on MessageBusName column in Cisco CVP.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_EVENT', 'COLUMN', N'IVR_SERVER_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_IVR_SERVER', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_EVENT', 'COLUMN', N'IVR_SERVER_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DIALED_NUMBER of type IT_DIALED_NUMBER. This corresponds to the dnis associated with the call for which the event is recorded. In case of Cisco CVP this is looked up or generated based on DNIS column in Call table which is in-turn looked up based on the CallGUID during the ETL process.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_EVENT', 'COLUMN', N'DIALED_NUMBER_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DIALED_NUMBER', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_EVENT', 'COLUMN', N'DIALED_NUMBER_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to the column SybSystemName in Cisco CVP.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_EVENT', 'COLUMN', N'SUBSYSTEM_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to the column MessageBusName in Cisco CVP.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_EVENT', 'COLUMN', N'SERVER_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to the TransferLabel column in Cisco CVP.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_EVENT', 'COLUMN', N'TRANSFER_LABEL'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the date time when the record was written in the source database. This maps to DBDateTime column in Cisco CVP.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_EVENT', 'COLUMN', N'DB_DATETIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Identifier for the record in the source table. This maps to CallGUID column in Cisco CVP.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_EVENT', 'COLUMN', N'CALL_KEY1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Identifier for the record in the source table. This maps to CallStartDate column in Cisco CVP.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_EVENT', 'COLUMN', N'CALL_KEY2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to the CallLegID in Cisco CVP.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_EVENT', 'COLUMN', N'CALL_LEG_KEY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to the column mediafilename in Cisco CVP.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_EVENT', 'COLUMN', N'MEDIA_FILE_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from the table dbo.TB_CLU_RESOURCE indicating the source of the data.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_EVENT', 'COLUMN', N'CLUSTER_RESOURCE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_EVENT', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM0', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_EVENT', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_EVENT', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM1', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_EVENT', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_EVENT', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM2', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_EVENT', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_EVENT', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM3', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_EVENT', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_EVENT', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM4', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_EVENT', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_EVENT', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM5', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_EVENT', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_EVENT', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM6', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_EVENT', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_EVENT', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM7', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_EVENT', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_EVENT', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM8', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_EVENT', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_EVENT', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM9', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_EVENT', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_EVENT', 'COLUMN', N'CUSTOM_MEASURE_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_EVENT', 'COLUMN', N'CUSTOM_MEASURE_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_EVENT', 'COLUMN', N'CUSTOM_MEASURE_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_EVENT', 'COLUMN', N'CUSTOM_MEASURE_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_EVENT', 'COLUMN', N'CUSTOM_MEASURE_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_EVENT', 'COLUMN', N'CUSTOM_MEASURE_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_EVENT', 'COLUMN', N'CUSTOM_MEASURE_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_EVENT', 'COLUMN', N'CUSTOM_MEASURE_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_EVENT', 'COLUMN', N'CUSTOM_MEASURE_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_EVENT', 'COLUMN', N'CUSTOM_MEASURE_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_EVENT', 'COLUMN', N'TIDEMARK_VALUE1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_EVENT', 'COLUMN', N'TIDEMARK_VALUE2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_EVENT', 'COLUMN', N'TIDEMARK_VALUE3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_EVENT', 'COLUMN', N'TIDEMARK_VALUE4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_EVENT', 'COLUMN', N'TIDEMARK_VALUE5'
GO
GRANT SELECT
	ON [dbo].[TB_FCT_IVR_CALL_EVENT]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_FCT_IVR_CALL_EVENT]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_FCT_IVR_CALL_EVENT]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_FCT_IVR_CALL_EVENT] SET (LOCK_ESCALATION = TABLE)
GO
