SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TB_FCT_CHAT_DETAIL] (
		[PARTITION_URN]                  [int] NOT NULL,
		[PARTITION_GLOBAL_URN]           [bigint] NOT NULL,
		[PARTITION_ID]                   [int] NOT NULL,
		[COMPLETED_DATE_TIME_UTC]        [datetime] NOT NULL,
		[COMPLETED_DATE_UTC_URN]         [int] NOT NULL,
		[COMPLETED_TIME_UTC_URN]         [smallint] NOT NULL,
		[CLUSTER_RESOURCE_URN]           [int] NOT NULL,
		[ACTIVITY_ID]                    [numeric](19, 0) NOT NULL,
		[ACTIVITY_URN]                   [int] NOT NULL,
		[CREATED_TIME]                   [datetime] NOT NULL,
		[ACTIVITY_ORIGIN]                [int] NOT NULL,
		[ACTIVITY_SUB_TYPE_CODE_URN]     [int] NOT NULL,
		[CASE_ID]                        [numeric](19, 0) NOT NULL,
		[CASE_URN]                       [int] NOT NULL,
		[CASE_TYPE]                      [int] NOT NULL,
		[CUSTOMER_URN]                   [int] NOT NULL,
		[CONTACT_POINT_URN]              [int] NOT NULL,
		[TENANT_URN]                     [int] NOT NULL,
		[QUEUE_URN]                      [int] NOT NULL,
		[AGENT_URN]                      [int] NOT NULL,
		[ENTRY_POINT_URN]                [int] NOT NULL,
		[SERVICED_CNTR]                  [int] NOT NULL,
		[ABANDONED_CNTR]                 [int] NOT NULL,
		[WAIT_SERVICED_TIME]             [int] NOT NULL,
		[WAIT_ABANDONED_TIME]            [int] NOT NULL,
		[COMPLETED_CNTR]                 [int] NOT NULL,
		[ACTIVITY_DURATION]              [int] NOT NULL,
		[TRANSCRIPT_EMAIL_CNTR]          [int] NOT NULL,
		[WORK_TIME]                      [int] NOT NULL,
		[WRAP_TIME]                      [int] NOT NULL,
		[CHAT_REFERRER_NAME_URN]         [int] NOT NULL,
		[CHAT_REFERRER_URL_URN]          [int] NOT NULL,
		CONSTRAINT [PK_FCT_CHAT_DETAIL]
		PRIMARY KEY
		CLUSTERED
		([PARTITION_URN])
	ON [FCTEGNGROUP]
) ON [FCTEGNGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_FCT_CHAT_DETAIL_AGENT_URN]
	ON [dbo].[TB_FCT_CHAT_DETAIL] ([AGENT_URN])
	ON [FCTEGNGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_DETAIL', 'INDEX', N'IX_FCT_CHAT_DETAIL_AGENT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the template table for metrics or facts relating to the eGain chat activities for fixed drill down capability.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_DETAIL', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_DETAIL', 'COLUMN', N'PARTITION_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column holds a value that uniquely identifies a row across all the partition tables for this partition type.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_DETAIL', 'COLUMN', N'PARTITION_GLOBAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number for the current partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_DETAIL', 'COLUMN', N'PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The date and time when the event occurred in UTC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_DETAIL', 'COLUMN', N'COMPLETED_DATE_TIME_UTC'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the date of the COMPLETED_DATE_TIME_UTC value.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_DETAIL', 'COLUMN', N'COMPLETED_DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the time of the COMPLETED_DATE_TIME_UTC value.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_DETAIL', 'COLUMN', N'COMPLETED_TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column gives information regarding the source of the data. This corresponds to the RESOURCE_URN from TB_CLU_RESOURCE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_DETAIL', 'COLUMN', N'CLUSTER_RESOURCE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Unique ID for the activity on the source.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_DETAIL', 'COLUMN', N'ACTIVITY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN that represents Activity information, as TB_DIM_ACTIVITY.ITEM_URN.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_DETAIL', 'COLUMN', N'ACTIVITY_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Identifies if the chat originated from an offer (proactive chat) or if it was a reactive chat. 0 = Proactive, 1 = Reactive.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_DETAIL', 'COLUMN', N'ACTIVITY_ORIGIN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_SUB_CODE.ITEM_URN and refers to the type of chat activity e.g. Video or Text.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_DETAIL', 'COLUMN', N'ACTIVITY_SUB_TYPE_CODE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Unique ID for the case on the source.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_DETAIL', 'COLUMN', N'CASE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN that represents Case information, as TB_DIM_CASE.ITEM_URN.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_DETAIL', 'COLUMN', N'CASE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_CUSTOMER.ITEM_URN and refers to the customer of the activity.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_DETAIL', 'COLUMN', N'CUSTOMER_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_TENANT.ITEM_URN and refers to the Tenant (or "Department" on the source) of the Agent.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_DETAIL', 'COLUMN', N'TENANT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TENANT', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_DETAIL', 'COLUMN', N'TENANT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_QUEUE.ITEM_URN and refers to the Queue related to this activity.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_DETAIL', 'COLUMN', N'QUEUE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_QUEUE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_DETAIL', 'COLUMN', N'QUEUE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_AGENT.ITEM_URN and refers to the Agent to which the activity is assigned.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_DETAIL', 'COLUMN', N'AGENT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_AGENT', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_DETAIL', 'COLUMN', N'AGENT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Identifies if this chat was serviced by an agent at least once. A chat is considered as serviced when the activity status is changed to Assigned - In Progress at least once. This occurs when the agent selects the activity in the Chat Inbox the first time.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_DETAIL', 'COLUMN', N'SERVICED_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Identifies if this chat was abandoned by the customer before an agent joins the chat session. A chat is considered as abandoned if the customer leaves the chat session before the activity status changes to Assigned - In Progress the first time. This occurs when no agent joins the chat session and the customer leaves the chat.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_DETAIL', 'COLUMN', N'ABANDONED_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N' The wait time before the chat is serviced by an agent. Wait Serviced Time = Time when agent clicks on a chat – Time when the chat is started', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_DETAIL', 'COLUMN', N'WAIT_SERVICED_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The wait time before the customer abandoned the chat. Wait Abandoned Time = Time customer abandoned the chat – Time when the chat is started', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_DETAIL', 'COLUMN', N'WAIT_ABANDONED_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Identifies if the chat activity is completed. This includes the activities created by the system or by the agent.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_DETAIL', 'COLUMN', N'COMPLETED_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The total duration of a chat. Chat Duration = Activity completion time – Activity creation time', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_DETAIL', 'COLUMN', N'ACTIVITY_DURATION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Identifies if the chat transcript was emailed to the customer. Transcripts can be emailed for both serviced chats and abandoned chats.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_DETAIL', 'COLUMN', N'TRANSCRIPT_EMAIL_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The time the agent spent actively servicing a chat. This is not the time for which the chat stays in the agents inbox, but the time for which the agent works on the activity. For example, assume that the agent is servicing two chats at a time, and both the activities stay in the agent’s inbox for 10 minutes and the time for which the agent has serviced each of the chat is five minutes. The work time for each activity is five minutes.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_DETAIL', 'COLUMN', N'WORK_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N' The time the agent spent working on the activity after the customer has exited the chat. This is the time for which the agent’s focus is on a chat activity after the customer exits the chat and before the agent completes the activity.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_DETAIL', 'COLUMN', N'WRAP_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_CHAT_REFERRER_NAME.ITEM_URN', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_DETAIL', 'COLUMN', N'CHAT_REFERRER_NAME_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_CHAT_REFERRER_URL.ITEM_URN', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CHAT_DETAIL', 'COLUMN', N'CHAT_REFERRER_URL_URN'
GO
GRANT SELECT
	ON [dbo].[TB_FCT_CHAT_DETAIL]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_FCT_CHAT_DETAIL]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_FCT_CHAT_DETAIL]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_FCT_CHAT_DETAIL] SET (LOCK_ESCALATION = TABLE)
GO
