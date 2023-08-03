SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TB_FCT_TASK_DETAIL] (
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
		[ACTIVITY_SUB_TYPE_CODE_URN]     [int] NOT NULL,
		[CASE_ID]                        [numeric](19, 0) NOT NULL,
		[CASE_URN]                       [int] NOT NULL,
		[CASE_TYPE]                      [int] NOT NULL,
		[CUSTOMER_URN]                   [int] NOT NULL,
		[CONTACT_POINT_URN]              [int] NOT NULL,
		[TENANT_URN]                     [int] NOT NULL,
		[QUEUE_URN]                      [int] NOT NULL,
		[AGENT_URN]                      [int] NOT NULL,
		[ACTIVITY_PRIORITY]              [int] NULL,
		[COMPLETED_CNTR]                 [int] NOT NULL,
		[ACTIVITY_DURATION]              [int] NOT NULL,
		[COMPLETED_METSLA_CNTR]          [int] NOT NULL,
		[HANDLED_TIME]                   [int] NOT NULL,
		CONSTRAINT [PK_FCT_TASK_DETAIL]
		PRIMARY KEY
		CLUSTERED
		([PARTITION_URN])
	ON [FCTEGNGROUP]
) ON [FCTEGNGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_FCT_TASK_DETAIL_AGENT_URN]
	ON [dbo].[TB_FCT_TASK_DETAIL] ([AGENT_URN])
	ON [FCTEGNGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_TASK_DETAIL', 'INDEX', N'IX_FCT_TASK_DETAIL_AGENT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the template table for metrics or facts relating to the eGain task activities for fixed drill down capability.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_TASK_DETAIL', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_TASK_DETAIL', 'COLUMN', N'PARTITION_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column holds a value that uniquely identifies a row across all the partition tables for this partition type.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_TASK_DETAIL', 'COLUMN', N'PARTITION_GLOBAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number for the current partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_TASK_DETAIL', 'COLUMN', N'PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column gives information regarding the source of the data. This corresponds to the RESOURCE_URN from TB_CLU_RESOURCE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_TASK_DETAIL', 'COLUMN', N'CLUSTER_RESOURCE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Unique ID for the activity on the source.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_TASK_DETAIL', 'COLUMN', N'ACTIVITY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN that represents Activity information, as TB_DIM_ACTIVITY.ITEM_URN.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_TASK_DETAIL', 'COLUMN', N'ACTIVITY_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_SUB_CODE.ITEM_URN and refers to the type of task activity.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_TASK_DETAIL', 'COLUMN', N'ACTIVITY_SUB_TYPE_CODE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Unique ID for the case on the source.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_TASK_DETAIL', 'COLUMN', N'CASE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN that represents Case information, as TB_DIM_CASE.ITEM_URN.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_TASK_DETAIL', 'COLUMN', N'CASE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_CUSTOMER.ITEM_URN and refers to the customer of the activity.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_TASK_DETAIL', 'COLUMN', N'CUSTOMER_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_TENANT.ITEM_URN and refers to the Tenant (or "Department" on the source) of the Agent.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_TASK_DETAIL', 'COLUMN', N'TENANT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TENANT', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_TASK_DETAIL', 'COLUMN', N'TENANT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_QUEUE.ITEM_URN and refers to the Queue related to this activity.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_TASK_DETAIL', 'COLUMN', N'QUEUE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_QUEUE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_TASK_DETAIL', 'COLUMN', N'QUEUE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_AGENT.ITEM_URN and refers to the Agent to which the activity is assigned.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_TASK_DETAIL', 'COLUMN', N'AGENT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_AGENT', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_TASK_DETAIL', 'COLUMN', N'AGENT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The total duration of a task. Task Duration = Activity completion time – Activity creation time', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_TASK_DETAIL', 'COLUMN', N'ACTIVITY_DURATION'
GO
GRANT SELECT
	ON [dbo].[TB_FCT_TASK_DETAIL]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_FCT_TASK_DETAIL]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_FCT_TASK_DETAIL]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_FCT_TASK_DETAIL] SET (LOCK_ESCALATION = TABLE)
GO
