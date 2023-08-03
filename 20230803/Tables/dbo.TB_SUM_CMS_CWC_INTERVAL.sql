SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TB_SUM_CMS_CWC_INTERVAL] (
		[PARTITION_URN]            [int] NOT NULL,
		[PARTITION_GLOBAL_URN]     [bigint] NOT NULL,
		[PARTITION_ID]             [int] NOT NULL,
		[CLUSTER_RESOURCE_URN]     [int] NOT NULL,
		[ACD_URN]                  [int] NOT NULL,
		[CWC_URN]                  [int] NOT NULL,
		[DATE_UTC_URN]             [int] NOT NULL,
		[TIME_UTC_URN]             [smallint] NOT NULL,
		[DB_DATETIME]              [datetime] NULL,
		[UTC_DATE_TIME]            [datetime] NOT NULL,
		[INTRVL]                   [int] NULL,
		[ACD_CALLS]                [int] NULL,
		[ACD_TIME]                 [int] NULL,
		[ACW_TIME]                 [int] NULL,
		[INCOMPLETE]               [int] NULL,
		CONSTRAINT [PK_SUM_CMS_CWC_INTERVAL]
		PRIMARY KEY
		CLUSTERED
		([PARTITION_URN], [PARTITION_ID])
	ON [SUMCMSGROUP]
) ON [SUMCMSGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_SUM_CMS_CWC_INTERVAL_ACD_URN]
	ON [dbo].[TB_SUM_CMS_CWC_INTERVAL] ([ACD_URN])
	ON [SUMCMSIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_CWC_INTERVAL', 'INDEX', N'IX_SUM_CMS_CWC_INTERVAL_ACD_URN'
GO
CREATE NONCLUSTERED INDEX [IX_SUM_CMS_CWC_INTERVAL_CWC_URN]
	ON [dbo].[TB_SUM_CMS_CWC_INTERVAL] ([CWC_URN])
	ON [SUMCMSIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_CWC_INTERVAL', 'INDEX', N'IX_SUM_CMS_CWC_INTERVAL_CWC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the template table for the historical interval based call work code summary statistics from CMS systems. This table is created at install time and the partitioning service creates various partition tables with the same schema. These partition tables are prefixed as TB_SUM_CMS_CWC_INTERVAL_ followed by the partition identifier. The partition identifier is created depending on the partition configuration, for example monthly, weekly etc. All currently active partitions are included VW_PARTITONED_SUM_CMS_CWC_INTERVAL view. Since the partitioned tables are generated at runtime and that they have the same schema no separate documentations are required for each partition table. In case of a configured Avaya CMS the data in these partition tables are sourced from the  table in cms Database.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_CWC_INTERVAL', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary Key Identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_CWC_INTERVAL', 'COLUMN', N'PARTITION_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column holds a value that uniquely identifies a row across all the partition tables for this partition type.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_CWC_INTERVAL', 'COLUMN', N'PARTITION_GLOBAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number for the current partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_CWC_INTERVAL', 'COLUMN', N'PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from the table dbo.TB_CLU_RESOURCE indicating the source of the data..', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_CWC_INTERVAL', 'COLUMN', N'CLUSTER_RESOURCE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_PERIPHERAL corresponding to an item of type PT_ACD. This corresponds to the ACD associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_CWC_INTERVAL', 'COLUMN', N'ACD_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_PERIPHERAL', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_CWC_INTERVAL', 'COLUMN', N'ACD_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_WRAPUP_CODE corresponding to an item of type IT_WRAPUP_CODE. This corresponds to the CWC associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_CWC_INTERVAL', 'COLUMN', N'CWC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_WRAPUP_CODE', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_CWC_INTERVAL', 'COLUMN', N'CWC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the date associated with the record. This is calculated by the data importer based on the source data time corresponding to the start of the reporting interval from the source data.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_CWC_INTERVAL', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the time associated with the record. This is calculated by the data importer based on the source data time corresponding to the start of the reporting interval from the source data.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_CWC_INTERVAL', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the datetime stamp associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_CWC_INTERVAL', 'COLUMN', N'DB_DATETIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The UTC start time of the interval for which data was collected. It is records in number of seconds since midnight 01/01/1970 UTC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_CWC_INTERVAL', 'COLUMN', N'UTC_DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of minutes in the intrahour interval. The length of the intrahour interval can be 15, 30, or 60 minutes. INTRVL applies to intrahour tables only. The data in this column maps to the HCWC.INTRVL column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_CWC_INTERVAL', 'COLUMN', N'INTRVL'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times that this call work code was entered while an agent was on a split/skill or direct agent ACD call or in call-related ACW. The data in this column maps to the HCWC.ACDCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_CWC_INTERVAL', 'COLUMN', N'ACD_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The talk time of all ACDCALLS that are associated with this call work code. The data in this column maps to the HCWC.ACDTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_CWC_INTERVAL', 'COLUMN', N'ACD_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time that agents spend in ACW for ACDCALLS that are associated with this call work code. The data in this column maps to the HCWC.ACWTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_CWC_INTERVAL', 'COLUMN', N'ACW_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'An indication of whether data is complete for this collection interval. Data is incomplete whenever the link goes down and whenever tracking is aborted for calls, because of the trunk going maintenance busy with a call active, protocol failures with data . The data in this column maps to the HCWC.INCOMPLETE column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_CWC_INTERVAL', 'COLUMN', N'INCOMPLETE'
GO
GRANT SELECT
	ON [dbo].[TB_SUM_CMS_CWC_INTERVAL]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_SUM_CMS_CWC_INTERVAL]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_SUM_CMS_CWC_INTERVAL]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_SUM_CMS_CWC_INTERVAL] SET (LOCK_ESCALATION = TABLE)
GO
