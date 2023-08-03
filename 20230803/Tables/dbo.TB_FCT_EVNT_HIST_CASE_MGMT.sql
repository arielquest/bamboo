SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_FCT_EVNT_HIST_CASE_MGMT] (
		[PARTITION_URN]                  [int] NOT NULL,
		[PARTITION_ID]                   [int] NOT NULL,
		[PARTITION_GLOBAL_URN]           [bigint] NOT NULL,
		[EVENT_ID]                       [bigint] NOT NULL,
		[EVENT_DATE_TIME_UTC]            [datetime] NULL,
		[EVENT_DATE_UTC_URN]             [int] NULL,
		[EVENT_TIME_UTC_URN]             [int] NULL,
		[CLUSTER_RESOURCE_URN]           [int] NOT NULL,
		[ACTIVITY_TYPE_CODE_URN]         [int] NULL,
		[LANGUAGE_URN]                   [int] NULL,
		[TENANT_URN]                     [int] NULL,
		[OFFER_URN]                      [int] NULL,
		[QUEUE_URN]                      [int] NULL,
		[ENTRY_POINT_URN]                [int] NULL,
		[ALIAS_URN]                      [int] NULL,
		[AGENT_URN]                      [int] NULL,
		[OBJECT_OPERATION]               [smallint] NULL,
		[EVENT_DURATION]                 [int] NULL,
		[SESSION_ID]                     [bigint] NULL,
		[REASON]                         [int] NULL,
		[REASON1]                        [int] NULL,
		[REASON2]                        [int] NULL,
		[REASON3]                        [int] NULL,
		[REASON4]                        [nvarchar](255) COLLATE Latin1_General_CI_AS NULL,
		[OBJECT_TYPE]                    [smallint] NULL,
		[SOURCE_ACTIVITY_ID]             [int] NULL,
		[CASE_ID]                        [int] NULL,
		[ACTIVITY_ID]                    [int] NULL,
		[TOP_LVL_ACTIVITY_ID]            [int] NULL,
		[CUSTOMER_URN]                   [int] NULL,
		[CUSTOM_DIMENSION_0]             [int] NOT NULL,
		[CUSTOM_DIMENSION_1]             [int] NOT NULL,
		[CUSTOM_DIMENSION_2]             [int] NOT NULL,
		[CUSTOM_DIMENSION_3]             [int] NOT NULL,
		[CUSTOM_DIMENSION_4]             [int] NOT NULL,
		[CUSTOM_DIMENSION_5]             [int] NOT NULL,
		[CUSTOM_DIMENSION_6]             [int] NOT NULL,
		[CUSTOM_DIMENSION_7]             [int] NOT NULL,
		[CUSTOM_DIMENSION_8]             [int] NOT NULL,
		[CUSTOM_DIMENSION_9]             [int] NOT NULL,
		[CUSTOM_MEASURE_0]               [int] NULL,
		[CUSTOM_MEASURE_1]               [int] NULL,
		[CUSTOM_MEASURE_2]               [int] NULL,
		[CUSTOM_MEASURE_3]               [int] NULL,
		[CUSTOM_MEASURE_4]               [int] NULL,
		[CUSTOM_MEASURE_5]               [int] NULL,
		[CUSTOM_MEASURE_6]               [int] NULL,
		[CUSTOM_MEASURE_7]               [int] NULL,
		[CUSTOM_MEASURE_8]               [int] NULL,
		[CUSTOM_MEASURE_9]               [int] NULL,
		[ACTIVITY_URN]                   [int] NOT NULL,
		[CASE_URN]                       [int] NOT NULL,
		[SOURCE_ACTIVITY_URN]            [int] NOT NULL,
		[TOP_LVL_ACTIVITY_URN]           [int] NOT NULL,
		[ACTIVITY_SUB_TYPE_CODE_URN]     [int] NOT NULL,
		[ACTIVITY_MODE_CODE_URN]         [int] NOT NULL,
		[ACTIVITY_ORIGIN]                [int] NOT NULL,
		[DUE_DATE]                       [datetime] NULL,
		[CASE_DUE_DATE]                  [datetime] NULL,
		[SCL_SEARCH_URN]                 [int] NOT NULL,
		[SCL_ADAPTER_URN]                [int] NOT NULL,
		[CASE_CUSTOM_DIMENSION_0]        [int] NOT NULL,
		[CASE_CUSTOM_DIMENSION_1]        [int] NOT NULL,
		[CASE_CUSTOM_DIMENSION_2]        [int] NOT NULL,
		[CASE_CUSTOM_DIMENSION_3]        [int] NOT NULL,
		[CASE_CUSTOM_DIMENSION_4]        [int] NOT NULL,
		[CASE_CUSTOM_DIMENSION_5]        [int] NOT NULL,
		[CASE_CUSTOM_DIMENSION_6]        [int] NOT NULL,
		[CASE_CUSTOM_DIMENSION_7]        [int] NOT NULL,
		[CASE_CUSTOM_DIMENSION_8]        [int] NOT NULL,
		[CASE_CUSTOM_DIMENSION_9]        [int] NOT NULL,
		[CASE_CUSTOM_MEASURE_0]          [int] NULL,
		[CASE_CUSTOM_MEASURE_1]          [int] NULL,
		[CASE_CUSTOM_MEASURE_2]          [int] NULL,
		[CASE_CUSTOM_MEASURE_3]          [int] NULL,
		[CASE_CUSTOM_MEASURE_4]          [int] NULL,
		[CASE_CUSTOM_MEASURE_5]          [int] NULL,
		[CASE_CUSTOM_MEASURE_6]          [int] NULL,
		[CASE_CUSTOM_MEASURE_7]          [int] NULL,
		[CASE_CUSTOM_MEASURE_8]          [int] NULL,
		[CASE_CUSTOM_MEASURE_9]          [int] NULL,
		[CHAT_REFERRER_NAME_URN]         [int] NOT NULL,
		[CHAT_REFERRER_URL_URN]          [int] NOT NULL,
		[EVENT_DATA_JSON]                [nvarchar](1000) COLLATE Latin1_General_CI_AS NULL,
		CONSTRAINT [PK_FCT_EVNT_HIST_CASE_MGMT]
		PRIMARY KEY
		CLUSTERED
		([PARTITION_URN], [PARTITION_ID])
	ON [FCTEGNGROUP]
) ON [FCTEGNGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_FCT_EVNT_HIST_CASE_MGMT_PARTITION_GLOBAL_URN]
	ON [dbo].[TB_FCT_EVNT_HIST_CASE_MGMT] ([PARTITION_GLOBAL_URN])
	ON [FCTEGNIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'INDEX', N'IX_FCT_EVNT_HIST_CASE_MGMT_PARTITION_GLOBAL_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_EVNT_HIST_CASE_MGMT_AGENT_URN]
	ON [dbo].[TB_FCT_EVNT_HIST_CASE_MGMT] ([AGENT_URN])
	ON [FCTEGNIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'INDEX', N'IX_FCT_EVNT_HIST_CASE_MGMT_AGENT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table will hold the detailed fact data for event history case management.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'PARTITION_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number for the current partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column holds a value that uniquely identifies a row across all the partition tables for this partition type.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'PARTITION_GLOBAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to field EVENT_ID in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'EVENT_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The date and time when the event occurred in UTC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'EVENT_DATE_TIME_UTC'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the date of the EVENT_DATE_TIME_UTC value.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'EVENT_DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the time of the EVENT_DATE_TIME_UTC value.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'EVENT_TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column gives information regarding the source of the data. This corresponds to the RESOURCE_URN from TB_CLU_RESOURCE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'CLUSTER_RESOURCE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column gives information regarding the source of the data.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'ACTIVITY_TYPE_CODE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'A foreign key to the language of this culture in TE_ADM_CULTURE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'LANGUAGE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_TENANT.ITEM_URN and refers to the Tenant (or "Department" on the source) of the Agent.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'TENANT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TENANT', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'TENANT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_OFFER.ITEM_URN and refers to the offer.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'OFFER_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_OFFER', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'OFFER_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_QUEUE.ITEM_URN and refers to the queue.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'QUEUE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_QUEUE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'QUEUE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to ENTRY_POINT in TB_DIM_ENTRY_POINT.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'ENTRY_POINT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_ENTRY_POINT', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'ENTRY_POINT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to the alias in TB_DIM_ALIAS.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'ALIAS_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_ALIAS', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'ALIAS_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_AGENT.ITEM_URN and refers to the Agent to which the activity is assigned.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'AGENT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_AGENT', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'AGENT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to the OBJECT_OPERATION of source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'OBJECT_OPERATION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to the EVENT_DURATION of source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'EVENT_DURATION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'If present,this maps to field SESSION_ID in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'SESSION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'If present,this maps to field REASON in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'REASON'
GO
EXEC sp_addextendedproperty N'MS_Description', N'If present,this maps to field REASON1 in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'REASON1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'If present,this maps to field REASON2 in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'REASON2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'If present,this maps to field REASON3 in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'REASON3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'If present,this maps to field REASON4 in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'REASON4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'If present,this maps to field OBJECT_TYPE in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'OBJECT_TYPE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'If present,this maps to field SOURCE_ACTIVITY_ID in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'SOURCE_ACTIVITY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to field CASE_ID in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'CASE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to field ACTIVITY_ID in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'ACTIVITY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to field TOP_LVL_ACTIVITY_ID in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'TOP_LVL_ACTIVITY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_CUSTOMER.ITEM_URN and refers to the customer of the activity.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'CUSTOMER_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM0', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM1', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM2', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM3', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM4', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM5', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM6', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM7', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM8', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM9', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'CUSTOM_MEASURE_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'CUSTOM_MEASURE_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'CUSTOM_MEASURE_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'CUSTOM_MEASURE_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'CUSTOM_MEASURE_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'CUSTOM_MEASURE_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'CUSTOM_MEASURE_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'CUSTOM_MEASURE_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'CUSTOM_MEASURE_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'CUSTOM_MEASURE_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN that represents Activity information, as TB_DIM_ACTIVITY.ITEM_URN.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'ACTIVITY_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN that represents Case information, as TB_DIM_CASE.ITEM_URN.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'CASE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN that represents Source Activity information, as TB_DIM_ACTIVITY.ITEM_URN.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'SOURCE_ACTIVITY_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN that represents Top Level Activity information, as TB_DIM_ACTIVITY.ITEM_URN.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'TOP_LVL_ACTIVITY_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column gives information regarding the sub types for the source of the data. Eg Video Chat or Text Chat', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'ACTIVITY_SUB_TYPE_CODE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column gives information regarding the mode of activity', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'ACTIVITY_MODE_CODE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column gives information regarding the origin of activity', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'ACTIVITY_ORIGIN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column gives information regarding the due date of activity if supplied. This may be used for SLA calculation.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'DUE_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column gives information regarding the due date of case if supplied. This may be used for SLA calculation.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'CASE_DUE_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN that represents Social Search information, as TB_DIM_SCL_ADAPTER.ITEM_URN.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'SCL_SEARCH_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN that represents Social Adapter information, as TB_DIM_SCL_SEARCH.ITEM_URN.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'SCL_ADAPTER_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'CASE_CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM0', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'CASE_CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'CASE_CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM1', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'CASE_CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'CASE_CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM2', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'CASE_CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'CASE_CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM3', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'CASE_CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'CASE_CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM4', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'CASE_CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'CASE_CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM5', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'CASE_CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'CASE_CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM6', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'CASE_CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'CASE_CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM7', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'CASE_CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'CASE_CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM8', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'CASE_CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'CASE_CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM9', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'CASE_CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'CASE_CUSTOM_MEASURE_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'CASE_CUSTOM_MEASURE_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'CASE_CUSTOM_MEASURE_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'CASE_CUSTOM_MEASURE_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'CASE_CUSTOM_MEASURE_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'CASE_CUSTOM_MEASURE_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'CASE_CUSTOM_MEASURE_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'CASE_CUSTOM_MEASURE_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'CASE_CUSTOM_MEASURE_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'CASE_CUSTOM_MEASURE_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_CHAT_REFERRER_NAME.ITEM_URN', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'CHAT_REFERRER_NAME_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_CHAT_REFERRER_URL.ITEM_URN', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_EVNT_HIST_CASE_MGMT', 'COLUMN', N'CHAT_REFERRER_URL_URN'
GO
GRANT SELECT
	ON [dbo].[TB_FCT_EVNT_HIST_CASE_MGMT]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_FCT_EVNT_HIST_CASE_MGMT]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_FCT_EVNT_HIST_CASE_MGMT]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_FCT_EVNT_HIST_CASE_MGMT] SET (LOCK_ESCALATION = TABLE)
GO
