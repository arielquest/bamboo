SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TB_SUM_ROUTER_QUEUE_INTERVAL] (
		[PARTITION_URN]                       [int] NOT NULL,
		[PARTITION_ID]                        [int] NOT NULL,
		[PARTITION_GLOBAL_URN]                [bigint] NOT NULL,
		[DATE_TIME]                           [datetime] NOT NULL,
		[TIME_ZONE]                           [int] NOT NULL,
		[DATE_URN]                            [int] NOT NULL,
		[TIME_URN]                            [smallint] NOT NULL,
		[DATE_UTC_URN]                        [int] NOT NULL,
		[TIME_UTC_URN]                        [smallint] NOT NULL,
		[PRECISION_QUEUE_URN]                 [int] NOT NULL,
		[BUCKET_INTERVAL_URN]                 [int] NOT NULL,
		[CLUSTER_RESOURCE_URN]                [int] NOT NULL,
		[CALLS_ABAND_DEQUEUED]                [int] NULL,
		[CALLS_ABAND_Q]                       [int] NULL,
		[CALLS_ABAND_TO_AGENT]                [int] NULL,
		[CALLS_ANSWERED]                      [int] NULL,
		[CALLS_DEQUEUED]                      [int] NULL,
		[CALLS_OFFERED]                       [int] NULL,
		[DELAY_Q_ABAND_TIME]                  [int] NULL,
		[MAX_CALLS_QUEUED]                    [int] NULL,
		[MAX_CALL_WAIT_TIME]                  [int] NULL,
		[QUEUE_CALLS]                         [int] NULL,
		[ROUTED_TO_AGENT]                     [int] NULL,
		[ROUTER_ERROR]                        [int] NULL,
		[SERVICE_LEVEL]                       [int] NULL,
		[SERVICE_LEVEL_CALLS]                 [int] NULL,
		[SERVICE_LEVEL_CALLS_ABAND]           [int] NULL,
		[SERVICE_LEVEL_CALLS_DEQUEUE]         [int] NULL,
		[SERVICE_LEVEL_CALLS_OFFERED]         [int] NULL,
		[SERVICE_LEVEL_ERROR]                 [int] NULL,
		[SERVICE_LEVEL_RONA]                  [int] NULL,
		[ABAND_INTERVAL_1]                    [int] NULL,
		[ABAND_INTERVAL_2]                    [int] NULL,
		[ABAND_INTERVAL_3]                    [int] NULL,
		[ABAND_INTERVAL_4]                    [int] NULL,
		[ABAND_INTERVAL_5]                    [int] NULL,
		[ABAND_INTERVAL_6]                    [int] NULL,
		[ABAND_INTERVAL_7]                    [int] NULL,
		[ABAND_INTERVAL_8]                    [int] NULL,
		[ABAND_INTERVAL_9]                    [int] NULL,
		[ABAND_INTERVAL_10]                   [int] NULL,
		[ANS_INTERVAL_1]                      [int] NULL,
		[ANS_INTERVAL_2]                      [int] NULL,
		[ANS_INTERVAL_3]                      [int] NULL,
		[ANS_INTERVAL_4]                      [int] NULL,
		[ANS_INTERVAL_5]                      [int] NULL,
		[ANS_INTERVAL_6]                      [int] NULL,
		[ANS_INTERVAL_7]                      [int] NULL,
		[ANS_INTERVAL_8]                      [int] NULL,
		[ANS_INTERVAL_9]                      [int] NULL,
		[ANS_INTERVAL_10]                     [int] NULL,
		[PRECISION_ATTRIBUTE_URN_1]           [int] NULL,
		[PRECISION_ATTRIBUTE_URN_2]           [int] NULL,
		[PRECISION_ATTRIBUTE_URN_3]           [int] NULL,
		[PRECISION_ATTRIBUTE_URN_4]           [int] NULL,
		[PRECISION_ATTRIBUTE_URN_5]           [int] NULL,
		[PRECISION_ATTRIBUTE_URN_6]           [int] NULL,
		[PRECISION_ATTRIBUTE_URN_7]           [int] NULL,
		[PRECISION_ATTRIBUTE_URN_8]           [int] NULL,
		[PRECISION_ATTRIBUTE_URN_9]           [int] NULL,
		[PRECISION_ATTRIBUTE_URN_10]          [int] NULL,
		[ABAND_PRECISION_QUEUE_STEP_1]        [int] NULL,
		[ABAND_PRECISION_QUEUE_STEP_2]        [int] NULL,
		[ABAND_PRECISION_QUEUE_STEP_3]        [int] NULL,
		[ABAND_PRECISION_QUEUE_STEP_4]        [int] NULL,
		[ABAND_PRECISION_QUEUE_STEP_5]        [int] NULL,
		[ABAND_PRECISION_QUEUE_STEP_6]        [int] NULL,
		[ABAND_PRECISION_QUEUE_STEP_7]        [int] NULL,
		[ABAND_PRECISION_QUEUE_STEP_8]        [int] NULL,
		[ABAND_PRECISION_QUEUE_STEP_9]        [int] NULL,
		[ABAND_PRECISION_QUEUE_STEP_10]       [int] NULL,
		[ANS_PRECISION_QUEUE_STEP_1]          [int] NULL,
		[ANS_PRECISION_QUEUE_STEP_2]          [int] NULL,
		[ANS_PRECISION_QUEUE_STEP_3]          [int] NULL,
		[ANS_PRECISION_QUEUE_STEP_4]          [int] NULL,
		[ANS_PRECISION_QUEUE_STEP_5]          [int] NULL,
		[ANS_PRECISION_QUEUE_STEP_6]          [int] NULL,
		[ANS_PRECISION_QUEUE_STEP_7]          [int] NULL,
		[ANS_PRECISION_QUEUE_STEP_8]          [int] NULL,
		[ANS_PRECISION_QUEUE_STEP_9]          [int] NULL,
		[ANS_PRECISION_QUEUE_STEP_10]         [int] NULL,
		[OFFERED_PRECISION_QUEUE_STEP_1]      [int] NULL,
		[OFFERED_PRECISION_QUEUE_STEP_2]      [int] NULL,
		[OFFERED_PRECISION_QUEUE_STEP_3]      [int] NULL,
		[OFFERED_PRECISION_QUEUE_STEP_4]      [int] NULL,
		[OFFERED_PRECISION_QUEUE_STEP_5]      [int] NULL,
		[OFFERED_PRECISION_QUEUE_STEP_6]      [int] NULL,
		[OFFERED_PRECISION_QUEUE_STEP_7]      [int] NULL,
		[OFFERED_PRECISION_QUEUE_STEP_8]      [int] NULL,
		[OFFERED_PRECISION_QUEUE_STEP_9]      [int] NULL,
		[OFFERED_PRECISION_QUEUE_STEP_10]     [int] NULL,
		[SKIP_PRECISION_QUEUE_STEP_1]         [int] NULL,
		[SKIP_PRECISION_QUEUE_STEP_2]         [int] NULL,
		[SKIP_PRECISION_QUEUE_STEP_3]         [int] NULL,
		[SKIP_PRECISION_QUEUE_STEP_4]         [int] NULL,
		[SKIP_PRECISION_QUEUE_STEP_5]         [int] NULL,
		[SKIP_PRECISION_QUEUE_STEP_6]         [int] NULL,
		[SKIP_PRECISION_QUEUE_STEP_7]         [int] NULL,
		[SKIP_PRECISION_QUEUE_STEP_8]         [int] NULL,
		[SKIP_PRECISION_QUEUE_STEP_9]         [int] NULL,
		[SKIP_PRECISION_QUEUE_STEP_10]        [int] NULL,
		[REPORTING_HALF_HOUR]                 [int] NULL,
		[REPORTING_INTERVAL]                  [int] NULL,
		[RECOVERY_KEY]                        [float] NULL,
		[DB_DATETIME]                         [datetime] NULL,
		[MEDIA_CLASS_URN]                     [int] NOT NULL,
		[MEDIA_ROUTING_DOMAIN_URN]            [int] NOT NULL
) ON [SUMICMGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the template table for the historical summary statistics for precision queues. This table is created at install time and the partitioning service creates various partition tables with the same schema. These partition tables are prefixed as TB_SUM_ROUTER_QUEUE_INTERVAL_ followed by the partition identifier. The partition identifier is created depending on the partition configuration, for example monthly, weekly etc. All currently active partitions are included VW_PARTITONED_SUM_CALL_TYPE_SKILLGROUP_INTERVAL view. Since the partitioned tables are generated at runtime and that they have the same schema no separate documentations are required for each partition table. In case of Cisco ICM/IPCC the data in these partitioned tables is imported from t_Call_Type_SG_Interval table for version 8.0 or higher.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'PARTITION_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number for the current partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column holds a value that uniquely identifies a row across all the partition tables for this partition type.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'PARTITION_GLOBAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the datetime stamp associated with the record. This corresponds to the start of the reporting interval. This maps to the DateTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the offset in minutes from UTC for the date and time. This maps to the TimeZone column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'TIME_ZONE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the date associated with the record. This is calculated by the data importer based on the source date time corresponding to the start of the reporting interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'DATE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DATE', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'DATE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the time associated with the record. This is calculated by the data importer based on the source date time corresponding to the start of the reporting interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'TIME_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIME', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'TIME_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the UTC date associated with the record. This is calculated by the data importer based on the source date time corresponding to the start of the reporting interval and the TimeZone information from the source data.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DATE', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the UTC time associated with the record. This is calculated by the data importer based on the source date time corresponding to the start of the reporting interval and the TimeZone information from the source data.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIME', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the ITEM_URN from TB_DIM_PRECISION_QUEUE. This corresponds to the precision queue associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'PRECISION_QUEUE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the ITEM_URN from TB_DIM_BUCKET_INTERVAL. This corresponds to the bucket interval associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'BUCKET_INTERVAL_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_BUCKET_INTERVAL', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'BUCKET_INTERVAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column gives information regarding the source of the data. This corresponds to the RESOURCE_URN from TB_CLU_RESOURCE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'CLUSTER_RESOURCE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total calls that were abandoned while being dequeued to the precision queue in the reporting interval. This maps to CallsAbandDequeued in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'CALLS_ABAND_DEQUEUED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total calls that were abandoned while being queued to the precision queue in the reporting interval. This maps to CallsAbandQ in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'CALLS_ABAND_Q'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total calls that were abandoned to the agent for the precision queue in the reporting interval. This maps to CallsAbandToAgent in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'CALLS_ABAND_TO_AGENT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total calls that were answered for the precision queue in the reporting interval. This maps to CallsAnswered in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'CALLS_ANSWERED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total calls that were dequeued for the precision queue in the reporting interval. This maps to CallsDequeued in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'CALLS_DEQUEUED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total calls that were offered for the precision queue in the reporting interval. This maps to CallsOffered in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'CALLS_OFFERED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total delay queue abandoned time, in seconds, for the precision queue in the reporting interval. This maps to DelayQAbandTime in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'DELAY_Q_ABAND_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the maximum calls that were queued for the precision queue in the reporting interval. This maps to MaxCallsQueued in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'MAX_CALLS_QUEUED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the maximum call wait time, in seconds, for the precision queue in the reporting interval. This maps to MaxCallWaitTime in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'MAX_CALL_WAIT_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total calls that were queued for the precision queue in the reporting interval. This maps to QueueCalls in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'QUEUE_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total calls that were routed to agent for the precision queue in the reporting interval. This maps to RoutedToAgent in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'ROUTED_TO_AGENT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total calls that experienced an error at the router for the precision queue in the reporting interval. This maps to RouterError in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'ROUTER_ERROR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the service level for the precision queue in the reporting interval. This maps to ServiceLevel in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'SERVICE_LEVEL'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that were answered within the service level threshold for the precision queue during the reporting interval. This maps to ServiceLevelCalls in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'SERVICE_LEVEL_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that were abandoned within the service level threshold for the precision queue during the reporting interval. This maps to ServiceLevelCallsAband in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'SERVICE_LEVEL_CALLS_ABAND'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of queued calls that were de-queued within the service level threshold for the precision queue during the reporting interval. This maps to ServiceLevelCallsDequeue in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'SERVICE_LEVEL_CALLS_DEQUEUE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that had service level events for the precision queue during the reporting interval. This maps to ServiceLevelCallsOffered in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'SERVICE_LEVEL_CALLS_OFFERED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that ended in an error state within the service level threshold for the precision queue during the reporting interval. This maps to ServiceLevelError in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'SERVICE_LEVEL_ERROR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that were redirected on no answer within the service level threshold for the precision queue during the reporting interval. This maps to ServiceLevelRONA in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'SERVICE_LEVEL_RONA'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to AbandInterval1 column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'ABAND_INTERVAL_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to AbandInterval2 column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'ABAND_INTERVAL_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to AbandInterval3 column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'ABAND_INTERVAL_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to AbandInterval4 column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'ABAND_INTERVAL_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to AbandInterval5 column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'ABAND_INTERVAL_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to AbandInterval6 column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'ABAND_INTERVAL_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to AbandInterval7 column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'ABAND_INTERVAL_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to AbandInterval8 column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'ABAND_INTERVAL_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to AbandInterval9 column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'ABAND_INTERVAL_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to AbandInterval10 column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'ABAND_INTERVAL_10'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to AnsInterval1 column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'ANS_INTERVAL_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to AnsInterval2 column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'ANS_INTERVAL_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to AnsInterval3 column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'ANS_INTERVAL_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to AnsInterval4 column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'ANS_INTERVAL_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to AnsInterval5 column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'ANS_INTERVAL_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to AnsInterval6 column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'ANS_INTERVAL_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to AnsInterval7 column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'ANS_INTERVAL_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to AnsInterval8 column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'ANS_INTERVAL_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to AnsInterval9 column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'ANS_INTERVAL_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to AnsInterval10 column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'ANS_INTERVAL_10'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the ITEM_URN from TB_DIM_PRECISION_ATTRIBUTE. This corresponds to the first of the possible ten precision attributes associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'PRECISION_ATTRIBUTE_URN_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the ITEM_URN from TB_DIM_PRECISION_ATTRIBUTE. This corresponds to the second of the possible ten precision attributes associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'PRECISION_ATTRIBUTE_URN_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the ITEM_URN from TB_DIM_PRECISION_ATTRIBUTE. This corresponds to the third of the possible ten precision attributes associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'PRECISION_ATTRIBUTE_URN_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the ITEM_URN from TB_DIM_PRECISION_ATTRIBUTE. This corresponds to the fourth of the possible ten precision attributes associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'PRECISION_ATTRIBUTE_URN_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the ITEM_URN from TB_DIM_PRECISION_ATTRIBUTE. This corresponds to the fifth of the possible ten precision attributes associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'PRECISION_ATTRIBUTE_URN_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the ITEM_URN from TB_DIM_PRECISION_ATTRIBUTE. This corresponds to the sixth of the possible ten precision attributes associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'PRECISION_ATTRIBUTE_URN_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the ITEM_URN from TB_DIM_PRECISION_ATTRIBUTE. This corresponds to the seventh of the possible ten precision attributes associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'PRECISION_ATTRIBUTE_URN_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the ITEM_URN from TB_DIM_PRECISION_ATTRIBUTE. This corresponds to the eighth of the possible ten precision attributes associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'PRECISION_ATTRIBUTE_URN_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the ITEM_URN from TB_DIM_PRECISION_ATTRIBUTE. This corresponds to the ninth of the possible ten precision attributes associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'PRECISION_ATTRIBUTE_URN_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the ITEM_URN from TB_DIM_PRECISION_ATTRIBUTE. This corresponds to the tenth of the possible ten precision attributes associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'PRECISION_ATTRIBUTE_URN_10'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total calls that were abandoned in step 1 of the Precision Queue. This maps to AbandStep1 in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'ABAND_PRECISION_QUEUE_STEP_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total calls that were abandoned in step 2 of the Precision Queue. This maps to AbandStep2 in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'ABAND_PRECISION_QUEUE_STEP_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total calls that were abandoned in step 3 of the Precision Queue. This maps to AbandStep3 in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'ABAND_PRECISION_QUEUE_STEP_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total calls that were abandoned in step 4 of the Precision Queue. This maps to AbandStep4 in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'ABAND_PRECISION_QUEUE_STEP_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total calls that were abandoned in step 5 of the Precision Queue. This maps to AbandStep5 in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'ABAND_PRECISION_QUEUE_STEP_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total calls that were abandoned in step 6 of the Precision Queue. This maps to AbandStep6 in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'ABAND_PRECISION_QUEUE_STEP_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total calls that were abandoned in step 7 of the Precision Queue. This maps to AbandStep7 in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'ABAND_PRECISION_QUEUE_STEP_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total calls that were abandoned in step 8 of the Precision Queue. This maps to AbandStep8 in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'ABAND_PRECISION_QUEUE_STEP_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total calls that were abandoned in step 9 of the Precision Queue. This maps to AbandStep9 in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'ABAND_PRECISION_QUEUE_STEP_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total calls that were abandoned in step 10 of the Precision Queue. This maps to AbandStep10 in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'ABAND_PRECISION_QUEUE_STEP_10'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total calls that were answered in step 1 of the Precision Queue. This maps to AnsStep1 in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'ANS_PRECISION_QUEUE_STEP_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total calls that were answered in step 2 of the Precision Queue. This maps to AnsStep2 in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'ANS_PRECISION_QUEUE_STEP_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total calls that were answered in step 3 of the Precision Queue. This maps to AnsStep3 in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'ANS_PRECISION_QUEUE_STEP_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total calls that were answered in step 4 of the Precision Queue. This maps to AnsStep4 in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'ANS_PRECISION_QUEUE_STEP_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total calls that were answered in step 5 of the Precision Queue. This maps to AnsStep5 in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'ANS_PRECISION_QUEUE_STEP_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total calls that were answered in step 6 of the Precision Queue. This maps to AnsStep6 in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'ANS_PRECISION_QUEUE_STEP_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total calls that were answered in step 7 of the Precision Queue. This maps to AnsStep7 in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'ANS_PRECISION_QUEUE_STEP_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total calls that were answered in step 8 of the Precision Queue. This maps to AnsStep8 in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'ANS_PRECISION_QUEUE_STEP_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total calls that were answered in step 9 of the Precision Queue. This maps to AnsStep9 in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'ANS_PRECISION_QUEUE_STEP_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total calls that were answered in step 10 of the Precision Queue. This maps to AnsStep10 in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'ANS_PRECISION_QUEUE_STEP_10'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total calls that were offered in step 1 of the Precision Queue. This maps to OfferedStep1 in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'OFFERED_PRECISION_QUEUE_STEP_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total calls that were offered in step 2 of the Precision Queue. This maps to OfferedStep2 in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'OFFERED_PRECISION_QUEUE_STEP_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total calls that were offered in step 3 of the Precision Queue. This maps to OfferedStep3 in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'OFFERED_PRECISION_QUEUE_STEP_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total calls that were offered in step 4 of the Precision Queue. This maps to OfferedStep4 in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'OFFERED_PRECISION_QUEUE_STEP_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total calls that were offered in step 5 of the Precision Queue. This maps to OfferedStep5 in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'OFFERED_PRECISION_QUEUE_STEP_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total calls that were offered in step 6 of the Precision Queue. This maps to OfferedStep6 in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'OFFERED_PRECISION_QUEUE_STEP_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total calls that were offered in step 7 of the Precision Queue. This maps to OfferedStep7 in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'OFFERED_PRECISION_QUEUE_STEP_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total calls that were offered in step 8 of the Precision Queue. This maps to OfferedStep8 in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'OFFERED_PRECISION_QUEUE_STEP_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total calls that were offered in step 9 of the Precision Queue. This maps to OfferedStep9 in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'OFFERED_PRECISION_QUEUE_STEP_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total calls that were offered in step 10 of the Precision Queue. This maps to OfferedStep10 in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'OFFERED_PRECISION_QUEUE_STEP_10'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total calls that were skipped in step 1 of the Precision Queue. This maps to SkipStep1 in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'SKIP_PRECISION_QUEUE_STEP_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total calls that were skipped in step 2 of the Precision Queue. This maps to SkipStep2 in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'SKIP_PRECISION_QUEUE_STEP_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total calls that were skipped in step 3 of the Precision Queue. This maps to SkipStep3 in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'SKIP_PRECISION_QUEUE_STEP_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total calls that were skipped in step 4 of the Precision Queue. This maps to SkipStep4 in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'SKIP_PRECISION_QUEUE_STEP_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total calls that were skipped in step 5 of the Precision Queue. This maps to SkipStep5 in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'SKIP_PRECISION_QUEUE_STEP_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total calls that were skipped in step 6 of the Precision Queue. This maps to SkipStep6 in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'SKIP_PRECISION_QUEUE_STEP_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total calls that were skipped in step 7 of the Precision Queue. This maps to SkipStep7 in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'SKIP_PRECISION_QUEUE_STEP_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total calls that were skipped in step 8 of the Precision Queue. This maps to SkipStep8 in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'SKIP_PRECISION_QUEUE_STEP_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total calls that were skipped in step 9 of the Precision Queue. This maps to SkipStep9 in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'SKIP_PRECISION_QUEUE_STEP_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total calls that were skipped in step 10 of the Precision Queue. This maps to SkipStep10 in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'SKIP_PRECISION_QUEUE_STEP_10'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to the ReportingHalfHour column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'REPORTING_HALF_HOUR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to the ReportingInterval column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'REPORTING_INTERVAL'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the surrogate key identifier for the record from the source data. The data in this column maps to RecoveryKey column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'RECOVERY_KEY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a date time stamp corresponding to when the data was written into the source database. The data in this column maps to DbDateTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'DB_DATETIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_MEDIA_CLASS. This corresponds to the media class associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'MEDIA_CLASS_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_MEDIA_CLASS', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'MEDIA_CLASS_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_MEDIA_ROUTING_DOMAIN. This corresponds to the media routing domain associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'MEDIA_ROUTING_DOMAIN_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_MEDIA_ROUTING_DOMAIN', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_ROUTER_QUEUE_INTERVAL', 'COLUMN', N'MEDIA_ROUTING_DOMAIN_URN'
GO
GRANT SELECT
	ON [dbo].[TB_SUM_ROUTER_QUEUE_INTERVAL]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_SUM_ROUTER_QUEUE_INTERVAL]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_SUM_ROUTER_QUEUE_INTERVAL]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_SUM_ROUTER_QUEUE_INTERVAL] SET (LOCK_ESCALATION = TABLE)
GO
