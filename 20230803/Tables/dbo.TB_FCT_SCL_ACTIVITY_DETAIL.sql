SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TB_FCT_SCL_ACTIVITY_DETAIL] (
		[PARTITION_URN]                      [int] NOT NULL,
		[PARTITION_ID]                       [int] NOT NULL,
		[PARTITION_GLOBAL_URN]               [bigint] NOT NULL,
		[EVENT_ID]                           [bigint] NOT NULL,
		[DATE_TIME_UTC]                      [datetime] NOT NULL,
		[DATE_UTC_URN]                       [int] NOT NULL,
		[TIME_UTC_URN]                       [smallint] NOT NULL,
		[CLUSTER_RESOURCE_URN]               [int] NOT NULL,
		[ACTIVITY_ID]                        [numeric](19, 0) NOT NULL,
		[CASE_ID]                            [numeric](19, 0) NOT NULL,
		[ACTIVITY_URN]                       [int] NOT NULL,
		[CASE_URN]                           [int] NOT NULL,
		[TENANT_URN]                         [int] NOT NULL,
		[QUEUE_URN]                          [int] NOT NULL,
		[AGENT_URN]                          [int] NOT NULL,
		[AGENT_TEAM_URN]                     [int] NOT NULL,
		[PERSON_URN]                         [int] NOT NULL,
		[SCL_ADAPTER_URN]                    [int] NOT NULL,
		[SCL_SEARCH_URN]                     [int] NOT NULL,
		[SCL_ADAPTER_TYPE_CODE_URN]          [int] NOT NULL,
		[SCL_ADAPTER_TYPE_SUB_CODE_URN]      [int] NOT NULL,
		[NEW_CASE_CNTR]                      [int] NOT NULL,
		[EXISTING_CASE_CNTR]                 [int] NOT NULL,
		[EXISTING_CASE_FOLLOW_UP_CNTR]       [int] NOT NULL,
		[COMPLETED_CNTR]                     [int] NOT NULL,
		[ASSIGNED_TO_QUEUE_CNTR]             [int] NOT NULL,
		[ASSIGNED_TO_USER_CNTR]              [int] NOT NULL,
		[COMPOSE_SENT_CNTR]                  [int] NOT NULL,
		[COMPOSE_SENT_FOLLOW_UP_CNTR]        [int] NOT NULL,
		[PUBLISH_SENT_CNTR]                  [int] NOT NULL,
		[PUBLISH_SENT_FOLLOW_UP_CNTR]        [int] NOT NULL,
		[COMPLETED_MET_SLA_CNTR]             [int] NOT NULL,
		[COMPLETED_NOT_MET_SLA_CNTR]         [int] NOT NULL,
		[MANUAL_REPLY_CNTR]                  [int] NOT NULL,
		[MANUAL_REPLY_FOLLOW_UP_CNTR]        [int] NOT NULL,
		[MANUAL_REPLY_MET_SLA_CNTR]          [int] NOT NULL,
		[MANUAL_REPLY_NOT_MET_SLA_CNTR]      [int] NOT NULL,
		[FIRST_REPLY_TIME]                   [int] NOT NULL,
		[WORK_TIME]                          [int] NOT NULL,
		[ACTIVITY_DURATION]                  [int] NOT NULL,
		[CUSTOM_ATTRIBUTE_0]                 [int] NOT NULL,
		[CUSTOM_ATTRIBUTE_1]                 [int] NOT NULL,
		[CUSTOM_ATTRIBUTE_2]                 [int] NOT NULL,
		[CUSTOM_ATTRIBUTE_3]                 [int] NOT NULL,
		[CUSTOM_ATTRIBUTE_4]                 [int] NOT NULL,
		[CUSTOM_ATTRIBUTE_5]                 [int] NOT NULL,
		[CUSTOM_ATTRIBUTE_6]                 [int] NOT NULL,
		[CUSTOM_ATTRIBUTE_7]                 [int] NOT NULL,
		[CUSTOM_ATTRIBUTE_8]                 [int] NOT NULL,
		[CUSTOM_ATTRIBUTE_9]                 [int] NOT NULL,
		[CUSTOM_MEASURE_0]                   [int] NULL,
		[CUSTOM_MEASURE_1]                   [int] NULL,
		[CUSTOM_MEASURE_2]                   [int] NULL,
		[CUSTOM_MEASURE_3]                   [int] NULL,
		[CUSTOM_MEASURE_4]                   [int] NULL,
		[CUSTOM_MEASURE_5]                   [int] NULL,
		[CUSTOM_MEASURE_6]                   [int] NULL,
		[CUSTOM_MEASURE_7]                   [int] NULL,
		[CUSTOM_MEASURE_8]                   [int] NULL,
		[CUSTOM_MEASURE_9]                   [int] NULL,
		[MANAGER_AGENT_URN]                  [int] NOT NULL,
		[TURNAROUND_CNTR]                    [int] NOT NULL,
		[TURNAROUND_TIME]                    [int] NOT NULL,
		[WORK_STATE_TIME]                    [int] NOT NULL,
		[FIRST_REPLY_TIME_BIZCAL]            [int] NOT NULL,
		[TURNAROUND_TIME_BIZCAL]             [int] NOT NULL,
		[ACTIVITY_DURATION_BIZCAL]           [int] NOT NULL,
		[TURNAROUND_TIME_MET]                [int] NOT NULL,
		[TURNAROUND_TIME_NOT_MET]            [int] NOT NULL,
		[TURNAROUND_TIME_MET_BIZCAL]         [int] NOT NULL,
		[TURNAROUND_TIME_NOT_MET_BIZCAL]     [int] NOT NULL,
		CONSTRAINT [PK_FCT_SCL_ACTIVITY_DETAIL]
		PRIMARY KEY
		CLUSTERED
		([PARTITION_URN], [PARTITION_ID])
	ON [FCTEGNGROUP]
) ON [FCTEGNGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SCL_ACTIVITY_DETAIL', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SCL_ACTIVITY_DETAIL', 'COLUMN', N'PARTITION_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number for the current partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SCL_ACTIVITY_DETAIL', 'COLUMN', N'PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column holds a value that uniquely identifies a row across all the partition tables for this partition type.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SCL_ACTIVITY_DETAIL', 'COLUMN', N'PARTITION_GLOBAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to field EVENT_ID in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SCL_ACTIVITY_DETAIL', 'COLUMN', N'EVENT_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The date and time when the event occurred in UTC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SCL_ACTIVITY_DETAIL', 'COLUMN', N'DATE_TIME_UTC'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the date of the DATE_TIME_UTC value.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SCL_ACTIVITY_DETAIL', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DATE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SCL_ACTIVITY_DETAIL', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the time of the DATE_TIME_UTC value.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SCL_ACTIVITY_DETAIL', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIME', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SCL_ACTIVITY_DETAIL', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column gives information regarding the source of the data. This corresponds to the RESOURCE_URN from TB_CLU_RESOURCE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SCL_ACTIVITY_DETAIL', 'COLUMN', N'CLUSTER_RESOURCE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Unique ID for the activity on the source.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SCL_ACTIVITY_DETAIL', 'COLUMN', N'ACTIVITY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Unique ID for the case on the source.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SCL_ACTIVITY_DETAIL', 'COLUMN', N'CASE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN that represents Activity information, as TB_DIM_ACTIVITY.ITEM_URN.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SCL_ACTIVITY_DETAIL', 'COLUMN', N'ACTIVITY_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN that represents Case information, as TB_DIM_CASE.ITEM_URN.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SCL_ACTIVITY_DETAIL', 'COLUMN', N'CASE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_TENANT.ITEM_URN and refers to the Tenant (or "Department" on the source).', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SCL_ACTIVITY_DETAIL', 'COLUMN', N'TENANT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TENANT', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SCL_ACTIVITY_DETAIL', 'COLUMN', N'TENANT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN that represents Queue information, as TB_DIM_QUEUE.ITEM_URN.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SCL_ACTIVITY_DETAIL', 'COLUMN', N'QUEUE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN that represents Agent information, as TB_DIM_AGENT.ITEM_URN.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SCL_ACTIVITY_DETAIL', 'COLUMN', N'AGENT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN that represents Aget Team information, as TB_DIM_AGENT_TEAM.ITEM_URN.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SCL_ACTIVITY_DETAIL', 'COLUMN', N'AGENT_TEAM_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN that represents Person information, as TB_DIM_PERSON.ITEM_URN.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SCL_ACTIVITY_DETAIL', 'COLUMN', N'PERSON_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN that represents SCL Adapter information, as TB_DIM_SCL_ADAPTER.ITEM_URN', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SCL_ACTIVITY_DETAIL', 'COLUMN', N'SCL_ADAPTER_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN that represents SCL Search information, as TB_DIM_SCL_SEARCH.ITEM_URN.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SCL_ACTIVITY_DETAIL', 'COLUMN', N'SCL_SEARCH_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN that represents SCL Adapter Type Code information, as TB_DIM_CODE.ITEM_URN.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SCL_ACTIVITY_DETAIL', 'COLUMN', N'SCL_ADAPTER_TYPE_CODE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN that represents SCL Adapter Type Sub Code information, as TB_DIM_SUB_CODE.ITEM_URN.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SCL_ACTIVITY_DETAIL', 'COLUMN', N'SCL_ADAPTER_TYPE_SUB_CODE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'TO-DO', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SCL_ACTIVITY_DETAIL', 'COLUMN', N'NEW_CASE_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'TO-DO', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SCL_ACTIVITY_DETAIL', 'COLUMN', N'EXISTING_CASE_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'TO-DO', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SCL_ACTIVITY_DETAIL', 'COLUMN', N'EXISTING_CASE_FOLLOW_UP_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'TO-DO', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SCL_ACTIVITY_DETAIL', 'COLUMN', N'COMPLETED_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'TO-DO', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SCL_ACTIVITY_DETAIL', 'COLUMN', N'ASSIGNED_TO_QUEUE_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'TO-DO', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SCL_ACTIVITY_DETAIL', 'COLUMN', N'ASSIGNED_TO_USER_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'TO-DO', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SCL_ACTIVITY_DETAIL', 'COLUMN', N'COMPOSE_SENT_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'TO-DO', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SCL_ACTIVITY_DETAIL', 'COLUMN', N'COMPOSE_SENT_FOLLOW_UP_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'TO-DO', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SCL_ACTIVITY_DETAIL', 'COLUMN', N'PUBLISH_SENT_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'TO-DO', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SCL_ACTIVITY_DETAIL', 'COLUMN', N'PUBLISH_SENT_FOLLOW_UP_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'TO-DO', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SCL_ACTIVITY_DETAIL', 'COLUMN', N'COMPLETED_MET_SLA_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'TO-DO', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SCL_ACTIVITY_DETAIL', 'COLUMN', N'COMPLETED_NOT_MET_SLA_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'TO-DO', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SCL_ACTIVITY_DETAIL', 'COLUMN', N'MANUAL_REPLY_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'TO-DO', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SCL_ACTIVITY_DETAIL', 'COLUMN', N'MANUAL_REPLY_FOLLOW_UP_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'TO-DO', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SCL_ACTIVITY_DETAIL', 'COLUMN', N'MANUAL_REPLY_MET_SLA_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'TO-DO', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SCL_ACTIVITY_DETAIL', 'COLUMN', N'MANUAL_REPLY_NOT_MET_SLA_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'TO-DO', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SCL_ACTIVITY_DETAIL', 'COLUMN', N'FIRST_REPLY_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'TO-DO', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SCL_ACTIVITY_DETAIL', 'COLUMN', N'WORK_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'TO-DO', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SCL_ACTIVITY_DETAIL', 'COLUMN', N'ACTIVITY_DURATION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SCL_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_ATTRIBUTE_0'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM0', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SCL_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_ATTRIBUTE_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SCL_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_ATTRIBUTE_1'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM1', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SCL_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_ATTRIBUTE_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SCL_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_ATTRIBUTE_2'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM2', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SCL_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_ATTRIBUTE_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SCL_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_ATTRIBUTE_3'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM3', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SCL_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_ATTRIBUTE_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SCL_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_ATTRIBUTE_4'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM4', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SCL_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_ATTRIBUTE_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SCL_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_ATTRIBUTE_5'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM5', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SCL_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_ATTRIBUTE_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SCL_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_ATTRIBUTE_6'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM6', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SCL_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_ATTRIBUTE_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SCL_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_ATTRIBUTE_7'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM7', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SCL_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_ATTRIBUTE_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SCL_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_ATTRIBUTE_8'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM8', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SCL_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_ATTRIBUTE_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SCL_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_ATTRIBUTE_9'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM9', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SCL_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_ATTRIBUTE_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SCL_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SCL_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SCL_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SCL_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SCL_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SCL_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SCL_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SCL_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SCL_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SCL_ACTIVITY_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_AGENT.ITEM_URN and refers to the Agent who is manager of the Agent specified in AGENT_URN.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SCL_ACTIVITY_DETAIL', 'COLUMN', N'MANAGER_AGENT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'An activity is considered to have been turned around when a social activity is responded for the first time, is completed or manually transferred out from the agent (whichever happens first after it is assigned to the agent).', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SCL_ACTIVITY_DETAIL', 'COLUMN', N'TURNAROUND_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Time spent in seconds since the assignment of activity to an agent till it is turned around.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SCL_ACTIVITY_DETAIL', 'COLUMN', N'TURNAROUND_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of social activities turned around within the target turnaround time.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SCL_ACTIVITY_DETAIL', 'COLUMN', N'TURNAROUND_TIME_MET'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of social activities turned around outside of the target turnaround time.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SCL_ACTIVITY_DETAIL', 'COLUMN', N'TURNAROUND_TIME_NOT_MET'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of social activities turned around within the target turnaround time, calculated according to the business calendar.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SCL_ACTIVITY_DETAIL', 'COLUMN', N'TURNAROUND_TIME_MET_BIZCAL'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of social activities turned around outside of the target turnaround time, calculated according to the business calendar.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SCL_ACTIVITY_DETAIL', 'COLUMN', N'TURNAROUND_TIME_NOT_MET_BIZCAL'
GO
GRANT SELECT
	ON [dbo].[TB_FCT_SCL_ACTIVITY_DETAIL]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_FCT_SCL_ACTIVITY_DETAIL]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_FCT_SCL_ACTIVITY_DETAIL]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_FCT_SCL_ACTIVITY_DETAIL] SET (LOCK_ESCALATION = TABLE)
GO
