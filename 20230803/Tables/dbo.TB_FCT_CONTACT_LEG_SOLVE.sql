SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_FCT_CONTACT_LEG_SOLVE] (
		[PARTITION_URN]            [int] NOT NULL,
		[PARTITION_GLOBAL_URN]     [bigint] NOT NULL,
		[PARTITION_ID]             [int] NOT NULL,
		[START_DATE_TIME_UTC]      [datetime] NOT NULL,
		[START_DATE_UTC_URN]       [int] NOT NULL,
		[START_TIME_UTC_URN]       [smallint] NOT NULL,
		[END_DATE_TIME_UTC]        [datetime] NULL,
		[END_DATE_UTC_URN]         [int] NOT NULL,
		[END_TIME_UTC_URN]         [smallint] NOT NULL,
		[CLUSTER_RESOURCE_URN]     [int] NOT NULL,
		[CUSTOMER_URN]             [int] NOT NULL,
		[TENANT_URN]               [int] NOT NULL,
		[CHANNEL_URN]              [int] NOT NULL,
		[QUEUE_URN]                [int] NOT NULL,
		[PRECISION_QUEUE_URN]      [int] NOT NULL,
		[SKILLGROUP_URN]           [int] NOT NULL,
		[AGENT_URN]                [int] NOT NULL,
		[CALL_TYPE_URN]            [int] NOT NULL,
		[CALL_REASON_URN]          [int] NOT NULL,
		[CALL_KEY_1]               [int] NULL,
		[CALL_KEY_2]               [int] NULL,
		[CALL_KEY_3]               [uniqueidentifier] NULL,
		[CALL_KEY_4]               [varchar](64) COLLATE Latin1_General_CI_AS NULL,
		[CALL_KEY_5]               [nvarchar](64) COLLATE Latin1_General_CI_AS NULL,
		[ANI]                      [nvarchar](32) COLLATE Latin1_General_CI_AS NULL,
		[EMAIL_ANI]                [nvarchar](512) COLLATE Latin1_General_CI_AS NULL,
		[TRANSFER_COUNT]           [int] NULL,
		[HANDLE_TIME]              [bigint] NULL,
		[WRAPUP_TIME]              [bigint] NULL,
		[WORK_TIME]                [bigint] NULL,
		[HOLD_TIME]                [bigint] NULL,
		[HOLD_COUNT]               [int] NULL,
		[KNOWLEDGE_USED_COUNT]     [int] NULL,
		[WRAPUP_DATA]              [nvarchar](255) COLLATE Latin1_General_CI_AS NULL,
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
		CONSTRAINT [PK_FCT_CONTACT_LEG_SOLVE]
		PRIMARY KEY
		CLUSTERED
		([PARTITION_URN])
	ON [FCTEGNGROUP]
) ON [FCTEGNGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_FCT_CONTACT_LEG_SOLVE_SKILLGROUP_URN]
	ON [dbo].[TB_FCT_CONTACT_LEG_SOLVE] ([SKILLGROUP_URN])
	ON [FCTEGNGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CONTACT_LEG_SOLVE', 'INDEX', N'IX_FCT_CONTACT_LEG_SOLVE_SKILLGROUP_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_CONTACT_LEG_SOLVE_AGENT_URN]
	ON [dbo].[TB_FCT_CONTACT_LEG_SOLVE] ([AGENT_URN])
	ON [FCTEGNGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CONTACT_LEG_SOLVE', 'INDEX', N'IX_FCT_CONTACT_LEG_SOLVE_AGENT_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_CONTACT_LEG_SOLVE_CALL_TYPE_URN]
	ON [dbo].[TB_FCT_CONTACT_LEG_SOLVE] ([CALL_TYPE_URN])
	ON [FCTEGNGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CONTACT_LEG_SOLVE', 'INDEX', N'IX_FCT_CONTACT_LEG_SOLVE_CALL_TYPE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the template table for metrics or facts relating to contact leg in the eGain application.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CONTACT_LEG_SOLVE', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CONTACT_LEG_SOLVE', 'COLUMN', N'PARTITION_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column holds a value that uniquely identifies a row across all the partition tables for this partition type.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CONTACT_LEG_SOLVE', 'COLUMN', N'PARTITION_GLOBAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number for the current partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CONTACT_LEG_SOLVE', 'COLUMN', N'PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the date time when the contact event occurred.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CONTACT_LEG_SOLVE', 'COLUMN', N'START_DATE_TIME_UTC'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the date of the START_DATE_TIME_UTC value.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CONTACT_LEG_SOLVE', 'COLUMN', N'START_DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DATE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CONTACT_LEG_SOLVE', 'COLUMN', N'START_DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the date of the START_DATE_TIME_UTC value.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CONTACT_LEG_SOLVE', 'COLUMN', N'START_TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIME', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CONTACT_LEG_SOLVE', 'COLUMN', N'START_TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The date and time indicating the end of the contact event.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CONTACT_LEG_SOLVE', 'COLUMN', N'END_DATE_TIME_UTC'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the date of the END_DATE_TIME_UTC value.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CONTACT_LEG_SOLVE', 'COLUMN', N'END_DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the time of the END_DATE_TIME_UTC value.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CONTACT_LEG_SOLVE', 'COLUMN', N'END_TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column gives information regarding the source of the data. This corresponds to the RESOURCE_URN from TB_CLU_RESOURCE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CONTACT_LEG_SOLVE', 'COLUMN', N'CLUSTER_RESOURCE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_TENANT.ITEM_URN and refers to the Tenant (or "Department" on the source) of the contact event.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CONTACT_LEG_SOLVE', 'COLUMN', N'TENANT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TENANT', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CONTACT_LEG_SOLVE', 'COLUMN', N'TENANT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_CHANNEL.ITEM_URN and refers to the Channel of the contact event.  Can be one of: Email/Phone/Chat.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CONTACT_LEG_SOLVE', 'COLUMN', N'CHANNEL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_QUEUE.ITEM_URN and refers to the Queue related to this contact event.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CONTACT_LEG_SOLVE', 'COLUMN', N'QUEUE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_QUEUE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CONTACT_LEG_SOLVE', 'COLUMN', N'QUEUE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_PRECISION_QUEUE corresponding to an item of type IT_PRECISION_QUEUE. This corresponds to the precision queue associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CONTACT_LEG_SOLVE', 'COLUMN', N'PRECISION_QUEUE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_SKILLGROUP for an item of type IT_SKILLGROUP. This corresponds to the skillgroup that handled the contact event.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CONTACT_LEG_SOLVE', 'COLUMN', N'SKILLGROUP_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_SKILLGROUP', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CONTACT_LEG_SOLVE', 'COLUMN', N'SKILLGROUP_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_AGENT for an item of type IT_AGENT. This corresponds to the agent who handled the contact event.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CONTACT_LEG_SOLVE', 'COLUMN', N'AGENT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_AGENT', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CONTACT_LEG_SOLVE', 'COLUMN', N'AGENT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_CALL_TYPE for an item of type IT_CALL_TYPE. This corresponds to the call type associated with the call.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CONTACT_LEG_SOLVE', 'COLUMN', N'CALL_TYPE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CALL_TYPE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CONTACT_LEG_SOLVE', 'COLUMN', N'CALL_TYPE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_CODE of type CG_CALL_REASON.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CONTACT_LEG_SOLVE', 'COLUMN', N'CALL_REASON_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CODE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CONTACT_LEG_SOLVE', 'COLUMN', N'CALL_REASON_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Part of a key to uniquely identify the customer interaction for this TENANT_ID.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CONTACT_LEG_SOLVE', 'COLUMN', N'CALL_KEY_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Part of a key to uniquely identify the customer interaction for this TENANT_ID.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CONTACT_LEG_SOLVE', 'COLUMN', N'CALL_KEY_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This represents a unique identifier for the call leg.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CONTACT_LEG_SOLVE', 'COLUMN', N'CALL_KEY_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Part of a key to uniquely identify the customer interaction, this tracks across multiple call legs.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CONTACT_LEG_SOLVE', 'COLUMN', N'CALL_KEY_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'A unique identifier for the contact which persists across multiple legs.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CONTACT_LEG_SOLVE', 'COLUMN', N'CALL_KEY_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a string representing the number to with the contact event was placed.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CONTACT_LEG_SOLVE', 'COLUMN', N'ANI'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the email address.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CONTACT_LEG_SOLVE', 'COLUMN', N'EMAIL_ANI'
GO
EXEC sp_addextendedproperty N'MS_Description', N'A count of transfer out events for the contact.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CONTACT_LEG_SOLVE', 'COLUMN', N'TRANSFER_COUNT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Time between the agent answering the call and the agent completing wrapup for the call.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CONTACT_LEG_SOLVE', 'COLUMN', N'HANDLE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The amount of time in seconds the agent spent on post-call or post-task wrapup activity.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CONTACT_LEG_SOLVE', 'COLUMN', N'WRAPUP_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The amount of time in seconds the agent spent talking to the caller for voice calls, or the time the agent spent actively working on the task for chat/email tasks. For voice calls this does not include any time the agent spent talking to other parties whilst the caller was on hold.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CONTACT_LEG_SOLVE', 'COLUMN', N'WORK_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The amount of time in seconds the agent put the caller on hold.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CONTACT_LEG_SOLVE', 'COLUMN', N'HOLD_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'A flag which is set if the current agent put the call on hold.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CONTACT_LEG_SOLVE', 'COLUMN', N'HOLD_COUNT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'A flag set if knowledge was used, otherwise 0. Knowledge Used implies that a link to a KB article was clicked, or a guided help session was initiated.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CONTACT_LEG_SOLVE', 'COLUMN', N'KNOWLEDGE_USED_COUNT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The wrapup code as provided by the call routing platform.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CONTACT_LEG_SOLVE', 'COLUMN', N'WRAPUP_DATA'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds information regarding any extra dimension that are required by an organization. These are created in the database based on the Variable fields (Variable1 to Variable10) in case of Cisco ICM/IPCC database. This field maps to the CUSTOM_ENTRY_URN from TB_DIM_CUSTOM_ENTRY.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CONTACT_LEG_SOLVE', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM0', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CONTACT_LEG_SOLVE', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds information regarding any extra dimension that are required by an organization. These are created in the database based on the Variable fields (Variable1 to Variable10) in case of Cisco ICM/IPCC database. This field maps to the CUSTOM_ENTRY_URN from TB_DIM_CUSTOM_ENTRY.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CONTACT_LEG_SOLVE', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM1', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CONTACT_LEG_SOLVE', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds information regarding any extra dimension that are required by an organization. These are created in the database based on the Variable fields (Variable1 to Variable10) in case of Cisco ICM/IPCC database. This field maps to the CUSTOM_ENTRY_URN from TB_DIM_CUSTOM_ENTRY.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CONTACT_LEG_SOLVE', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM2', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CONTACT_LEG_SOLVE', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds information regarding any extra dimension that are required by an organization. These are created in the database based on the Variable fields (Variable1 to Variable10) in case of Cisco ICM/IPCC database. This field maps to the CUSTOM_ENTRY_URN from TB_DIM_CUSTOM_ENTRY.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CONTACT_LEG_SOLVE', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM3', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CONTACT_LEG_SOLVE', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds information regarding any extra dimension that are required by an organization. These are created in the database based on the Variable fields (Variable1 to Variable10) in case of Cisco ICM/IPCC database. This field maps to the CUSTOM_ENTRY_URN from TB_DIM_CUSTOM_ENTRY.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CONTACT_LEG_SOLVE', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM4', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CONTACT_LEG_SOLVE', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds information regarding any extra dimension that are required by an organization. These are created in the database based on the Variable fields (Variable1 to Variable10) in case of Cisco ICM/IPCC database. This field maps to the CUSTOM_ENTRY_URN from TB_DIM_CUSTOM_ENTRY.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CONTACT_LEG_SOLVE', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM5', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CONTACT_LEG_SOLVE', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds information regarding any extra dimension that are required by an organization. These are created in the database based on the Variable fields (Variable1 to Variable10) in case of Cisco ICM/IPCC database. This field maps to the CUSTOM_ENTRY_URN from TB_DIM_CUSTOM_ENTRY.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CONTACT_LEG_SOLVE', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM6', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CONTACT_LEG_SOLVE', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds information regarding any extra dimension that are required by an organization. These are created in the database based on the Variable fields (Variable1 to Variable10) in case of Cisco ICM/IPCC database. This field maps to the CUSTOM_ENTRY_URN from TB_DIM_CUSTOM_ENTRY.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CONTACT_LEG_SOLVE', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM7', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CONTACT_LEG_SOLVE', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds information regarding any extra dimension that are required by an organization. These are created in the database based on the Variable fields (Variable1 to Variable10) in case of Cisco ICM/IPCC database. This field maps to the CUSTOM_ENTRY_URN from TB_DIM_CUSTOM_ENTRY.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CONTACT_LEG_SOLVE', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM8', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CONTACT_LEG_SOLVE', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds information regarding any extra dimension that are required by an organization. These are created in the database based on the Variable fields (Variable1 to Variable10) in case of Cisco ICM/IPCC database. This field maps to the CUSTOM_ENTRY_URN from TB_DIM_CUSTOM_ENTRY.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CONTACT_LEG_SOLVE', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM9', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CONTACT_LEG_SOLVE', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds information regarding any extra measure that are required by an organization.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CONTACT_LEG_SOLVE', 'COLUMN', N'CUSTOM_MEASURE_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds information regarding any extra measure that are required by an organization.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CONTACT_LEG_SOLVE', 'COLUMN', N'CUSTOM_MEASURE_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds information regarding any extra measure that are required by an organization.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CONTACT_LEG_SOLVE', 'COLUMN', N'CUSTOM_MEASURE_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds information regarding any extra measure that are required by an organization.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CONTACT_LEG_SOLVE', 'COLUMN', N'CUSTOM_MEASURE_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds information regarding any extra measure that are required by an organization.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CONTACT_LEG_SOLVE', 'COLUMN', N'CUSTOM_MEASURE_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds information regarding any extra measure that are required by an organization.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CONTACT_LEG_SOLVE', 'COLUMN', N'CUSTOM_MEASURE_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds information regarding any extra measure that are required by an organization.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CONTACT_LEG_SOLVE', 'COLUMN', N'CUSTOM_MEASURE_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds information regarding any extra measure that are required by an organization.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CONTACT_LEG_SOLVE', 'COLUMN', N'CUSTOM_MEASURE_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds information regarding any extra measure that are required by an organization.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CONTACT_LEG_SOLVE', 'COLUMN', N'CUSTOM_MEASURE_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds information regarding any extra measure that are required by an organization.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CONTACT_LEG_SOLVE', 'COLUMN', N'CUSTOM_MEASURE_9'
GO
GRANT SELECT
	ON [dbo].[TB_FCT_CONTACT_LEG_SOLVE]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_FCT_CONTACT_LEG_SOLVE]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_FCT_CONTACT_LEG_SOLVE]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_FCT_CONTACT_LEG_SOLVE] SET (LOCK_ESCALATION = TABLE)
GO
