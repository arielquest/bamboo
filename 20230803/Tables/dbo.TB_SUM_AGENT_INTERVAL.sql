SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TB_SUM_AGENT_INTERVAL] (
		[SUMMARIZED_URN]                   [int] NOT NULL,
		[DATE_URN]                         [int] NOT NULL,
		[TIME_URN]                         [smallint] NOT NULL,
		[DATE_UTC_URN]                     [int] NOT NULL,
		[TIME_UTC_URN]                     [smallint] NOT NULL,
		[AGENT_URN]                        [int] NOT NULL,
		[AGENT_TEAM_URN]                   [int] NOT NULL,
		[PERIPHERAL_URN]                   [int] NOT NULL,
		[LOGGED_ON_TIME]                   [int] NULL,
		[AVAIL_TIME]                       [int] NULL,
		[NOT_READY_TIME]                   [int] NULL,
		[TALK_OTHER_TIME]                  [int] NULL,
		[PARTITION_ID]                     [int] NOT NULL,
		[RECOVERY_KEY]                     [float] NULL,
		[PERSON_URN]                       [int] NULL,
		[DB_DATETIME]                      [datetime] NULL,
		[MEDIA_ROUTING_DOMAIN_URN]         [int] NULL,
		[AVAILABLE_IN_MRD_TIME]            [int] NULL,
		[ROUTABLE_IN_MRD_TIME]             [int] NULL,
		[ROUTER_CALLS_ABAND_Q]             [int] NULL,
		[ROUTER_CALLS_ABAND]               [int] NULL,
		[ROUTER_CALLS_ANSWERED]            [int] NULL,
		[ROUTER_CALLS_DEQUEUED]            [int] NULL,
		[ROUTER_CALLS_HANDLED]             [int] NULL,
		[ROUTER_CALLS_OFFERED]             [int] NULL,
		[ROUTER_CALLS_REDIRECTED]          [int] NULL,
		[ROUTER_ERROR]                     [int] NULL,
		[ROUTER_Q_CALLS]                   [int] NULL,
		[DATE_TIME]                        [datetime] NOT NULL,
		[NON_ACD_LINE_CALLS_IN_COUNT]      [int] NULL,
		[NON_ACD_LINE_CALLS_OUT_COUNT]     [int] NULL,
		[NON_ACD_LINE_CALLS_IN_TIME]       [int] NULL,
		[NON_ACD_LINE_CALLS_OUT_TIME]      [int] NULL,
		[REPORTING_HALF_HOUR]              [int] NULL,
		[REPORTING_INTERVAL]               [int] NULL,
		[TIME_ZONE]                        [int] NULL,
		[SUPERVISOR_AGENT_URN]             [int] NOT NULL,
		[CLUSTER_RESOURCE_URN]             [int] NOT NULL
) ON [SUMICMGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_SUM_AGENT_INTERVAL_AGENT_URN]
	ON [dbo].[TB_SUM_AGENT_INTERVAL] ([AGENT_URN])
	ON [SUMICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_INTERVAL', 'INDEX', N'IX_SUM_AGENT_INTERVAL_AGENT_URN'
GO
CREATE NONCLUSTERED INDEX [IX_SUM_AGENT_INTERVAL_DATE_TIME]
	ON [dbo].[TB_SUM_AGENT_INTERVAL] ([DATE_TIME])
	ON [SUMICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_INTERVAL', 'INDEX', N'IX_SUM_AGENT_INTERVAL_DATE_TIME'
GO
CREATE NONCLUSTERED INDEX [IX_SUM_AGENT_INTERVAL_DATE_URN]
	ON [dbo].[TB_SUM_AGENT_INTERVAL] ([DATE_URN])
	ON [SUMICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_INTERVAL', 'INDEX', N'IX_SUM_AGENT_INTERVAL_DATE_URN'
GO
CREATE NONCLUSTERED INDEX [IX_SUM_AGENT_INTERVAL_AGENT_TEAM_URN]
	ON [dbo].[TB_SUM_AGENT_INTERVAL] ([AGENT_TEAM_URN])
	ON [SUMICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_INTERVAL', 'INDEX', N'IX_SUM_AGENT_INTERVAL_AGENT_TEAM_URN'
GO
CREATE NONCLUSTERED INDEX [IX_SUM_AGENT_INTERVAL_PERIPHERAL_URN]
	ON [dbo].[TB_SUM_AGENT_INTERVAL] ([PERIPHERAL_URN])
	ON [SUMICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_INTERVAL', 'INDEX', N'IX_SUM_AGENT_INTERVAL_PERIPHERAL_URN'
GO
CREATE NONCLUSTERED INDEX [IX_SUM_AGENT_INTERVAL_PERSON_URN]
	ON [dbo].[TB_SUM_AGENT_INTERVAL] ([PERSON_URN])
	ON [SUMICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_INTERVAL', 'INDEX', N'IX_SUM_AGENT_INTERVAL_PERSON_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the template table for the historical summary statistics of an agent''s activities. This table is created at install time and the partitioning service creates various partition tables with the same schema. These partition tables are prefixed as TB_SUM_AGENT_INTERVAL_ followed by the partition identifier. The partition identifier is created depending on the partition configuration, for example monthly, weekly etc. All currently active partitions are included VW_PARTITONED_SUM_AGENT_INTERVAL view. Since the partitioned tables are generated at runtime and that they have the same schema no separate documentations are required for each partition table. In case of Cisco ICM/IPCC the data in these partitioned tables is imported from t_Agent_Half_Hour table or t_Agent_Interval table for version 8.0 or higher.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_INTERVAL', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_INTERVAL', 'COLUMN', N'SUMMARIZED_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the date associated with the record. This is calculated by the data importer based on the source date time corresponding to the start of the reporting interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_INTERVAL', 'COLUMN', N'DATE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DATE', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_INTERVAL', 'COLUMN', N'DATE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the time associated with the record. This is calculated by the data importer based on the source date time corresponding to the start of the reporting interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_INTERVAL', 'COLUMN', N'TIME_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIME', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_INTERVAL', 'COLUMN', N'TIME_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the UTC date associated with the record. This is calculated by the data importer based on the source date time corresponding to the start of the reporting interval and the TimeZone information from the source data.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_INTERVAL', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DATE', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_INTERVAL', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the UTC time associated with the record. This is calculated by the data importer based on the source date time corresponding to the start of the reporting interval and the TimeZone information from the source data.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_INTERVAL', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIME', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_INTERVAL', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_AGENT corresponding to an item of type IT_AGENT. This corresponds to the agent associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_INTERVAL', 'COLUMN', N'AGENT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_AGENT', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_INTERVAL', 'COLUMN', N'AGENT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_AGENT_TEAM corresponding to an item of type IT_AGENT_TEAM. This corresponds to the first agent team, which the agent belonged to at the time when the record was written into the database.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_INTERVAL', 'COLUMN', N'AGENT_TEAM_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_AGENT_TEAM', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_INTERVAL', 'COLUMN', N'AGENT_TEAM_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_PERIPHERAL corresponding to an item of type IT_PERIPHERAL. This corresponds to the peripheral associated with the agent in the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_INTERVAL', 'COLUMN', N'PERIPHERAL_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_PERIPHERAL', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_INTERVAL', 'COLUMN', N'PERIPHERAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time in seconds, the agent was logged into the media routing domain during the reporting interval. The data in this column maps to LoggedOnTimeToHalf or LoggedOnTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_INTERVAL', 'COLUMN', N'LOGGED_ON_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time in seconds, the agent was in NOT ACTIVE state during the reporting interval. The data in this column maps to AvailTimeToHalf or AvailTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_INTERVAL', 'COLUMN', N'AVAIL_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time in seconds, the agent was in NOT READY state during the reporting interval. The data in this column maps to NotReadyTimeToHalf or NotReadyTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_INTERVAL', 'COLUMN', N'NOT_READY_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time in seconds, the agent spent talking on internal calls. The data in this column maps to TalkOtherTimeToHalf or TalkOtherTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_INTERVAL', 'COLUMN', N'TALK_OTHER_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number for the current partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_INTERVAL', 'COLUMN', N'PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the surrogate key identifier for the record from the source data. The data in this column maps to RecoveryKey column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_INTERVAL', 'COLUMN', N'RECOVERY_KEY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_PERSON corresponding to an item of type IT_PERSON. This corresponds to the person associated with the agent in the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_INTERVAL', 'COLUMN', N'PERSON_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_PERSON', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_INTERVAL', 'COLUMN', N'PERSON_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a date time stamp corresponding to when the data was written into the source database. The data in this column maps to DbDateTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_INTERVAL', 'COLUMN', N'DB_DATETIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_MEDIA_ROUTING_DOMAIN corresponding to an item of type IT_MEDIA_ROUTING_DOMAIN. This corresponds to the media routing domain associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_INTERVAL', 'COLUMN', N'MEDIA_ROUTING_DOMAIN_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_MEDIA_ROUTING_DOMAIN', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_INTERVAL', 'COLUMN', N'MEDIA_ROUTING_DOMAIN_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of seconds, the agent was available with respect to the media routing domain in the reporting interval. The data in this column maps to AvailableInMRDTimeToHalf or AvailableInMRDTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_INTERVAL', 'COLUMN', N'AVAILABLE_IN_MRD_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of seconds, the agent was routable with respect to the media routing domain in the reporting interval. The data in this column maps to RoutableInMRDTimeToHalf or RoutableInMRDTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_INTERVAL', 'COLUMN', N'ROUTABLE_IN_MRD_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls queued to the agent that were abandoned in the reporting interval. The data in this column maps to RouterCallsAbandQToHalf or RouterCallsAbandQ column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_INTERVAL', 'COLUMN', N'ROUTER_CALLS_ABAND_Q'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that were abandoned after being routed to the agent in the reporting interval. The data in this column maps to RouterCallsAbandToHalf or RouterCallsAband column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_INTERVAL', 'COLUMN', N'ROUTER_CALLS_ABAND'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls answered by the agent in the reporting interval. The data in this column maps to RouterCallsAnsweredToHalf or RouterCallsAnswered column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_INTERVAL', 'COLUMN', N'ROUTER_CALLS_ANSWERED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that were dequeued from the agent to be routed to another agent in the reporting interval. The data in this column maps to RouterCallsDequeuedToHalf or RouterCallsDequeued column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_INTERVAL', 'COLUMN', N'ROUTER_CALLS_DEQUEUED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that were handled by the agent in the reporting interval. The data in this column maps to RouterCallsHandledToHalf or RouterCallsHandled column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_INTERVAL', 'COLUMN', N'ROUTER_CALLS_HANDLED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that were either routed or queued to the agent in the reporting interval. The data in this column maps to RouterCallsOfferedToHalf or RouterCallsOffered column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_INTERVAL', 'COLUMN', N'ROUTER_CALLS_OFFERED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that were redirected from the agent in the reporting interval. The data in this column maps to RouterCallsRedirectedToHalf or RouterCallsRedirected column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_INTERVAL', 'COLUMN', N'ROUTER_CALLS_REDIRECTED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that were directly routed to the agent and resulted in an error condition in the reporting interval. The data in this column maps to RouterErrorToHalf or RouterError column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_INTERVAL', 'COLUMN', N'ROUTER_ERROR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that were queued to the agent in the reporting interval. The data in this column maps to RouterQueueCallsToHalf or RouterQueueCalls column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_INTERVAL', 'COLUMN', N'ROUTER_Q_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the datetime stamp associated with the record. This corresponds to the start of the reporting interval. This maps to the DateTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_INTERVAL', 'COLUMN', N'DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of non-ACD calls answered by the agent in the reporting interval. The data maps to the NonACDLineCallsInCount column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_INTERVAL', 'COLUMN', N'NON_ACD_LINE_CALLS_IN_COUNT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of non-ACD calls initiated by the agent in the reporting interval. The data maps to the NonACDLineCallsOutCount column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_INTERVAL', 'COLUMN', N'NON_ACD_LINE_CALLS_OUT_COUNT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time for all non-ACD calls answered by the agent in the reporting interval. The data maps to NonACDLineCallsInTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_INTERVAL', 'COLUMN', N'NON_ACD_LINE_CALLS_IN_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time for all non-ACD calls initiated by the agent in ther reporting interval. The data maps to NonACDLineCallsOutTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_INTERVAL', 'COLUMN', N'NON_ACD_LINE_CALLS_OUT_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to the ReportingHalfHour column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_INTERVAL', 'COLUMN', N'REPORTING_HALF_HOUR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to the ReportingInterval column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_INTERVAL', 'COLUMN', N'REPORTING_INTERVAL'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the offset in minutes from UTC for the date and time. This maps to the TimeZone column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_INTERVAL', 'COLUMN', N'TIME_ZONE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_AGENT corresponding to an item of type IT_AGENT. This corresponds to the supervisor agent of the team where the agent in the record is associated with.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_INTERVAL', 'COLUMN', N'SUPERVISOR_AGENT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_AGENT', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_INTERVAL', 'COLUMN', N'SUPERVISOR_AGENT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column gives information regarding the source of the data. This corresponds to the RESOURCE_URN from TB_CLU_RESOURCE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_AGENT_INTERVAL', 'COLUMN', N'CLUSTER_RESOURCE_URN'
GO
GRANT SELECT
	ON [dbo].[TB_SUM_AGENT_INTERVAL]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_SUM_AGENT_INTERVAL]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_SUM_AGENT_INTERVAL]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_SUM_AGENT_INTERVAL] SET (LOCK_ESCALATION = TABLE)
GO
