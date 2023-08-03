SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_FCT_IVR_CALL_ICM_MAP] (
		[PARTITION_URN]                [int] NOT NULL,
		[PARTITION_GLOBAL_URN]         [bigint] NOT NULL,
		[PARTITION_ID]                 [int] NOT NULL,
		[DATE_TIME]                    [datetime] NOT NULL,
		[DATE_UTC_URN]                 [int] NOT NULL,
		[TIME_UTC_URN]                 [smallint] NOT NULL,
		[UTC_TIMEZONE]                 [int] NOT NULL,
		[DB_DATETIME]                  [datetime] NULL,
		[IVR_CALL_KEY1]                [varchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[IVR_CALL_KEY2]                [varchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[ICM_CALL_KEY1]                [int] NOT NULL,
		[ICM_CALL_KEY2]                [int] NOT NULL,
		[ICM_SEQUENCE_NUMBER]          [int] NULL,
		[IVR_CLUSTER_RESOURCE_URN]     [int] NOT NULL,
		[ICM_CLUSTER_RESOURCE_URN]     [int] NULL,
		[TIDEMARK_VALUE1]              [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
		[TIDEMARK_VALUE2]              [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
		[TIDEMARK_VALUE3]              [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
		[TIDEMARK_VALUE4]              [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
		[TIDEMARK_VALUE5]              [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
		[CUSTOM_DIMENSION_0]           [int] NOT NULL,
		[CUSTOM_DIMENSION_1]           [int] NOT NULL,
		[CUSTOM_DIMENSION_2]           [int] NOT NULL,
		[CUSTOM_DIMENSION_3]           [int] NOT NULL,
		[CUSTOM_DIMENSION_4]           [int] NOT NULL,
		[CUSTOM_DIMENSION_5]           [int] NOT NULL,
		[CUSTOM_DIMENSION_6]           [int] NOT NULL,
		[CUSTOM_DIMENSION_7]           [int] NOT NULL,
		[CUSTOM_DIMENSION_8]           [int] NOT NULL,
		[CUSTOM_DIMENSION_9]           [int] NOT NULL,
		[CUSTOM_MEASURE_0]             [int] NULL,
		[CUSTOM_MEASURE_1]             [int] NULL,
		[CUSTOM_MEASURE_2]             [int] NULL,
		[CUSTOM_MEASURE_3]             [int] NULL,
		[CUSTOM_MEASURE_4]             [int] NULL,
		[CUSTOM_MEASURE_5]             [int] NULL,
		[CUSTOM_MEASURE_6]             [int] NULL,
		[CUSTOM_MEASURE_7]             [int] NULL,
		[CUSTOM_MEASURE_8]             [int] NULL,
		[CUSTOM_MEASURE_9]             [int] NULL,
		CONSTRAINT [PK_FCT_IVR_CALL_ICM_MAP]
		PRIMARY KEY
		CLUSTERED
		([PARTITION_URN], [PARTITION_ID])
	ON [FCTIVRGROUP]
) ON [FCTIVRGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_FCT_IVR_CALL_ICM_MAP_DATE_TIME]
	ON [dbo].[TB_FCT_IVR_CALL_ICM_MAP] ([DATE_TIME])
	ON [FCTIVRIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_ICM_MAP', 'INDEX', N'IX_FCT_IVR_CALL_ICM_MAP_DATE_TIME'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_IVR_CALL_ICM_MAP_DATE_UTC_URN]
	ON [dbo].[TB_FCT_IVR_CALL_ICM_MAP] ([DATE_UTC_URN])
	ON [FCTIVRIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_ICM_MAP', 'INDEX', N'IX_FCT_IVR_CALL_ICM_MAP_DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the template table for the historical data for ivr call to ICM mapping statistics. This table is created at install time and the partitioning service creates various partition tables with the same schema. These partition tables are prefixed as TB_FCT_IVR_CALL_ICM_MAP_ followed by the partition identifier. The partition identifier is created depending on the partition configuration, for example monthly, weekly etc. All currently active partitions are included VW_PARTITONED_FCT_IVR_CALL_ICM_MAP view. Since the partitioned tables are generated at runtime and that they have the same schema no separate documentations are required for each partition table. In case of a configured Cisco Unified Customer Voice Portal (CVP) the data in these partition tables are sourced from the CallICMInfo table in CVP Report Server Core Database.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_ICM_MAP', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_ICM_MAP', 'COLUMN', N'PARTITION_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column holds a value that uniquely identifies a row across all the partition tables for this partition type.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_ICM_MAP', 'COLUMN', N'PARTITION_GLOBAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number for the current partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_ICM_MAP', 'COLUMN', N'PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the UTC date time of the event. This maps to the column EventDateTime in Cisco CVP', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_ICM_MAP', 'COLUMN', N'DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the UTC date of the event. This is calculated based on DATE_TIME.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_ICM_MAP', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the UTC time of UTC date of the event. This is calculated based on DATE_TIME.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_ICM_MAP', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the offset from UTC in minutes. In case of Cisco CVP this is retrieved from the LocalTimeZoneOffset column in the Call table based on CallGUID.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_ICM_MAP', 'COLUMN', N'UTC_TIMEZONE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the date time when the record was written in the source database. This maps to DBDateTime column in Cisco CVP.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_ICM_MAP', 'COLUMN', N'DB_DATETIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'IVR call Identifier for the record in the source table. This maps to CallGUID column in Cisco CVP.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_ICM_MAP', 'COLUMN', N'IVR_CALL_KEY1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'IVR call Identifier for the record in the source table. This maps to CallStartDate column in Cisco CVP.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_ICM_MAP', 'COLUMN', N'IVR_CALL_KEY2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'ICM call Identifier for the record in the source table. This maps to RouterCallKey column in Cisco CVP.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_ICM_MAP', 'COLUMN', N'ICM_CALL_KEY1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'ICM call Identifier for the record in the source table. This maps to RouterCallKeyDay column in Cisco CVP.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_ICM_MAP', 'COLUMN', N'ICM_CALL_KEY2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to the column RouterCallKeySequenceNumber in Cisco CVP.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_ICM_MAP', 'COLUMN', N'ICM_SEQUENCE_NUMBER'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from the table dbo.TB_CLU_RESOURCE indicating the source of the data.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_ICM_MAP', 'COLUMN', N'IVR_CLUSTER_RESOURCE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from the table dbo.TB_CLU_RESOURCE indicating mapped ICM resource for the IVR resource.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_ICM_MAP', 'COLUMN', N'ICM_CLUSTER_RESOURCE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_ICM_MAP', 'COLUMN', N'TIDEMARK_VALUE1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_ICM_MAP', 'COLUMN', N'TIDEMARK_VALUE2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_ICM_MAP', 'COLUMN', N'TIDEMARK_VALUE3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_ICM_MAP', 'COLUMN', N'TIDEMARK_VALUE4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_ICM_MAP', 'COLUMN', N'TIDEMARK_VALUE5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_ICM_MAP', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM0', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_ICM_MAP', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_ICM_MAP', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM1', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_ICM_MAP', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_ICM_MAP', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM2', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_ICM_MAP', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_ICM_MAP', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM3', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_ICM_MAP', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_ICM_MAP', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM4', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_ICM_MAP', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_ICM_MAP', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM5', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_ICM_MAP', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_ICM_MAP', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM6', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_ICM_MAP', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_ICM_MAP', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM7', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_ICM_MAP', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_ICM_MAP', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM8', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_ICM_MAP', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_ICM_MAP', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM9', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_ICM_MAP', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_ICM_MAP', 'COLUMN', N'CUSTOM_MEASURE_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_ICM_MAP', 'COLUMN', N'CUSTOM_MEASURE_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_ICM_MAP', 'COLUMN', N'CUSTOM_MEASURE_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_ICM_MAP', 'COLUMN', N'CUSTOM_MEASURE_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_ICM_MAP', 'COLUMN', N'CUSTOM_MEASURE_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_ICM_MAP', 'COLUMN', N'CUSTOM_MEASURE_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_ICM_MAP', 'COLUMN', N'CUSTOM_MEASURE_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_ICM_MAP', 'COLUMN', N'CUSTOM_MEASURE_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_ICM_MAP', 'COLUMN', N'CUSTOM_MEASURE_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL_ICM_MAP', 'COLUMN', N'CUSTOM_MEASURE_9'
GO
GRANT SELECT
	ON [dbo].[TB_FCT_IVR_CALL_ICM_MAP]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_FCT_IVR_CALL_ICM_MAP]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_FCT_IVR_CALL_ICM_MAP]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_FCT_IVR_CALL_ICM_MAP] SET (LOCK_ESCALATION = TABLE)
GO
