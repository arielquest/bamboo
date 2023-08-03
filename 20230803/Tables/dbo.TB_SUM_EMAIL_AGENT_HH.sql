SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TB_SUM_EMAIL_AGENT_HH] (
		[PARTITION_URN]                [int] IDENTITY(1, 1) NOT NULL,
		[PARTITION_ID]                 [int] NOT NULL,
		[PARTITION_GLOBAL_URN]         [bigint] NOT NULL,
		[DATE_URN]                     [int] NOT NULL,
		[TIME_URN]                     [smallint] NOT NULL,
		[DATE_UTC_URN]                 [int] NOT NULL,
		[TIME_UTC_URN]                 [smallint] NOT NULL,
		[DATE_TIME]                    [datetime] NOT NULL,
		[UTC_TIMEZONE]                 [int] NOT NULL,
		[AGENT_URN]                    [int] NOT NULL,
		[SKILLGROUP_URN]               [int] NULL,
		[LOGGED_ON_TTH]                [int] NULL,
		[AVAIL_TTH]                    [int] NULL,
		[QUEUE_TTH]                    [int] NULL,
		[HANDLED_EMAILS_QUEUE_TTH]     [int] NULL,
		[HANDLED_EMAILS_TTH]           [int] NULL,
		[HANDLED_EMAIL_TH]             [int] NULL,
		[FORWARDED_IN_EMAILS_TH]       [int] NULL,
		[FORWARDED_OUT_EMAILS_TH]      [int] NULL,
		[DELETED_EMAILS_TH]            [int] NULL,
		[AGENT_OUT_EMAILS_TH]          [int] NULL,
		[CLUSTER_RESOURCE_URN]         [int] NOT NULL
) ON [SUMMMGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_SUM_EMAIL_AGENT_HH_DATE_TIME]
	ON [dbo].[TB_SUM_EMAIL_AGENT_HH] ([DATE_TIME])
	ON [SUMMMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_EMAIL_AGENT_HH', 'INDEX', N'IX_SUM_EMAIL_AGENT_HH_DATE_TIME'
GO
CREATE NONCLUSTERED INDEX [IX_SUM_EMAIL_AGENT_HH_DATE_URN]
	ON [dbo].[TB_SUM_EMAIL_AGENT_HH] ([DATE_URN])
	ON [SUMMMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_EMAIL_AGENT_HH', 'INDEX', N'IX_SUM_EMAIL_AGENT_HH_DATE_URN'
GO
CREATE NONCLUSTERED INDEX [IX_SUM_EMAIL_AGENT_HH_AGENT_URN]
	ON [dbo].[TB_SUM_EMAIL_AGENT_HH] ([AGENT_URN])
	ON [SUMMMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_EMAIL_AGENT_HH', 'INDEX', N'IX_SUM_EMAIL_AGENT_HH_AGENT_URN'
GO
CREATE NONCLUSTERED INDEX [IX_SUM_EMAIL_AGENT_HH_SKILLGROUP_URN]
	ON [dbo].[TB_SUM_EMAIL_AGENT_HH] ([SKILLGROUP_URN])
	ON [SUMMMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_EMAIL_AGENT_HH', 'INDEX', N'IX_SUM_EMAIL_AGENT_HH_SKILLGROUP_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the partition.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_EMAIL_AGENT_HH', 'COLUMN', N'PARTITION_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number for the current partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_EMAIL_AGENT_HH', 'COLUMN', N'PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column holds a value that uniquely identifies a row across all the partition tables for this partition type.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_EMAIL_AGENT_HH', 'COLUMN', N'PARTITION_GLOBAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the date associated with the record. This is calculated by the data importer based on the source date time corresponding to the start of the half hour interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_EMAIL_AGENT_HH', 'COLUMN', N'DATE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DATE', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_EMAIL_AGENT_HH', 'COLUMN', N'DATE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the time associated with the record. This is calculated by the data importer based on the source date time corresponding to the start of the half hour interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_EMAIL_AGENT_HH', 'COLUMN', N'TIME_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIME', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_EMAIL_AGENT_HH', 'COLUMN', N'TIME_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the UTC date associated with the record. This is calculated by the data importer based on the source date time corresponding to the start of the half hour interval and the TimeZone information from the source data.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_EMAIL_AGENT_HH', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DATE', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_EMAIL_AGENT_HH', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the UTC time associated with the record. This is calculated by the data importer based on the source date time corresponding to the start of the half hour interval and the TimeZone information from the source data.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_EMAIL_AGENT_HH', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIME', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_EMAIL_AGENT_HH', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the wall clock date time corresponding to the start of the half hour interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_EMAIL_AGENT_HH', 'COLUMN', N'DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the offset in minutes from UTC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_EMAIL_AGENT_HH', 'COLUMN', N'UTC_TIMEZONE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_AGENT for an item of type IT_AGENT indicating the email agent.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_EMAIL_AGENT_HH', 'COLUMN', N'AGENT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_AGENT', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_EMAIL_AGENT_HH', 'COLUMN', N'AGENT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_SKILLGROUP for an item of type IT_SKILLGROUP indicating the skillgroup associated with the email agent.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_EMAIL_AGENT_HH', 'COLUMN', N'SKILLGROUP_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_SKILLGROUP', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_EMAIL_AGENT_HH', 'COLUMN', N'SKILLGROUP_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total logged in time in seconds by the agent on the skillgroup in the half hour interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_EMAIL_AGENT_HH', 'COLUMN', N'LOGGED_ON_TTH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time in seconds when the agent was in available state for the skillgroup in the half hour interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_EMAIL_AGENT_HH', 'COLUMN', N'AVAIL_TTH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time in seconds spent by all email to the agent on the queue in the half hour interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_EMAIL_AGENT_HH', 'COLUMN', N'QUEUE_TTH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time in seconds spent on the queue by all email that were handled by the agent in the half hour interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_EMAIL_AGENT_HH', 'COLUMN', N'HANDLED_EMAILS_QUEUE_TTH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total handle time in seconds for all the emails that were handled by the agent in the half hour interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_EMAIL_AGENT_HH', 'COLUMN', N'HANDLED_EMAILS_TTH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of email handled by the agent in the half hour interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_EMAIL_AGENT_HH', 'COLUMN', N'HANDLED_EMAIL_TH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of emails that were forwarded to the agent in the half hour interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_EMAIL_AGENT_HH', 'COLUMN', N'FORWARDED_IN_EMAILS_TH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of emails that forwarded elsewhere by the agent in the half hour interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_EMAIL_AGENT_HH', 'COLUMN', N'FORWARDED_OUT_EMAILS_TH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of emails deleted by the agent in the half hour interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_EMAIL_AGENT_HH', 'COLUMN', N'DELETED_EMAILS_TH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of email initiated by the agent in the half hour interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_EMAIL_AGENT_HH', 'COLUMN', N'AGENT_OUT_EMAILS_TH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column gives information regarding the source of the data. This corresponds to the RESOURCE_URN from TB_CLU_RESOURCE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_EMAIL_AGENT_HH', 'COLUMN', N'CLUSTER_RESOURCE_URN'
GO
GRANT SELECT
	ON [dbo].[TB_SUM_EMAIL_AGENT_HH]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_SUM_EMAIL_AGENT_HH]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_SUM_EMAIL_AGENT_HH]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_SUM_EMAIL_AGENT_HH] SET (LOCK_ESCALATION = TABLE)
GO
