SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TB_FCT_EMAIL_CASE_SNAPSHOT] (
		[PARTITION_URN]              [int] NOT NULL,
		[PARTITION_ID]               [int] NOT NULL,
		[PARTITION_GLOBAL_URN]       [bigint] NOT NULL,
		[EVENT_DATE_TIME_UTC]        [datetime] NOT NULL,
		[EVENT_DATE_UTC_URN]         [int] NOT NULL,
		[EVENT_TIME_UTC_URN]         [smallint] NOT NULL,
		[CLUSTER_RESOURCE_URN]       [int] NOT NULL,
		[TENANT_URN]                 [int] NOT NULL,
		[ALIAS_URN]                  [int] NOT NULL,
		[AGENT_URN]                  [int] NOT NULL,
		[MANAGER_AGENT_URN]          [int] NOT NULL,
		[QUEUE_URN]                  [int] NOT NULL,
		[EMAIL_OPEN_COUNT]           [int] NOT NULL,
		[EMAIL_UNASSIGNED_COUNT]     [int] NOT NULL,
		[NEW_CASE_COUNT]             [int] NOT NULL,
		[EXISTING_CASE_COUNT]        [int] NOT NULL,
		[UNDELIVERED_MAIL_COUNT]     [int] NOT NULL,
		[AUTO_ACK_COUNT]             [int] NOT NULL,
		[AUTO_REPLY_COUNT]           [int] NOT NULL,
		[MANUAL_REPLY_COUNT]         [int] NOT NULL,
		[RESPONSE_COUNT]             [int] NOT NULL,
		[COMPOSE_COUNT]              [int] NOT NULL,
		[COMPLETED_COUNT]            [int] NOT NULL,
		[ASSIGNED_COUNT]             [int] NOT NULL,
		[RESPONDED_IN_SLA_COUNT]     [int] NOT NULL,
		[HANDLE_TIME]                [bigint] NOT NULL,
		[RESPONSE_TIME]              [bigint] NOT NULL,
		CONSTRAINT [PK_FCT_EMAIL_CASE_SNAPSHOT]
		PRIMARY KEY
		CLUSTERED
		([PARTITION_URN], [PARTITION_ID])
	ON [FCTEGNGROUP]
) ON [FCTEGNGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_FCT_EMAIL_CASE_SNAPSHOT_AGENT_URN]
	ON [dbo].[TB_FCT_EMAIL_CASE_SNAPSHOT] ([AGENT_URN])
	ON [FCTEGNGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_CASE_SNAPSHOT', 'INDEX', N'IX_FCT_EMAIL_CASE_SNAPSHOT_AGENT_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_EMAIL_CASE_SNAPSHOT_MANAGER_AGENT_URN]
	ON [dbo].[TB_FCT_EMAIL_CASE_SNAPSHOT] ([MANAGER_AGENT_URN])
	ON [FCTEGNGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_CASE_SNAPSHOT', 'INDEX', N'IX_FCT_EMAIL_CASE_SNAPSHOT_MANAGER_AGENT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table will hold the detailed fact data for event history case management.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_CASE_SNAPSHOT', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_CASE_SNAPSHOT', 'COLUMN', N'PARTITION_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number for the current partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_CASE_SNAPSHOT', 'COLUMN', N'PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column holds a value that uniquely identifies a row across all the partition tables for this partition type.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_CASE_SNAPSHOT', 'COLUMN', N'PARTITION_GLOBAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The interval date and time when the event occurred in UTC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_CASE_SNAPSHOT', 'COLUMN', N'EVENT_DATE_TIME_UTC'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the date of the EVENT_DATE_TIME_UTC value.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_CASE_SNAPSHOT', 'COLUMN', N'EVENT_DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the time of the EVENT_DATE_TIME_UTC value.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_CASE_SNAPSHOT', 'COLUMN', N'EVENT_TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column gives information regarding the source of the data. This corresponds to the RESOURCE_URN from TB_CLU_RESOURCE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_CASE_SNAPSHOT', 'COLUMN', N'CLUSTER_RESOURCE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_TENANT.ITEM_URN and refers to the Tenant (or "Department" on the source) of the Agent.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_CASE_SNAPSHOT', 'COLUMN', N'TENANT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TENANT', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_CASE_SNAPSHOT', 'COLUMN', N'TENANT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to the alias in TB_DIM_ALIAS.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_CASE_SNAPSHOT', 'COLUMN', N'ALIAS_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_ALIAS', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_CASE_SNAPSHOT', 'COLUMN', N'ALIAS_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_AGENT.ITEM_URN and refers to the Agent to which the activity is assigned.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_CASE_SNAPSHOT', 'COLUMN', N'AGENT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_AGENT', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_CASE_SNAPSHOT', 'COLUMN', N'AGENT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_AGENT.ITEM_URN and refers to the Manager of the Agent to which the activity is assigned.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_CASE_SNAPSHOT', 'COLUMN', N'MANAGER_AGENT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_AGENT', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_CASE_SNAPSHOT', 'COLUMN', N'MANAGER_AGENT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_QUEUE.ITEM_URN and refers to the queue.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_CASE_SNAPSHOT', 'COLUMN', N'QUEUE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_QUEUE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_CASE_SNAPSHOT', 'COLUMN', N'QUEUE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'A count of email activities that are not in Completed status when the snapshot interval starts', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_CASE_SNAPSHOT', 'COLUMN', N'EMAIL_OPEN_COUNT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Number of emails not assigned to any agent at the end of the reporting time period. This column counts the incoming emails, emails from create object node, and composed emails', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_CASE_SNAPSHOT', 'COLUMN', N'EMAIL_UNASSIGNED_COUNT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Number of incoming activities that resulted in the creation of a new case.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_CASE_SNAPSHOT', 'COLUMN', N'NEW_CASE_COUNT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Number of incoming activities that were associated with an existing case.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_CASE_SNAPSHOT', 'COLUMN', N'EXISTING_CASE_COUNT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Number of undelivered email activities. An undeliverable mail is one that is sent out by the dispatcher, but is bounced back by the exchange server since it could not be delivered for various reasons. As a result, the email may become associated with a new case, existing case, or no case.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_CASE_SNAPSHOT', 'COLUMN', N'UNDELIVERED_MAIL_COUNT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Number of auto-acknowledgements sent.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_CASE_SNAPSHOT', 'COLUMN', N'AUTO_ACK_COUNT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Number of auto-replies sent.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_CASE_SNAPSHOT', 'COLUMN', N'AUTO_REPLY_COUNT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Number of manual replies sent. This column counts each email in the group reply individually. For example, if you send a group reply for five emails, the count of this column will go up by five. Forwarded or redirected emails are not counted in this column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_CASE_SNAPSHOT', 'COLUMN', N'MANUAL_REPLY_COUNT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Number of responses sent. A response is the first manual email reply to an incoming email.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_CASE_SNAPSHOT', 'COLUMN', N'RESPONSE_COUNT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Number of composed emails sent out. An email can be composed in the Agent Console and sent directly to an email address through the alias.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_CASE_SNAPSHOT', 'COLUMN', N'COMPOSE_COUNT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Number of completed email activities. This column counts the incoming emails, emails created from the create object node, and composed emails.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_CASE_SNAPSHOT', 'COLUMN', N'COMPLETED_COUNT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Number of emails assigned to an agent, but not completed at the end of the reporting time period. This column counts the incoming emails, emails created from the create object node, and composed emails.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_CASE_SNAPSHOT', 'COLUMN', N'ASSIGNED_COUNT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Out of all the email responses, the number of responses that met the specified service level.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_CASE_SNAPSHOT', 'COLUMN', N'RESPONDED_IN_SLA_COUNT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Time spent by the agent working on the email. This is the time for which the the activity was selected in the agent''s inbox, and not the time for which the email stayed in the inbox.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_CASE_SNAPSHOT', 'COLUMN', N'HANDLE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Time taken to send the first manual reply. Response time is calculated as the time from which the email is received by the system, to the time at which the first manual response is sent out.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EMAIL_CASE_SNAPSHOT', 'COLUMN', N'RESPONSE_TIME'
GO
GRANT SELECT
	ON [dbo].[TB_FCT_EMAIL_CASE_SNAPSHOT]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_FCT_EMAIL_CASE_SNAPSHOT]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_FCT_EMAIL_CASE_SNAPSHOT]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_FCT_EMAIL_CASE_SNAPSHOT] SET (LOCK_ESCALATION = TABLE)
GO
