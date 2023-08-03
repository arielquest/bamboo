SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TB_SUM_VOICE_AGENT_STATE_INTERVAL] (
		[PARTITION_URN]              [int] NOT NULL,
		[PARTITION_GLOBAL_URN]       [bigint] NOT NULL,
		[PARTITION_ID]               [int] NOT NULL,
		[DATE_TIME_UTC]              [datetime] NOT NULL,
		[DATE_UTC_URN]               [int] NOT NULL,
		[TIME_UTC_URN]               [smallint] NOT NULL,
		[CLUSTER_RESOURCE_URN]       [int] NOT NULL,
		[AGENT_URN]                  [int] NOT NULL,
		[PERSON_URN]                 [int] NOT NULL,
		[QUEUE_URN]                  [int] NOT NULL,
		[CALL_DIRECTION_URN]         [int] NOT NULL,
		[REASON_CODE_URN]            [int] NOT NULL,
		[SERVICE_LEVEL_TYPE]         [int] NULL,
		[AVAILABLE_STATE_TIME]       [int] NULL,
		[HOLD_STATE_TIME]            [int] NULL,
		[LOGGED_ON_TIME]             [int] NULL,
		[RING_STATE_TIME]            [int] NULL,
		[TALK_STATE_TIME]            [int] NULL,
		[UNAVAILABLE_STATE_TIME]     [int] NULL,
		[WRAP_STATE_TIME]            [int] NULL,
		[CUSTOM_DIMENSION_0]         [int] NOT NULL,
		[CUSTOM_DIMENSION_1]         [int] NOT NULL,
		[CUSTOM_DIMENSION_2]         [int] NOT NULL,
		[CUSTOM_DIMENSION_3]         [int] NOT NULL,
		[CUSTOM_DIMENSION_4]         [int] NOT NULL,
		[CUSTOM_DIMENSION_5]         [int] NOT NULL,
		[CUSTOM_DIMENSION_6]         [int] NOT NULL,
		[CUSTOM_DIMENSION_7]         [int] NOT NULL,
		[CUSTOM_DIMENSION_8]         [int] NOT NULL,
		[CUSTOM_DIMENSION_9]         [int] NOT NULL,
		[CUSTOM_MEASURE_0]           [int] NULL,
		[CUSTOM_MEASURE_1]           [int] NULL,
		[CUSTOM_MEASURE_2]           [int] NULL,
		[CUSTOM_MEASURE_3]           [int] NULL,
		[CUSTOM_MEASURE_4]           [int] NULL,
		[CUSTOM_MEASURE_5]           [int] NULL,
		[CUSTOM_MEASURE_6]           [int] NULL,
		[CUSTOM_MEASURE_7]           [int] NULL,
		[CUSTOM_MEASURE_8]           [int] NULL,
		[CUSTOM_MEASURE_9]           [int] NULL,
		CONSTRAINT [PK_SUM_VOICE_AGENT_STATE_INTERVAL]
		PRIMARY KEY
		CLUSTERED
		([PARTITION_URN])
	ON [SUMAWSGROUP]
) ON [SUMAWSGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_SUM_VOICE_AGENT_STATE_INTERVAL_AGENT_URN]
	ON [dbo].[TB_SUM_VOICE_AGENT_STATE_INTERVAL] ([AGENT_URN])
	ON [SUMAWSGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_AGENT_STATE_INTERVAL', 'INDEX', N'IX_SUM_VOICE_AGENT_STATE_INTERVAL_AGENT_URN'
GO
CREATE NONCLUSTERED INDEX [IX_SUM_VOICE_AGENT_STATE_INTERVAL_PERSON_URN]
	ON [dbo].[TB_SUM_VOICE_AGENT_STATE_INTERVAL] ([PERSON_URN])
	ON [SUMAWSGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_AGENT_STATE_INTERVAL', 'INDEX', N'IX_SUM_VOICE_AGENT_STATE_INTERVAL_PERSON_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the template table for metrics or summaries relating to capture summary state durations from the source.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_AGENT_STATE_INTERVAL', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_AGENT_STATE_INTERVAL', 'COLUMN', N'PARTITION_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column holds a value that uniquely identifies a row across all the partition tables for this partition type.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_AGENT_STATE_INTERVAL', 'COLUMN', N'PARTITION_GLOBAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number for the current partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_AGENT_STATE_INTERVAL', 'COLUMN', N'PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The date and time when the event occurred in UTC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_AGENT_STATE_INTERVAL', 'COLUMN', N'DATE_TIME_UTC'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the date of the DATE_TIME_UTC value.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_AGENT_STATE_INTERVAL', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the time of the DATE_TIME_UTC value.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_AGENT_STATE_INTERVAL', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column gives information regarding the source of the data. This corresponds to the RESOURCE_URN from TB_CLU_RESOURCE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_AGENT_STATE_INTERVAL', 'COLUMN', N'CLUSTER_RESOURCE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_AGENT.ITEM_URN and refers to the Agent to which the call leg is assigned.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_AGENT_STATE_INTERVAL', 'COLUMN', N'AGENT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_AGENT', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_AGENT_STATE_INTERVAL', 'COLUMN', N'AGENT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_PERSON.ITEM_URN and refers to the Person of the Agent.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_AGENT_STATE_INTERVAL', 'COLUMN', N'PERSON_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_PERSON', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_AGENT_STATE_INTERVAL', 'COLUMN', N'PERSON_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_QUEUE.ITEM_URN and refers to the Queue the call leg.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_AGENT_STATE_INTERVAL', 'COLUMN', N'QUEUE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_QUEUE', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_AGENT_STATE_INTERVAL', 'COLUMN', N'QUEUE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column refers to the direction of the call. This may be Inbound or Outbound.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_AGENT_STATE_INTERVAL', 'COLUMN', N'CALL_DIRECTION_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_REASON_CODE of type IT_REASON_CODE corresponding to the agent associated with the record. This is looked up or created based on ReasonCode.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_AGENT_STATE_INTERVAL', 'COLUMN', N'REASON_CODE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_REASON_CODE', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_AGENT_STATE_INTERVAL', 'COLUMN', N'REASON_CODE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the service level type used to calculate the service level.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_AGENT_STATE_INTERVAL', 'COLUMN', N'SERVICE_LEVEL_TYPE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The amount of time the agent spent in the available state during the interval i.e in online state (available to take calls).', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_AGENT_STATE_INTERVAL', 'COLUMN', N'AVAILABLE_STATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The amount of time the agent spent in the hold state during the interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_AGENT_STATE_INTERVAL', 'COLUMN', N'HOLD_STATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The amount of time the agent was logged on during the interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_AGENT_STATE_INTERVAL', 'COLUMN', N'LOGGED_ON_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The amount of time the agent spent in the ring state during the interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_AGENT_STATE_INTERVAL', 'COLUMN', N'RING_STATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The amount of time the agent spent in the talking state during the interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_AGENT_STATE_INTERVAL', 'COLUMN', N'TALK_STATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The amount of time the agent spent in the unavailable state during the interval i.e logged in but in an offline state (unavailable to take calls).', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_AGENT_STATE_INTERVAL', 'COLUMN', N'UNAVAILABLE_STATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The amount of time the agent spent in the wrap (after call work) state during the interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_AGENT_STATE_INTERVAL', 'COLUMN', N'WRAP_STATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_AGENT_STATE_INTERVAL', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM0', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_AGENT_STATE_INTERVAL', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_AGENT_STATE_INTERVAL', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM1', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_AGENT_STATE_INTERVAL', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_AGENT_STATE_INTERVAL', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM2', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_AGENT_STATE_INTERVAL', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_AGENT_STATE_INTERVAL', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM3', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_AGENT_STATE_INTERVAL', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_AGENT_STATE_INTERVAL', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM4', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_AGENT_STATE_INTERVAL', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_AGENT_STATE_INTERVAL', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM5', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_AGENT_STATE_INTERVAL', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_AGENT_STATE_INTERVAL', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM6', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_AGENT_STATE_INTERVAL', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_AGENT_STATE_INTERVAL', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM7', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_AGENT_STATE_INTERVAL', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_AGENT_STATE_INTERVAL', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM8', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_AGENT_STATE_INTERVAL', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_AGENT_STATE_INTERVAL', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM9', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_AGENT_STATE_INTERVAL', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_AGENT_STATE_INTERVAL', 'COLUMN', N'CUSTOM_MEASURE_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_AGENT_STATE_INTERVAL', 'COLUMN', N'CUSTOM_MEASURE_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_AGENT_STATE_INTERVAL', 'COLUMN', N'CUSTOM_MEASURE_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_AGENT_STATE_INTERVAL', 'COLUMN', N'CUSTOM_MEASURE_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_AGENT_STATE_INTERVAL', 'COLUMN', N'CUSTOM_MEASURE_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_AGENT_STATE_INTERVAL', 'COLUMN', N'CUSTOM_MEASURE_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_AGENT_STATE_INTERVAL', 'COLUMN', N'CUSTOM_MEASURE_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_AGENT_STATE_INTERVAL', 'COLUMN', N'CUSTOM_MEASURE_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_AGENT_STATE_INTERVAL', 'COLUMN', N'CUSTOM_MEASURE_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_VOICE_AGENT_STATE_INTERVAL', 'COLUMN', N'CUSTOM_MEASURE_9'
GO
GRANT SELECT
	ON [dbo].[TB_SUM_VOICE_AGENT_STATE_INTERVAL]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_SUM_VOICE_AGENT_STATE_INTERVAL] SET (LOCK_ESCALATION = TABLE)
GO
