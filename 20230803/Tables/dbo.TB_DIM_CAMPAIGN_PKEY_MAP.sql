SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_DIM_CAMPAIGN_PKEY_MAP] (
		[PKEY_MAP_URN]                      [int] IDENTITY(1, 4) NOT FOR REPLICATION NOT NULL,
		[PKEY_MAP_BIZ_URN]                  [int] NULL,
		[ITEM_BIZ_URN]                      [int] NOT NULL,
		[CLUSTER_RESOURCE_ID]               [uniqueidentifier] NOT NULL,
		[STATUS]                            [char](1) COLLATE Latin1_General_CI_AS NOT NULL,
		[PKEY1]                             [nvarchar](100) COLLATE Latin1_General_CI_AS NULL,
		[PKEY2]                             [nvarchar](100) COLLATE Latin1_General_CI_AS NULL,
		[SOURCE_CHANGE_STAMP]               [int] NULL,
		[INTERNAL_NAME]                     [nvarchar](100) COLLATE Latin1_General_CI_AS NOT NULL,
		[DESCRIPTION]                       [nvarchar](500) COLLATE Latin1_General_CI_AS NOT NULL,
		[ABANDON_ENABLED]                   [bit] NOT NULL,
		[ABANDON_PERCENT]                   [float] NOT NULL,
		[NO_ANSWER_CALLBACK]                [int] NOT NULL,
		[BUSY_CALLBACK]                     [int] NOT NULL,
		[NO_ANSWER_RING_LIMIT]              [int] NOT NULL,
		[MAXIMUM_LINE_AGENT]                [float] NOT NULL,
		[LINES_PER_AGENT]                   [float] NOT NULL,
		[LEAVE_MESSAGE_ENABLED]             [bit] NOT NULL,
		[MAXIMUM_ATTEMPTS]                  [int] NOT NULL,
		[WORK_START_HOURS]                  [int] NOT NULL,
		[WORK_START_MINUTES]                [int] NOT NULL,
		[WORK_END_HOURS]                    [int] NOT NULL,
		[WORK_END_MINUTES]                  [int] NOT NULL,
		[HOME_START_HOURS]                  [int] NOT NULL,
		[HOME_START_MINUTES]                [int] NOT NULL,
		[HOME_END_HOURS]                    [int] NOT NULL,
		[HOME_END_MINUTES]                  [int] NOT NULL,
		[HOME_ENABLED]                      [bit] NOT NULL,
		[WORK_ENABLED]                      [bit] NOT NULL,
		[BUSY_RETRY_ENABLED]                [bit] NOT NULL,
		[MAXIMUM_BUSY_ATTEMPTS]             [smallint] NOT NULL,
		[ANSWER_DETECT_ENABLED]             [bit] NOT NULL,
		[CALLBACK_TIME_LIMIT]               [smallint] NOT NULL,
		[MINIMUM_CALL_DURATION]             [smallint] NOT NULL,
		[EXHAUSTED_CALLS_ENABLED]           [bit] NOT NULL,
		[EDGE_DETECT_ENABLED]               [bit] NOT NULL,
		[QUICK_DETECT_ENABLED]              [bit] NOT NULL,
		[SP_CLOSED_RECORD_ENABLED]          [bit] NOT NULL,
		[SP_CLOSED_RECORD_COUNT]            [smallint] NOT NULL,
		[PERSONALIZED_CALLBACK_ENABLED]     [bit] NOT NULL,
		[RELEASE_CALLBACK_ENABLED]          [bit] NOT NULL,
		[RESCHEDULE_CALLBACK_MODE]          [smallint] NOT NULL,
		[IP_TERMINATING_BEEP_DETECT]        [bit] NOT NULL,
		[CAMPAIGN_PURPOSE_TYPE]             [int] NOT NULL,
		[IPAMD_ENABLED]                     [bit] NOT NULL,
		[AMD_TREATMENT_MODE]                [int] NOT NULL,
		[USE_GMT_FROM_REGION_PREFIX]        [bit] NOT NULL,
		[CONFIG_PARAM]                      [nvarchar](255) COLLATE Latin1_General_CI_AS NULL,
		[ABANDON_CUSTOMER_CALLBACK]         [int] NULL,
		[ABANDONED_DIALER_CALLBACK]         [int] NULL,
		[CUSTOMER_NOT_HOME_CALLBACK]        [int] NULL,
		[ANSWERING_MACHINE_CALLBACK]        [int] NULL,
		[PREFIX_DIGITS]                     [nvarchar](5) COLLATE Latin1_General_CI_AS NULL,
		[WAIT_FOR_BUSY_RETRY]               [bit] NOT NULL,
		[DISABLE_CPA]                       [bit] NOT NULL,
		[DST_LOCATION]                      [int] NOT NULL,
		[ICM_ENABLED]                       [bit] NOT NULL,
		[EFFECTIVE_FROM]                    [datetime] NOT NULL,
		[EFFECTIVE_TO]                      [datetime] NOT NULL,
		[SYSTEM]                            [bit] NOT NULL,
		[PURGED]                            [bit] NOT NULL,
		[LATEST]                            [bit] NOT NULL,
		[CREATED_BY_ID]                     [uniqueidentifier] NOT NULL,
		[MODIFIED_BY_ID]                    [uniqueidentifier] NOT NULL,
		[CREATION_DATE]                     [datetime] NOT NULL,
		[MODIFIED_DATE]                     [datetime] NOT NULL,
		[CHANGE_STAMP]                      [int] NOT NULL,
		[XML_DATA]                          [xml](DOCUMENT [dbo].[ColumnCollection]) NULL,
		[CUSTOM_XML_DATA]                   [xml](DOCUMENT [dbo].[ColumnCollection]) NULL,
		[msrepl_tran_version]               [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TB_DIM_CAMPAIGN_PKEY_MAP]
		PRIMARY KEY
		CLUSTERED
		([PKEY_MAP_URN])
	ON [DIMGROUP]
) ON [DIMGROUP] TEXTIMAGE_ON [DIMGROUP]
GO
ALTER TABLE [dbo].[TB_DIM_CAMPAIGN_PKEY_MAP]
	ADD
	CONSTRAINT [CK_TB_DIM_CAMPAIGN_PKEY_MAP_DELETE_CONSISTENCEY]
	CHECK
	(case when [STATUS]='D' AND [EFFECTIVE_TO]>getutcdate() then (1) else (0) end=(0))
GO
ALTER TABLE [dbo].[TB_DIM_CAMPAIGN_PKEY_MAP]
CHECK CONSTRAINT [CK_TB_DIM_CAMPAIGN_PKEY_MAP_DELETE_CONSISTENCEY]
GO
ALTER TABLE [dbo].[TB_DIM_CAMPAIGN_PKEY_MAP]
	ADD
	CONSTRAINT [CK_TB_DIM_CAMPAIGN_PKEY_MAP_PURGE_CONSISTENCEY]
	CHECK
	(case when [STATUS]<>'D' AND [PURGED]=(1) then (1) else (0) end=(0))
GO
ALTER TABLE [dbo].[TB_DIM_CAMPAIGN_PKEY_MAP]
CHECK CONSTRAINT [CK_TB_DIM_CAMPAIGN_PKEY_MAP_PURGE_CONSISTENCEY]
GO
ALTER TABLE [dbo].[TB_DIM_CAMPAIGN_PKEY_MAP]
	ADD
	CONSTRAINT [CK_TB_DIM_CAMPAIGN_PKEY_MAP_LATEST_CONSISTENCEY]
	CHECK
	(case when [LATEST]=(0) AND ([STATUS]<>'D' OR [PURGED]=(0) OR [EFFECTIVE_TO]>getutcdate()) then (1) else (0) end=(0))
GO
ALTER TABLE [dbo].[TB_DIM_CAMPAIGN_PKEY_MAP]
CHECK CONSTRAINT [CK_TB_DIM_CAMPAIGN_PKEY_MAP_LATEST_CONSISTENCEY]
GO
ALTER TABLE [dbo].[TB_DIM_CAMPAIGN_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_CAMPAIGN_PKEY_MAP_CREATION_DATE]
	DEFAULT (getutcdate()) FOR [CREATION_DATE]
GO
ALTER TABLE [dbo].[TB_DIM_CAMPAIGN_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_CAMPAIGN_PKEY_MAP_EFFECTIVE_FROM]
	DEFAULT (getutcdate()) FOR [EFFECTIVE_FROM]
GO
ALTER TABLE [dbo].[TB_DIM_CAMPAIGN_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_CAMPAIGN_PKEY_MAP_EFFECTIVE_TO]
	DEFAULT ('2079-06-06 00:00:00') FOR [EFFECTIVE_TO]
GO
ALTER TABLE [dbo].[TB_DIM_CAMPAIGN_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_CAMPAIGN_PKEY_MAP_LATEST]
	DEFAULT ((1)) FOR [LATEST]
GO
ALTER TABLE [dbo].[TB_DIM_CAMPAIGN_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_CAMPAIGN_PKEY_MAP_SYSTEM]
	DEFAULT ((0)) FOR [SYSTEM]
GO
ALTER TABLE [dbo].[TB_DIM_CAMPAIGN_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_CAMPAIGN_PKEY_MAP_PURGED]
	DEFAULT ((0)) FOR [PURGED]
GO
ALTER TABLE [dbo].[TB_DIM_CAMPAIGN_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_CAMPAIGN_PKEY_MAP_CHANGE_STAMP]
	DEFAULT ((0)) FOR [CHANGE_STAMP]
GO
ALTER TABLE [dbo].[TB_DIM_CAMPAIGN_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_CAMPAIGN_PKEY_MAP_INTERNAL_NAME]
	DEFAULT (N'') FOR [INTERNAL_NAME]
GO
ALTER TABLE [dbo].[TB_DIM_CAMPAIGN_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_CAMPAIGN_PKEY_MAP_DESCRIPTION]
	DEFAULT (N'') FOR [DESCRIPTION]
GO
ALTER TABLE [dbo].[TB_DIM_CAMPAIGN_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_CAMPAIGN_PKEY_MAP_ABANDON_ENABLED]
	DEFAULT ((0)) FOR [ABANDON_ENABLED]
GO
ALTER TABLE [dbo].[TB_DIM_CAMPAIGN_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_CAMPAIGN_PKEY_MAP_ABANDON_PERCENT]
	DEFAULT ((0)) FOR [ABANDON_PERCENT]
GO
ALTER TABLE [dbo].[TB_DIM_CAMPAIGN_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_CAMPAIGN_PKEY_MAP_NO_ANSWER_CALLBACK]
	DEFAULT ((0)) FOR [NO_ANSWER_CALLBACK]
GO
ALTER TABLE [dbo].[TB_DIM_CAMPAIGN_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_CAMPAIGN_PKEY_MAP_BUSY_CALLBACK]
	DEFAULT ((0)) FOR [BUSY_CALLBACK]
GO
ALTER TABLE [dbo].[TB_DIM_CAMPAIGN_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_CAMPAIGN_PKEY_MAP_NO_ANSWER_RING_LIMIT]
	DEFAULT ((0)) FOR [NO_ANSWER_RING_LIMIT]
GO
ALTER TABLE [dbo].[TB_DIM_CAMPAIGN_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_CAMPAIGN_PKEY_MAP_MAXIMUM_LINE_AGENT]
	DEFAULT ((0)) FOR [MAXIMUM_LINE_AGENT]
GO
ALTER TABLE [dbo].[TB_DIM_CAMPAIGN_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_CAMPAIGN_PKEY_MAP_LINES_PER_AGENT]
	DEFAULT ((0)) FOR [LINES_PER_AGENT]
GO
ALTER TABLE [dbo].[TB_DIM_CAMPAIGN_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_CAMPAIGN_PKEY_MAP_LEAVE_MESSAGE_ENABLED]
	DEFAULT ((0)) FOR [LEAVE_MESSAGE_ENABLED]
GO
ALTER TABLE [dbo].[TB_DIM_CAMPAIGN_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_CAMPAIGN_PKEY_MAP_MAXIMUM_ATTEMPTS]
	DEFAULT ((0)) FOR [MAXIMUM_ATTEMPTS]
GO
ALTER TABLE [dbo].[TB_DIM_CAMPAIGN_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_CAMPAIGN_PKEY_MAP_WORK_START_HOURS]
	DEFAULT ((0)) FOR [WORK_START_HOURS]
GO
ALTER TABLE [dbo].[TB_DIM_CAMPAIGN_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_CAMPAIGN_PKEY_MAP_WORK_START_MINUTES]
	DEFAULT ((0)) FOR [WORK_START_MINUTES]
GO
ALTER TABLE [dbo].[TB_DIM_CAMPAIGN_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_CAMPAIGN_PKEY_MAP_WORK_END_HOURS]
	DEFAULT ((0)) FOR [WORK_END_HOURS]
GO
ALTER TABLE [dbo].[TB_DIM_CAMPAIGN_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_CAMPAIGN_PKEY_MAP_WORK_END_MINUTES]
	DEFAULT ((0)) FOR [WORK_END_MINUTES]
GO
ALTER TABLE [dbo].[TB_DIM_CAMPAIGN_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_CAMPAIGN_PKEY_MAP_HOME_START_HOURS]
	DEFAULT ((0)) FOR [HOME_START_HOURS]
GO
ALTER TABLE [dbo].[TB_DIM_CAMPAIGN_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_CAMPAIGN_PKEY_MAP_HOME_START_MINUTES]
	DEFAULT ((0)) FOR [HOME_START_MINUTES]
GO
ALTER TABLE [dbo].[TB_DIM_CAMPAIGN_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_CAMPAIGN_PKEY_MAP_HOME_END_HOURS]
	DEFAULT ((0)) FOR [HOME_END_HOURS]
GO
ALTER TABLE [dbo].[TB_DIM_CAMPAIGN_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_CAMPAIGN_PKEY_MAP_HOME_END_MINUTES]
	DEFAULT ((0)) FOR [HOME_END_MINUTES]
GO
ALTER TABLE [dbo].[TB_DIM_CAMPAIGN_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_CAMPAIGN_PKEY_MAP_HOME_ENABLED]
	DEFAULT ((0)) FOR [HOME_ENABLED]
GO
ALTER TABLE [dbo].[TB_DIM_CAMPAIGN_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_CAMPAIGN_PKEY_MAP_WORK_ENABLED]
	DEFAULT ((0)) FOR [WORK_ENABLED]
GO
ALTER TABLE [dbo].[TB_DIM_CAMPAIGN_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_CAMPAIGN_PKEY_MAP_BUSY_RETRY_ENABLED]
	DEFAULT ((0)) FOR [BUSY_RETRY_ENABLED]
GO
ALTER TABLE [dbo].[TB_DIM_CAMPAIGN_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_CAMPAIGN_PKEY_MAP_MAXIMUM_BUSY_ATTEMPTS]
	DEFAULT ((0)) FOR [MAXIMUM_BUSY_ATTEMPTS]
GO
ALTER TABLE [dbo].[TB_DIM_CAMPAIGN_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_CAMPAIGN_PKEY_MAP_ANSWER_DETECT_ENABLED]
	DEFAULT ((0)) FOR [ANSWER_DETECT_ENABLED]
GO
ALTER TABLE [dbo].[TB_DIM_CAMPAIGN_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_CAMPAIGN_PKEY_MAP_CALLBACK_TIME_LIMIT]
	DEFAULT ((0)) FOR [CALLBACK_TIME_LIMIT]
GO
ALTER TABLE [dbo].[TB_DIM_CAMPAIGN_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_CAMPAIGN_PKEY_MAP_MINIMUM_CALL_DURATION]
	DEFAULT ((1)) FOR [MINIMUM_CALL_DURATION]
GO
ALTER TABLE [dbo].[TB_DIM_CAMPAIGN_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_CAMPAIGN_PKEY_MAP_EXHAUSTED_CALLS_ENABLED]
	DEFAULT ((0)) FOR [EXHAUSTED_CALLS_ENABLED]
GO
ALTER TABLE [dbo].[TB_DIM_CAMPAIGN_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_CAMPAIGN_PKEY_MAP_EDGE_DETECT_ENABLED]
	DEFAULT ((0)) FOR [EDGE_DETECT_ENABLED]
GO
ALTER TABLE [dbo].[TB_DIM_CAMPAIGN_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_CAMPAIGN_PKEY_MAP_QUICK_DETECT_ENABLED]
	DEFAULT ((0)) FOR [QUICK_DETECT_ENABLED]
GO
ALTER TABLE [dbo].[TB_DIM_CAMPAIGN_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_CAMPAIGN_PKEY_MAP_SP_CLOSED_RECORD_ENABLED]
	DEFAULT ((0)) FOR [SP_CLOSED_RECORD_ENABLED]
GO
ALTER TABLE [dbo].[TB_DIM_CAMPAIGN_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_CAMPAIGN_PKEY_MAP_SP_CLOSED_RECORD_COUNT]
	DEFAULT ((0)) FOR [SP_CLOSED_RECORD_COUNT]
GO
ALTER TABLE [dbo].[TB_DIM_CAMPAIGN_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_CAMPAIGN_PKEY_MAP_PERSONALIZED_CALLBACK_ENABLED]
	DEFAULT ((0)) FOR [PERSONALIZED_CALLBACK_ENABLED]
GO
ALTER TABLE [dbo].[TB_DIM_CAMPAIGN_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_CAMPAIGN_PKEY_MAP_RELEASE_CALLBACK_ENABLED]
	DEFAULT ((0)) FOR [RELEASE_CALLBACK_ENABLED]
GO
ALTER TABLE [dbo].[TB_DIM_CAMPAIGN_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_CAMPAIGN_PKEY_MAP_RESCHEDULE_CALLBACK_MODE]
	DEFAULT ((0)) FOR [RESCHEDULE_CALLBACK_MODE]
GO
ALTER TABLE [dbo].[TB_DIM_CAMPAIGN_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_CAMPAIGN_PKEY_MAP_IP_TERMINATING_BEEP_DETECT]
	DEFAULT ((0)) FOR [IP_TERMINATING_BEEP_DETECT]
GO
ALTER TABLE [dbo].[TB_DIM_CAMPAIGN_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_CAMPAIGN_PKEY_MAP_CAMPAIGN_PURPOSE_TYPE]
	DEFAULT ((1)) FOR [CAMPAIGN_PURPOSE_TYPE]
GO
ALTER TABLE [dbo].[TB_DIM_CAMPAIGN_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_CAMPAIGN_PKEY_MAP_IPAMD_ENABLED]
	DEFAULT ((0)) FOR [IPAMD_ENABLED]
GO
ALTER TABLE [dbo].[TB_DIM_CAMPAIGN_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_CAMPAIGN_PKEY_MAP_AMD_TREATMENT_MODE]
	DEFAULT ((1)) FOR [AMD_TREATMENT_MODE]
GO
ALTER TABLE [dbo].[TB_DIM_CAMPAIGN_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_CAMPAIGN_PKEY_MAP_USE_GMT_FROM_REGION_PREFIX]
	DEFAULT ((1)) FOR [USE_GMT_FROM_REGION_PREFIX]
GO
ALTER TABLE [dbo].[TB_DIM_CAMPAIGN_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_CAMPAIGN_PKEY_MAP_WAIT_FOR_BUSY_RETRY]
	DEFAULT ((1)) FOR [WAIT_FOR_BUSY_RETRY]
GO
ALTER TABLE [dbo].[TB_DIM_CAMPAIGN_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_CAMPAIGN_PKEY_MAP_DISABLE_CPA]
	DEFAULT ((0)) FOR [DISABLE_CPA]
GO
ALTER TABLE [dbo].[TB_DIM_CAMPAIGN_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_CAMPAIGN_PKEY_MAP_DST_LOCATION]
	DEFAULT ((1)) FOR [DST_LOCATION]
GO
ALTER TABLE [dbo].[TB_DIM_CAMPAIGN_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_CAMPAIGN_PKEY_MAP_ICM_ENABLED]
	DEFAULT ((1)) FOR [ICM_ENABLED]
GO
ALTER TABLE [dbo].[TB_DIM_CAMPAIGN_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_CAMPAIGN_PKEY_MAP_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_DIM_CAMPAIGN_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_CAMPAIGN_PKEY_MAP_STATUS]
	DEFAULT ('N') FOR [STATUS]
GO
ALTER TABLE [dbo].[TB_DIM_CAMPAIGN_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_CAMPAIGN_PKEY_MAP_MODIFIED_DATE]
	DEFAULT (getutcdate()) FOR [MODIFIED_DATE]
GO
ALTER TABLE [dbo].[TB_DIM_CAMPAIGN_PKEY_MAP]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_DIM_CAMPAIGN_PKEY_MAP_PKEY_MAP_BIZ_URN]
	FOREIGN KEY ([PKEY_MAP_BIZ_URN]) REFERENCES [dbo].[TB_DIM_CAMPAIGN_PKEY_MAP] ([PKEY_MAP_URN])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_DIM_CAMPAIGN_PKEY_MAP]
	CHECK CONSTRAINT [FK_TB_DIM_CAMPAIGN_PKEY_MAP_PKEY_MAP_BIZ_URN]

GO
ALTER TABLE [dbo].[TB_DIM_CAMPAIGN_PKEY_MAP]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_DIM_CAMPAIGN_PKEY_MAP_TB_CLU_RESOURCE]
	FOREIGN KEY ([CLUSTER_RESOURCE_ID]) REFERENCES [dbo].[TB_CLU_RESOURCE] ([RESOURCE_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_DIM_CAMPAIGN_PKEY_MAP]
	CHECK CONSTRAINT [FK_TB_DIM_CAMPAIGN_PKEY_MAP_TB_CLU_RESOURCE]

GO
ALTER TABLE [dbo].[TB_DIM_CAMPAIGN_PKEY_MAP]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_DIM_CAMPAIGN_PKEY_MAP_ITEM_BIZ_URN]
	FOREIGN KEY ([ITEM_BIZ_URN]) REFERENCES [dbo].[TB_DIM_CAMPAIGN] ([ITEM_URN])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_DIM_CAMPAIGN_PKEY_MAP]
	CHECK CONSTRAINT [FK_TB_DIM_CAMPAIGN_PKEY_MAP_ITEM_BIZ_URN]

GO
CREATE NONCLUSTERED INDEX [IX_TB_DIM_CAMPAIGN_PKEY_MAP_ITEM_CLUSTER_RESOURCE]
	ON [dbo].[TB_DIM_CAMPAIGN_PKEY_MAP] ([ITEM_BIZ_URN], [LATEST], [CLUSTER_RESOURCE_ID], [STATUS], [EFFECTIVE_FROM], [EFFECTIVE_TO])
	INCLUDE ([PURGED])
	ON [DIMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_DIM_CAMPAIGN_PKEY_MAP_CLUSTER_RESOURCE_PKEY]
	ON [dbo].[TB_DIM_CAMPAIGN_PKEY_MAP] ([CLUSTER_RESOURCE_ID], [PKEY1], [PKEY2])
	INCLUDE ([PURGED])
	ON [DIMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_DIM_CAMPAIGN_PKEY_MAP_CLUSTER_RESOURCE_STATUS]
	ON [dbo].[TB_DIM_CAMPAIGN_PKEY_MAP] ([CLUSTER_RESOURCE_ID], [STATUS], [EFFECTIVE_FROM], [EFFECTIVE_TO])
	INCLUDE ([ITEM_BIZ_URN], [LATEST], [PURGED])
	ON [DIMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_DIM_CAMPAIGN_PKEY_MAP_INTERNAL_NAME]
	ON [dbo].[TB_DIM_CAMPAIGN_PKEY_MAP] ([INTERNAL_NAME])
	ON [DIMINDEXGROUP]
GO
SET ANSI_PADDING ON
GO
CREATE UNIQUE NONCLUSTERED INDEX [UN_TB_DIM_CAMPAIGN_PKEY_MAP_PKEY1_PKEY2_CLUSTER_RESOURCE_ID]
	ON [dbo].[TB_DIM_CAMPAIGN_PKEY_MAP] ([PKEY1], [PKEY2], [CLUSTER_RESOURCE_ID])
	WHERE (([PKEY1] IS NOT NULL AND [PURGED]=(0)))
	ON [DIMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_DIM_CAMPAIGN_PKEY_MAP_PKEY_MAP_BIZ_URN]
	ON [dbo].[TB_DIM_CAMPAIGN_PKEY_MAP] ([PKEY_MAP_BIZ_URN])
	ON [DIMINDEXGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table stores the mappings for Campaigns in TB_DIM_CAMPAIGN corresponding to the items on various sources for the application. This sources can be CICMs, NAMs, WMS, IVRs etc.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CAMPAIGN_PKEY_MAP', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CAMPAIGN_PKEY_MAP', 'COLUMN', N'PKEY_MAP_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the business key for this entity. This key references the parent row.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CAMPAIGN_PKEY_MAP', 'COLUMN', N'PKEY_MAP_BIZ_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_CAMPAIGN corresponding to the item for which the mapping is defined. This is unique for a given source specified by the column CLUSTER_RESOURCE_ID.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CAMPAIGN_PKEY_MAP', 'COLUMN', N'ITEM_BIZ_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id of the logical resoource as in TB_CLU_RESOURCE that corresponds to the source for which the mapping is defined for the given item.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CAMPAIGN_PKEY_MAP', 'COLUMN', N'CLUSTER_RESOURCE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the a charactor flag indicating the status of the item on the specified equipment. Possible values are; R: Ready, S: Pending Active, P: Pending Delete, D: Delete confirmed, E: Error, N: Not applicable.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CAMPAIGN_PKEY_MAP', 'COLUMN', N'STATUS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the primary identifier of the item on the specified source. This has to be unique on the specified source. For example, this can be a primary key value on any source database table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CAMPAIGN_PKEY_MAP', 'COLUMN', N'PKEY1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the secondary identifier of the item on the specified source.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CAMPAIGN_PKEY_MAP', 'COLUMN', N'PKEY2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'If specified this is the change stamp of the item on the source equipment.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CAMPAIGN_PKEY_MAP', 'COLUMN', N'SOURCE_CHANGE_STAMP'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The name of the item.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CAMPAIGN_PKEY_MAP', 'COLUMN', N'INTERNAL_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The description of the item.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CAMPAIGN_PKEY_MAP', 'COLUMN', N'DESCRIPTION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the column AbandonEnabled in Cisco ICM\IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CAMPAIGN_PKEY_MAP', 'COLUMN', N'ABANDON_ENABLED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the column AbandonPercent in Cisco ICM\IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CAMPAIGN_PKEY_MAP', 'COLUMN', N'ABANDON_PERCENT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the column NoAnswerCallback in Cisco ICM\IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CAMPAIGN_PKEY_MAP', 'COLUMN', N'NO_ANSWER_CALLBACK'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the column BusyCallback in Cisco ICM\IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CAMPAIGN_PKEY_MAP', 'COLUMN', N'BUSY_CALLBACK'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the column NoAnswerRingLimit in Cisco ICM\IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CAMPAIGN_PKEY_MAP', 'COLUMN', N'NO_ANSWER_RING_LIMIT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the column MaximumLineAgent in Cisco ICM\IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CAMPAIGN_PKEY_MAP', 'COLUMN', N'MAXIMUM_LINE_AGENT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the column LinesPerAgent in Cisco ICM\IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CAMPAIGN_PKEY_MAP', 'COLUMN', N'LINES_PER_AGENT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the column LeaveMessageEnabled in Cisco ICM\IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CAMPAIGN_PKEY_MAP', 'COLUMN', N'LEAVE_MESSAGE_ENABLED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the column MaxAttempts in Cisco ICM\IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CAMPAIGN_PKEY_MAP', 'COLUMN', N'MAXIMUM_ATTEMPTS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the column WorkStartHours in Cisco ICM\IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CAMPAIGN_PKEY_MAP', 'COLUMN', N'WORK_START_HOURS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the column WorkStartMinutes in Cisco ICM\IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CAMPAIGN_PKEY_MAP', 'COLUMN', N'WORK_START_MINUTES'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the column WorkEndHours in Cisco ICM\IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CAMPAIGN_PKEY_MAP', 'COLUMN', N'WORK_END_HOURS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the column WorkEndMinutes in Cisco ICM\IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CAMPAIGN_PKEY_MAP', 'COLUMN', N'WORK_END_MINUTES'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the column HomeStartHours in Cisco ICM\IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CAMPAIGN_PKEY_MAP', 'COLUMN', N'HOME_START_HOURS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the column HomeStartMinutes in Cisco ICM\IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CAMPAIGN_PKEY_MAP', 'COLUMN', N'HOME_START_MINUTES'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the column HomeEndHours in Cisco ICM\IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CAMPAIGN_PKEY_MAP', 'COLUMN', N'HOME_END_HOURS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the column HomeEndMinutes in Cisco ICM\IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CAMPAIGN_PKEY_MAP', 'COLUMN', N'HOME_END_MINUTES'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the column HomeEnabled in Cisco ICM\IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CAMPAIGN_PKEY_MAP', 'COLUMN', N'HOME_ENABLED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the column WorkEnabled in Cisco ICM\IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CAMPAIGN_PKEY_MAP', 'COLUMN', N'WORK_ENABLED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the column BusyRetryEnabled in Cisco ICM\IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CAMPAIGN_PKEY_MAP', 'COLUMN', N'BUSY_RETRY_ENABLED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the column MaxBusyAttempts in Cisco ICM\IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CAMPAIGN_PKEY_MAP', 'COLUMN', N'MAXIMUM_BUSY_ATTEMPTS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the column AnswerDetectEnabled in Cisco ICM\IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CAMPAIGN_PKEY_MAP', 'COLUMN', N'ANSWER_DETECT_ENABLED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the column CallbackTimeLimit in Cisco ICM\IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CAMPAIGN_PKEY_MAP', 'COLUMN', N'CALLBACK_TIME_LIMIT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the column MinimumCallDuration in Cisco ICM\IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CAMPAIGN_PKEY_MAP', 'COLUMN', N'MINIMUM_CALL_DURATION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the column ExhaustedCallsEnabled in Cisco ICM\IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CAMPAIGN_PKEY_MAP', 'COLUMN', N'EXHAUSTED_CALLS_ENABLED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the column EdgeDetectEnabled in Cisco ICM\IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CAMPAIGN_PKEY_MAP', 'COLUMN', N'EDGE_DETECT_ENABLED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the column QuickDetectEnabled in Cisco ICM\IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CAMPAIGN_PKEY_MAP', 'COLUMN', N'QUICK_DETECT_ENABLED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the column SPClosedRecordEnabled in Cisco ICM\IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CAMPAIGN_PKEY_MAP', 'COLUMN', N'SP_CLOSED_RECORD_ENABLED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the column SPClosedRecordCount in Cisco ICM\IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CAMPAIGN_PKEY_MAP', 'COLUMN', N'SP_CLOSED_RECORD_COUNT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the column PersonalizedCallbackEnabled in Cisco ICM\IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CAMPAIGN_PKEY_MAP', 'COLUMN', N'PERSONALIZED_CALLBACK_ENABLED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the column ReleaseCallbackEnabled in Cisco ICM\IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CAMPAIGN_PKEY_MAP', 'COLUMN', N'RELEASE_CALLBACK_ENABLED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the column RescheduleCallbackMode in Cisco ICM\IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CAMPAIGN_PKEY_MAP', 'COLUMN', N'RESCHEDULE_CALLBACK_MODE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the column IPTerminatingBeepDetect in Cisco ICM\IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CAMPAIGN_PKEY_MAP', 'COLUMN', N'IP_TERMINATING_BEEP_DETECT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the column CampaignPurposeType in Cisco ICM\IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CAMPAIGN_PKEY_MAP', 'COLUMN', N'CAMPAIGN_PURPOSE_TYPE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the column IPAMDEnabled in Cisco ICM\IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CAMPAIGN_PKEY_MAP', 'COLUMN', N'IPAMD_ENABLED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the column AMDTreatmentMode in Cisco ICM\IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CAMPAIGN_PKEY_MAP', 'COLUMN', N'AMD_TREATMENT_MODE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the column UseGMTFromRegionPrefix in Cisco ICM\IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CAMPAIGN_PKEY_MAP', 'COLUMN', N'USE_GMT_FROM_REGION_PREFIX'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the column ConfigParam in Cisco ICM\IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CAMPAIGN_PKEY_MAP', 'COLUMN', N'CONFIG_PARAM'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the column AbandonCustomerCallback in Cisco ICM\IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CAMPAIGN_PKEY_MAP', 'COLUMN', N'ABANDON_CUSTOMER_CALLBACK'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the column AbandonedDialerCallback in Cisco ICM\IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CAMPAIGN_PKEY_MAP', 'COLUMN', N'ABANDONED_DIALER_CALLBACK'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the column CustomerNotHomeCallback in Cisco ICM\IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CAMPAIGN_PKEY_MAP', 'COLUMN', N'CUSTOMER_NOT_HOME_CALLBACK'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the column AnsweringMachineCallback in Cisco ICM\IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CAMPAIGN_PKEY_MAP', 'COLUMN', N'ANSWERING_MACHINE_CALLBACK'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the column PrefixDigits in Cisco ICM\IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CAMPAIGN_PKEY_MAP', 'COLUMN', N'PREFIX_DIGITS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the column WaitForBusyRetry in Cisco ICM\IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CAMPAIGN_PKEY_MAP', 'COLUMN', N'WAIT_FOR_BUSY_RETRY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the column DisableCPA in Cisco ICM\IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CAMPAIGN_PKEY_MAP', 'COLUMN', N'DISABLE_CPA'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the column DSTLocation in Cisco ICM\IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CAMPAIGN_PKEY_MAP', 'COLUMN', N'DST_LOCATION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the column Enabled in Cisco ICM\IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CAMPAIGN_PKEY_MAP', 'COLUMN', N'ICM_ENABLED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a UTC date time indicating when the item becomes active on the specified source.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CAMPAIGN_PKEY_MAP', 'COLUMN', N'EFFECTIVE_FROM'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a UTC date time indicating when the item ceases to exist on the specified source.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CAMPAIGN_PKEY_MAP', 'COLUMN', N'EFFECTIVE_TO'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Not used.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CAMPAIGN_PKEY_MAP', 'COLUMN', N'SYSTEM'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Whether or not the item has been purged (ie. row physically removed) from the equipment.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CAMPAIGN_PKEY_MAP', 'COLUMN', N'PURGED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the item is latest or not. Value 1 indicates latest. For type 2 pkey map change this value is set to 0 for parent pkey maps.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CAMPAIGN_PKEY_MAP', 'COLUMN', N'LATEST'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the ID from TB_SEC_USER indicating the user who created the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CAMPAIGN_PKEY_MAP', 'COLUMN', N'CREATED_BY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the ID from TB_SEC_USER indicating the user who last modified the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CAMPAIGN_PKEY_MAP', 'COLUMN', N'MODIFIED_BY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the UTC date time indicating when the record was created.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CAMPAIGN_PKEY_MAP', 'COLUMN', N'CREATION_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the UTC date time indicating when the record was last modified.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CAMPAIGN_PKEY_MAP', 'COLUMN', N'MODIFIED_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the change stamp for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CAMPAIGN_PKEY_MAP', 'COLUMN', N'CHANGE_STAMP'
GO
EXEC sp_addextendedproperty N'MS_Description', N'XML data block', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CAMPAIGN_PKEY_MAP', 'COLUMN', N'XML_DATA'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Custom XML data block', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CAMPAIGN_PKEY_MAP', 'COLUMN', N'CUSTOM_XML_DATA'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CAMPAIGN_PKEY_MAP', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_DIM_CAMPAIGN_PKEY_MAP]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_DIM_CAMPAIGN_PKEY_MAP]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_DIM_CAMPAIGN_PKEY_MAP]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_DIM_CAMPAIGN_PKEY_MAP]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_DIM_CAMPAIGN_PKEY_MAP]
	TO [portalrs_role]
GO
ALTER TABLE [dbo].[TB_DIM_CAMPAIGN_PKEY_MAP] SET (LOCK_ESCALATION = TABLE)
GO
