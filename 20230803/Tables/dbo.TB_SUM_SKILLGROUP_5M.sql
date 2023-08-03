SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TB_SUM_SKILLGROUP_5M] (
		[SUMMARIZED_URN]                      [int] IDENTITY(0, 1) NOT FOR REPLICATION NOT NULL,
		[SKILLGROUP_URN]                      [int] NOT NULL,
		[DATE_URN]                            [int] NOT NULL,
		[TIME_URN]                            [smallint] NOT NULL,
		[DATE_UTC_URN]                        [int] NOT NULL,
		[TIME_UTC_URN]                        [smallint] NOT NULL,
		[LOGGED_ON]                           [int] NULL,
		[AVAIL]                               [int] NULL,
		[READY]                               [int] NULL,
		[NOT_READY]                           [int] NULL,
		[TALKING_IN]                          [int] NULL,
		[TALKING_OUT]                         [int] NULL,
		[TALKING_OTHER]                       [int] NULL,
		[WORK_READY]                          [int] NULL,
		[WORK_NOT_READY]                      [int] NULL,
		[AVG_HANDLED_CALLS_TALK_TIME_TO5]     [int] NULL,
		[CALLS_HANDLED_TO5]                   [int] NULL,
		[AVG_HANDLED_CALLS_TIME_TO5]          [int] NULL,
		[PERCENT_UTILIZATION_TO5]             [real] NULL,
		[AVAIL_TIME_TO5]                      [int] NULL,
		[NOT_READY_TIME_TO5]                  [int] NULL,
		[TALK_TIME_TO5]                       [int] NULL,
		[WORK_READY_TIME_TO5]                 [int] NULL,
		[WORK_NOT_READY_TIME_TO5]             [int] NULL,
		[BUSY_OTHER]                          [int] NULL,
		[BUSY_OTHER_TIME_TO5]                 [int] NULL,
		[CALLS_ANSWERED_TO5]                  [int] NULL,
		[RESERVED_STATE_TIME_TO5]             [int] NULL,
		[LONGEST_AVAIL_AGENT]                 [int] NULL,
		[PARTITION_ID]                        [int] NOT NULL,
		[RECOVERY_KEY]                        [float] NULL,
		[DATE_TIME]                           [datetime] NOT NULL,
		[CLUSTER_RESOURCE_URN]                [int] NOT NULL
) ON [SUMICMGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the template table for the historical five minute summary statistics of all the skillgroups. This table is created as install time and the data importer creates various partition tables with the same schema. These partition tables are prefixed as TB_SUM_SKILLGROUP_5M_ followed by the partition identifier. The partition identifier is created depending on the importer configuration, for example monthly, weekly etc. All currently active partitions are included VW_PARTITONED_SUM_SKILLGROUP_5M view. Since the partitioned tables are generated at runtime and that they have the same schema no separate documentations are required for each partition table. In case of Cisco ICM/IPCC the data in these partitioned tables is imported from t_Skill_Group_Five_Minute table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_5M', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_5M', 'COLUMN', N'SUMMARIZED_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_SKILLGROUP for an item of type IT_SKILLGROUP. This is the skillgroup associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_5M', 'COLUMN', N'SKILLGROUP_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the date associated with the record. This is calculated by the data importer based on the source date time corresponding to the start of the five minute interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_5M', 'COLUMN', N'DATE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the time associated with the record. This is calculated by the data importer based on the source date time corresponding to the start of the five minute interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_5M', 'COLUMN', N'TIME_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the UTC date associated with the record. This is calculated by the data importer based on the source date time corresponding to the start of the five minute interval and the TimeZone information from the source data.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_5M', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the UTC time associated with the record. This is calculated by the data importer based on the source date time corresponding to the start of the five minute interval and the TimeZone information from the source data.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_5M', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'during the five minute interval. In Cisco ICM/IPCC this maps to CallsInProgress column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_5M', 'COLUMN', N'LOGGED_ON'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of agents for the skillgroup that were in available state at the end of the five minute interval. In Cisco ICM/IPCC this maps to Avail column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_5M', 'COLUMN', N'AVAIL'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of agents for the skillgroup that were in ready state at the end of the five minute interval. In Cisco ICM/IPCC this maps to Ready column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_5M', 'COLUMN', N'READY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of agents for the skillgroup that were in not ready state at the end of the five minute interval. In Cisco ICM/IPCC this maps to NotReady column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_5M', 'COLUMN', N'NOT_READY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of agents for the skillgroup talking on inbound calls at the end of the five minute interval. In Cisco ICM/IPCC this maps to TalkingIn column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_5M', 'COLUMN', N'TALKING_IN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of agents for the skillgroup talking on outbound calls at the end of the five minute interval. In Cisco ICM/IPCC this maps to TalkingOut column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_5M', 'COLUMN', N'TALKING_OUT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of agents for the skillgroup talking on internal calls at the end of the five minute interval. In Cisco ICM/IPCC this maps to TalkingOther column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_5M', 'COLUMN', N'TALKING_OTHER'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of agents for the skillgroup that were in work ready state at the end of the five minute interval. In Cisco ICM/IPCC this maps to WorkReady column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_5M', 'COLUMN', N'WORK_READY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of agents for the skillgroup that were in work not ready state at the end of the five minute interval. In Cisco ICM/IPCC this maps to WorkNotReady column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_5M', 'COLUMN', N'WORK_NOT_READY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the average talk time, in seconds, for all calls to the skillgroup that were handled during the five minute interval. In Cisco ICM/IPCC this maps to AvgHandledCallsTimeTo5 column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_5M', 'COLUMN', N'AVG_HANDLED_CALLS_TALK_TIME_TO5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls to the skillgroup that were handled during the five minute interval. In Cisco ICM/IPCC this maps to CallsHandledTo5 column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_5M', 'COLUMN', N'CALLS_HANDLED_TO5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the average time, in seconds, for all calls to the skillgroup that were handled during the five minute interval. In Cisco ICM/IPCC this maps to AvgHandledCallsTimeTo5 column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_5M', 'COLUMN', N'AVG_HANDLED_CALLS_TIME_TO5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the percentage of time agents spend working on calls versus the time agents were ready during the five minute interval. In Cisco ICM/IPCC this maps to PercentUtilizationTo5 column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_5M', 'COLUMN', N'PERCENT_UTILIZATION_TO5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, the agents for the skillgroups were in availbale state during the five minute interval. In Cisco ICM/IPCC this maps to AvailTimeTo5 column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_5M', 'COLUMN', N'AVAIL_TIME_TO5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, the agents for the skillgroup were in not ready state during the five minute interval. In Cisco ICM/IPCC this maps to NotReadyTimeTo5 column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_5M', 'COLUMN', N'NOT_READY_TIME_TO5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, the agents for the skillgroup were in talking state during the five minute interval. In Cisco ICM/IPCC this maps to TalkTimeTo5 column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_5M', 'COLUMN', N'TALK_TIME_TO5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, the agents for the skillgroup were in work ready state during the five minute interval. In Cisco ICM/IPCC this maps to WorkReadyTimeTo5 column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_5M', 'COLUMN', N'WORK_READY_TIME_TO5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, the agents for the skillgroup were in work not ready state during the five minute interval. In Cisco ICM/IPCC this maps to WorkNotReadyTimeTo5 column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_5M', 'COLUMN', N'WORK_NOT_READY_TIME_TO5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of agents in busy other state at the end of the five minute interval. In Cisco ICM/IPCC this maps to BusyOther column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_5M', 'COLUMN', N'BUSY_OTHER'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, the agents for the skillgroup were in busy other state during the five minute interval. In Cisco ICM/IPCC this maps to BusyOtherTimeTo5 column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_5M', 'COLUMN', N'BUSY_OTHER_TIME_TO5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls answered by agents for the skillgroup during the five minute interval. In Cisco ICM/IPCC this maps to CallsAnsweredTo5 column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_5M', 'COLUMN', N'CALLS_ANSWERED_TO5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, the agents for the skillgroup spent in reserved state during the five minute interval. In Cisco ICM/IPCC this maps to ReservedStateTimeTo5 column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_5M', 'COLUMN', N'RESERVED_STATE_TIME_TO5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the duration, in seconds, when agent for the skillgroup was available for the longest period of time during the five minute interval. In Cisco ICM/IPCC this maps to LongestAvailAgent column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_5M', 'COLUMN', N'LONGEST_AVAIL_AGENT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number for the current partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_5M', 'COLUMN', N'PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the surrogate key identifier for the record from the source data. The data in this column maps to RecoveryKey column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_5M', 'COLUMN', N'RECOVERY_KEY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the datetime stamp associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_5M', 'COLUMN', N'DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column gives information regarding the source of the data. This corresponds to the RESOURCE_URN from TB_CLU_RESOURCE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_SKILLGROUP_5M', 'COLUMN', N'CLUSTER_RESOURCE_URN'
GO
GRANT SELECT
	ON [dbo].[TB_SUM_SKILLGROUP_5M]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_SUM_SKILLGROUP_5M]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_SUM_SKILLGROUP_5M]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_SUM_SKILLGROUP_5M] SET (LOCK_ESCALATION = TABLE)
GO
