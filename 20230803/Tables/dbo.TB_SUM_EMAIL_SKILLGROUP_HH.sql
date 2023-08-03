SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TB_SUM_EMAIL_SKILLGROUP_HH] (
		[PARTITION_URN]                [int] IDENTITY(1, 1) NOT NULL,
		[PARTITION_ID]                 [int] NOT NULL,
		[PARTITION_GLOBAL_URN]         [bigint] NOT NULL,
		[DATE_URN]                     [int] NOT NULL,
		[TIME_URN]                     [smallint] NOT NULL,
		[DATE_UTC_URN]                 [int] NOT NULL,
		[TIME_UTC_URN]                 [smallint] NOT NULL,
		[DATE_TIME]                    [datetime] NOT NULL,
		[UTC_TIMEZONE]                 [int] NOT NULL,
		[SKILLGROUP_URN]               [int] NOT NULL,
		[LOGGED_ON_TTH]                [int] NULL,
		[AVAIL_TTH]                    [int] NULL,
		[HANDLED_EMAILS_TTH]           [int] NULL,
		[HANDLED_EMAILS_QUEUE_TTH]     [int] NULL,
		[QUEUE_TTH]                    [int] NULL,
		[NEW_CASE_EMAILS_TH]           [int] NULL,
		[NO_CASE_EMAILS_TH]            [int] NULL,
		[EXISTING_CASE_EMAILS_TH]      [int] NULL,
		[OFFERED_EMAILS_TH]            [int] NULL,
		[TRANSFER_IN_EMAILS_TH]        [int] NULL,
		[TRANSFER_OUT_EMAILS_TH]       [int] NULL,
		[COMPOSED_EMAILS_TH]           [int] NULL,
		[REPLIED_EMAILS_TH]            [int] NULL,
		[AUTO_ACK_EMAILS_TH]           [int] NULL,
		[AUTO_REPLY_EMAILS_TH]         [int] NULL,
		[ASSIGNED_EMAILS_TH]           [int] NULL,
		[UNASSIGNED_EMAILS_TH]         [int] NULL,
		[OPEN_EMAILS_TH]               [int] NULL,
		[COMPLETED_EMAILS_TH]          [int] NULL,
		[HANDLED_EMAILS_TH]            [int] NULL,
		[SERVICE_LEVEL_TH]             [float] NULL,
		[CLUSTER_RESOURCE_URN]         [int] NOT NULL
) ON [SUMMMGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_SUM_EMAIL_SKILLGROUP_HH_DATE_TIME]
	ON [dbo].[TB_SUM_EMAIL_SKILLGROUP_HH] ([DATE_TIME])
	ON [SUMMMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_EMAIL_SKILLGROUP_HH', 'INDEX', N'IX_SUM_EMAIL_SKILLGROUP_HH_DATE_TIME'
GO
CREATE NONCLUSTERED INDEX [IX_SUM_EMAIL_SKILLGROUP_HH_DATE_URN]
	ON [dbo].[TB_SUM_EMAIL_SKILLGROUP_HH] ([DATE_URN])
	ON [SUMMMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_EMAIL_SKILLGROUP_HH', 'INDEX', N'IX_SUM_EMAIL_SKILLGROUP_HH_DATE_URN'
GO
CREATE NONCLUSTERED INDEX [IX_SUM_EMAIL_SKILLGROUP_HH_SKILLGROUP_URN]
	ON [dbo].[TB_SUM_EMAIL_SKILLGROUP_HH] ([SKILLGROUP_URN])
	ON [SUMMMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_EMAIL_SKILLGROUP_HH', 'INDEX', N'IX_SUM_EMAIL_SKILLGROUP_HH_SKILLGROUP_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the template table for the historical half hour summary statistics for all the email skillgroups in the application. This table is created at install time and the partitioning service creates various partition tables with the same schema. These partition tables are prefixed as TB_SUM_EMAIL_SKILLGROUP_HH_ followed by the partition identifier. The partition identifier is created depending on the importer configuration, for example monthly, weekly etc. All currently active partitions are included VW_PARTITONED_SUM_EMAIL_SKILLGROUP_HH view. Since the partitioned tables are generated at runtime and that they have the same schema no separate documentations are required for each partition table. The data in these partitioned tables are source from a third party data store.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_EMAIL_SKILLGROUP_HH', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the partition.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_EMAIL_SKILLGROUP_HH', 'COLUMN', N'PARTITION_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number for the current partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_EMAIL_SKILLGROUP_HH', 'COLUMN', N'PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column holds a value that uniquely identifies a row across all the partition tables for this partition type.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_EMAIL_SKILLGROUP_HH', 'COLUMN', N'PARTITION_GLOBAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the date associated with the record. This is calculated by the data importer based on the source date time corresponding to the start of the half hour interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_EMAIL_SKILLGROUP_HH', 'COLUMN', N'DATE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DATE', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_EMAIL_SKILLGROUP_HH', 'COLUMN', N'DATE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the time associated with the record. This is calculated by the data importer based on the source date time corresponding to the start of the half hour interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_EMAIL_SKILLGROUP_HH', 'COLUMN', N'TIME_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIME', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_EMAIL_SKILLGROUP_HH', 'COLUMN', N'TIME_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the UTC date associated with the record. This is calculated by the data importer based on the source date time corresponding to the start of the half hour interval and the TimeZone information from the source data.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_EMAIL_SKILLGROUP_HH', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DATE', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_EMAIL_SKILLGROUP_HH', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the UTC time associated with the record. This is calculated by the data importer based on the source date time corresponding to the start of the half hour interval and the TimeZone information from the source data.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_EMAIL_SKILLGROUP_HH', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIME', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_EMAIL_SKILLGROUP_HH', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the wall clock date time corresponding to the start of the half hour interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_EMAIL_SKILLGROUP_HH', 'COLUMN', N'DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the offset in minutes from UTC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_EMAIL_SKILLGROUP_HH', 'COLUMN', N'UTC_TIMEZONE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_SKILLGROUP for an item of type IT_SKILLGROUP indicating the email skillgroup.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_EMAIL_SKILLGROUP_HH', 'COLUMN', N'SKILLGROUP_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_SKILLGROUP', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_EMAIL_SKILLGROUP_HH', 'COLUMN', N'SKILLGROUP_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total logged in time for all agents in the skillgroup in the half hour interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_EMAIL_SKILLGROUP_HH', 'COLUMN', N'LOGGED_ON_TTH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time in seconds for all agents in the skillgroup that spent in available state.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_EMAIL_SKILLGROUP_HH', 'COLUMN', N'AVAIL_TTH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time in seconds that were spent handling mails to the skillgroup in the half hour interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_EMAIL_SKILLGROUP_HH', 'COLUMN', N'HANDLED_EMAILS_TTH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time in seconds that all mails to the skillgroup in the half hour interval spent in the queue before they were handled.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_EMAIL_SKILLGROUP_HH', 'COLUMN', N'HANDLED_EMAILS_QUEUE_TTH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time in seconds that all mails to the skillgroup in the half hour interval spent in the queue.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_EMAIL_SKILLGROUP_HH', 'COLUMN', N'QUEUE_TTH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This the total number of new case mails sent to the skillgroup in the half hour interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_EMAIL_SKILLGROUP_HH', 'COLUMN', N'NEW_CASE_EMAILS_TH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of mails to the skillgroup in the half hour interval where no case was defined.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_EMAIL_SKILLGROUP_HH', 'COLUMN', N'NO_CASE_EMAILS_TH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of existing case mails received by the skillgroup in the half hour interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_EMAIL_SKILLGROUP_HH', 'COLUMN', N'EXISTING_CASE_EMAILS_TH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of mails offered to the skillgroup in the half hour interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_EMAIL_SKILLGROUP_HH', 'COLUMN', N'OFFERED_EMAILS_TH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of mails forwared to the skillgroup from elsewhere in the half hour interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_EMAIL_SKILLGROUP_HH', 'COLUMN', N'TRANSFER_IN_EMAILS_TH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of mails forwarded elsewhere by the skillgroup in the half hour interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_EMAIL_SKILLGROUP_HH', 'COLUMN', N'TRANSFER_OUT_EMAILS_TH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of mails composed under the skillgroup in the half hour interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_EMAIL_SKILLGROUP_HH', 'COLUMN', N'COMPOSED_EMAILS_TH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of mails to the skillgroup that were replied to in the half hour interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_EMAIL_SKILLGROUP_HH', 'COLUMN', N'REPLIED_EMAILS_TH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of mails to the skillgroup in the half hour interval where an automatic acknowledgement was sent.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_EMAIL_SKILLGROUP_HH', 'COLUMN', N'AUTO_ACK_EMAILS_TH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of mails to the skillgroup in the half hour interval where an automatic reply was sent', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_EMAIL_SKILLGROUP_HH', 'COLUMN', N'AUTO_REPLY_EMAILS_TH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total  number of assigned mails to the skillgroup in the half hour interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_EMAIL_SKILLGROUP_HH', 'COLUMN', N'ASSIGNED_EMAILS_TH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of unassigned mails to the skillgroup in the half hour interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_EMAIL_SKILLGROUP_HH', 'COLUMN', N'UNASSIGNED_EMAILS_TH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of open mails in the skillgroup in the half hour interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_EMAIL_SKILLGROUP_HH', 'COLUMN', N'OPEN_EMAILS_TH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total mails completed in the skillgroup in the half hour interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_EMAIL_SKILLGROUP_HH', 'COLUMN', N'COMPLETED_EMAILS_TH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of handled mails to the skillgroup in the half hour interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_EMAIL_SKILLGROUP_HH', 'COLUMN', N'HANDLED_EMAILS_TH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number mails to the skillgroup in the half hour interval where service level was met.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_EMAIL_SKILLGROUP_HH', 'COLUMN', N'SERVICE_LEVEL_TH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column gives information regarding the source of the data. This corresponds to the RESOURCE_URN from TB_CLU_RESOURCE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_EMAIL_SKILLGROUP_HH', 'COLUMN', N'CLUSTER_RESOURCE_URN'
GO
GRANT SELECT
	ON [dbo].[TB_SUM_EMAIL_SKILLGROUP_HH]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_SUM_EMAIL_SKILLGROUP_HH]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_SUM_EMAIL_SKILLGROUP_HH]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_SUM_EMAIL_SKILLGROUP_HH] SET (LOCK_ESCALATION = TABLE)
GO
