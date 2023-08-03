SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TB_FCT_ACTIVITY_CLASSIFICATION] (
		[PARTITION_URN]                    [int] NOT NULL,
		[PARTITION_GLOBAL_URN]             [bigint] NOT NULL,
		[PARTITION_ID]                     [int] NOT NULL,
		[DATE_TIME_UTC]                    [datetime] NOT NULL,
		[DATE_UTC_URN]                     [int] NOT NULL,
		[TIME_UTC_URN]                     [smallint] NOT NULL,
		[CLUSTER_RESOURCE_URN]             [int] NOT NULL,
		[ACTIVITY_URN]                     [int] NOT NULL,
		[CASE_URN]                         [int] NOT NULL,
		[CLASSIFICATION_CATEGORY_URN]      [int] NOT NULL,
		[RESOLUTION_CODE_CATEGORY_URN]     [int] NOT NULL,
		[TENANT_URN]                       [int] NOT NULL,
		[QUEUE_URN]                        [int] NOT NULL,
		[AGENT_URN]                        [int] NOT NULL,
		[ACTIVITY_TYPE_CODE_URN]           [int] NOT NULL,
		[CUSTOM_DIMENSION_0]               [int] NOT NULL,
		[CUSTOM_DIMENSION_1]               [int] NOT NULL,
		[CUSTOM_DIMENSION_2]               [int] NOT NULL,
		[CUSTOM_DIMENSION_3]               [int] NOT NULL,
		[CUSTOM_DIMENSION_4]               [int] NOT NULL,
		[CUSTOM_DIMENSION_5]               [int] NOT NULL,
		[CUSTOM_DIMENSION_6]               [int] NOT NULL,
		[CUSTOM_DIMENSION_7]               [int] NOT NULL,
		[CUSTOM_DIMENSION_8]               [int] NOT NULL,
		[CUSTOM_DIMENSION_9]               [int] NOT NULL,
		[CUSTOM_MEASURE_0]                 [int] NULL,
		[CUSTOM_MEASURE_1]                 [int] NULL,
		[CUSTOM_MEASURE_2]                 [int] NULL,
		[CUSTOM_MEASURE_3]                 [int] NULL,
		[CUSTOM_MEASURE_4]                 [int] NULL,
		[CUSTOM_MEASURE_5]                 [int] NULL,
		[CUSTOM_MEASURE_6]                 [int] NULL,
		[CUSTOM_MEASURE_7]                 [int] NULL,
		[CUSTOM_MEASURE_8]                 [int] NULL,
		[CUSTOM_MEASURE_9]                 [int] NULL,
		[NEW_CASE_CNTR]                    [int] NOT NULL,
		[EXISTING_CASE_CNTR]               [int] NOT NULL,
		CONSTRAINT [PK_FCT_ACTIVITY_CLASSIFICATION]
		PRIMARY KEY
		CLUSTERED
		([PARTITION_URN])
	ON [FCTEGNGROUP]
) ON [FCTEGNGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_FCT_ACTIVITY_CLASSIFICATION_AGENT_URN]
	ON [dbo].[TB_FCT_ACTIVITY_CLASSIFICATION] ([AGENT_URN])
	ON [FCTEGNGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_CLASSIFICATION', 'INDEX', N'IX_FCT_ACTIVITY_CLASSIFICATION_AGENT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the template table for metrics relating to classification of activities.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_CLASSIFICATION', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_CLASSIFICATION', 'COLUMN', N'PARTITION_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column holds a value that uniquely identifies a row across all the partition tables for this partition type.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_CLASSIFICATION', 'COLUMN', N'PARTITION_GLOBAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number for the current partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_CLASSIFICATION', 'COLUMN', N'PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The date and time when the event occurred in UTC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_CLASSIFICATION', 'COLUMN', N'DATE_TIME_UTC'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the date of the DATE_TIME_UTC value.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_CLASSIFICATION', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DATE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_CLASSIFICATION', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the time of the DATE_TIME_UTC value.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_CLASSIFICATION', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIME', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_CLASSIFICATION', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column gives information regarding the source of the data. This corresponds to the RESOURCE_URN from TB_CLU_RESOURCE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_CLASSIFICATION', 'COLUMN', N'CLUSTER_RESOURCE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_ACTIVITY.ITEM_URN and refers to the Activity related to this activity.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_CLASSIFICATION', 'COLUMN', N'ACTIVITY_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_CASE.ITEM_URN and refers to the Case related to this activity.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_CLASSIFICATION', 'COLUMN', N'CASE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_CLASSIFICATION', 'COLUMN', N'CLASSIFICATION_CATEGORY_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_CLASSIFICATION', 'COLUMN', N'RESOLUTION_CODE_CATEGORY_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_TENANT.ITEM_URN and refers to the Tenant (or "Department" on the source) of the Agent.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_CLASSIFICATION', 'COLUMN', N'TENANT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TENANT', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_CLASSIFICATION', 'COLUMN', N'TENANT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_QUEUE.ITEM_URN and refers to the Queue related to this activity.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_CLASSIFICATION', 'COLUMN', N'QUEUE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_QUEUE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_CLASSIFICATION', 'COLUMN', N'QUEUE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_AGENT.ITEM_URN and refers to the Agent to which the case is assigned.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_CLASSIFICATION', 'COLUMN', N'AGENT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_AGENT', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_CLASSIFICATION', 'COLUMN', N'AGENT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_CODE.ITEM_URN and refers to the type of the activity (e.g. Chat or Email) associated with this event.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_CLASSIFICATION', 'COLUMN', N'ACTIVITY_TYPE_CODE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_CLASSIFICATION', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM0', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_CLASSIFICATION', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_CLASSIFICATION', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM1', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_CLASSIFICATION', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_CLASSIFICATION', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM2', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_CLASSIFICATION', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_CLASSIFICATION', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM3', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_CLASSIFICATION', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_CLASSIFICATION', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM4', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_CLASSIFICATION', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_CLASSIFICATION', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM5', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_CLASSIFICATION', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_CLASSIFICATION', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM6', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_CLASSIFICATION', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_CLASSIFICATION', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM7', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_CLASSIFICATION', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_CLASSIFICATION', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM8', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_CLASSIFICATION', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_CLASSIFICATION', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM9', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_CLASSIFICATION', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_CLASSIFICATION', 'COLUMN', N'CUSTOM_MEASURE_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_CLASSIFICATION', 'COLUMN', N'CUSTOM_MEASURE_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_CLASSIFICATION', 'COLUMN', N'CUSTOM_MEASURE_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_CLASSIFICATION', 'COLUMN', N'CUSTOM_MEASURE_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_CLASSIFICATION', 'COLUMN', N'CUSTOM_MEASURE_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_CLASSIFICATION', 'COLUMN', N'CUSTOM_MEASURE_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_CLASSIFICATION', 'COLUMN', N'CUSTOM_MEASURE_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_CLASSIFICATION', 'COLUMN', N'CUSTOM_MEASURE_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_CLASSIFICATION', 'COLUMN', N'CUSTOM_MEASURE_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_CLASSIFICATION', 'COLUMN', N'CUSTOM_MEASURE_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Indicates whether the activity classified had a new case created.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_CLASSIFICATION', 'COLUMN', N'NEW_CASE_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Indicates whether the activity classified was part of an existing case.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_CLASSIFICATION', 'COLUMN', N'EXISTING_CASE_CNTR'
GO
GRANT SELECT
	ON [dbo].[TB_FCT_ACTIVITY_CLASSIFICATION]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_FCT_ACTIVITY_CLASSIFICATION]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_FCT_ACTIVITY_CLASSIFICATION]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_FCT_ACTIVITY_CLASSIFICATION] SET (LOCK_ESCALATION = TABLE)
GO
