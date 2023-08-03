SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_FCT_REPEAT_INTERACTION_EVENT] (
		[PARTITION_URN]                      [int] NOT NULL,
		[PARTITION_ID]                       [int] NOT NULL,
		[PARTITION_GLOBAL_URN]               [bigint] NOT NULL,
		[EVENT_DATE_TIME_UTC]                [datetime] NOT NULL,
		[EVENT_DATE_URN_UTC]                 [int] NOT NULL,
		[EVENT_TIME_URN_UTC]                 [smallint] NOT NULL,
		[EVENT_TYPE]                         [tinyint] NOT NULL,
		[CHAIN_ID]                           [bigint] NOT NULL,
		[SEQUENCE]                           [int] NOT NULL,
		[IS_REPEAT]                          [bit] NOT NULL,
		[TIMEBAND_URN]                       [int] NOT NULL,
		[CONTACT_URN]                        [int] NOT NULL,
		[CHANNEL_ADDRESS_URN]                [int] NOT NULL,
		[CLUSTER_RESOURCE_URN]               [int] NOT NULL,
		[CALL_KEY1]                          [int] NOT NULL,
		[CALL_KEY2]                          [int] NOT NULL,
		[FINAL_CALL_TYPE_URN]                [int] NOT NULL,
		[FINAL_CALL_DRIVER_CATEGORY_URN]     [int] NOT NULL,
		[FINAL_AGENT_URN]                    [int] NOT NULL,
		[FINAL_SKILLGROUP_URN]               [int] NOT NULL,
		[FINAL_DISPOSITION_CODE_URN]         [int] NOT NULL,
		[FINAL_WRAPUP_CODE_URN]              [int] NOT NULL,
		[TRANSFER_COUNT]                     [tinyint] NOT NULL,
		[DURATION]                           [int] NOT NULL,
		[QUEUE_TIME]                         [int] NOT NULL,
		[DISPOSITION_CX_SCORE]               [tinyint] NOT NULL,
		[TRANSFER_COUNT_CX_SCORE]            [tinyint] NOT NULL,
		[DURATION_CX_SCORE]                  [tinyint] NOT NULL,
		[QUEUE_TIME_CX_SCORE]                [tinyint] NOT NULL,
		[WRAPUP_CODE_CX_SCORE]               [tinyint] NOT NULL,
		[OVERALL_CX_SCORE]                   [tinyint] NOT NULL,
		[FINAL_AGENT_TEAM_URN]               [int] NOT NULL,
		[FINAL_PRECISION_QUEUE_URN]          [int] NOT NULL,
		[CUSTOM_DIMENSION_0]                 [int] NOT NULL,
		[CUSTOM_DIMENSION_1]                 [int] NOT NULL,
		[CUSTOM_DIMENSION_2]                 [int] NOT NULL,
		[CUSTOM_DIMENSION_3]                 [int] NOT NULL,
		[CUSTOM_DIMENSION_4]                 [int] NOT NULL,
		[CUSTOM_DIMENSION_5]                 [int] NOT NULL,
		[CUSTOM_DIMENSION_6]                 [int] NOT NULL,
		[CUSTOM_DIMENSION_7]                 [int] NOT NULL,
		[CUSTOM_DIMENSION_8]                 [int] NOT NULL,
		[CUSTOM_DIMENSION_9]                 [int] NOT NULL,
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
		[ORIGINAL_CONTACT_ID]                [nvarchar](256) COLLATE Latin1_General_CI_AS NOT NULL,
		[CONTACT_ID]                         [nvarchar](256) COLLATE Latin1_General_CI_AS NOT NULL,
		[FINAL_QUEUE_URN]                    [int] NOT NULL
) ON [FCTICMGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_FCT_REPEAT_INTERACTION_EVENT_CHAIN_ID_SEQUENCE]
	ON [dbo].[TB_FCT_REPEAT_INTERACTION_EVENT] ([CHAIN_ID], [SEQUENCE])
	INCLUDE ([IS_REPEAT], [TIMEBAND_URN])
	ON [FCTICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_REPEAT_INTERACTION_EVENT', 'INDEX', N'IX_TB_FCT_REPEAT_INTERACTION_EVENT_CHAIN_ID_SEQUENCE'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_REPEAT_INTERACTION_EVENT_FINAL_CALL_TYPE_URN]
	ON [dbo].[TB_FCT_REPEAT_INTERACTION_EVENT] ([FINAL_CALL_TYPE_URN])
	ON [FCTICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_REPEAT_INTERACTION_EVENT', 'INDEX', N'IX_FCT_REPEAT_INTERACTION_EVENT_FINAL_CALL_TYPE_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_REPEAT_INTERACTION_EVENT_FINAL_AGENT_URN]
	ON [dbo].[TB_FCT_REPEAT_INTERACTION_EVENT] ([FINAL_AGENT_URN])
	ON [FCTICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_REPEAT_INTERACTION_EVENT', 'INDEX', N'IX_FCT_REPEAT_INTERACTION_EVENT_FINAL_AGENT_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_REPEAT_INTERACTION_EVENT_FINAL_SKILLGROUP_URN]
	ON [dbo].[TB_FCT_REPEAT_INTERACTION_EVENT] ([FINAL_SKILLGROUP_URN])
	ON [FCTICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_REPEAT_INTERACTION_EVENT', 'INDEX', N'IX_FCT_REPEAT_INTERACTION_EVENT_FINAL_SKILLGROUP_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table contains event data defining all repeat and non-repeat (First Call Resolution or Abandon) interactions (voice, email, chat etc) in the system', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_REPEAT_INTERACTION_EVENT', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary Key Identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_REPEAT_INTERACTION_EVENT', 'COLUMN', N'PARTITION_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number for the current partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_REPEAT_INTERACTION_EVENT', 'COLUMN', N'PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column holds a value that uniquely identifies a row across all the partition tables for this partition type.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_REPEAT_INTERACTION_EVENT', 'COLUMN', N'PARTITION_GLOBAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'UTC Date Time containing the start time for the  which triggered this event.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_REPEAT_INTERACTION_EVENT', 'COLUMN', N'EVENT_DATE_TIME_UTC'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key to TB_DIM_DATE. Contains the Date URN for the start datetime of the interaction which triggered this event.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_REPEAT_INTERACTION_EVENT', 'COLUMN', N'EVENT_DATE_URN_UTC'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DATE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_REPEAT_INTERACTION_EVENT', 'COLUMN', N'EVENT_DATE_URN_UTC'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key to TB_DIM_TIME. Contains the Time URN for the start datetime of the interaction which triggered this event.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_REPEAT_INTERACTION_EVENT', 'COLUMN', N'EVENT_TIME_URN_UTC'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIME', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_REPEAT_INTERACTION_EVENT', 'COLUMN', N'EVENT_TIME_URN_UTC'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Integer defining the type of event. 1 = Channel Address (ANI) Based, 2 = Contact (Customer) Based, 3 = Channel Address (ANI) and Call Type Based, 4 = Contact (Customer) and Call Type Based, 5 = Channel Address (ANI) and Call Driver (Category), 6 = Contact (Customer) and Call Driver (Category).', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_REPEAT_INTERACTION_EVENT', 'COLUMN', N'EVENT_TYPE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Unique number that maps together a set of repeat events linked to the same key.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_REPEAT_INTERACTION_EVENT', 'COLUMN', N'CHAIN_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'0 based sequence that indicates which number repeat or non-repeat event the record defines. For repeat calls the 0 indexed record defines the trigger call for the event chain, i.e. sequence 1 is the first actual repeat call.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_REPEAT_INTERACTION_EVENT', 'COLUMN', N'SEQUENCE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key to TB_DIM_TIMEBAND. Defines the granularity of the event.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_REPEAT_INTERACTION_EVENT', 'COLUMN', N'IS_REPEAT'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIMEBAND', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_REPEAT_INTERACTION_EVENT', 'COLUMN', N'TIMEBAND_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key to TB_DIM_CONTACT. This contains the ID of the contact that made the interaction.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_REPEAT_INTERACTION_EVENT', 'COLUMN', N'CONTACT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key to TB_DIM_CHANNEL_ADDRESS. This contains the ID of the channel address (Currently just ANI) from which the interaction originated.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_REPEAT_INTERACTION_EVENT', 'COLUMN', N'CHANNEL_ADDRESS_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column gives information regarding the source of the data. This corresponds to the RESOURCE_URN from TB_CLU_RESOURCE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_REPEAT_INTERACTION_EVENT', 'COLUMN', N'CLUSTER_RESOURCE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The TCD Router Call Key Day for the interaction that generated this event.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_REPEAT_INTERACTION_EVENT', 'COLUMN', N'CALL_KEY1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The TCD Router Call Key for the interaction that generated this event.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_REPEAT_INTERACTION_EVENT', 'COLUMN', N'CALL_KEY2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key to TB_DIM_CALL_TYPE. Contains the final call type for the interaction that generated this event.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_REPEAT_INTERACTION_EVENT', 'COLUMN', N'FINAL_CALL_TYPE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CALL_TYPE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_REPEAT_INTERACTION_EVENT', 'COLUMN', N'FINAL_CALL_TYPE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key to TB_DIM_CATEGORY. Contains the final call driver category for the interaction that generated this event.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_REPEAT_INTERACTION_EVENT', 'COLUMN', N'FINAL_CALL_DRIVER_CATEGORY_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CATEGORY', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_REPEAT_INTERACTION_EVENT', 'COLUMN', N'FINAL_CALL_DRIVER_CATEGORY_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key to TB_DIM_AGENT. Contains the final agent for the interaction that generated this event.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_REPEAT_INTERACTION_EVENT', 'COLUMN', N'FINAL_AGENT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_AGENT', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_REPEAT_INTERACTION_EVENT', 'COLUMN', N'FINAL_AGENT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key to TB_DIM_SKILLGROUP. Contains the final skillgroup for the interaction that generated this event.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_REPEAT_INTERACTION_EVENT', 'COLUMN', N'FINAL_SKILLGROUP_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_SKILLGROUP', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_REPEAT_INTERACTION_EVENT', 'COLUMN', N'FINAL_SKILLGROUP_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key to TB_DIM_CODE. Contains the disposition code for the interaction that generated this event.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_REPEAT_INTERACTION_EVENT', 'COLUMN', N'FINAL_DISPOSITION_CODE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CODE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_REPEAT_INTERACTION_EVENT', 'COLUMN', N'FINAL_DISPOSITION_CODE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key to TB_DIM_WRAPUP_CODE. Contains the wrap code for the interaction that generated this event.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_REPEAT_INTERACTION_EVENT', 'COLUMN', N'FINAL_WRAPUP_CODE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_WRAPUP_CODE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_REPEAT_INTERACTION_EVENT', 'COLUMN', N'FINAL_WRAPUP_CODE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Total number of transfers within the interaction that generated this event.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_REPEAT_INTERACTION_EVENT', 'COLUMN', N'TRANSFER_COUNT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Total duration of the interaction from the contacts perspective. ', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_REPEAT_INTERACTION_EVENT', 'COLUMN', N'DURATION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Total time spent in queue during the call (seconds).', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_REPEAT_INTERACTION_EVENT', 'COLUMN', N'QUEUE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'A customer experience score from 0-10 that indicates the component of customer experience derived from the interaction disposition.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_REPEAT_INTERACTION_EVENT', 'COLUMN', N'DISPOSITION_CX_SCORE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'A customer experience score from 0-10 that indicates the component of customer experience derived from the interaction disposition.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_REPEAT_INTERACTION_EVENT', 'COLUMN', N'TRANSFER_COUNT_CX_SCORE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'A customer experience score from 0-10 that indicates the component of customer experience derived from the duration.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_REPEAT_INTERACTION_EVENT', 'COLUMN', N'DURATION_CX_SCORE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'A customer experience score from 0-10 that indicates the component of customer experience derived from the queue time.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_REPEAT_INTERACTION_EVENT', 'COLUMN', N'QUEUE_TIME_CX_SCORE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'A customer experience score from 0-10 that indicates the component of customer experience derived from the wrap code.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_REPEAT_INTERACTION_EVENT', 'COLUMN', N'WRAPUP_CODE_CX_SCORE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'A customer experience score from 0-10 that indicates the overall score for the call.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_REPEAT_INTERACTION_EVENT', 'COLUMN', N'OVERALL_CX_SCORE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key to TB_DIM_AGENT_TEAM. Contains the final agent team for the interaction that generated this event. Calculated based on FINAL_AGENT_URN.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_REPEAT_INTERACTION_EVENT', 'COLUMN', N'FINAL_AGENT_TEAM_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key to TB_DIM_PRECISION_QUEUE. Contains the final precision queue for the interaction that generated this event. This is the precision queue associated with the FINAL_AGENT_URN.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_REPEAT_INTERACTION_EVENT', 'COLUMN', N'FINAL_PRECISION_QUEUE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_REPEAT_INTERACTION_EVENT', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM0', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_REPEAT_INTERACTION_EVENT', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_REPEAT_INTERACTION_EVENT', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM1', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_REPEAT_INTERACTION_EVENT', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_REPEAT_INTERACTION_EVENT', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM2', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_REPEAT_INTERACTION_EVENT', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_REPEAT_INTERACTION_EVENT', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM3', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_REPEAT_INTERACTION_EVENT', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_REPEAT_INTERACTION_EVENT', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM4', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_REPEAT_INTERACTION_EVENT', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_REPEAT_INTERACTION_EVENT', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM5', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_REPEAT_INTERACTION_EVENT', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_REPEAT_INTERACTION_EVENT', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM6', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_REPEAT_INTERACTION_EVENT', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_REPEAT_INTERACTION_EVENT', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM7', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_REPEAT_INTERACTION_EVENT', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_REPEAT_INTERACTION_EVENT', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM8', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_REPEAT_INTERACTION_EVENT', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_REPEAT_INTERACTION_EVENT', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM9', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_REPEAT_INTERACTION_EVENT', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_REPEAT_INTERACTION_EVENT', 'COLUMN', N'CUSTOM_MEASURE_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_REPEAT_INTERACTION_EVENT', 'COLUMN', N'CUSTOM_MEASURE_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_REPEAT_INTERACTION_EVENT', 'COLUMN', N'CUSTOM_MEASURE_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_REPEAT_INTERACTION_EVENT', 'COLUMN', N'CUSTOM_MEASURE_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_REPEAT_INTERACTION_EVENT', 'COLUMN', N'CUSTOM_MEASURE_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_REPEAT_INTERACTION_EVENT', 'COLUMN', N'CUSTOM_MEASURE_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_REPEAT_INTERACTION_EVENT', 'COLUMN', N'CUSTOM_MEASURE_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_REPEAT_INTERACTION_EVENT', 'COLUMN', N'CUSTOM_MEASURE_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_REPEAT_INTERACTION_EVENT', 'COLUMN', N'CUSTOM_MEASURE_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_REPEAT_INTERACTION_EVENT', 'COLUMN', N'CUSTOM_MEASURE_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the unique key for the entire contact, this key persists across call legs.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_REPEAT_INTERACTION_EVENT', 'COLUMN', N'ORIGINAL_CONTACT_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the unique key for the current call leg for which this event has been generated.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_REPEAT_INTERACTION_EVENT', 'COLUMN', N'CONTACT_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key to TB_DIM_QUEUE. Contains the final queue for the interaction that generated this event.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_REPEAT_INTERACTION_EVENT', 'COLUMN', N'FINAL_QUEUE_URN'
GO
GRANT SELECT
	ON [dbo].[TB_FCT_REPEAT_INTERACTION_EVENT]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_FCT_REPEAT_INTERACTION_EVENT]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_FCT_REPEAT_INTERACTION_EVENT]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_FCT_REPEAT_INTERACTION_EVENT] SET (LOCK_ESCALATION = TABLE)
GO
