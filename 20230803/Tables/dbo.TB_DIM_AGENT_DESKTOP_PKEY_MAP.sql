SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_DIM_AGENT_DESKTOP_PKEY_MAP] (
		[PKEY_MAP_URN]                          [int] IDENTITY(1, 4) NOT FOR REPLICATION NOT NULL,
		[PKEY_MAP_BIZ_URN]                      [int] NULL,
		[ITEM_BIZ_URN]                          [int] NOT NULL,
		[CLUSTER_RESOURCE_ID]                   [uniqueidentifier] NOT NULL,
		[STATUS]                                [char](1) COLLATE Latin1_General_CI_AS NOT NULL,
		[PKEY1]                                 [nvarchar](100) COLLATE Latin1_General_CI_AS NULL,
		[PKEY2]                                 [nvarchar](100) COLLATE Latin1_General_CI_AS NULL,
		[SOURCE_CHANGE_STAMP]                   [int] NULL,
		[INTERNAL_NAME]                         [nvarchar](100) COLLATE Latin1_General_CI_AS NOT NULL,
		[DESCRIPTION]                           [nvarchar](500) COLLATE Latin1_General_CI_AS NOT NULL,
		[AVAILABLE_AFTER_INCOMING]              [bit] NOT NULL,
		[AVAILABLE_AFTER_OUTGOING]              [bit] NOT NULL,
		[WRAPUP_DATA_INCOMING_MODE]             [int] NOT NULL,
		[WRAPUP_DATA_OUTGOING_MODE]             [int] NOT NULL,
		[AUTO_ANSWER_ENABLED]                   [bit] NOT NULL,
		[IDLE_REASON_REQUIRED]                  [bit] NOT NULL,
		[LOGOUT_NON_ACTIVITY_TIME]              [int] NULL,
		[LOGOUT_REASON_REQUIRED]                [bit] NOT NULL,
		[SUPERVISOR_CALLS_ALLOWED]              [bit] NOT NULL,
		[SUPERVISOR_ASSIST_CALL_METHOD]         [int] NULL,
		[EMERGENCY_CALL_METHOD]                 [int] NULL,
		[AUTO_RECORD_ON_EMERGENCY]              [bit] NULL,
		[AGENT_TO_AGENT_CALLS_ALLOWED]          [bit] NOT NULL,
		[OUTBOUND_ACCESS_INTERNATIONAL]         [bit] NOT NULL,
		[OUTBOUND_ACCESS_PUBLIC_NETWORK]        [bit] NOT NULL,
		[OUTBOUND_ACCESS_PRIVATE_NETWORK]       [bit] NOT NULL,
		[OUTBOUND_ACCESS_OPERATOR_ASSISTED]     [bit] NOT NULL,
		[OUTBOUND_ACCESS_PBX]                   [bit] NOT NULL,
		[NON_ACD_CALLS_ALLOWED]                 [bit] NOT NULL,
		[QUALITY_RECORDING_RATE]                [int] NULL,
		[RECORDING_MODE]                        [int] NULL,
		[WORK_MODE_TIMER]                       [int] NULL,
		[RING_NO_ANSWER_TIME]                   [int] NULL,
		[SILENT_MONITOR_WARNING_MESSAGE]        [bit] NULL,
		[SILENT_MONITOR_AUDIBLE_INDICATION]     [bit] NULL,
		[DEFAULT_DEVICE_PORT_ADDRESS]           [varchar](32) COLLATE Latin1_General_CI_AS NULL,
		[AGENT_CAN_SELECT_GROUP]                [bit] NOT NULL,
		[REMOTE_AGENT_TYPE]                     [int] NOT NULL,
		[REMOTE_LOGIN_WITHOUT_DESKTOP]          [bit] NOT NULL,
		[PLAY_ZIP_TONE]                         [bit] NOT NULL,
		[ACD_SHARED_LINE_USAGE]                 [bit] NOT NULL,
		[EFFECTIVE_FROM]                        [datetime] NOT NULL,
		[EFFECTIVE_TO]                          [datetime] NOT NULL,
		[SYSTEM]                                [bit] NOT NULL,
		[PURGED]                                [bit] NOT NULL,
		[LATEST]                                [bit] NOT NULL,
		[CREATED_BY_ID]                         [uniqueidentifier] NOT NULL,
		[MODIFIED_BY_ID]                        [uniqueidentifier] NOT NULL,
		[CREATION_DATE]                         [datetime] NOT NULL,
		[MODIFIED_DATE]                         [datetime] NOT NULL,
		[CHANGE_STAMP]                          [int] NOT NULL,
		[XML_DATA]                              [xml](DOCUMENT [dbo].[ColumnCollection]) NULL,
		[CUSTOM_XML_DATA]                       [xml](DOCUMENT [dbo].[ColumnCollection]) NULL,
		[msrepl_tran_version]                   [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TB_DIM_AGENT_DESKTOP_PKEY_MAP]
		PRIMARY KEY
		CLUSTERED
		([PKEY_MAP_URN])
	ON [DIMGROUP]
) ON [DIMGROUP] TEXTIMAGE_ON [DIMGROUP]
GO
ALTER TABLE [dbo].[TB_DIM_AGENT_DESKTOP_PKEY_MAP]
	ADD
	CONSTRAINT [CK_TB_DIM_AGENT_DESKTOP_PKEY_MAP_PLAY_ZIP_TONE]
	CHECK
	([PLAY_ZIP_TONE]=(1) AND [AUTO_ANSWER_ENABLED]=(1) OR [PLAY_ZIP_TONE]=(0))
GO
ALTER TABLE [dbo].[TB_DIM_AGENT_DESKTOP_PKEY_MAP]
CHECK CONSTRAINT [CK_TB_DIM_AGENT_DESKTOP_PKEY_MAP_PLAY_ZIP_TONE]
GO
ALTER TABLE [dbo].[TB_DIM_AGENT_DESKTOP_PKEY_MAP]
	ADD
	CONSTRAINT [CK_TB_DIM_AGENT_DESKTOP_PKEY_MAP_DELETE_CONSISTENCEY]
	CHECK
	(case when [STATUS]='D' AND [EFFECTIVE_TO]>getutcdate() then (1) else (0) end=(0))
GO
ALTER TABLE [dbo].[TB_DIM_AGENT_DESKTOP_PKEY_MAP]
CHECK CONSTRAINT [CK_TB_DIM_AGENT_DESKTOP_PKEY_MAP_DELETE_CONSISTENCEY]
GO
ALTER TABLE [dbo].[TB_DIM_AGENT_DESKTOP_PKEY_MAP]
	ADD
	CONSTRAINT [CK_TB_DIM_AGENT_DESKTOP_PKEY_MAP_PURGE_CONSISTENCEY]
	CHECK
	(case when [STATUS]<>'D' AND [PURGED]=(1) then (1) else (0) end=(0))
GO
ALTER TABLE [dbo].[TB_DIM_AGENT_DESKTOP_PKEY_MAP]
CHECK CONSTRAINT [CK_TB_DIM_AGENT_DESKTOP_PKEY_MAP_PURGE_CONSISTENCEY]
GO
ALTER TABLE [dbo].[TB_DIM_AGENT_DESKTOP_PKEY_MAP]
	ADD
	CONSTRAINT [CK_TB_DIM_AGENT_DESKTOP_PKEY_MAP_LATEST_CONSISTENCEY]
	CHECK
	(case when [LATEST]=(0) AND ([STATUS]<>'D' OR [PURGED]=(0) OR [EFFECTIVE_TO]>getutcdate()) then (1) else (0) end=(0))
GO
ALTER TABLE [dbo].[TB_DIM_AGENT_DESKTOP_PKEY_MAP]
CHECK CONSTRAINT [CK_TB_DIM_AGENT_DESKTOP_PKEY_MAP_LATEST_CONSISTENCEY]
GO
ALTER TABLE [dbo].[TB_DIM_AGENT_DESKTOP_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_AGENT_DESKTOP_PKEY_MAP_STATUS]
	DEFAULT ('N') FOR [STATUS]
GO
ALTER TABLE [dbo].[TB_DIM_AGENT_DESKTOP_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_AGENT_DESKTOP_PKEY_MAP_MODIFIED_DATE]
	DEFAULT (getutcdate()) FOR [MODIFIED_DATE]
GO
ALTER TABLE [dbo].[TB_DIM_AGENT_DESKTOP_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_AGENT_DESKTOP_PKEY_MAP_CREATION_DATE]
	DEFAULT (getutcdate()) FOR [CREATION_DATE]
GO
ALTER TABLE [dbo].[TB_DIM_AGENT_DESKTOP_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_AGENT_DESKTOP_PKEY_MAP_EFFECTIVE_FROM]
	DEFAULT (getutcdate()) FOR [EFFECTIVE_FROM]
GO
ALTER TABLE [dbo].[TB_DIM_AGENT_DESKTOP_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_AGENT_DESKTOP_PKEY_MAP_EFFECTIVE_TO]
	DEFAULT ('2079-06-06 00:00:00') FOR [EFFECTIVE_TO]
GO
ALTER TABLE [dbo].[TB_DIM_AGENT_DESKTOP_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_AGENT_DESKTOP_PKEY_MAP_LATEST]
	DEFAULT ((1)) FOR [LATEST]
GO
ALTER TABLE [dbo].[TB_DIM_AGENT_DESKTOP_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_AGENT_DESKTOP_PKEY_MAP_SYSTEM]
	DEFAULT ((0)) FOR [SYSTEM]
GO
ALTER TABLE [dbo].[TB_DIM_AGENT_DESKTOP_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_AGENT_DESKTOP_PKEY_MAP_PURGED]
	DEFAULT ((0)) FOR [PURGED]
GO
ALTER TABLE [dbo].[TB_DIM_AGENT_DESKTOP_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_AGENT_DESKTOP_PKEY_MAP_CHANGE_STAMP]
	DEFAULT ((0)) FOR [CHANGE_STAMP]
GO
ALTER TABLE [dbo].[TB_DIM_AGENT_DESKTOP_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_AGENT_DESKTOP_PKEY_MAP_INTERNAL_NAME]
	DEFAULT (N'') FOR [INTERNAL_NAME]
GO
ALTER TABLE [dbo].[TB_DIM_AGENT_DESKTOP_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_AGENT_DESKTOP_PKEY_MAP_DESCRIPTION]
	DEFAULT (N'') FOR [DESCRIPTION]
GO
ALTER TABLE [dbo].[TB_DIM_AGENT_DESKTOP_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_AGENT_DESKTOP_PKEY_MAP_AVAILABLE_AFTER_INCOMING]
	DEFAULT ((0)) FOR [AVAILABLE_AFTER_INCOMING]
GO
ALTER TABLE [dbo].[TB_DIM_AGENT_DESKTOP_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_AGENT_DESKTOP_PKEY_MAP_AVAILABLE_AFTER_OUTGOING]
	DEFAULT ((0)) FOR [AVAILABLE_AFTER_OUTGOING]
GO
ALTER TABLE [dbo].[TB_DIM_AGENT_DESKTOP_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_AGENT_DESKTOP_PKEY_MAP_WRAPUP_DATA_INCOMING_MODE]
	DEFAULT ((1)) FOR [WRAPUP_DATA_INCOMING_MODE]
GO
ALTER TABLE [dbo].[TB_DIM_AGENT_DESKTOP_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_AGENT_DESKTOP_PKEY_MAP_WRAPUP_DATA_OUTGOING_MODE]
	DEFAULT ((1)) FOR [WRAPUP_DATA_OUTGOING_MODE]
GO
ALTER TABLE [dbo].[TB_DIM_AGENT_DESKTOP_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_AGENT_DESKTOP_PKEY_MAP_AUTO_ANSWER_ENABLED]
	DEFAULT ((0)) FOR [AUTO_ANSWER_ENABLED]
GO
ALTER TABLE [dbo].[TB_DIM_AGENT_DESKTOP_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_AGENT_DESKTOP_PKEY_MAP_IDLE_REASON_REQUIRED]
	DEFAULT ((0)) FOR [IDLE_REASON_REQUIRED]
GO
ALTER TABLE [dbo].[TB_DIM_AGENT_DESKTOP_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_AGENT_DESKTOP_PKEY_MAP_LOGOUT_REASON_REQUIRED]
	DEFAULT ((0)) FOR [LOGOUT_REASON_REQUIRED]
GO
ALTER TABLE [dbo].[TB_DIM_AGENT_DESKTOP_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_AGENT_DESKTOP_PKEY_MAP_SUPERVISOR_CALLS_ALLOWED]
	DEFAULT ((0)) FOR [SUPERVISOR_CALLS_ALLOWED]
GO
ALTER TABLE [dbo].[TB_DIM_AGENT_DESKTOP_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_AGENT_DESKTOP_PKEY_MAP_AGENT_TO_AGENT_CALLS_ALLOWED]
	DEFAULT ((0)) FOR [AGENT_TO_AGENT_CALLS_ALLOWED]
GO
ALTER TABLE [dbo].[TB_DIM_AGENT_DESKTOP_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_AGENT_DESKTOP_PKEY_MAP_OUTBOUND_ACCESS_INTERNATIONAL]
	DEFAULT ((0)) FOR [OUTBOUND_ACCESS_INTERNATIONAL]
GO
ALTER TABLE [dbo].[TB_DIM_AGENT_DESKTOP_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_AGENT_DESKTOP_PKEY_MAP_OUTBOUND_ACCESS_PUBLIC_NETWORK]
	DEFAULT ((0)) FOR [OUTBOUND_ACCESS_PUBLIC_NETWORK]
GO
ALTER TABLE [dbo].[TB_DIM_AGENT_DESKTOP_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_AGENT_DESKTOP_PKEY_MAP_OUTBOUND_ACCESS_PRIVATE_NETWORK]
	DEFAULT ((0)) FOR [OUTBOUND_ACCESS_PRIVATE_NETWORK]
GO
ALTER TABLE [dbo].[TB_DIM_AGENT_DESKTOP_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_AGENT_DESKTOP_PKEY_MAP_OUTBOUND_ACCESS_OPERATOR_ASSISTED]
	DEFAULT ((0)) FOR [OUTBOUND_ACCESS_OPERATOR_ASSISTED]
GO
ALTER TABLE [dbo].[TB_DIM_AGENT_DESKTOP_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_AGENT_DESKTOP_PKEY_MAP_OUTBOUND_ACCESS_PBX]
	DEFAULT ((0)) FOR [OUTBOUND_ACCESS_PBX]
GO
ALTER TABLE [dbo].[TB_DIM_AGENT_DESKTOP_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_AGENT_DESKTOP_PKEY_MAP_NON_ACD_CALLS_ALLOWED]
	DEFAULT ((0)) FOR [NON_ACD_CALLS_ALLOWED]
GO
ALTER TABLE [dbo].[TB_DIM_AGENT_DESKTOP_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_AGENT_DESKTOP_PKEY_MAP_AGENT_CAN_SELECT_GROUP]
	DEFAULT ((1)) FOR [AGENT_CAN_SELECT_GROUP]
GO
ALTER TABLE [dbo].[TB_DIM_AGENT_DESKTOP_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_AGENT_DESKTOP_PKEY_MAP_REMOTE_AGENT_TYPE]
	DEFAULT ((0)) FOR [REMOTE_AGENT_TYPE]
GO
ALTER TABLE [dbo].[TB_DIM_AGENT_DESKTOP_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_AGENT_DESKTOP_PKEY_MAP_REMOTE_LOGIN_WITHOUT_DESKTOP]
	DEFAULT ((0)) FOR [REMOTE_LOGIN_WITHOUT_DESKTOP]
GO
ALTER TABLE [dbo].[TB_DIM_AGENT_DESKTOP_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_AGENT_DESKTOP_PKEY_MAP_PLAY_ZIP_TONE]
	DEFAULT ((0)) FOR [PLAY_ZIP_TONE]
GO
ALTER TABLE [dbo].[TB_DIM_AGENT_DESKTOP_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_AGENT_DESKTOP_PKEY_MAP_ACD_SHARED_LINE_USAGE]
	DEFAULT ((0)) FOR [ACD_SHARED_LINE_USAGE]
GO
ALTER TABLE [dbo].[TB_DIM_AGENT_DESKTOP_PKEY_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_AGENT_DESKTOP_PKEY_MAP_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_DIM_AGENT_DESKTOP_PKEY_MAP]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_DIM_AGENT_DESKTOP_PKEY_MAP_PKEY_MAP_BIZ_URN]
	FOREIGN KEY ([PKEY_MAP_BIZ_URN]) REFERENCES [dbo].[TB_DIM_AGENT_DESKTOP_PKEY_MAP] ([PKEY_MAP_URN])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_DIM_AGENT_DESKTOP_PKEY_MAP]
	CHECK CONSTRAINT [FK_TB_DIM_AGENT_DESKTOP_PKEY_MAP_PKEY_MAP_BIZ_URN]

GO
ALTER TABLE [dbo].[TB_DIM_AGENT_DESKTOP_PKEY_MAP]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_DIM_AGENT_DESKTOP_PKEY_MAP_TB_CLU_RESOURCE]
	FOREIGN KEY ([CLUSTER_RESOURCE_ID]) REFERENCES [dbo].[TB_CLU_RESOURCE] ([RESOURCE_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_DIM_AGENT_DESKTOP_PKEY_MAP]
	CHECK CONSTRAINT [FK_TB_DIM_AGENT_DESKTOP_PKEY_MAP_TB_CLU_RESOURCE]

GO
ALTER TABLE [dbo].[TB_DIM_AGENT_DESKTOP_PKEY_MAP]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_DIM_AGENT_DESKTOP_PKEY_MAP_ITEM_BIZ_URN]
	FOREIGN KEY ([ITEM_BIZ_URN]) REFERENCES [dbo].[TB_DIM_AGENT_DESKTOP] ([ITEM_URN])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_DIM_AGENT_DESKTOP_PKEY_MAP]
	CHECK CONSTRAINT [FK_TB_DIM_AGENT_DESKTOP_PKEY_MAP_ITEM_BIZ_URN]

GO
CREATE NONCLUSTERED INDEX [IX_TB_DIM_AGENT_DESKTOP_PKEY_MAP_ITEM_CLUSTER_RESOURCE]
	ON [dbo].[TB_DIM_AGENT_DESKTOP_PKEY_MAP] ([ITEM_BIZ_URN], [LATEST], [CLUSTER_RESOURCE_ID], [STATUS], [EFFECTIVE_FROM], [EFFECTIVE_TO])
	INCLUDE ([PURGED])
	ON [DIMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_DIM_AGENT_DESKTOP_PKEY_MAP_CLUSTER_RESOURCE_PKEY]
	ON [dbo].[TB_DIM_AGENT_DESKTOP_PKEY_MAP] ([CLUSTER_RESOURCE_ID], [PKEY1], [PKEY2])
	INCLUDE ([PURGED])
	ON [DIMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_DIM_AGENT_DESKTOP_PKEY_MAP_CLUSTER_RESOURCE_STATUS]
	ON [dbo].[TB_DIM_AGENT_DESKTOP_PKEY_MAP] ([CLUSTER_RESOURCE_ID], [STATUS], [EFFECTIVE_FROM], [EFFECTIVE_TO])
	INCLUDE ([ITEM_BIZ_URN], [LATEST], [PURGED])
	ON [DIMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_DIM_AGENT_DESKTOP_PKEY_MAP_INTERNAL_NAME]
	ON [dbo].[TB_DIM_AGENT_DESKTOP_PKEY_MAP] ([INTERNAL_NAME])
	ON [DIMINDEXGROUP]
GO
SET ANSI_PADDING ON
GO
CREATE UNIQUE NONCLUSTERED INDEX [UN_TB_DIM_AGENT_DESKTOP_PKEY_MAP_PKEY1_PKEY2_CLUSTER_RESOURCE_ID]
	ON [dbo].[TB_DIM_AGENT_DESKTOP_PKEY_MAP] ([PKEY1], [PKEY2], [CLUSTER_RESOURCE_ID])
	WHERE (([PKEY1] IS NOT NULL AND [PURGED]=(0)))
	ON [DIMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_DIM_AGENT_DESKTOP_PKEY_MAP_PKEY_MAP_BIZ_URN]
	ON [dbo].[TB_DIM_AGENT_DESKTOP_PKEY_MAP] ([PKEY_MAP_BIZ_URN])
	ON [DIMINDEXGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table stores the mappings for Agent Desktops in TB_DIM_AGENT_DESKTOP corresponding to the items on various sources for the application. This sources can be CICMs, NAMs, WMS, IVRs etc.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_AGENT_DESKTOP_PKEY_MAP', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_AGENT_DESKTOP_PKEY_MAP', 'COLUMN', N'PKEY_MAP_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the business key for this entity. This key references the parent row.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_AGENT_DESKTOP_PKEY_MAP', 'COLUMN', N'PKEY_MAP_BIZ_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_AGENT_DESKTOP corresponding to the item for which the mapping is defined. This is unique for a given source specified by the column CLUSTER_RESOURCE_ID.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_AGENT_DESKTOP_PKEY_MAP', 'COLUMN', N'ITEM_BIZ_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id of the logical resoource as in TB_CLU_RESOURCE that corresponds to the source for which the mapping is defined for the given item.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_AGENT_DESKTOP_PKEY_MAP', 'COLUMN', N'CLUSTER_RESOURCE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the a charactor flag indicating the status of the item on the specified equipment. Possible values are; R: Ready, S: Pending Active, P: Pending Delete, D: Delete confirmed, E: Error, N: Not applicable.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_AGENT_DESKTOP_PKEY_MAP', 'COLUMN', N'STATUS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the primary identifier of the item on the specified source. This has to be unique on the specified source. For example, this can be a primary key value on any source database table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_AGENT_DESKTOP_PKEY_MAP', 'COLUMN', N'PKEY1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the secondary identifier of the item on the specified source.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_AGENT_DESKTOP_PKEY_MAP', 'COLUMN', N'PKEY2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'If specified this is the change stamp of the item on the source equipment.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_AGENT_DESKTOP_PKEY_MAP', 'COLUMN', N'SOURCE_CHANGE_STAMP'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The name of the item.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_AGENT_DESKTOP_PKEY_MAP', 'COLUMN', N'INTERNAL_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The description of the item.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_AGENT_DESKTOP_PKEY_MAP', 'COLUMN', N'DESCRIPTION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether to consider an agent to be available after handling an incoming call. Value 1 indicates yes.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_AGENT_DESKTOP_PKEY_MAP', 'COLUMN', N'AVAILABLE_AFTER_INCOMING'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether to consider an agent to be available after handling an outbound call. Value 1 indicates yes.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_AGENT_DESKTOP_PKEY_MAP', 'COLUMN', N'AVAILABLE_AFTER_OUTGOING'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the agent is allowed or required to enter wrap-up data after handling an incoming call. This takes the values 0: Required; 1: Optional; 2: Not allowed, 3:Required with Wrapup Data.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_AGENT_DESKTOP_PKEY_MAP', 'COLUMN', N'WRAPUP_DATA_INCOMING_MODE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the agent is allowed or required to enter wrap-up data after handling an outbound call. This takes the values 0: Required; 1: Optional; 2: Not allowed.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_AGENT_DESKTOP_PKEY_MAP', 'COLUMN', N'WRAPUP_DATA_OUTGOING_MODE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the calls to the agent are automatically answered. Value 1 indicates yes.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_AGENT_DESKTOP_PKEY_MAP', 'COLUMN', N'AUTO_ANSWER_ENABLED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is flag indicating whether the agent should enter a reason before entering the Idle state. Value 1 indicates yes.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_AGENT_DESKTOP_PKEY_MAP', 'COLUMN', N'IDLE_REASON_REQUIRED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number of seconds after which the agent will be logged out automatically if there is no activity at the agent desktop. This value is between 10 and 7200.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_AGENT_DESKTOP_PKEY_MAP', 'COLUMN', N'LOGOUT_NON_ACTIVITY_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the agent is required to enter a reason before logging out. Value 1 indicates yes.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_AGENT_DESKTOP_PKEY_MAP', 'COLUMN', N'LOGOUT_REASON_REQUIRED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the agent can initiate supervisor assisted calls.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_AGENT_DESKTOP_PKEY_MAP', 'COLUMN', N'SUPERVISOR_CALLS_ALLOWED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a value that indicates whether system would create a consultative or a blind conference call for the supervisor assistance request. This takes the values 0: Consultative; 1: Blind conference.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_AGENT_DESKTOP_PKEY_MAP', 'COLUMN', N'SUPERVISOR_ASSIST_CALL_METHOD'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a value that indicates whether system would create a consultative or a blind conference call for the emergency call request. This takes the values 0: Consultative; 1: Blind conference.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_AGENT_DESKTOP_PKEY_MAP', 'COLUMN', N'EMERGENCY_CALL_METHOD'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether to automatically record or not to record when an emergency call request is started. Value 1 indicates automatically record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_AGENT_DESKTOP_PKEY_MAP', 'COLUMN', N'AUTO_RECORD_ON_EMERGENCY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether calls to other agents are allowed. Value 1 indicates yes.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_AGENT_DESKTOP_PKEY_MAP', 'COLUMN', N'AGENT_TO_AGENT_CALLS_ALLOWED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the agent can initiate international calls.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_AGENT_DESKTOP_PKEY_MAP', 'COLUMN', N'OUTBOUND_ACCESS_INTERNATIONAL'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the agent can initiate calls through public network. Value 1 indicates yes.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_AGENT_DESKTOP_PKEY_MAP', 'COLUMN', N'OUTBOUND_ACCESS_PUBLIC_NETWORK'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the agent can initiate calls through private network. Value 1 indicates yes.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_AGENT_DESKTOP_PKEY_MAP', 'COLUMN', N'OUTBOUND_ACCESS_PRIVATE_NETWORK'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the agent can initiate operator assisted calls. Value 1 indicates yes.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_AGENT_DESKTOP_PKEY_MAP', 'COLUMN', N'OUTBOUND_ACCESS_OPERATOR_ASSISTED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the agent can initiate outbound PBX calls. Value 1 indicates yes.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_AGENT_DESKTOP_PKEY_MAP', 'COLUMN', N'OUTBOUND_ACCESS_PBX'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is flag indicating whether the agent can place or handle non-ACD calls. Value 1 indicates yes.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_AGENT_DESKTOP_PKEY_MAP', 'COLUMN', N'NON_ACD_CALLS_ALLOWED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This value indicates how frequently calls to the agent are recorded.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_AGENT_DESKTOP_PKEY_MAP', 'COLUMN', N'QUALITY_RECORDING_RATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is value that indicates whether the call requests are routed through the Call manager PIM. Value 0 indicates that the calls do not get routed through the callmanager PIM.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_AGENT_DESKTOP_PKEY_MAP', 'COLUMN', N'RECORDING_MODE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This value indicates the wrap-up time out in seconds. This value is between 1 and 7200.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_AGENT_DESKTOP_PKEY_MAP', 'COLUMN', N'WORK_MODE_TIMER'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This value is the the number of seconds a call may ring at the agents station before it is redirected. This value is between 1 and 120.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_AGENT_DESKTOP_PKEY_MAP', 'COLUMN', N'RING_NO_ANSWER_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether a worning message will appear on the agents desktop when silent monitoring is started. Value 1 indicates yes.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_AGENT_DESKTOP_PKEY_MAP', 'COLUMN', N'SILENT_MONITOR_WARNING_MESSAGE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether an audio click will sound when silent monitoring is started. Value 1 indicates yes.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_AGENT_DESKTOP_PKEY_MAP', 'COLUMN', N'SILENT_MONITOR_AUDIBLE_INDICATION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a value to override the default port address the agents telephony device.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_AGENT_DESKTOP_PKEY_MAP', 'COLUMN', N'DEFAULT_DEVICE_PORT_ADDRESS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the agent can select which group they are logged in to. Value 1 indicates yes.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_AGENT_DESKTOP_PKEY_MAP', 'COLUMN', N'AGENT_CAN_SELECT_GROUP'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a value that indicates how mobile agents who use this dial plan are handled. This takes the values 0: Local agent, no remote access; 1: Use call by call mobile agent routing; 2: Use nailed connection for mobile agents; 3: Agent chooses at login.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_AGENT_DESKTOP_PKEY_MAP', 'COLUMN', N'REMOTE_AGENT_TYPE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is flag indicating whether mobile agents are allowed to login without a desktop.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_AGENT_DESKTOP_PKEY_MAP', 'COLUMN', N'REMOTE_LOGIN_WITHOUT_DESKTOP'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is flag indicating whether a zip tone plays when the agent connects. Value 1 indicates yes.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_AGENT_DESKTOP_PKEY_MAP', 'COLUMN', N'PLAY_ZIP_TONE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is flag indicating whether the agent can participate in a shared line experience. Value 1 indicates yes.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_AGENT_DESKTOP_PKEY_MAP', 'COLUMN', N'ACD_SHARED_LINE_USAGE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a UTC date time indicating when the item becomes active on the specified source.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_AGENT_DESKTOP_PKEY_MAP', 'COLUMN', N'EFFECTIVE_FROM'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a UTC date time indicating when the item ceases to exist on the specified source.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_AGENT_DESKTOP_PKEY_MAP', 'COLUMN', N'EFFECTIVE_TO'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Not used.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_AGENT_DESKTOP_PKEY_MAP', 'COLUMN', N'SYSTEM'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Whether or not the item has been purged (ie. row physically removed) from the equipment.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_AGENT_DESKTOP_PKEY_MAP', 'COLUMN', N'PURGED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the item is latest or not. Value 1 indicates latest. For type 2 pkey map change this value is set to 0 for parent pkey maps.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_AGENT_DESKTOP_PKEY_MAP', 'COLUMN', N'LATEST'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the ID from TB_SEC_USER indicating the user who created the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_AGENT_DESKTOP_PKEY_MAP', 'COLUMN', N'CREATED_BY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the ID from TB_SEC_USER indicating the user who last modified the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_AGENT_DESKTOP_PKEY_MAP', 'COLUMN', N'MODIFIED_BY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the UTC date time indicating when the record was created.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_AGENT_DESKTOP_PKEY_MAP', 'COLUMN', N'CREATION_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the UTC date time indicating when the record was last modified.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_AGENT_DESKTOP_PKEY_MAP', 'COLUMN', N'MODIFIED_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the change stamp for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_AGENT_DESKTOP_PKEY_MAP', 'COLUMN', N'CHANGE_STAMP'
GO
EXEC sp_addextendedproperty N'MS_Description', N'XML data block', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_AGENT_DESKTOP_PKEY_MAP', 'COLUMN', N'XML_DATA'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Custom XML data block', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_AGENT_DESKTOP_PKEY_MAP', 'COLUMN', N'CUSTOM_XML_DATA'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_AGENT_DESKTOP_PKEY_MAP', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_DIM_AGENT_DESKTOP_PKEY_MAP]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_DIM_AGENT_DESKTOP_PKEY_MAP]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_DIM_AGENT_DESKTOP_PKEY_MAP]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_DIM_AGENT_DESKTOP_PKEY_MAP]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_DIM_AGENT_DESKTOP_PKEY_MAP]
	TO [portalrs_role]
GO
ALTER TABLE [dbo].[TB_DIM_AGENT_DESKTOP_PKEY_MAP] SET (LOCK_ESCALATION = TABLE)
GO
