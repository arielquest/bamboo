SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TB_SUM_CMS_SKILLGROUP_INTERVAL] (
		[PARTITION_URN]            [int] NOT NULL,
		[PARTITION_GLOBAL_URN]     [bigint] NOT NULL,
		[PARTITION_ID]             [int] NOT NULL,
		[CLUSTER_RESOURCE_URN]     [int] NOT NULL,
		[ACD_URN]                  [int] NOT NULL,
		[SKILLGROUP_URN]           [int] NOT NULL,
		[DATE_UTC_URN]             [int] NOT NULL,
		[TIME_UTC_URN]             [smallint] NOT NULL,
		[DB_DATETIME]              [datetime] NULL,
		[UTC_DATE_TIME]            [datetime] NOT NULL,
		[INTRVL]                   [int] NULL,
		[I_STAFF_TIME]             [int] NULL,
		[I_AVAIL_TIME]             [int] NULL,
		[I_ACD_TIME]               [int] NULL,
		[I_ACW_TIME]               [int] NULL,
		[I_ACW_OUT_TIME]           [int] NULL,
		[I_ACW_IN_TIME]            [int] NULL,
		[I_AUX_TIME]               [int] NULL,
		[I_AUX_OUT_TIME]           [int] NULL,
		[I_AUX_IN_TIME]            [int] NULL,
		[I_OTHER_TIME]             [int] NULL,
		[MAX_STAFFED]              [int] NULL,
		[ACW_IN_CALLS]             [int] NULL,
		[ACW_IN_TIME]              [int] NULL,
		[AUX_IN_CALLS]             [int] NULL,
		[AUX_IN_TIME]              [int] NULL,
		[ACW_OUT_CALLS]            [int] NULL,
		[ACW_OUT_TIME]             [int] NULL,
		[ACW_OUT_OFF_CALLS]        [int] NULL,
		[ACW_OUT_OFF_TIME]         [int] NULL,
		[ACW_OUT_ADJ_CALLS]        [int] NULL,
		[AUX_OUT_CALLS]            [int] NULL,
		[AUX_OUT_TIME]             [int] NULL,
		[AUX_OUT_OFF_CALLS]        [int] NULL,
		[AUX_OUT_OFF_TIME]         [int] NULL,
		[AUX_OUT_ADJ_CALLS]        [int] NULL,
		[EVENT1]                   [int] NULL,
		[EVENT2]                   [int] NULL,
		[EVENT3]                   [int] NULL,
		[EVENT4]                   [int] NULL,
		[EVENT5]                   [int] NULL,
		[EVENT6]                   [int] NULL,
		[EVENT7]                   [int] NULL,
		[EVENT8]                   [int] NULL,
		[EVENT9]                   [int] NULL,
		[ASSISTS]                  [int] NULL,
		[IN_FLOW_CALLS]            [int] NULL,
		[ACD_CALLS]                [int] NULL,
		[ANS_TIME]                 [int] NULL,
		[ACD_TIME]                 [int] NULL,
		[ACW_TIME]                 [int] NULL,
		[O_ACD_CALLS]              [int] NULL,
		[O_ACD_TIME]               [int] NULL,
		[O_ACW_TIME]               [int] NULL,
		[ACD_CALLS1]               [int] NULL,
		[ACD_CALLS2]               [int] NULL,
		[ACD_CALLS3]               [int] NULL,
		[ACD_CALLS4]               [int] NULL,
		[ACD_CALLS5]               [int] NULL,
		[ACD_CALLS6]               [int] NULL,
		[ACD_CALLS7]               [int] NULL,
		[ACD_CALLS8]               [int] NULL,
		[ACD_CALLS9]               [int] NULL,
		[ACD_CALLS10]              [int] NULL,
		[BACKUP_CALLS]             [int] NULL,
		[HOLD_CALLS]               [int] NULL,
		[HOLD_TIME]                [int] NULL,
		[HOLD_ABN_CALLS]           [int] NULL,
		[TRANSFERRED]              [int] NULL,
		[CONFERENCE]               [int] NULL,
		[ABN_CALLS]                [int] NULL,
		[ABN_TIME]                 [int] NULL,
		[ABN_CALLS1]               [int] NULL,
		[ABN_CALLS2]               [int] NULL,
		[ABN_CALLS3]               [int] NULL,
		[ABN_CALLS4]               [int] NULL,
		[ABN_CALLS5]               [int] NULL,
		[ABN_CALLS6]               [int] NULL,
		[ABN_CALLS7]               [int] NULL,
		[ABN_CALLS8]               [int] NULL,
		[ABN_CALLS9]               [int] NULL,
		[ABN_CALLS10]              [int] NULL,
		[DE_QUE_CALLS]             [int] NULL,
		[DE_QUE_TIME]              [int] NULL,
		[BUSY_CALLS]               [int] NULL,
		[BUSY_TIME]                [int] NULL,
		[DISC_CALLS]               [int] NULL,
		[DISC_TIME]                [int] NULL,
		[OUT_FLOW_CALLS]           [int] NULL,
		[OUT_FLOW_TIME]            [int] NULL,
		[INTERFLOW_CALLS]          [int] NULL,
		[LOW_CALLS]                [int] NULL,
		[MED_CALLS]                [int] NULL,
		[HIGH_CALLS]               [int] NULL,
		[TOP_CALLS]                [int] NULL,
		[ACCEPTABLE]               [int] NULL,
		[SERVICE_LEVEL]            [int] NULL,
		[PERIOD1]                  [int] NULL,
		[PERIOD2]                  [int] NULL,
		[PERIOD3]                  [int] NULL,
		[PERIOD4]                  [int] NULL,
		[PERIOD5]                  [int] NULL,
		[PERIOD6]                  [int] NULL,
		[PERIOD7]                  [int] NULL,
		[PERIOD8]                  [int] NULL,
		[PERIOD9]                  [int] NULL,
		[MAX_IN_QUEUE]             [int] NULL,
		[MAX_OCW_TIME]             [int] NULL,
		[CALLS_OFFERED]            [int] NULL,
		[PERIOD_CHG]               [int] NULL,
		[SVC_LEVEL_CHG]            [int] NULL,
		[I_RING_TIME]              [int] NULL,
		[RING_TIME]                [int] NULL,
		[RING_CALLS]               [int] NULL,
		[ABN_RING_CALLS]           [int] NULL,
		[O_ABN_CALLS]              [int] NULL,
		[O_OTHER_CALLS]            [int] NULL,
		[DA_ACW_IN_CALLS]          [int] NULL,
		[DA_ACW_IN_TIME]           [int] NULL,
		[DA_ACW_O_CALLS]           [int] NULL,
		[DA_ACW_O_TIME]            [int] NULL,
		[NO_ANS_REDIR]             [int] NULL,
		[INCOMPLETE]               [int] NULL,
		[ACD_AUX_OUT_CALLS]        [int] NULL,
		[I_ACD_AUX_OUT_TIME]       [int] NULL,
		[I_ACD_AUX_IN_TIME]        [int] NULL,
		[I_ACD_OTHER_TIME]         [int] NULL,
		[PHANTOM_ABNS]             [int] NULL,
		[OTHER_CALLS]              [int] NULL,
		[OTHER_TIME]               [int] NULL,
		[SLVL_ABNS]                [int] NULL,
		[SLVL_OUT_FLOWS]           [int] NULL,
		[I_ARRIVED]                [int] NULL,
		[I_AUX_TIME0]              [int] NULL,
		[I_AUX_TIME1]              [int] NULL,
		[I_AUX_TIME2]              [int] NULL,
		[I_AUX_TIME3]              [int] NULL,
		[I_AUX_TIME4]              [int] NULL,
		[I_AUX_TIME5]              [int] NULL,
		[I_AUX_TIME6]              [int] NULL,
		[I_AUX_TIME7]              [int] NULL,
		[I_AUX_TIME8]              [int] NULL,
		[I_AUX_TIME9]              [int] NULL,
		[I_DA_ACD_TIME]            [int] NULL,
		[I_DA_ACW_TIME]            [int] NULL,
		[I_T_AVAIL_TIME]           [int] NULL,
		[I_T_AUX_TIME]             [int] NULL,
		[MAXTOP]                   [int] NULL,
		[I_NORM_TIME]              [int] NULL,
		[I_OL1_TIME]               [int] NULL,
		[I_OL2_TIME]               [int] NULL,
		[I_T_OTHER_TIME]           [int] NULL,
		[MAX_TOT_PERCENTS]         [int] NULL,
		[ACD_CALLS_R1]             [int] NULL,
		[ACD_CALLS_R2]             [int] NULL,
		[I_ACD_TIME_R1]            [int] NULL,
		[I_ACD_TIME_R2]            [int] NULL,
		[I_ACW_TIME_R1]            [int] NULL,
		[I_ACW_TIME_R2]            [int] NULL,
		[I_RING_TIME_R1]           [int] NULL,
		[I_RING_TIME_R2]           [int] NULL,
		[I_OTHER_TIME_R1]          [int] NULL,
		[I_OTHER_TIME_R2]          [int] NULL,
		[I_AUX_TIME_R1]            [int] NULL,
		[I_AUX_TIME_R2]            [int] NULL,
		[I_OTHER_STBY_TIME_R1]     [int] NULL,
		[I_OTHER_STBY_TIME_R2]     [int] NULL,
		[I_AUX_STBY_TIME_R1]       [int] NULL,
		[I_AUX_STBY_TIME_R2]       [int] NULL,
		[I_BEHIND_TIME]            [int] NULL,
		[I_AUTO_RESERVE_TIME]      [int] NULL,
		[TARGET_PERCENT]           [int] NULL,
		[TARGET_PCT_CHG]           [int] NULL,
		[TARGET_SECONDS]           [int] NULL,
		[TARGET_SEC_CHG]           [int] NULL,
		[TARGET_ACD_CALLS]         [int] NULL,
		[TARGET_ABNS]              [int] NULL,
		[TARGET_OUT_FLOWS]         [int] NULL,
		[INTR_DELIVERIES]          [int] NULL,
		[AG_SURP_DELIVERIES]       [int] NULL,
		[AG_SURP_PREF_CALLS]       [int] NULL,
		[AG_SURP_NPREF_CALLS]      [int] NULL,
		[CALL_SURP_DELIVERIES]     [int] NULL,
		[I_AUX_TIME10]             [int] NULL,
		[I_AUX_TIME11]             [int] NULL,
		[I_AUX_TIME12]             [int] NULL,
		[I_AUX_TIME13]             [int] NULL,
		[I_AUX_TIME14]             [int] NULL,
		[I_AUX_TIME15]             [int] NULL,
		[I_AUX_TIME16]             [int] NULL,
		[I_AUX_TIME17]             [int] NULL,
		[I_AUX_TIME18]             [int] NULL,
		[I_AUX_TIME19]             [int] NULL,
		[I_AUX_TIME20]             [int] NULL,
		[I_AUX_TIME21]             [int] NULL,
		[I_AUX_TIME22]             [int] NULL,
		[I_AUX_TIME23]             [int] NULL,
		[I_AUX_TIME24]             [int] NULL,
		[I_AUX_TIME25]             [int] NULL,
		[I_AUX_TIME26]             [int] NULL,
		[I_AUX_TIME27]             [int] NULL,
		[I_AUX_TIME28]             [int] NULL,
		[I_AUX_TIME29]             [int] NULL,
		[I_AUX_TIME30]             [int] NULL,
		[I_AUX_TIME31]             [int] NULL,
		[I_AUX_TIME32]             [int] NULL,
		[I_AUX_TIME33]             [int] NULL,
		[I_AUX_TIME34]             [int] NULL,
		[I_AUX_TIME35]             [int] NULL,
		[I_AUX_TIME36]             [int] NULL,
		[I_AUX_TIME37]             [int] NULL,
		[I_AUX_TIME38]             [int] NULL,
		[I_AUX_TIME39]             [int] NULL,
		[I_AUX_TIME40]             [int] NULL,
		[I_AUX_TIME41]             [int] NULL,
		[I_AUX_TIME42]             [int] NULL,
		[I_AUX_TIME43]             [int] NULL,
		[I_AUX_TIME44]             [int] NULL,
		[I_AUX_TIME45]             [int] NULL,
		[I_AUX_TIME46]             [int] NULL,
		[I_AUX_TIME47]             [int] NULL,
		[I_AUX_TIME48]             [int] NULL,
		[I_AUX_TIME49]             [int] NULL,
		[I_AUX_TIME50]             [int] NULL,
		[I_AUX_TIME51]             [int] NULL,
		[I_AUX_TIME52]             [int] NULL,
		[I_AUX_TIME53]             [int] NULL,
		[I_AUX_TIME54]             [int] NULL,
		[I_AUX_TIME55]             [int] NULL,
		[I_AUX_TIME56]             [int] NULL,
		[I_AUX_TIME57]             [int] NULL,
		[I_AUX_TIME58]             [int] NULL,
		[I_AUX_TIME59]             [int] NULL,
		[I_AUX_TIME60]             [int] NULL,
		[I_AUX_TIME61]             [int] NULL,
		[I_AUX_TIME62]             [int] NULL,
		[I_AUX_TIME63]             [int] NULL,
		[I_AUX_TIME64]             [int] NULL,
		[I_AUX_TIME65]             [int] NULL,
		[I_AUX_TIME66]             [int] NULL,
		[I_AUX_TIME67]             [int] NULL,
		[I_AUX_TIME68]             [int] NULL,
		[I_AUX_TIME69]             [int] NULL,
		[I_AUX_TIME70]             [int] NULL,
		[I_AUX_TIME71]             [int] NULL,
		[I_AUX_TIME72]             [int] NULL,
		[I_AUX_TIME73]             [int] NULL,
		[I_AUX_TIME74]             [int] NULL,
		[I_AUX_TIME75]             [int] NULL,
		[I_AUX_TIME76]             [int] NULL,
		[I_AUX_TIME77]             [int] NULL,
		[I_AUX_TIME78]             [int] NULL,
		[I_AUX_TIME79]             [int] NULL,
		[I_AUX_TIME80]             [int] NULL,
		[I_AUX_TIME81]             [int] NULL,
		[I_AUX_TIME82]             [int] NULL,
		[I_AUX_TIME83]             [int] NULL,
		[I_AUX_TIME84]             [int] NULL,
		[I_AUX_TIME85]             [int] NULL,
		[I_AUX_TIME86]             [int] NULL,
		[I_AUX_TIME87]             [int] NULL,
		[I_AUX_TIME88]             [int] NULL,
		[I_AUX_TIME89]             [int] NULL,
		[I_AUX_TIME90]             [int] NULL,
		[I_AUX_TIME91]             [int] NULL,
		[I_AUX_TIME92]             [int] NULL,
		[I_AUX_TIME93]             [int] NULL,
		[I_AUX_TIME94]             [int] NULL,
		[I_AUX_TIME95]             [int] NULL,
		[I_AUX_TIME96]             [int] NULL,
		[I_AUX_TIME97]             [int] NULL,
		[I_AUX_TIME98]             [int] NULL,
		[I_AUX_TIME99]             [int] NULL,
		[ICR_PULL_CALLS]           [int] NULL,
		[ICR_PULL_TIME]            [int] NULL,
		[ICR_PULL_RING_CALLS]      [int] NULL,
		[REDIRECT_CALLS]           [int] NULL,
		[TALK_TIME_IN]             [int] NULL,
		[TALK_TIME_CALLS]          [int] NULL,
		[EXT_TALK_TIME_OUT]        [int] NULL,
		[EXT_TALK_CALLS_OUT]       [int] NULL,
		[MAIN_ACD_CALLS]           [int] NULL,
		CONSTRAINT [PK_SUM_CMS_SKILLGROUP_INTERVAL]
		PRIMARY KEY
		CLUSTERED
		([PARTITION_URN], [PARTITION_ID])
	ON [SUMCMSGROUP]
) ON [SUMCMSGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_SUM_CMS_SKILLGROUP_INTERVAL_ACD_URN]
	ON [dbo].[TB_SUM_CMS_SKILLGROUP_INTERVAL] ([ACD_URN])
	ON [SUMCMSIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'INDEX', N'IX_SUM_CMS_SKILLGROUP_INTERVAL_ACD_URN'
GO
CREATE NONCLUSTERED INDEX [IX_SUM_CMS_SKILLGROUP_INTERVAL_SKILLGROUP_URN]
	ON [dbo].[TB_SUM_CMS_SKILLGROUP_INTERVAL] ([SKILLGROUP_URN])
	ON [SUMCMSIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'INDEX', N'IX_SUM_CMS_SKILLGROUP_INTERVAL_SKILLGROUP_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the template table for the historical interval based split summary statistics from CMS systems. This table is created at install time and the partitioning service creates various partition tables with the same schema. These partition tables are prefixed as TB_SUM_CMS_SKILLGROUP_INTERVAL_ followed by the partition identifier. The partition identifier is created depending on the partition configuration, for example monthly, weekly etc. All currently active partitions are included VW_PARTITONED_SUM_CMS_SKILLGROUP_INTERVAL view. Since the partitioned tables are generated at runtime and that they have the same schema no separate documentations are required for each partition table. In case of a configured Avaya CMS the data in these partition tables are sourced from the hsplit table in cms Database.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary Key Identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'PARTITION_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column holds a value that uniquely identifies a row across all the partition tables for this partition type.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'PARTITION_GLOBAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number for the current partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from the table dbo.TB_CLU_RESOURCE indicating the source of the data..', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'CLUSTER_RESOURCE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_PERIPHERAL corresponding to an item of type PT_ACD. This corresponds to the ACD associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'ACD_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_PERIPHERAL', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'ACD_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_SKILLGROUP corresponding to an item of type IT_SKILLGROUP. This corresponds to the skillgroup associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'SKILLGROUP_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_SKILLGROUP', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'SKILLGROUP_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the date associated with the record. This is calculated by the data importer based on the source data time corresponding to the start of the reporting interval from the source data.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the time associated with the record. This is calculated by the data importer based on the source data time corresponding to the start of the reporting interval from the source data.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the datetime stamp associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'DB_DATETIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The UTC start time of the interval for which data was collected. It is records in number of seconds since midnight 01/01/1970 UTC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'UTC_DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of minutes in the intrahour interval. The length of the intrahour interval can be 15, 30, or 60 minutes. INTRVL applies to intrahour tables only. The data in this column maps to the HSPLIT.INTRVL column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'INTRVL'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were logged in. I_STAFFTIME includes I_ACDTIME, I_ACWTIME, I_AUXTIME, I_AVAILTIME, I_OTHERTIME, and I_RINGTIME.. The data in this column maps to the HSPLIT.I_STAFFTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_STAFF_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were available for calls from this split/skill. The data in this column maps to the HSPLIT.I_AVAILTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AVAIL_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were on split/skill ACD calls. I_ACDTIME includes time on O_ACDCALLS and ACDCALLS. I_ACDTIME includes I_ACDTIME_R1 and I_ACDTIME_R2 when reserve agents are used. The data in this column maps to the HSPLIT.I_ACDTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_ACD_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in ACW for this split/skill. The ACW can be associated with a split/skill ACD call or not associated with a call. I_ACWTIME includes I_ACWINTIME, I_ACWOUTTIME. I_ACWTIME includes I_ACWTIME_R1 and I_ACWTIME_R2 when reserve agents are used. The data in this column maps to the HSPLIT.I_ACWTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_ACW_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in ACW for this split/skill and on outbound extension calls. The ACW can be associated with a split/skill ACD call or not associated with a call. I_ACWOUTTIME does not include the time that outbound extension calls spend on hold. The data in this column maps to the HSPLIT.I_ACWOUTTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_ACW_OUT_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in ACW for this split/skill and on inbound extension calls. The ACW can be associated with a split/skill ACD call or not associated with a call. I_ACWINTIME does not include the time that inbound extension calls spend on hold. The data in this column maps to the HSPLIT.I_ACWINTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_ACW_IN_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents are in AUX in this skill. I_AUXTIME includes I_AUXTIME0, I_AUXTIME1 through I_AUXTIME9, I_AUXTIME10 through I_AUXTIME99, I_AUXINTIME, I_AUXOUTTIME, I_TAUXTIME. The data in this column maps to the HSPLIT.I_AUXTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that the agent was in AUX work, AVAILABLE, or had an AUXIN or AUXOUT call is on hold, and on outbound extension calls. This does not include time outbound extension calls spent on hold.. The data in this column maps to the HSPLIT.I_AUXOUTTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_OUT_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The time during the collection interval that agents were in AUX work or AVAILABLE and on an inbound extension call. I_AUXINTIME includes the length of time when an ACD, AUXIN, or AUXOUT call is on hold and the time the agent is on inbound extension calls. I_AUXINTIME includes I_ACDAUXINTIME but does not include time inbound extension calls spent on hold. The data in this column maps to the HSPLIT.I_AUXINTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_IN_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents spent doing other work.I_OTHERTIME is collected for the time period after the link to the communication server is initiated or after the agent logs in and before the CMS receives notification of the agents state from the communication server. The data in this column maps to the HSPLIT.I_OTHERTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_OTHER_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The maximum number of agents that are simultaneously staffed during the collection interval.MAXSTAFFED includes MAXTOP. The data in this column maps to the HSPLIT.MAXSTAFFED column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'MAX_STAFFED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of inbound extension calls that are received by agents while they are in ACW. This includes ACW for split/skill, direct agent ACD calls, and ACW not associated with a call.. The data in this column maps to the HSPLIT.ACWINCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'ACW_IN_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The talk time of all ACWINCALLS. ACWINTIME includes DA_ACWINTIME but it does not include HOLDTIME. The data in this column maps to the HSPLIT.ACWINTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'ACW_IN_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of inbound extension calls that are received by agents while they are in AUX or AVAILABLE, or while the agents have an ACD, AUXIN, or AUXOUT call on hold. AUXINCALLS are recorded in the SPLIT that is the OLDEST_LOGON for agents in multiple splits/skills. The data in this column maps to the HSPLIT.AUXINCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'AUX_IN_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The talk time of all AUXINCALLS. AUXINTIME does not include HOLDTIME. The data in this column maps to the HSPLIT.AUXINTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'AUX_IN_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of outbound extension calls that are placed by agents or on behalf of the agent while they are in ACW. This includes ACW for ACD calls and ACW that is not associated with a call. ACWOUTCALLS includes ACWOUTADJCALLS and ACWOUTOFFCALLS. The data in this column maps to the HSPLIT.ACWOUTCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'ACW_OUT_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Talk time of all ACWOUTCALLS. ACWOUTTIME does not include hold time. The data in this column maps to the HSPLIT.ACWOUTTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'ACW_OUT_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of ACWOUTCALLS that are placed to an off-communication server destination. If these calls are placed by an adjunct on behalf of an agent while the agent is in ACW, they are also counted as ACWOUTADJCALLS. The data in this column maps to the HSPLIT.ACWOUTOFFCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'ACW_OUT_OFF_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The talk time of all ACWOUTOFFCALLS. ACWOUTOFFTIME does not include HOLDTIME.ACWOUTTIME includes ACWOUTOFFTIME. The data in this column maps to the HSPLIT.ACWOUTOFFTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'ACW_OUT_OFF_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of ACWOUTCALLS that are placed by an adjunct on behalf of an agent (keyboard-dialed). If such calls are placed to off-communication server destinations, they are also counted as ACWOUTOFFCALLS. ACWOUTADJCALLS is available with the ASAI feature. The data in this column maps to the HSPLIT.ACWOUTADJCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'ACW_OUT_ADJ_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of outbound extension calls that are placed by agents while they are in AUX or AVAILABLE, or while the agents have an ACD, AUXIN, or AUXOUT call on hold.AUXOUTCALLS are recorded in the SPLIT that is the OLDEST_LOGON, unless the agent placed the call with an ACD call on hold. In this case, AUXOUTCALLS are recorded for the split/skill of the ACD call. AUXOUTCALLS includes ACDAUXOUTCALLS, AUXOUTADJCALLS, and AUXOUTOFFCALLS.. The data in this column maps to the HSPLIT.AUXOUTCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'AUX_OUT_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The talk time of all AUXOUTCALLS. AUXOUTTIME does not include HOLDTIME.AUXOUTTIME includes AUXOUTOFFTIME. The data in this column maps to the HSPLIT.AUXOUTTIME. column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'AUX_OUT_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of AUXOUTCALLS that are placed to a destination outside the communication server. If such calls are placed by an adjunct on behalf of an agent, they are also counted as AUXOUTADJCALLS. The data in this column maps to the HSPLIT.AUXOUTOFFCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'AUX_OUT_OFF_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The talk time of all AUXOUTOFFCALLS not including HOLDTIME. AUXOUTOFFTIME is included in AUXOUTTIME. The data in this column maps to the HSPLIT.AUXOUTOFFTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'AUX_OUT_OFF_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of AUXOUTCALLS that are placed by an adjunct on behalf of an agent (keyboard dialed). If such calls are placed to off-communication server destinations, they are also counted as AUXOUTOFFCALLS. AUXOUTADJCALLS is available with the ASAI feature. The data in this column maps to the HSPLIT.AUXOUTADJCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'AUX_OUT_ADJ_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times each event (stroke count) feature button (feature button 1 to 9) was pressed by agents on split/skill or direct agent ACD calls or in after call work associated with an ACD call for this split/skill. The data in this column maps to the HSPLIT.EVENT1 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'EVENT1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times each event (stroke count) feature button (feature button 1 to 9) was pressed by agents on split/skill or direct agent ACD calls or in after call work associated with an ACD call for this split/skill. The data in this column maps to the HSPLIT.EVENT2 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'EVENT2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times each event (stroke count) feature button (feature button 1 to 9) was pressed by agents on split/skill or direct agent ACD calls or in after call work associated with an ACD call for this split/skill. The data in this column maps to the HSPLIT.EVENT3 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'EVENT3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times each event (stroke count) feature button (feature button 1 to 9) was pressed by agents on split/skill or direct agent ACD calls or in after call work associated with an ACD call for this split/skill. The data in this column maps to the HSPLIT.EVENT4 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'EVENT4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times each event (stroke count) feature button (feature button 1 to 9) was pressed by agents on split/skill or direct agent ACD calls or in after call work associated with an ACD call for this split/skill. The data in this column maps to the HSPLIT.EVENT5 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'EVENT5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times each event (stroke count) feature button (feature button 1 to 9) was pressed by agents on split/skill or direct agent ACD calls or in after call work associated with an ACD call for this split/skill. The data in this column maps to the HSPLIT.EVENT6 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'EVENT6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times each event (stroke count) feature button (feature button 1 to 9) was pressed by agents on split/skill or direct agent ACD calls or in after call work associated with an ACD call for this split/skill. The data in this column maps to the HSPLIT.EVENT7 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'EVENT7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times each event (stroke count) feature button (feature button 1 to 9) was pressed by agents on split/skill or direct agent ACD calls or in after call work associated with an ACD call for this split/skill. The data in this column maps to the HSPLIT.EVENT8 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'EVENT8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times each event (stroke count) feature button (feature button 1 to 9) was pressed by agents on split/skill or direct agent ACD calls or in after call work associated with an ACD call for this split/skill. The data in this column maps to the HSPLIT.EVENT9 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'EVENT9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times that agents requested supervisor assistance while they were on split/skill ACD calls, direct agent ACD calls, or in call-related ACW for this split/skill. The data in this column maps to the HSPLIT.ASSISTS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'ASSISTS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of calls that are redirected to the split/skills queue from another queue. When a call leaves the VDN, for example, by routing to another VDN, or leaves vector processing, for example, by routing to a split/skill, the next split/skill to which a call queues will not be credited with an inflow. Calls that ring at an agent and are then requeued to the same split/skill by the Redirect on No answer feature are counted as inflows to that split/skill.Without the Vectoring feature, an inflow is counted for calls that intraflow from one split queue to another split queue.With the Vectoring feature, calls answered by an agent in a non-primary split/skill are counted as inflows to that split/skill. Calls that abandon from ringing at an agents telephone in a non-primary split/skill are also counted as inflows to that skill. The data in this column maps to the HSPLIT.INFLOWCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'IN_FLOW_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of CALLSOFFERED calls that are answered by an agent in the split/skill. The data in this column maps to the HSPLIT.ACDCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'ACD_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time that is spent by callers in queue or ringing before an agent answers the call. The data in this column maps to the HSPLIT.ANSTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'ANS_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The talk time of all ACDCALLS. ACDTIME includes O_ACDTIME but does not include HOLDTIME. The data in this column maps to the HSPLIT.ACDTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'ACD_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time that agents spend in ACW that is associated with ACDCALLS. The ACWTIME database item includes portions of ACWINTIME, ACWOUTTIME, and O_ACWTIME that are associated with ACD calls. Only the ACWINTIME and ACWOUTTIME associated with calls made or received while in ACW associated with Split/Skill ACD calls are included. The data in this column maps to the HSPLIT.ACWTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'ACW_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of ACDCALLS that are placed by an adjunct (outbound predictive dialing). O_ACDCALLS includes DA_ACDCALLS. The O_ACDCALLS item is available with the ASAI feature. The data in this column maps to the HSPLIT.O_ACDCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'O_ACD_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The talk time of all O_ACDCALLS. O_ACDTIME does not include HOLDTIME. O_ACDTIME is included in ACDTIME. The O_ACDTIME item is available with the ASAI feature. The data in this column maps to the HSPLIT.O_ACDTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'O_ACD_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The duration of all ACW that is associated with O_ACDCALLS. O_ACWTIME is included in ACWTIME. The O_ACWTIME item is available with the ASAI feature. The data in this column maps to the HSPLIT.O_ACWTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'O_ACW_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of ACDCALLS during the collection interval that are answered in each of the service level increments PERIOD1 through PERIOD9 as defined on the Call Center Administration: Split/Skill Call Profile window. ACDCALLS10 is the number of calls answered after the last increment PERIOD9. If call profiles are not set, then the data is stored in the first interval (ACDCALLS1).. The data in this column maps to the HSPLIT.ACDCALLS1 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'ACD_CALLS1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of ACDCALLS during the collection interval that are answered in each of the service level increments PERIOD1 through PERIOD9 as defined on the Call Center Administration: Split/Skill Call Profile window. ACDCALLS10 is the number of calls answered after the last increment PERIOD9. If call profiles are not set, then the data is stored in the first interval (ACDCALLS1).. The data in this column maps to the HSPLIT.ACDCALLS2 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'ACD_CALLS2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of ACDCALLS during the collection interval that are answered in each of the service level increments PERIOD1 through PERIOD9 as defined on the Call Center Administration: Split/Skill Call Profile window. ACDCALLS10 is the number of calls answered after the last increment PERIOD9. If call profiles are not set, then the data is stored in the first interval (ACDCALLS1).. The data in this column maps to the HSPLIT.ACDCALLS3 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'ACD_CALLS3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of ACDCALLS during the collection interval that are answered in each of the service level increments PERIOD1 through PERIOD9 as defined on the Call Center Administration: Split/Skill Call Profile window. ACDCALLS10 is the number of calls answered after the last increment PERIOD9. If call profiles are not set, then the data is stored in the first interval (ACDCALLS1).. The data in this column maps to the HSPLIT.ACDCALLS4 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'ACD_CALLS4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of ACDCALLS during the collection interval that are answered in each of the service level increments PERIOD1 through PERIOD9 as defined on the Call Center Administration: Split/Skill Call Profile window. ACDCALLS10 is the number of calls answered after the last increment PERIOD9. If call profiles are not set, then the data is stored in the first interval (ACDCALLS1).. The data in this column maps to the HSPLIT.ACDCALLS5 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'ACD_CALLS5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of ACDCALLS during the collection interval that are answered in each of the service level increments PERIOD1 through PERIOD9 as defined on the Call Center Administration: Split/Skill Call Profile window. ACDCALLS10 is the number of calls answered after the last increment PERIOD9. If call profiles are not set, then the data is stored in the first interval (ACDCALLS1).. The data in this column maps to the HSPLIT.ACDCALLS6 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'ACD_CALLS6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of ACDCALLS during the collection interval that are answered in each of the service level increments PERIOD1 through PERIOD9 as defined on the Call Center Administration: Split/Skill Call Profile window. ACDCALLS10 is the number of calls answered after the last increment PERIOD9. If call profiles are not set, then the data is stored in the first interval (ACDCALLS1).. The data in this column maps to the HSPLIT.ACDCALLS7 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'ACD_CALLS7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of ACDCALLS during the collection interval that are answered in each of the service level increments PERIOD1 through PERIOD9 as defined on the Call Center Administration: Split/Skill Call Profile window. ACDCALLS10 is the number of calls answered after the last increment PERIOD9. If call profiles are not set, then the data is stored in the first interval (ACDCALLS1).. The data in this column maps to the HSPLIT.ACDCALLS8 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'ACD_CALLS8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of ACDCALLS during the collection interval that are answered in each of the service level increments PERIOD1 through PERIOD9 as defined on the Call Center Administration: Split/Skill Call Profile window. ACDCALLS10 is the number of calls answered after the last increment PERIOD9. If call profiles are not set, then the data is stored in the first interval (ACDCALLS1).. The data in this column maps to the HSPLIT.ACDCALLS9 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'ACD_CALLS9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of ACDCALLS during the collection interval that are answered in each of the service level increments PERIOD1 through PERIOD9 as defined on the Call Center Administration: Split/Skill Call Profile window. ACDCALLS10 is the number of calls answered after the last increment PERIOD9. If call profiles are not set, then the data is stored in the first interval (ACDCALLS1).. The data in this column maps to the HSPLIT.ACDCALLS10 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'ACD_CALLS10'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of ACDCALLS that are delivered by a vector command other than "queue to" and answered by this split/skill plus the number of ACDCALLS that are delivered to this split/skill by a "queue to" vector command and answered by an agent who has either Reserve 1 or Reserve 2 skill levels assigned for this skill. The data in this column maps to the HSPLIT.BACKUPCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'BACKUP_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of split/skill ACD calls that are placed on hold at least once. The data in this column maps to the HSPLIT.HOLDCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'HOLD_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time that split/skill ACD callers spend on hold. The data in this column maps to the HSPLIT.HOLDTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'HOLD_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times that split/skill ACD callers abandoned the call while on hold. The data in this column maps to the HSPLIT.HOLDABNCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'HOLD_ABN_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of ACDCALLS that are transferred to another destination. TRANSFERRED includes all split/skill calls that are transferred. The data in this column maps to the HSPLIT.TRANSFERRED column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'TRANSFERRED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of ACDCALLS that are conferenced at least once. The data in this column maps to the HSPLIT.CONFERENCE column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'CONFERENCE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of CALLSOFFERED that are abandoned while in queue or ringing at an agentposition.When a call is abandoned while it is queued to multiple splits/skills, only the primary split/skill increments ABNCALLS. If a split/skill ACD call is ringing at an agent and then abandons, the split/skill that routed the call to the agent gets credit for the abandon. ABNCALLS includes PHANTOMABNS, which are ACD calls and calls routed to an agent or extension with talk times less than the value of the phantom-abandon call timer.ABNCALLS = ABNCALLS1 + ABNCALLS2 + ABNCALLS3 + ABNCALLS4 + ABNCALLS5 + ABNCALLS6 + ABNCALLS7 + ABNCALLS8 + ABNCALLS9 + ABNCALLS10 Dictionary of CMS database items 174 Avaya CMS R16 Database Items and Calculations November 2009 ABNCALLS includes ABNRINGCALLS, O_ABNCALLS, PHANTOMABNS, SLVLABNS. The data in this column maps to the HSPLIT.ABNCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'ABN_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time that callers waited in queue and ringing at an agents telephone before abandoning the call. For phantom abandons, ABNTIME includes the total time until the agent releases the call. The data in this column maps to the HSPLIT.ABNTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'ABN_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of CALLSOFFERED that are abandoned during the collection interval in each of the service-level increments PERIOD1 through PERIOD9, as defined on the Call Center Administration: Split/Skill Call Profile window. If call profiles are not set, the data is stored in the first interval (ABNCALLS1). ABNCALLS10 counts calls that abandoned after PERIOD9. The data in this column maps to the HSPLIT.ABNCALLS1 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'ABN_CALLS1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of CALLSOFFERED that are abandoned during the collection interval in each of the service-level increments PERIOD1 through PERIOD9, as defined on the Call Center Administration: Split/Skill Call Profile window. If call profiles are not set, the data is stored in the first interval (ABNCALLS1). ABNCALLS10 counts calls that abandoned after PERIOD9. The data in this column maps to the HSPLIT.ABNCALLS2 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'ABN_CALLS2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of CALLSOFFERED that are abandoned during the collection interval in each of the service-level increments PERIOD1 through PERIOD9, as defined on the Call Center Administration: Split/Skill Call Profile window. If call profiles are not set, the data is stored in the first interval (ABNCALLS1). ABNCALLS10 counts calls that abandoned after PERIOD9. The data in this column maps to the HSPLIT.ABNCALLS3 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'ABN_CALLS3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of CALLSOFFERED that are abandoned during the collection interval in each of the service-level increments PERIOD1 through PERIOD9, as defined on the Call Center Administration: Split/Skill Call Profile window. If call profiles are not set, the data is stored in the first interval (ABNCALLS1). ABNCALLS10 counts calls that abandoned after PERIOD9. The data in this column maps to the HSPLIT.ABNCALLS4 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'ABN_CALLS4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of CALLSOFFERED that are abandoned during the collection interval in each of the service-level increments PERIOD1 through PERIOD9, as defined on the Call Center Administration: Split/Skill Call Profile window. If call profiles are not set, the data is stored in the first interval (ABNCALLS1). ABNCALLS10 counts calls that abandoned after PERIOD9. The data in this column maps to the HSPLIT.ABNCALLS5 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'ABN_CALLS5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of CALLSOFFERED that are abandoned during the collection interval in each of the service-level increments PERIOD1 through PERIOD9, as defined on the Call Center Administration: Split/Skill Call Profile window. If call profiles are not set, the data is stored in the first interval (ABNCALLS1). ABNCALLS10 counts calls that abandoned after PERIOD9. The data in this column maps to the HSPLIT.ABNCALLS6 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'ABN_CALLS6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of CALLSOFFERED that are abandoned during the collection interval in each of the service-level increments PERIOD1 through PERIOD9, as defined on the Call Center Administration: Split/Skill Call Profile window. If call profiles are not set, the data is stored in the first interval (ABNCALLS1). ABNCALLS10 counts calls that abandoned after PERIOD9. The data in this column maps to the HSPLIT.ABNCALLS7 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'ABN_CALLS7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of CALLSOFFERED that are abandoned during the collection interval in each of the service-level increments PERIOD1 through PERIOD9, as defined on the Call Center Administration: Split/Skill Call Profile window. If call profiles are not set, the data is stored in the first interval (ABNCALLS1). ABNCALLS10 counts calls that abandoned after PERIOD9. The data in this column maps to the HSPLIT.ABNCALLS8 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'ABN_CALLS8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of CALLSOFFERED that are abandoned during the collection interval in each of the service-level increments PERIOD1 through PERIOD9, as defined on the Call Center Administration: Split/Skill Call Profile window. If call profiles are not set, the data is stored in the first interval (ABNCALLS1). ABNCALLS10 counts calls that abandoned after PERIOD9. The data in this column maps to the HSPLIT.ABNCALLS9 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'ABN_CALLS9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of CALLSOFFERED that are abandoned during the collection interval in each of the service-level increments PERIOD1 through PERIOD9, as defined on the Call Center Administration: Split/Skill Call Profile window. If call profiles are not set, the data is stored in the first interval (ABNCALLS1). ABNCALLS10 counts calls that abandoned after PERIOD9. The data in this column maps to the HSPLIT.ABNCALLS10 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'ABN_CALLS10'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of calls that queued to this split/skill as a nonprimary split/skill and whose disposition was recorded in another split/skill as answered, abandoned, outflowed, busy, or forced disconnect. The DEQUECALLS item is available with the Vectoring feature. The data in this column maps to the HSPLIT.DEQUECALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'DE_QUE_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time that DEQUECALLS waited in this split/skill queue before dequeuing. The DEQUETIME item is available with the Vectoring feature. The data in this column maps to the HSPLIT.DEQUETIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'DE_QUE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of CALLSOFFERED that are given a busy signal by the communication server.This occurs when the "busy" vector command is executed while the call is queued to this split/skill and this is the primary split/skill to which the call is queued, or if a call queued to this split/skill forwards to another split/skill whose queue is full. A busy is given when a nonvector-controlled split has: a full queue, no queue and no available agents, or no agents that are staffed. This is a cumulative item. The data in this column maps to the HSPLIT.BUSYCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'BUSY_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time that callers wait in queue before hearing a busy tone for all BUSYCALLS. The data in this column maps to the HSPLIT.BUSYTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'BUSY_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of CALLSOFFERED that executed the "disconnect vector command. DISCCALLS also includes calls that are disconnected by the communication server when the vector disconnect timer expires. The data in this column maps to the HSPLIT.DISCCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'DISC_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time that all DISCCALLS spent in this splits/skills queue. If the call is disconnected because the vector disconnect timer expires, this is the time until the call is disconnected by the communication server. The data in this column maps to the HSPLIT.DISCTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'DISC_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of CALLSOFFERED that are redirected to another destination while queued to this split/skill. This can happen under different circumstances, depending on the communication server release and on whether the Vectoring feature is active or not. The data in this column maps to the HSPLIT.OUTFLOWCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'OUT_FLOW_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time that all OUTFLOWCALLS wait in queue or ringing before being redirected. The data in this column maps to the HSPLIT.OUTFLOWTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'OUT_FLOW_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of OUTFLOWCALLS that are redirected to a destination outside the communication server. The data in this column maps to the HSPLIT.INTERFLOWCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'INTERFLOW_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'On communication servers with the Vectoring feature, LOWCALLS is the number of ACDCALLS with low priority that are answered by this split/skill. On communication servers without the Vectoring feature, LOWCALLS is the number of ACDCALLS with no priority that are answered by this split/skill. The data in this column maps to the HSPLIT.LOWCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'LOW_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'On communication servers with the Vectoring feature, MEDCALLS is the number of ACDCALLS with medium priority that are answered by agents in the split/skill. For example, answered calls that are queued to the split/skill with medium priority by a "queue to" or "check" vector command. MEDCALLS includes calls that are queued to a split/skill with no priority using the "route to" or "messaging split" vector commands, calls that queued directly to a non-vector-controlled split with no priority, and calls that intraflowed to a split/skill with no priority. On communication servers without the Vectoring feature, MEDCALLS is the number of ACDCALLS with the priority set to yes that are answered by agents in the split/skill. The data in this column maps to the HSPLIT.MEDCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'MED_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of ACDCALLS with high priority that are answered by agents in this split/skill, for example, answered calls that are queued to the split/skill with high priority by a "queue to" or "check" vector command. This includes calls that are queued to a split/skill with priority using the "route to" or "messaging split/skill" vector commands, and calls that queued directly to a split/skill with priority. Priority in these cases is determined by the class of restriction of the originator, which is an agent, an extension, a trunk group or a VDN. The HIGHCALLS item is available with the Vectoring feature. The data in this column maps to the HSPLIT.HIGHCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'HIGH_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of ACDCALLS with top priority that are answered by agents in this split/skill. The TOPCALLS item is available with the Vectoring feature. The data in this column maps to the HSPLIT.TOPCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'TOP_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of ACDCALLS that are answered by an agent within the predefined acceptable service level (SERVICELEVEL) as defined on the Call Center Administration: Split/Skill Call Profile window. The data in this column maps to the HSPLIT.ACCEPTABLE column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'ACCEPTABLE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of seconds within which calls must be answered or connected in order to be considered acceptable. The acceptable service level is defined on the Call Center Administration: Split/Skill Call Profile window. The data in this column maps to the HSPLIT.SERVICELEVEL column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'SERVICE_LEVEL'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length, in seconds, of each service level increment as defined in the Call Center Administration: Split/Skill Call Profile window. Each increment represents a progressively longer wait time. CMS counts answered or abandoned calls that wait beyond the last increment, which is PERIOD9, in ACDCALLS10 or ABNCALLS10, as appropriate. The data in this column maps to the HSPLIT.PERIOD1 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'PERIOD1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length, in seconds, of each service level increment as defined in the Call Center Administration: Split/Skill Call Profile window. Each increment represents a progressively longer wait time. CMS counts answered or abandoned calls that wait beyond the last increment, which is PERIOD9, in ACDCALLS10 or ABNCALLS10, as appropriate. The data in this column maps to the HSPLIT.PERIOD2 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'PERIOD2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length, in seconds, of each service level increment as defined in the Call Center Administration: Split/Skill Call Profile window. Each increment represents a progressively longer wait time. CMS counts answered or abandoned calls that wait beyond the last increment, which is PERIOD9, in ACDCALLS10 or ABNCALLS10, as appropriate. The data in this column maps to the HSPLIT.PERIOD3 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'PERIOD3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length, in seconds, of each service level increment as defined in the Call Center Administration: Split/Skill Call Profile window. Each increment represents a progressively longer wait time. CMS counts answered or abandoned calls that wait beyond the last increment, which is PERIOD9, in ACDCALLS10 or ABNCALLS10, as appropriate. The data in this column maps to the HSPLIT.PERIOD4 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'PERIOD4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length, in seconds, of each service level increment as defined in the Call Center Administration: Split/Skill Call Profile window. Each increment represents a progressively longer wait time. CMS counts answered or abandoned calls that wait beyond the last increment, which is PERIOD9, in ACDCALLS10 or ABNCALLS10, as appropriate. The data in this column maps to the HSPLIT.PERIOD5 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'PERIOD5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length, in seconds, of each service level increment as defined in the Call Center Administration: Split/Skill Call Profile window. Each increment represents a progressively longer wait time. CMS counts answered or abandoned calls that wait beyond the last increment, which is PERIOD9, in ACDCALLS10 or ABNCALLS10, as appropriate. The data in this column maps to the HSPLIT.PERIOD6 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'PERIOD6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length, in seconds, of each service level increment as defined in the Call Center Administration: Split/Skill Call Profile window. Each increment represents a progressively longer wait time. CMS counts answered or abandoned calls that wait beyond the last increment, which is PERIOD9, in ACDCALLS10 or ABNCALLS10, as appropriate. The data in this column maps to the HSPLIT.PERIOD7 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'PERIOD7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length, in seconds, of each service level increment as defined in the Call Center Administration: Split/Skill Call Profile window. Each increment represents a progressively longer wait time. CMS counts answered or abandoned calls that wait beyond the last increment, which is PERIOD9, in ACDCALLS10 or ABNCALLS10, as appropriate. The data in this column maps to the HSPLIT.PERIOD8 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'PERIOD8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length, in seconds, of each service level increment as defined in the Call Center Administration: Split/Skill Call Profile window. Each increment represents a progressively longer wait time. CMS counts answered or abandoned calls that wait beyond the last increment, which is PERIOD9, in ACDCALLS10 or ABNCALLS10, as appropriate. The data in this column maps to the HSPLIT.PERIOD9 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'PERIOD9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The maximum number of simultaneous calls that are in this split/skill queue during the collection interval.. The data in this column maps to the HSPLIT.MAXINQUEUE column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'MAX_IN_QUEUE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The maximum length of time that a call, recorded during the collection interval, waited in queue and ringing before an agent answered in this split/skill, the caller abandoned, or the call was redirected, received a busy signal, or was disconnected. The data in this column maps to the HSPLIT.MAXOCWTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'MAX_OCW_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of calls that queued to the split/skill and that completed during the interval. This does not include calls that could not queue to the split/skill because the queue was full or there was no queue. CALLSOFFERED = ACDCALLS + ABNCALLS + BUSYCALLS + DISCCALLS + OUTFLOWCALLS + DEQUECALLS. The data in this column maps to the HSPLIT.CALLSOFFERED column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'CALLS_OFFERED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'An indication of whether service level increments PERIOD1 through PERIOD9 changed during the collection interval. Service level is defined on the Call Center Administration: Split/Skill Call Profile window. Valid values for PERIODCHG are 0, which means that no change was made, and 1, which means that a change was made. The data in this column maps to the HSPLIT.PERIODCHG column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'PERIOD_CHG'
GO
EXEC sp_addextendedproperty N'MS_Description', N'An indication of whether the service level was changed during the collection interval. Valid values for SVCLEVELCHG are 0, which means that no change was made, and 1, which means that a change was made. The data in this column maps to the HSPLIT.SVCLEVELCHG column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'SVC_LEVEL_CHG'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in the ringing state for calls to this split/skill. If the agent changes work modes or answers/makes another call instead of answering the ringing call, I_RINGTIME will stop accumulating. RINGTIME is the length of time that the caller spends ringing and is independent of agent activity. With forced multiple call handling if an ACD call rings at the agents telephone while the agent is talking on another call, I_RINGTIME does not accumulate. I_RINGTIME includes I_RINGTIME_R1 and I_RINGTIME_R2 when the reserve agents are active. The data in this column maps to the HSPLIT.I_RINGTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_RING_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time that calls for this split/skill spend ringing at agent positions independent of the final disposition and other agent activity. I_RINGTIME is the time that agents spend with ringing calls and is affected by other agent activity. RINGTIME is the time the caller spends ringing at the agent station. The data in this column maps to the HSPLIT.RINGTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'RING_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of split/skill calls that rang at agent positions. RINGCALLS includes NOANSREDIR.. The data in this column maps to the HSPLIT.RINGCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'RING_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of split/skill or direct agent ABNCALLS that are abandoned while ringing at an agent position. The data in this column maps to the HSPLIT.ABNRINGCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'ABN_RING_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of ABNCALLS that are placed by an adjunct, that is, the number of outbound predictive dialing calls that are abandoned by the far end. O_ABNCALLS is a subset of ABNCALLS. Available for outbound calls with the ASAI feature. The data in this column maps to the HSPLIT.O_ABNCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'O_ABN_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of outbound calls that queued to this split/skill and are not answered or abandoned as ACD split/skill calls. O_OTHERCALLS includes forced busy calls and calls with unknown dispositions. The O_OTHERCALLS item is available with the ASAI feature. The data in this column maps to the HSPLIT.O_OTHERCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'O_OTHER_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of inbound extension calls answered by ACW agents, who entered that work mode as a result of direct agent calls from this split/skill. Requires a communication server with the ASAI or EAS feature for direct agent calling. The data in this column maps to the HSPLIT.DA_ACWINCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'DA_ACW_IN_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time that agents spent on inbound extension calls that they answered while in ACW for direct agent ACD calls that queued through this split/skill. DA_ACWINTIME is available with the ASAI or EAS feature for direct agent calling. The data in this column maps to the HSPLIT.DA_ACWINTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'DA_ACW_IN_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Number of outbound extension calls made by ACW agents, who entered that work mode as a result of direct agent calls from this split/skill. Requires a communication server with the ASAI or EAS feature for direct agent calling. The data in this column maps to the HSPLIT.DA_ACWOCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'DA_ACW_O_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time that agents talk on outbound extension calls that they place while in ACW a direct agent ACD call. The DA_ACWOTIME item is available with the ASAI or EAS feature. The data in this column maps to the HSPLIT.DA_ACWOTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'DA_ACW_O_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of split/skill ACD calls that rang at agent positions in the split/skill and then were automatically redirected back to the split/skill queue or to a VDN by the Redirection on No Answer feature because they were not answered. When a call is requeued to the same split/skill by the Redirection on No Answer feature, it is counted as an outflow from the split/skill and an inflow to the same split/skill. This is not true for calls that are redirected to a VDN by the Redirection on No Answer feature, rather than redirecting the call back to the same split/skill. Such calls count as outflows from the original split or skill, but do not count as inflows to the next split/skill to which they are queued through the new VDN. It is also counted as a NOANSREDIR call and so can be subtracted out from the outflows and from the inflows to calculate the number of outflows and inflows that are not due to requeuing the call to the same split. The data in this column maps to the HSPLIT.NOANSREDIR column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'NO_ANS_REDIR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'An indication of whether data is complete for this collection interval. Data is incomplete whenever the link goes down and whenever tracking is aborted for calls, because of the trunk going maintenance busy with a call active, protocol failures with data collection active, or when split/skill or VDN call profile is changed with data collection active. Valid values for the INCOMPLETE item are 1, which means that the data is incomplete, and 0, which means that the data is complete. The value in the daily, weekly, and monthly tables indicates the number of incomplete intervals in the day, week, or month. The data in this column maps to the HSPLIT.INCOMPLETE column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'INCOMPLETE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of AUXOUTCALLS that agents in the split/skill placed with at least one split/skill ACD call for this split/skill on hold. On Avaya communication servers with multiple call handling and agents in multiple skills, the call is recorded for the skill of the last ACD call that the agent put on hold. ACDAUXOUTCALLS includes calls placed to transfer or conference the ACD call. The data in this column maps to the HSPLIT.ACDAUXOUTCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'ACD_AUX_OUT_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents spent dialing and talking on AUXOUT calls with a split/skill ACD call for this split/skill on hold. In a multiple call handling environment with agents in multiple skills, the ACD call for this skill must have been the last ACD call to have been put on hold before the agent placed the AUXOUT call. The data in this column maps to the HSPLIT.I_ACDAUX_OUTTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_ACD_AUX_OUT_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were talking on AUXIN calls with a split/skill ACD call on hold where SPLIT is OLDEST_LOGON. The data in this column maps to the HSPLIT.I_ACDAUXINTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_ACD_AUX_IN_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents spent in the OTHER state with a split/skill ACD call on hold. Instances of the OTHER state include, dialing an outgoing call, a ringing extension call, or having calls on hold and with no other state selected. The data in this column maps to the HSPLIT.I_ACDOTHERTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_ACD_OTHER_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of split/skill ACD calls for which talk time is less than the value of the phantom-abandon call timer. The data in this column maps to the HSPLIT.PHANTOMABNS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'PHANTOM_ABNS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of calls offered to this split/skill that do not abandon and are not answered by an ACD agent for this split/skill. OTHERCALLS = BUSYCALLS + DISCCALLS + OUTFLOWCALLS + DEQUEUECALLS. The data in this column maps to the HSPLIT.OTHERCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'OTHER_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time that OTHERCALLS wait in queue until the disposition is known and the call left the split/skill. OTHERTIME relates to time for OTHERCALLS and is not related to I_OTHERTIME, which is the time agents that spend in the OTHER state. OTHERTIME includes BUSYTIME, DEQUETIME, DISCTIME, and OUTFLOWTIME. The data in this column maps to the HSPLIT.OTHERTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'OTHER_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of ABNCALLS for which the time-to-abandon was less than or equal to the administered SERVICELEVEL for this split/skill. The data in this column maps to the HSPLIT.SLVLABNS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'SLVL_ABNS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of OUTFLOWCALLS for which the time-to-outflow was less than or equal to administered SERVICELEVEL for this split/skill. The data in this column maps to the HSPLIT.SLVLOUTFLOWS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'SLVL_OUT_FLOWS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of calls that reached this Split/Skill during this interval. The data in this column maps to the HSPLIT.I_ARRIVED column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_ARRIVED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for reason code 0 in this split/skill. This includes time on extension calls from this AUX state. For communication servers with AUX reason codes active, this represents time agents spent in "system" AUX. For communication servers without the EAS feature and AUX reason codes active and prior to R5,I_AUXTIME0 is the same as I_AUXTIME. The data in this column maps to the HSPLIT.IAUXTIME0 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 1 through 9 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.IAUXTIME1 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 1 through 9 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.IAUXTIME2 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 1 through 9 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.IAUXTIME3 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 1 through 9 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.IAUXTIME4 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 1 through 9 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.IAUXTIME5 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 1 through 9 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.IAUXTIME6 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 1 through 9 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.IAUXTIME7 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 1 through 9 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.IAUXTIME8 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 1 through 9 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.IAUXTIME9 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that the agent spent talking on direct agent ACD calls queued through this split/skill. I_DA_ACDTIME is a subset of I_OTHERTIME. The I_DA_ACDTIME item is available with the ASAI or EAS feature. The data in this column maps to the HSPLIT.I_DA_ACDTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_DA_ACD_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time that agents spent in ACW for direct agent ACD calls that queued through this split/skill. I_DA_ACWTIME is a subset of I_OTHERTIME. The I_DA_ACWTIME is available with the ASAI or EAS feature. The data in this column maps to the HSPLIT.I_DA_ACWTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_DA_ACW_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time that top agents in this split/skill were available to receive calls for this split/skill. The I_TAVAILTIME item is available with the EAS feature. The data in this column maps to the HSPLIT.I_TAVAILTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_T_AVAIL_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time that top agents in this split/skill were in AUX mode. This includes time on AUXIN or AUXOUT calls that were received or placed without an ACD call on hold. Time on AUXIN or AUXOUT calls with an ACD call on hold is tracked in I_ACDAUXINTIME and I_ACDAUX_OUTTIME. The I_TAUXTIME item is available with the EAS feature. The data in this column maps to the HSPLIT.I_TAUXTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_T_AUX_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The maximum number of top agents who are staffed during the collection interval in this split/skill. This item is available with the EAS feature. The data in this column maps to the HSPLIT.MAXTOP column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'MAXTOP'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time that the skill spent under all administered overload thresholds.The I_NORMTIME item is available on Avaya communication servers with the EAS feature. The data in this column maps to the HSPLIT.I_NORMTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_NORM_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time that the skill spent in overload threshold 1. The data in this column maps to the HSPLIT.I_OL1TIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_OL1_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time, that the skill spent in overload threshold 2. The data in this column maps to the HSPLIT.I_OL2TIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_OL2_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time that top agents spend in the OTHER state. The I_TOTHERTIME item is available with the EAS feature. The data in this column maps to the HSPLIT.I_TOTHERTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_T_OTHER_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The maximum total staffed agent percentages that are allocated to a skill. The MAX_TOT_PERCENTS item is available on Avaya communication servers with the EAS feature. The data in this column maps to the HSPLIT.MAX_TOT_PERCENTS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'MAX_TOT_PERCENTS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of ACDCALLS calls that are answered by a Reserve 1 Agent in the split/skill. The data in this column maps to the HSPLIT.ACDCALLS_R1 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'ACD_CALLS_R1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of ACDCALLS calls that are answered by a Reserve 2 Agent in the split/skill. The data in this column maps to the HSPLIT.ACDCALLS_R2 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'ACD_CALLS_R2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'I_ACDTIME_R1 is available with Advocate Service Level Supervisor working with CMS R3V11 or later.. The data in this column maps to the HSPLIT.I_ACDTIME_R1 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_ACD_TIME_R1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The time during the collection interval that Reserve Level 2 agents were on ACD calls for this skill. This includes time on outgoing ACD calls placed by an adjunct. Reserve Level 2 agents will continue to accumulate I_ACDTIME_R2 if the skill returns to Normal while an ACD call is active. The data in this column maps to the HSPLIT.I_ACDTIME_R2 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_ACD_TIME_R2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The time during the collection interval that Reserve Level 1 agents were in ACW in this skill, either associated with a skill ACD call or not associated with a call. This item includes the time that agents in ACW spent on inbound extension calls or outbound extension calls. (ACWINTIME and ACWOUTIME are included and not broken out in separate R1 database items.) Reserve Level 1 Agents will continue to accumulate I_ACWTIME_R1 if the skill returns to Normal while the agent is in ACW or an ACD call and goes into ACW upon completing the call. The data in this column maps to the HSPLIT.I_ACWTIME_R1 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_ACW_TIME_R1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The time during the collection interval that Reserve Level 2 agents were in ACW in this skill, either associated with a skill ACD call or not associated with a call. This item includes the time that agents in ACW spent on inbound extension calls or outbound extension calls. (ACWINTIME and ACWOUTIME are included and not broken out into separate R2 database items.) Reserve Level 2 Agents will continue to be tracked in I_ACWTIME_R2 if the skill returns to Normal while the agent is in ACW or on an ACD call and goes into ACW upon completing the call.. The data in this column maps to the HSPLIT.I_ACWTIME_R2 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_ACW_TIME_R2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The time during the collection interval that Reserve Level 1 agents were in the ringing state for calls to this skill. Reserve Level 1 agents will continue to accumulate I_RINGTIME_R1 if the skill returns to Normal while a call is ringing. I_RINGTIME_R1 is available with Advocate Service Level Supervisor. The data in this column maps to the HSPLIT.I_RINGTIME_R1 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_RING_TIME_R1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The time during the collection interval that Reserve Level 2 agents were in the ringing state for calls to this skill. Reserve Level 2 agents will continue to accumulate I_RINGTIME_R2 if the skillreturns to Normal while a call is ringing.I_RINGTIME_R2 is available with Advocate Service Level Supervisor. The data in this column maps to the HSPLIT.I_RINGTIME_R2 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_RING_TIME_R2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The time during the collection interval that Reserve Level 1 agents were doing other work while the skill is in overload 1. I_OTHERTIME_R1 is collected for the time period after the link to the communication server comes up or after the agent logs in and before the CMS receives notification of the agent''s state from the communication server. Other work includes: while in Auto-In or Manual-In mode, the agent put any call on hold and performed no further action; the agent had a direct agent call ringing, was on a direct agent call or in ACW for a direct agent call; the agent dialed to place a call or activate a feature; or an extension-in call rang at the agent''s terminal with no other activity. Also includes the time Reserve agents were logged into multiple skills and doing work for a skill other than this one (with an ACD call ringing, talking on an ACD call, or in ACW for a skill other than this one.) If the skill goes from overload 1 to Normal the agent will stop accumulating I_OTHERTIME_R1 and start accumulating I_OTHERSTBYTIME_R1.I_OTHERTIME_R1 does not include I_OTHERSTBYTIME_R1.I_OTHERTIME_R1 is available with Advocate Service Level Supervisor. The data in this column maps to the HSPLIT.I_OTHERTIME_R1 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_OTHER_TIME_R1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The time during the collection interval that Reserve Level 2 agents were doing other work while the skill is in overload 2. I_OTHERTIME_R2 is collected for the time period after the link to the communication server comes up or after the agent logs in and before the CMS receives notification of the agent''s state from the communication server. Other work includes: while in Auto-In or Manual-In mode, the agent put any call on hold and performed no further action; the agent had a direct agent call ringing, was on a direct agent call or in ACW for a direct agent call; the agent dialed to place a call or activate a feature; or an extension-in call rang at the agent''s terminal with no other activity. Also includes the time Reserve agents were logged into multiple skills and doing work for a skill other than this one (with an ACD call ringing, talking on an ACD call, or in ACW for a skill other than this one.) If the skill goes from overload 2 to overload 1 the agent will stop accumulating I_OTHERTIME_R2 and start accumulating I_OTHERSTBYTIME_R2. I_OTHERTIME_R2 does not include I_OTHERSTBYTIME_R2.I_OTHERTIME_R2 is available with Advocate Service Level Supervisor. The data in this column maps to the HSPLIT.I_OTHER_TIME_R2 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_OTHER_TIME_R2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The time during the collection interval that Reserve Level 1 agents spent in AUX Work for this skill while the skill was in overload 1. Includes all AUX time including time on extension calls from the AUX state. Unlike I_AUXTIME, this item is not broken down into separate items for call direction, or reason codes. If the skill goes from overload 1 to Normal the agent will stop accumulating I_AUXTIME_R1 and start accumulating I_AUXSTBYTIME_R1.I_AUXTIME_R1 is available with Advocate Service Level Supervisor. The data in this column maps to the HSPLIT.I_AUXTIME_R1 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME_R1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The time during the collection interval that Reserve Level 2 agents were in AUX in this skill while the skill was in overload 2. Includes all AUX time including time on extension calls from the AUX state. Unlike I_AUXTIME, this item is not broken down into separate items for call direction, or reason codes. If the skill goes from overload 2 to overload 1 the agent will stop accumulating I_AUXTIME_R2 and start accumulating I_AUXSTBYTIME_R2.I_AUXTIME_R2 is available with Advocate Service Level Supervisor. The data in this column maps to the HSPLIT.I_AUXTIME_R2 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME_R2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The time during the collection interval that Reserve Level 1 agents were logged into this skill and in standby. I_OTHERSTBYTIME_R1 accumulates while the skill (for which the agent is Reserve Level 1) is Normal. The data in this column maps to the HSPLIT.I_OTHERSTBYTIME_R1 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_OTHER_STBY_TIME_R1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The time during the collection interval that Reserve Level 2 agents were staffed in this skill and in standby. I_OTHERSTBYTIME_R2 accumulated while the skill (for which the agent is Reserve Level 2) is not in overload 2. The data in this column maps to the HSPLIT.I_OTHERSTBYTIME_R2 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_OTHER_STBY_TIME_R2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The time during the collection interval that Reserve Level 1 agents were in AUX Work and in standby because the skill is not in overload 1 or 2. Unlike I_AUXTIME, this item is not broken down into separate items, for call direction, or reason codes. If the skill goes from Normal to overload 1 the agent will stop accumulating I_AUXSTBYTIME_R1 and start accumulating I_AUXTIME_R1. The data in this column maps to the HSPLIT.I_AUXSTBYTIME_R1 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_STBY_TIME_R1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The time during the collection interval that Reserve Level 2 agents were in AUX Work and in standby because the skill is not in overload 2. Unlike I_AUXTIME, this item is not broken down into separate items, for call direction, or reason codes. If the skill goes from overload 1 to overload 2 the agent will stop accumulating I_AUXSTBYTIME_R2 and start accumulating I_AUXTIME_R2. The data in this column maps to the HSPLIT.I_AUXSTBYTIME_R2 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_STBY_TIME_R2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the amount of time that a skill has the potential of not meeting the assigned target service level percentage and no agents were auto-reserved. The data in this column maps to the HSPLIT.I_BEHINDTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_BEHIND_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the time during the collection interval that at least one agent was auto-reserved for this skill. The data in this column maps to the HSPLIT.I_AUTORESERVETIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUTO_RESERVE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the percentage of the target service level that is specified on the Avaya communication server for a selected split/skill. The archiving process that transforms data for larger time intervals, such as daily to weekly, will record the maximum value of TARGETPERCENT. The data in this column maps to the HSPLIT.TARGETPERCENT column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'TARGET_PERCENT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item indicates if the target service level percentage was modified during the collection interval. Valid values for this field are 0, indicating that no change was made, and 1, indicating that a change was made. The data in this column maps to the HSPLIT.TARGETPCTCHG column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'TARGET_PCT_CHG'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the number of target seconds specified on the Avaya communication server for the split/skill target service level. The archiving process that transforms data for larger time intervals, such as daily to weekly, will record the maximum value of TARGETSECONDS. The data in this column maps to the HSPLIT.TARGETSECONDS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'TARGET_SECONDS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item indicates if the number of target seconds was modified during the collection interval.Valid values for this field are 0, indicating that no change was made, and 1, indicating that a change was made. This is an administrative item.. The data in this column maps to the HSPLIT.TARGETSECCHG column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'TARGET_SEC_CHG'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item represents the number of ACD calls that were answered within the administered target service level (TARGETSECONDS).. The data in this column maps to the HSPLIT.TARGETACDCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'TARGET_ACD_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item represents the number of abandoned calls that occurred within the administered target service level (TARGETSECONDS).. The data in this column maps to the HSPLIT.TARGETABNS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'TARGET_ABNS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item represents the number of calls that outflowed within the administered target service level (TARGETSECONDS). This information is recorded for all splits. The data in this column maps to the HSPLIT.TARGETOUTFLOWS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'TARGET_OUT_FLOWS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of calls delivered to the agent when the agent is interrupted in an interruptible AUX state. It is counted against the skill the call is delivered to.. The data in this column maps to the HSPLIT.INTRDELIVERIES column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'INTR_DELIVERIES'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of calls delivered to agents in the skill upon agent surplus condition. The data in this column maps to the HSPLIT.AGSURPDELIVERIES column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'AG_SURP_DELIVERIES'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of calls delivered to preferred agents in the skill upon agent surplus condition. A preferred agent is an agent with a skill level for the skill matches the level specified in the check vector command. The data in this column maps to the HSPLIT.AGSURPPREFCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'AG_SURP_PREF_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of calls delivered to not preferred agents in the skill upon agent surplus condition. A preferred agent is an agent with a skill level for the skill matches the level specified in the check vector command. The data in this column maps to the HSPLIT.AGSURPNPREFCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'AG_SURP_NPREF_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of calls delivered to agents in the skill upon call surplus condition. The data in this column maps to the HSPLIT.CALLSURPDELIVERIES column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'CALL_SURP_DELIVERIES'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 10 through 99 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.I_AUXTIME10     column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME10'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 10 through 99 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.I_AUXTIME11     column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME11'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 10 through 99 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.I_AUXTIME12     column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME12'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 10 through 99 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.I_AUXTIME13     column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME13'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 10 through 99 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.I_AUXTIME14     column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME14'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 10 through 99 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.I_AUXTIME15     column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME15'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 10 through 99 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.I_AUXTIME16     column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME16'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 10 through 99 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.I_AUXTIME17     column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME17'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 10 through 99 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.I_AUXTIME18     column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME18'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 10 through 99 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.I_AUXTIME19     column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME19'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 10 through 99 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.I_AUXTIME20     column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME20'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 10 through 99 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.I_AUXTIME21     column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME21'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 10 through 99 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.I_AUXTIME22     column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME22'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 10 through 99 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.I_AUXTIME23     column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME23'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 10 through 99 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.I_AUXTIME24     column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME24'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 10 through 99 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.I_AUXTIME25     column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME25'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 10 through 99 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.I_AUXTIME26     column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME26'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 10 through 99 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.I_AUXTIME27     column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME27'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 10 through 99 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.I_AUXTIME28     column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME28'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 10 through 99 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.I_AUXTIME29     column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME29'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 10 through 99 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.I_AUXTIME30     column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME30'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 10 through 99 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.I_AUXTIME31     column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME31'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 10 through 99 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.I_AUXTIME32     column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME32'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 10 through 99 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.I_AUXTIME33     column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME33'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 10 through 99 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.I_AUXTIME34     column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME34'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 10 through 99 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.I_AUXTIME35     column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME35'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 10 through 99 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.I_AUXTIME36     column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME36'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 10 through 99 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.I_AUXTIME37     column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME37'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 10 through 99 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.I_AUXTIME38     column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME38'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 10 through 99 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.I_AUXTIME39     column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME39'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 10 through 99 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.I_AUXTIME40     column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME40'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 10 through 99 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.I_AUXTIME41     column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME41'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 10 through 99 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.I_AUXTIME42     column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME42'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 10 through 99 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.I_AUXTIME43     column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME43'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 10 through 99 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.I_AUXTIME44     column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME44'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 10 through 99 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.I_AUXTIME45     column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME45'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 10 through 99 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.I_AUXTIME46     column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME46'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 10 through 99 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.I_AUXTIME47     column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME47'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 10 through 99 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.I_AUXTIME48     column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME48'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 10 through 99 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.I_AUXTIME49     column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME49'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 10 through 99 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.I_AUXTIME50     column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME50'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 10 through 99 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.I_AUXTIME51     column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME51'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 10 through 99 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.I_AUXTIME52     column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME52'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 10 through 99 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.I_AUXTIME53     column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME53'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 10 through 99 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.I_AUXTIME54     column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME54'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 10 through 99 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.I_AUXTIME55     column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME55'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 10 through 99 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.I_AUXTIME56     column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME56'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 10 through 99 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.I_AUXTIME57     column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME57'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 10 through 99 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.I_AUXTIME58     column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME58'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 10 through 99 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.I_AUXTIME59     column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME59'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 10 through 99 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.I_AUXTIME60     column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME60'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 10 through 99 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.I_AUXTIME61     column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME61'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 10 through 99 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.I_AUXTIME62     column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME62'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 10 through 99 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.I_AUXTIME63     column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME63'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 10 through 99 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.I_AUXTIME64     column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME64'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 10 through 99 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.I_AUXTIME65     column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME65'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 10 through 99 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.I_AUXTIME66     column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME66'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 10 through 99 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.I_AUXTIME67     column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME67'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 10 through 99 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.I_AUXTIME68     column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME68'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 10 through 99 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.I_AUXTIME69     column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME69'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 10 through 99 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.I_AUXTIME70     column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME70'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 10 through 99 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.I_AUXTIME71     column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME71'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 10 through 99 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.I_AUXTIME72     column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME72'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 10 through 99 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.I_AUXTIME73     column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME73'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 10 through 99 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.I_AUXTIME74     column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME74'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 10 through 99 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.I_AUXTIME75     column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME75'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 10 through 99 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.I_AUXTIME76     column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME76'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 10 through 99 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.I_AUXTIME77     column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME77'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 10 through 99 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.I_AUXTIME78     column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME78'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 10 through 99 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.I_AUXTIME79     column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME79'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 10 through 99 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.I_AUXTIME80     column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME80'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 10 through 99 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.I_AUXTIME81     column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME81'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 10 through 99 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.I_AUXTIME82     column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME82'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 10 through 99 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.I_AUXTIME83     column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME83'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 10 through 99 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.I_AUXTIME84     column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME84'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 10 through 99 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.I_AUXTIME85     column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME85'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 10 through 99 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.I_AUXTIME86     column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME86'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 10 through 99 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.I_AUXTIME87     column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME87'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 10 through 99 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.I_AUXTIME88     column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME88'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 10 through 99 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.I_AUXTIME89     column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME89'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 10 through 99 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.I_AUXTIME90     column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME90'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 10 through 99 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.I_AUXTIME91     column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME91'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 10 through 99 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.I_AUXTIME92     column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME92'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 10 through 99 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.I_AUXTIME93     column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME93'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 10 through 99 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.I_AUXTIME94     column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME94'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 10 through 99 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.I_AUXTIME95     column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME95'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 10 through 99 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.I_AUXTIME96     column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME96'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 10 through 99 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.I_AUXTIME97     column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME97'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 10 through 99 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.I_AUXTIME98     column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME98'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that agents were in AUX for each reason code 10 through 99 in this skill. This includes time on extension calls from each AUX state. This feature is available on Avaya communication servers with the EAS and AUX Reason Code feature. The data in this column maps to the HSPLIT.I_AUXTIME99     column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'I_AUX_TIME99'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a calculated field for use to calculate the calculate the AVG_TALK_TIME_IN and AVG_TALK_TIME_IN_SUM.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'TALK_TIME_IN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a calculated field for calculating AVG_TALK_TIME_IN, Extension in calls average talk time .', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'TALK_TIME_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a calculated field for use to calculate the calculate the AVG_TALK_TIME_OUT and AVG_TALK_TIME_OUT_SUM.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'EXT_TALK_TIME_OUT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a calculated field for use to calculate the calculate the AVG_TALK_TIME_OUT and AVG_TALK_TIME_OUT_SUM.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'EXT_TALK_CALLS_OUT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a calculated field for help in calculating the number of calls answered for main split/skill calls .', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_SKILLGROUP_INTERVAL', 'COLUMN', N'MAIN_ACD_CALLS'
GO
GRANT SELECT
	ON [dbo].[TB_SUM_CMS_SKILLGROUP_INTERVAL]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_SUM_CMS_SKILLGROUP_INTERVAL]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_SUM_CMS_SKILLGROUP_INTERVAL]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_SUM_CMS_SKILLGROUP_INTERVAL] SET (LOCK_ESCALATION = TABLE)
GO
