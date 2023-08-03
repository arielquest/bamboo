SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_SUM_CMS_AGENT_INTERVAL] (
		[PARTITION_URN]            [int] NOT NULL,
		[PARTITION_GLOBAL_URN]     [bigint] NOT NULL,
		[PARTITION_ID]             [int] NOT NULL,
		[CLUSTER_RESOURCE_URN]     [int] NOT NULL,
		[AGENT_URN]                [int] NOT NULL,
		[ACD_URN]                  [int] NOT NULL,
		[SKILLGROUP_URN]           [int] NOT NULL,
		[DATE_UTC_URN]             [int] NOT NULL,
		[TIME_UTC_URN]             [smallint] NOT NULL,
		[DB_DATETIME]              [datetime] NULL,
		[ABN_CALLS]                [int] NULL,
		[ABN_TIME]                 [int] NULL,
		[ACCEPTED_INTRS]           [int] NULL,
		[ACD_RELEASE]              [int] NULL,
		[ACD_AUX_OUT_CALLS]        [int] NULL,
		[ACD_CALLS]                [int] NULL,
		[ACD_CALLS_R1]             [int] NULL,
		[ACD_CALLS_R2]             [int] NULL,
		[ACD_TIME]                 [int] NULL,
		[ACW_IN_CALLS]             [int] NULL,
		[ACW_IN_TIME]              [int] NULL,
		[ACW_OUT_ADJ_CALLS]        [int] NULL,
		[ACW_OUT_CALLS]            [int] NULL,
		[ACW_OUT_OFF_CALLS]        [int] NULL,
		[ACW_OUT_OFF_TIME]         [int] NULL,
		[ACW_OUT_TIME]             [int] NULL,
		[ACW_TIME]                 [int] NULL,
		[ANS_RING_TIME]            [int] NULL,
		[ASSISTS]                  [int] NULL,
		[AUX_IN_CALLS]             [int] NULL,
		[AUX_IN_TIME]              [int] NULL,
		[AUX_OUT_ADJ_CALLS]        [int] NULL,
		[AUX_OUT_CALLS]            [int] NULL,
		[AUX_OUT_OFF_CALLS]        [int] NULL,
		[AUX_OUT_OFF_TIME]         [int] NULL,
		[AUX_OUT_TIME]             [int] NULL,
		[CONFERENCE]               [int] NULL,
		[DA_ABN_CALLS]             [int] NULL,
		[DA_ABN_TIME]              [int] NULL,
		[DA_ACD_CALLS]             [int] NULL,
		[DA_ACD_TIME]              [int] NULL,
		[DA_ACW_IN_CALLS]          [int] NULL,
		[DA_ACW_IN_TIME]           [int] NULL,
		[DA_ACW_OADJ_CALLS]        [int] NULL,
		[DA_ACW_O_CALLS]           [int] NULL,
		[DA_ACW_O_OFF_CALLS]       [int] NULL,
		[DA_ACW_O_OFF_TIME]        [int] NULL,
		[DA_ACW_O_TIME]            [int] NULL,
		[DA_ACW_TIME]              [int] NULL,
		[DA_ANS_TIME]              [int] NULL,
		[DA_OTHER_CALLS]           [int] NULL,
		[DA_OTHER_TIME]            [int] NULL,
		[DA_RELEASE]               [int] NULL,
		[EVENT1]                   [int] NULL,
		[EVENT2]                   [int] NULL,
		[EVENT3]                   [int] NULL,
		[EVENT4]                   [int] NULL,
		[EVENT5]                   [int] NULL,
		[EVENT6]                   [int] NULL,
		[EVENT7]                   [int] NULL,
		[EVENT8]                   [int] NULL,
		[EVENT9]                   [int] NULL,
		[EXTENSION]                [char](15) COLLATE Latin1_General_CI_AS NULL,
		[HOLD_ABN_CALLS]           [int] NULL,
		[HOLD_ACD_TIME]            [int] NULL,
		[HOLD_CALLS]               [int] NULL,
		[HOLD_TIME]                [int] NULL,
		[I_ACD_AUX_IN_TIME]        [int] NULL,
		[I_ACD_AUX_OUT_TIME]       [int] NULL,
		[I_ACD_OTHER_TIME]         [int] NULL,
		[I_ACD_TIME]               [int] NULL,
		[I_ACW_IN_TIME]            [int] NULL,
		[I_ACW_OUT_TIME]           [int] NULL,
		[I_ACW_TIME]               [int] NULL,
		[I_AUX_IN_TIME]            [int] NULL,
		[I_AUX_OUT_TIME]           [int] NULL,
		[I_AUX_STBY_TIME]          [int] NULL,
		[I_AUX_TIME]               [int] NULL,
		[I_AVAIL_TIME]             [int] NULL,
		[I_DA_ACD_TIME]            [int] NULL,
		[I_DA_ACWTIME]             [int] NULL,
		[I_OTHER_STBY_TIME]        [int] NULL,
		[I_OTHER_TIME]             [int] NULL,
		[I_RING_TIME]              [int] NULL,
		[I_STAFF_TIME]             [int] NULL,
		[INCOMPLETE]               [int] NULL,
		[INTR_NOTIFIES]            [int] NULL,
		[LOC_ID]                   [int] NULL,
		[NO_ANS_REDIR]             [int] NULL,
		[O_ACD_CALLS]              [int] NULL,
		[O_ACD_TIME]               [int] NULL,
		[O_ACW_TIME]               [int] NULL,
		[PHANTOM_ABNS]             [int] NULL,
		[REJECTED_INTRS]           [int] NULL,
		[RING_CALLS]               [int] NULL,
		[RING_TIME]                [int] NULL,
		[UTC_DATE_TIME]            [datetime] NOT NULL,
		[TI_AUX_TIME]              [int] NULL,
		[TI_AVAIL_TIME]            [int] NULL,
		[TI_OTHER_TIME]            [int] NULL,
		[TI_STAFF_TIME]            [int] NULL,
		[TRANSFERRED]              [int] NULL,
		[TALK_TIME_IN]             [int] NULL,
		[TALK_TIME_CALLS]          [int] NULL,
		[EXT_TALK_TIME_OUT]        [int] NULL,
		[EXT_TALK_CALLS_OUT]       [int] NULL,
		[TOTAL_ACD_CALLS]          [int] NULL,
		[TOTAL_ACD_TIME]           [int] NULL,
		[TOTAL_ACW_TIME]           [int] NULL,
		[RSV_level]                [int] NULL,
		[Intr_Deliveries]          [int] NULL,
		[Icr_Pull_Calls]           [int] NULL,
		[Icr_Pull_Time]            [int] NULL,
		[Da_Icr_Pull_Calls]        [int] NULL,
		[Da_Icr_Pull_Time]         [int] NULL,
		[intrvl]                   [int] NULL,
		[TI_Aux_Time0]             [int] NULL,
		[TI_Aux_Time1]             [int] NULL,
		[TI_Aux_Time2]             [int] NULL,
		[TI_Aux_Time3]             [int] NULL,
		[TI_Aux_Time4]             [int] NULL,
		[TI_Aux_Time5]             [int] NULL,
		[TI_Aux_Time6]             [int] NULL,
		[TI_Aux_Time7]             [int] NULL,
		[TI_Aux_Time8]             [int] NULL,
		[TI_Aux_Time9]             [int] NULL,
		[TI_Aux_Time10]            [int] NULL,
		[TI_Aux_Time11]            [int] NULL,
		[TI_Aux_Time12]            [int] NULL,
		[TI_Aux_Time13]            [int] NULL,
		[TI_Aux_Time14]            [int] NULL,
		[TI_Aux_Time15]            [int] NULL,
		[TI_Aux_Time16]            [int] NULL,
		[TI_Aux_Time17]            [int] NULL,
		[TI_Aux_Time18]            [int] NULL,
		[TI_Aux_Time19]            [int] NULL,
		[TI_Aux_Time20]            [int] NULL,
		[TI_Aux_Time21]            [int] NULL,
		[TI_Aux_Time22]            [int] NULL,
		[TI_Aux_Time23]            [int] NULL,
		[TI_Aux_Time24]            [int] NULL,
		[TI_Aux_Time25]            [int] NULL,
		[TI_Aux_Time26]            [int] NULL,
		[TI_Aux_Time27]            [int] NULL,
		[TI_Aux_Time28]            [int] NULL,
		[TI_Aux_Time29]            [int] NULL,
		[TI_Aux_Time30]            [int] NULL,
		[TI_Aux_Time31]            [int] NULL,
		[TI_Aux_Time32]            [int] NULL,
		[TI_Aux_Time33]            [int] NULL,
		[TI_Aux_Time34]            [int] NULL,
		[TI_Aux_Time35]            [int] NULL,
		[TI_Aux_Time36]            [int] NULL,
		[TI_Aux_Time37]            [int] NULL,
		[TI_Aux_Time38]            [int] NULL,
		[TI_Aux_Time39]            [int] NULL,
		[TI_Aux_Time40]            [int] NULL,
		[TI_Aux_Time41]            [int] NULL,
		[TI_Aux_Time42]            [int] NULL,
		[TI_Aux_Time43]            [int] NULL,
		[TI_Aux_Time44]            [int] NULL,
		[TI_Aux_Time45]            [int] NULL,
		[TI_Aux_Time46]            [int] NULL,
		[TI_Aux_Time47]            [int] NULL,
		[TI_Aux_Time48]            [int] NULL,
		[TI_Aux_Time49]            [int] NULL,
		[TI_Aux_Time50]            [int] NULL,
		[TI_Aux_Time51]            [int] NULL,
		[TI_Aux_Time52]            [int] NULL,
		[TI_Aux_Time53]            [int] NULL,
		[TI_Aux_Time54]            [int] NULL,
		[TI_Aux_Time55]            [int] NULL,
		[TI_Aux_Time56]            [int] NULL,
		[TI_Aux_Time57]            [int] NULL,
		[TI_Aux_Time58]            [int] NULL,
		[TI_Aux_Time59]            [int] NULL,
		[TI_Aux_Time60]            [int] NULL,
		[TI_Aux_Time61]            [int] NULL,
		[TI_Aux_Time62]            [int] NULL,
		[TI_Aux_Time63]            [int] NULL,
		[TI_Aux_Time64]            [int] NULL,
		[TI_Aux_Time65]            [int] NULL,
		[TI_Aux_Time66]            [int] NULL,
		[TI_Aux_Time67]            [int] NULL,
		[TI_Aux_Time68]            [int] NULL,
		[TI_Aux_Time69]            [int] NULL,
		[TI_Aux_Time70]            [int] NULL,
		[TI_Aux_Time71]            [int] NULL,
		[TI_Aux_Time72]            [int] NULL,
		[TI_Aux_Time73]            [int] NULL,
		[TI_Aux_Time74]            [int] NULL,
		[TI_Aux_Time75]            [int] NULL,
		[TI_Aux_Time76]            [int] NULL,
		[TI_Aux_Time77]            [int] NULL,
		[TI_Aux_Time78]            [int] NULL,
		[TI_Aux_Time79]            [int] NULL,
		[TI_Aux_Time80]            [int] NULL,
		[TI_Aux_Time81]            [int] NULL,
		[TI_Aux_Time82]            [int] NULL,
		[TI_Aux_Time83]            [int] NULL,
		[TI_Aux_Time84]            [int] NULL,
		[TI_Aux_Time85]            [int] NULL,
		[TI_Aux_Time86]            [int] NULL,
		[TI_Aux_Time87]            [int] NULL,
		[TI_Aux_Time88]            [int] NULL,
		[TI_Aux_Time89]            [int] NULL,
		[TI_Aux_Time90]            [int] NULL,
		[TI_Aux_Time91]            [int] NULL,
		[TI_Aux_Time92]            [int] NULL,
		[TI_Aux_Time93]            [int] NULL,
		[TI_Aux_Time94]            [int] NULL,
		[TI_Aux_Time95]            [int] NULL,
		[TI_Aux_Time96]            [int] NULL,
		[TI_Aux_Time97]            [int] NULL,
		[TI_Aux_Time98]            [int] NULL,
		[TI_Aux_Time99]            [int] NULL,
		CONSTRAINT [PK_SUM_CMS_AGENT_INTERVAL]
		PRIMARY KEY
		CLUSTERED
		([PARTITION_URN], [PARTITION_ID])
	ON [SUMCMSGROUP]
) ON [SUMCMSGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_SUM_CMS_AGENT_INTERVAL_AGENT_URN]
	ON [dbo].[TB_SUM_CMS_AGENT_INTERVAL] ([AGENT_URN])
	ON [SUMCMSIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'INDEX', N'IX_SUM_CMS_AGENT_INTERVAL_AGENT_URN'
GO
CREATE NONCLUSTERED INDEX [IX_SUM_CMS_AGENT_INTERVAL_ACD_URN]
	ON [dbo].[TB_SUM_CMS_AGENT_INTERVAL] ([ACD_URN])
	ON [SUMCMSIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'INDEX', N'IX_SUM_CMS_AGENT_INTERVAL_ACD_URN'
GO
CREATE NONCLUSTERED INDEX [IX_SUM_CMS_AGENT_SKILLGROUP_URN]
	ON [dbo].[TB_SUM_CMS_AGENT_INTERVAL] ([SKILLGROUP_URN])
	ON [SUMCMSIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'INDEX', N'IX_SUM_CMS_AGENT_SKILLGROUP_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the template table for the historical interval based agent summary statistics from CMS systems. This table is created at install time and the partitioning service creates various partition tables with the same schema. These partition tables are prefixed as TB_SUM_CMS_AGENT_INTERVAL_ followed by the partition identifier. The partition identifier is created depending on the partition configuration, for example monthly, weekly etc. All currently active partitions are included VW_PARTITONED_SUM_CMS_AGENT_INTERVAL view. Since the partitioned tables are generated at runtime and that they have the same schema no separate documentations are required for each partition table. In case of a configured Avaya CMS the data in these partition tables are sourced from the  table in cms Database.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary Key Identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'PARTITION_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column holds a value that uniquely identifies a row across all the partition tables for this partition type.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'PARTITION_GLOBAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number for the current partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from the table dbo.TB_CLU_RESOURCE indicating the source of the data..', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'CLUSTER_RESOURCE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_AGENT corresponding to an item of type IT_AGENT. This corresponds to the AGENT associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'AGENT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_AGENT', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'AGENT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_PERIPHERAL corresponding to an item of type PT_ACD. This corresponds to the ACD associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'ACD_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_PERIPHERAL', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'ACD_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_SKILLGROUP corresponding to an item of type IT_SKILLGROUP. This corresponds to the skillgroup associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'SKILLGROUP_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_SKILLGROUP', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'SKILLGROUP_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the date associated with the record. This is calculated by the data importer based on the source data time corresponding to the start of the reporting interval from the source data.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the time associated with the record. This is calculated by the data importer based on the source data time corresponding to the start of the reporting interval from the source data.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the datetime stamp associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'DB_DATETIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of split/skill ACD calls that are abandoned while ringing the agents telephone (after being directed to the agent telephone, but before being answered). ABNCALLS includes PHANTOMABNS, which are ACD calls and calls routed to an agent or extension with talk times less than the value of the phantom-abandon call timer. The data in this column maps to the HAGENT.ABNCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'ABN_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time that split/skill ACD callers waited while ringing the agents telephone before abandoning the call. For phantom abandons, ABNTIME includes the total time until the agent releases the call.. The data in this column maps to the HAGENT.ABNTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'ABN_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of interrupts accepted by the agent when the agent is in an interruptible AUX state. It is counted against the agents top skill. The data in this column maps to the HAGENT.ACCEPTEDINTRS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'ACCEPTED_INTRS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of split/skill ACD calls that the agent released or dropped before the far end released. Calls that are transferred or conferenced are always recorded as agent-released calls. The data in this column maps to the HAGENT.ACD_RELEASE column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'ACD_RELEASE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'ACD call on hold. On Avaya communication servers with multiple call handling and agents in multiple skills, the call is recorded for the skill of the last ACD call that the agent put on hold.This includes calls that are placed to transfer or conference the ACD call.. The data in this column maps to the HAGENT.ACDAUXOUTCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'ACD_AUX_OUT_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of calls that are queued to SPLIT and answered by this agent in this SPLIT. The data in this column maps to the HAGENT.ACDCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'ACD_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of ACDCALLS that are queued to SPLIT and answered by this Reserve 1 Agent in this SPLIT. The data in this column maps to the HAGENT.ACDCALLS_R1 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'ACD_CALLS_R1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of ACDCALLS that are queued to SPLIT and answered by this Reserve 2 Agent in this SPLIT. The data in this column maps to the HAGENT.ACDCALLS_R2 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'ACD_CALLS_R2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The talk time of all ACDCALLS. ACDTIME includes O_ACDTIME but does not include HOLDTIME. The data in this column maps to the HAGENT.ACDTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'ACD_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of inbound extension calls that are received by agents while they are in ACW. This includes ACW for split/skill, direct agent ACD calls, and ACW not associated with a call.. The data in this column maps to the HAGENT.ACWINCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'ACW_IN_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The talk time of all ACWINCALLS. ACWINTIME includes DA_ACWINTIME but it does not include HOLDTIME. The data in this column maps to the HAGENT.ACWINTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'ACW_IN_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of ACWOUTCALLS that are placed by an adjunct on behalf of an agent (keyboard-dialed). If such calls are placed to off-communication server destinations, they are also counted as ACWOUTOFFCALLS. ACWOUTADJCALLS is available with the ASAI feature. The data in this column maps to the HAGENT.ACWOUTADJCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'ACW_OUT_ADJ_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of outbound extension calls that are placed by the agent or on behalf of the agent while they are in ACW. This includes ACW for ACD calls and ACW that is not associated with a call. ACWOUTCALLS includes ACWOUTADJCALLS, ACWOUTOFFCALLS, and DA_ACWOCALLS. The data in this column maps to the HAGENT.ACWOUTCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'ACW_OUT_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of ACWOUTCALLS that are placed to an off-communication server destination. If these calls are placed by an adjunct on behalf of an agent while the agent is in ACW, they are also counted as ACWOUTADJCALLS. The data in this column maps to the HAGENT.ACWOUTOFFCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'ACW_OUT_OFF_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The talk time of all ACWOUTOFFCALLS. ACWOUTOFFTIME does not include HOLDTIME.ACWOUTTIME includes ACWOUTOFFTIME. The data in this column maps to the HAGENT.ACWOUTOFFTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'ACW_OUT_OFF_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Talk time of all ACWOUTCALLS. ACWOUTTIME does not include hold time. The data in this column maps to the HAGENT.ACWOUTTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'ACW_OUT_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time that agents spend in ACW that is associated with ACDCALLS. ACWTIME does not include the time that is spent in ACW that is not associated with an ACD call. ACWINTIME and ACWOUTTIME associated with calls made or received while in ACW associated with Split/Skill and direct agent ACD calls are included. The data in this column maps to the HAGENT.ACWTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'ACW_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time that split/skill and direct agent ACD calls spent ringing at the agents telephone before being answered. The data in this column maps to the HAGENT.ANSRINGTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'ANS_RING_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times that agents requested supervisor assistance while they were on split/skill ACD calls, direct agent ACD calls, or in call-related ACW for this split/skill. The data in this column maps to the HAGENT.ASSISTS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'ASSISTS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of inbound extension calls that are received by agents while they are in AUX or AVAILABLE, or while the agents have an ACD, AUXIN, or AUXOUT call on hold. AUXINCALLS are recorded in the SPLIT that is the OLDEST_LOGON for agents in multiple splits/skills. The data in this column maps to the HAGENT.AUXINCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'AUX_IN_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The talk time of all AUXINCALLS. AUXINTIME does not include HOLDTIME. The data in this column maps to the HAGENT.AUXINTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'AUX_IN_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of AUXOUTCALLS that are placed by an adjunct on behalf of an agent (keyboard dialed). If such calls are placed to off-communication server destinations, they are also counted as AUXOUTOFFCALLS. AUXOUTADJCALLS is available with the ASAI feature. The data in this column maps to the HAGENT.AUXOUTADJCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'AUX_OUT_ADJ_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of outbound extension calls that are placed by agents while they are in AUX or AVAILABLE, or while the agents have an ACD, AUXIN, or AUXOUT call on hold.AUXOUTCALLS are recorded in the SPLIT that is the OLDEST_LOGON, unless the agent placed the call with an ACD call on hold. In this case, AUXOUTCALLS are recorded for the split/skill of the ACD call. AUXOUTCALLS includes ACDAUXOUTCALLS, AUXOUTADJCALLS, and AUXOUTOFFCALLS.. The data in this column maps to the HAGENT.AUXOUTCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'AUX_OUT_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of AUXOUTCALLS that are placed to a destination outside the communication server. If such calls are placed by an adjunct on behalf of an agent, they are also counted as AUXOUTADJCALLS. The data in this column maps to the HAGENT.AUXOUTOFFCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'AUX_OUT_OFF_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The talk time of all AUXOUTOFFCALLS not including HOLDTIME. This time is included in AUXOUTTIME. The data in this column maps to the HAGENT.AUXOUTOFFTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'AUX_OUT_OFF_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The talk time of all AUXOUTCALLS. The data in this column maps to the HAGENT.AUXOUTTIME. column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'AUX_OUT_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times that the agent completed a conference. A conference is considered completed when the agent pushes the conference key a second time. The data in this column maps to the HAGENT.CONFERENCE column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'CONFERENCE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of direct agent ACD calls that are abandoned by callers while in queue or ringing at an agent telephone. DA_ABNCALLS includes calls that are considered abandoned because their talk time was less than the phantom-abandon call timer. The DA_ABNCALLS item is available with the ASAI or EAS feature. The data in this column maps to the HAGENT.DA_ABNCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'DA_ABN_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time that DA_ABNCALLS wait in queue or ring before abandoning. DA_ABNTIME includes the time that elapses before the agent releases the call on phantom abandon calls.DA_ABNTIME is available with the ASAI or EAS feature. The data in this column maps to the HAGENT.DA_ABNTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'DA_ABN_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of direct agent ACD calls that the agent answers. DA_ACDCALLS is available with the ASAI or EAS feature. DA_ACDCALLS includes DA_RELEASE. The data in this column maps to the HAGENT.DA_ACDCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'DA_ACD_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time that agents spend talking on DA_ACDCALLS. DA_ACDTIME does not include HOLDTIME. DA_ACDTIME is available with the ASAI or EAS feature. The data in this column maps to the HAGENT.DA_ACDTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'DA_ACD_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of inbound extension calls answered by the ACW agent, who entered that work mode as a result of a direct agent call. Requires a communication server with the ASAI or EAS feature for direct agent calling. The data in this column maps to the HAGENT.DA_ACWINCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'DA_ACW_IN_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time that is spent on all DA_ACWINCALLS. DA_ACWINTIME does not include HOLDTIME. DA_ACWINTIME is available with the ASAI or EAS feature. The data in this column maps to the HAGENT.DA_ACWINTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'DA_ACW_IN_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of DA_ACWOCALLS that an ASAI adjunct placed on behalf of the agent. If these calls are placed to off-communication server destinations, they are also counted as DA_ACWOOFFCALLS. The DA_ACWOADJCALLS item is available with the ASAI feature. The data in this column maps to the HAGENT.DA_ACWOADJCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'DA_ACW_OADJ_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of outbound extension calls made by the ACW agent, who entered that work mode as a result of a direct agent call. Requires a communication server with the ASAI or EAS feature for direct agent calling. DA_ACWOCALLS includes DA_ACWOADJCALLS and DA_ACWOOFFCALLS.. The data in this column maps to the HAGENT.DA_ACWOCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'DA_ACW_O_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of DA_ACWOCALLS that are placed to an off-communication server destination. If these calls are placed by an ASAI adjunct on behalf of the agent, they are also counted as DA_ACWOADJCALLS. The DA_ACWOOFCALLS item is available with the ASAI feature. The data in this column maps to the HAGENT.DA_ACWOOFFCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'DA_ACW_O_OFF_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time that agents spend talking on all DA_ACWOOFFCALLS.DA_ACWOOFFTIME does not include HOLDTIME. DA_ACWOOFFTIME is included in DA_ACWOTIME. The DA_ACWOOFFTIME item is available the ASAI or EAS feature. The data in this column maps to the HAGENT.DA_ACWOOFFTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'DA_ACW_O_OFF_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time that agents spend on DA_ACWOCALLS. DA_ACWOTIME does not include HOLDTIME. DA_ACWOTIME includes DA_ACWOOFFTIME. The DA_ACWOTIME item is available with the ASAI or EAS feature.. The data in this column maps to the HAGENT.DA_ACWOTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'DA_ACW_O_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The duration of ACW that is associated with DA_ACDCALLS, including time on DA_ACWINCALLS and DA_ACWOCALLS. The DA_ACWTIME item is available with the ASAI or EAS feature. The data in this column maps to the HAGENT.DA_ACWTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'DA_ACW_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time that calls spend in the direct agent queue and ringing before being answered.The DA_ANSTIME item is available with the ASAI or EAS feature. The data in this column maps to the HAGENT.DA_ANSTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'DA_ANS_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of direct agent calls that are redirected to another destination before they are answered. Calls can be redirected as a result of call pickup, coverage, or Redirection on No Answer. The DA_OTHERCALLS item is available with the ASAI or EAS feature. The data in this column maps to the HAGENT.DA_OTHERCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'DA_OTHER_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time that is spent in queue or ringing by DA_OTHERCALLS before they are redirected. The DA_OTHERTIME item is available with the ASAI or EAS feature. The data in this column maps to the HAGENT.DA_OTHERTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'DA_OTHER_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of direct agent ACD calls that are released or dropped by the agent before the far end releases. The DA_RELEASE item is available with the ASAI or EAS feature. The data in this column maps to the HAGENT.DA_RELEASE column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'DA_RELEASE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times each event, or stroke count, feature button from 1 to 9 was pressed while the agent was on an ACD call or in call-related ACW. The data in this column maps to the HAGENT.EVENT1 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'EVENT1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times each event, or stroke count, feature button from 1 to 9 was pressed while the agent was on an ACD call or in call-related ACW. The data in this column maps to the HAGENT.EVENT2 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'EVENT2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times each event, or stroke count, feature button from 1 to 9 was pressed while the agent was on an ACD call or in call-related ACW. The data in this column maps to the HAGENT.EVENT3 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'EVENT3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times each event, or stroke count, feature button from 1 to 9 was pressed while the agent was on an ACD call or in call-related ACW. The data in this column maps to the HAGENT.EVENT4 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'EVENT4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times each event, or stroke count, feature button from 1 to 9 was pressed while the agent was on an ACD call or in call-related ACW. The data in this column maps to the HAGENT.EVENT5 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'EVENT5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times each event, or stroke count, feature button from 1 to 9 was pressed while the agent was on an ACD call or in call-related ACW. The data in this column maps to the HAGENT.EVENT6 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'EVENT6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times each event, or stroke count, feature button from 1 to 9 was pressed while the agent was on an ACD call or in call-related ACW. The data in this column maps to the HAGENT.EVENT7 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'EVENT7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times each event, or stroke count, feature button from 1 to 9 was pressed while the agent was on an ACD call or in call-related ACW. The data in this column maps to the HAGENT.EVENT8 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'EVENT8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times each event, or stroke count, feature button from 1 to 9 was pressed while the agent was on an ACD call or in call-related ACW. The data in this column maps to the HAGENT.EVENT9 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'EVENT9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The extension number for which data was collected. The data in this column maps to the HAGENT.EXTENSION column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'EXTENSION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times that callers abandoned while on hold. The HOLDABNCALLS item applies to all of the calls that the agent put on hold. The data in this column maps to the HAGENT.HOLDABNCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'HOLD_ABN_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time that split/skill and direct agent ACD calls spend on hold at the agents telephone. This includes time that the agent spends on AUXIN or AUXOUT calls with the ACD call on hold. The data in this column maps to the HAGENT.HOLDACDTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'HOLD_ACD_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of calls that are placed on hold at least once. HOLDCALLS includes HOLDABNCALLS. The HOLDCALLS item applies to all of the calls that the agent put on hold. The data in this column maps to the HAGENT.HOLDCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'HOLD_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time that split/skill ACD callers spend on hold. HOLDTIME includes HOLDACDTIME. The data in this column maps to the HAGENT.HOLDTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'HOLD_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that the agent spent talking on AUXIN calls with at least one split/skill or direct agent ACD call on hold. For agents in multiple splits/skills, this time is recorded in the record in which SPLIT is OLDEST_LOGON. The data in this column maps to the HAGENT.I_ACDAUXINTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'I_ACD_AUX_IN_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that the agent spent dialing and talking on AUXOUT calls with at least one split/skill or direct agent ACD call on hold. The data in this column maps to the HAGENT.I_ACDAUX_OUTTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'I_ACD_AUX_OUT_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that the agent spent in the OTHER state with at least one split/skill or direct agent ACD call on hold. Instances of the OTHER state include, dialing an outgoing call, a ringing extension call, or having calls on hold and with no other state selected. The data in this column maps to the HAGENT.I_ACDOTHERTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'I_ACD_OTHER_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that the agent was talking on ACD calls for this SPLIT. The data in this column maps to the HAGENT.I_ACDTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'I_ACD_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that the agent was in ACW and on inbound extension calls. I_ACWINTIME includes ACW for split/skill ACD calls and ACW that is not associated with a call. I_ACWINTIME does not include the time that inbound ACW calls spend on hold. The data in this column maps to the HAGENT.I_ACWINTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'I_ACW_IN_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that the agent was in ACW and on outbound extension calls. I_ACWOUTTIME includes ACW for split/skill ACD calls and ACW that is not associated with a call. I_ACWOUTTIME does not include the time ACWOUT calls spend on hold. The data in this column maps to the HAGENT.I_ACWOUTTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'I_ACW_OUT_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that the agent is in ACW. This includes ACW for split/skill ACD calls and ACW that is not associated with a call. I_ACWINTIME and I_ACWOUTTIME include time for direct agent ACW in and out calls, but I_ACWTIME does not include this time. Therefore, the sum of I_ACWINTIME and I_ACWOUTTIME may be greater than I_ACWTIME. I_ACWTIME includes the portions of I_ACWINTIME and I_ACWOUTTIME that are not associated with direct agent calls. The data in this column maps to the HAGENT.I_ACWTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'I_ACW_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that the agent was in AUX work or AVAILABLE and on an inbound extension call. I_AUXINTIME includes the length of time when an ACD, AUXIN, or AUXOUT call is on hold and the time the agent is on inbound extension calls and SPLIT is the OLDEST_LOGON. I_AUXINTIME includes I_ACDAUXINTIME but does not include the time these calls spent on hold. The data in this column maps to the HAGENT.I_AUXINTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'I_AUX_IN_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that the agent was in AUX work, AVAILABLE, had an ACD, AUXIN, or AUXOUT call on hold and on outbound extension calls. When the agent was in AUX work, AVAILABLE, or had an AUXIN or AUXOUT call on hold, the AUXOUT time and calls are recorded for the SPLIT that is the OLDEST_LOGON. When the agent had an ACD call on hold, SPLIT is the split/skill associated with the last ACD call put on hold. I_AUXOUTTIME includes I_ACDAUX_OUTTIME but does not include the time calls spent on hold. The data in this column maps to the HAGENT.I_AUXOUTTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'I_AUX_OUT_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The time during the collection interval that an Agent was in AUX Work state while the skill was Normal. This database item is valid only for agents administered as Reserve Level 1 or Reserve Level 2 for a skill. The data in this column maps to the HAGENT.I_AUXSTBYTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'I_AUX_STBY_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that the agent spends in AUX for all splits/skills, or on AUXINCALLS or AUXOUTCALLS and SPLIT was OLDEST_LOGON. "TI_" time is stored for the split/skill in which the agent has been logged in the longest. "TI_" needs to be summed across the splits/skills that the agent may log into in case the logon order changes during the collection interval. The data in this column maps to the HAGENT.I_AUXTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'I_AUX_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that the agent was available for ACD calls in this split/skill. The data in this column maps to the HAGENT.I_AVAILTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'I_AVAIL_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that the agent spent talking on direct agent calls. I_DA_ACDTIME does not include HOLDTIME. The I_DA_ACDTIME item is available with the ASAI or EAS feature. The data in this column maps to the HAGENT.I_DA_ACDTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'I_DA_ACD_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that the agent was doing ACW that was associated with direct agent ACD calls. The I_DA_ACWTIME item is available with the ASAI or EAS feature. The data in this column maps to the HAGENT.I_DA_ACWTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'I_DA_ACWTIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The time during the collection interval that the Agent was logged into the skill and in standby because the skill was not in overload 1 or 2. This database item is valid only for agents administered as Reserve Level 1 or Reserve Level 2 for a skill. The data in this column maps to the HAGENT.I_OTHERSTBYTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'I_OTHER_STBY_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time that the agent was doing other work. Reserve agents only accumulate I_OTHERTIME when the skill is in overload 1 or 2.. The data in this column maps to the HAGENT.I_OTHERTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'I_OTHER_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that the agent had split/skill and direct agent ACD calls ringing. If the agent changes work modes or makes/receives another call instead of answering the ringing call, I_RINGTIME will stop accumulating. RINGTIME is the length of time that the caller spends ringing and is independent of agent activity. The data in this column maps to the HAGENT.I_RINGTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'I_RING_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that the agent was logged in to this split/skill. Reserve agents only accumulate STAFFTIME when the skill is in overload 1 or 2. The data in this column maps to the HAGENT.I_STAFFTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'I_STAFF_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'An indication of whether data is complete for this collection interval. Data is incomplete whenever the link goes down and whenever tracking is aborted for calls, because of the trunk going maintenance busy with a call active, protocol failures with data collection active, or when split/skill or VDN call profile is changed with data collection active. Valid values for the INCOMPLETE item are 1, which means that the data is incomplete, and 0, which means that the data is complete. The value in the daily, weekly, and monthly tables indicates the number of incomplete intervals in the day, week, or month. Changing the split/skill or VDN call profile data while data collection is active only affects the respective split/skill or VDN data. The data in this column maps to the HAGENT.INCOMPLETE column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'INCOMPLETE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of interrupt notifications received by the agent when the agent is in an interruptible AUX state. It is counted against the agents top skill. The data in this column maps to the HAGENT.INTRNOTIFIES column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'INTR_NOTIFIES'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The equipment location ID that is associated with a particular agent. This is the location ID of the terminal the agent is logged into. It is associated with a port network location ID on the communication server. The data in this column maps to the HAGENT.LOC_ID column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'LOC_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of split/skill and direct agent ACD calls that rang at this agents telephone and then were automatically redirected by the Redirection on No Answer feature because they were not answered. Split/skill ACD calls are requeued to the split/skill or VDN, whereas direct agent ACD calls are redirected to the agents coverage path. The data in this column maps to the HAGENT.NOANSREDIR column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'NO_ANS_REDIR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of ACDCALLS and DA_ACDCALLS that are placed by an adjunct (predictive dialing). The O_ACDCALLS item is available with the ASAI feature. The data in this column maps to the HAGENT.O_ACDCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'O_ACD_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The talk time of all O_ACDCALLS. O_ACDTIME does not include HOLDTIME. O_ACDTIME is included in ACDTIME. The O_ACDTIME item is available with the ASAI feature. The data in this column maps to the HAGENT.O_ACDTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'O_ACD_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The duration of all ACW that is associated with O_ACDCALLS. O_ACWTIME is included in ACWTIME. The O_ACWTIME item is available with the ASAI feature. The data in this column maps to the HAGENT.O_ACWTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'O_ACW_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of ACD calls for which talk time is less than the value of the phantom-abandon call timer. The data in this column maps to the HAGENT.PHANTOMABNS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'PHANTOM_ABNS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of interrupts rejected by the agent. It is counted against the agent''s top skill. The data in this column maps to the HAGENT.REJECTEDINTRS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'REJECTED_INTRS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of split/skill and direct agent ACD calls that rang at the agents position. RINGCALLS includes NOANSREDIR. The data in this column maps to the HAGENT.RINGCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'RING_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time that split/skill and direct agent ACD calls spend ringing at the agents position independent of disposition or other agent activity. I_RINGTIME is the time that the agent spends in the ringing state and is affected by other agent activity. RINGTIME is the time the caller spends ringing at the agent station. RINGTIME includes ANSRINGTIME. The data in this column maps to the HAGENT.RINGTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'RING_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The UTC start time of the interval for which data was collected. It is records in number of seconds since midnight 01/01/1970 UTC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'UTC_DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that the agent spends in AUX for all splits/skills, or on AUXINCALLS or AUXOUTCALLS and SPLIT was OLDEST_LOGON. "TI_" time is stored for the split/skill in which the agent has been logged in the longest. "TI_" needs to be summed across the splits/skills that the agent may log into in case the logon order changes during the collection interval. The data in this column maps to the HAGENT.TI_AUXTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'TI_AUX_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that the agent is in the AVAIL state for split/skill or direct agent ACD calls in any split/skill. TI_AVAILTIME is recorded for the split/skill in which the agent has been logged in the longest. "TI_" time needs to be summed across the splits/skills the agents may log in to, in case the logon order changes during the collection interval. On communication servers without the EAS feature, if an agent logs into multiple splits and is in AUX mode in one split and is available for ACD calls in another split, the agent accrues I_AVAILTIME for the split in which the agent is available and TI_AVAILTIME in the split that the agent has been logged into the longest. The data in this column maps to the HAGENT.TI_AVAILTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'TI_AVAIL_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that the agent is in OTHER in any split/skill. TI_OTHERTIME is collected for the time period after the link to the communication server is initiated and directly after the agent logs in but before the CMS is notified of the agents work state.. The data in this column maps to the HAGENT.TI_OTHERTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'TI_OTHER_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that the agent is staffed in any split/skill. "TI_" time is stored for the split/skill in which the agent has been logged in the longest. "TI_" needs to be summed across the splits/skills that the agent may log into in case the logon order changes during the collection interval. sum(TI_STAFFTIME) = sum(I_ACDTIME + I_ACWTIME + I_DA_ACDTIME + I_DA_ACWTIME + I_RINGTIME + TI_AUXTIME + TI_AVAILTIME + TI_OTHERTIME), over all of the splits/skills that the agent was logged into. The data in this column maps to the HAGENT.TI_STAFFTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'TI_STAFF_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of calls that the agent transferred to another destination. TRANSFERRED includes all calls that are transferred. The data in this column maps to the HAGENT.TRANSFERRED column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'TRANSFERRED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a calculated field for calculating AVG_TALK_TIME_IN, Extension in calls average talk time .', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'TALK_TIME_IN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a calculated field for use to calculate the calculate the AVG_TALK_TIME_IN and AVG_TALK_TIME_IN_SUM.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'TALK_TIME_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a calculated field for use to calculate the calculate the AVG_TALK_TIME_OUT and AVG_TALK_TIME_OUT_SUM.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'EXT_TALK_TIME_OUT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a calculated field for use to calculate the calculate the AVG_TALK_TIME_OUT and AVG_TALK_TIME_OUT_SUM.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'EXT_TALK_CALLS_OUT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a calculated field for calculating Total split/skill and direct agent ACD calls TIME.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'TOTAL_ACD_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a calculated field for calculating Total ACD time + DA ACD TIME.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'TOTAL_ACD_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a calculated field for calculating Total ACW time +DA TIME.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_AGENT_INTERVAL', 'COLUMN', N'TOTAL_ACW_TIME'
GO
GRANT SELECT
	ON [dbo].[TB_SUM_CMS_AGENT_INTERVAL]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_SUM_CMS_AGENT_INTERVAL]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_SUM_CMS_AGENT_INTERVAL]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_SUM_CMS_AGENT_INTERVAL] SET (LOCK_ESCALATION = TABLE)
GO
