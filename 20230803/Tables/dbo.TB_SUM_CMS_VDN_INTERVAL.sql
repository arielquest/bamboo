SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TB_SUM_CMS_VDN_INTERVAL] (
		[PARTITION_URN]            [int] NOT NULL,
		[PARTITION_GLOBAL_URN]     [bigint] NOT NULL,
		[PARTITION_ID]             [int] NOT NULL,
		[CLUSTER_RESOURCE_URN]     [int] NOT NULL,
		[ACD_URN]                  [int] NOT NULL,
		[VDN_URN]                  [int] NOT NULL,
		[VECTOR_URN]               [int] NOT NULL,
		[DATE_UTC_URN]             [int] NOT NULL,
		[TIME_UTC_URN]             [smallint] NOT NULL,
		[DB_DATETIME]              [datetime] NULL,
		[UTC_DATE_TIME]            [datetime] NOT NULL,
		[INTRVL]                   [int] NULL,
		[IN_FLOW_CALLS]            [int] NULL,
		[ANS_TIME]                 [int] NULL,
		[ACD_CALLS]                [int] NULL,
		[ACD_TIME]                 [int] NULL,
		[BACKUP_CALLS]             [int] NULL,
		[TRANSFERRED]              [int] NULL,
		[ABN_CALLS]                [int] NULL,
		[ABN_TIME]                 [int] NULL,
		[ABN_QUE_CALLS]            [int] NULL,
		[BUSY_CALLS]               [int] NULL,
		[BUSY_TIME]                [int] NULL,
		[DISC_CALLS]               [int] NULL,
		[DISC_TIME]                [int] NULL,
		[OTHER_CALLS]              [int] NULL,
		[OTHER_TIME]               [int] NULL,
		[OUT_FLOW_CALLS]           [int] NULL,
		[OUT_FLOW_TIME]            [int] NULL,
		[INTERFLOW_CALLS]          [int] NULL,
		[LOOKFLOW_CALLS]           [int] NULL,
		[LOOK_ATTEMPTS]            [int] NULL,
		[ADJ_ROUTED]               [int] NULL,
		[ADJ_ATTEMPTS]             [int] NULL,
		[IN_TIME]                  [int] NULL,
		[IN_CALLS]                 [int] NULL,
		[CONNECT_CALLS]            [int] NULL,
		[CONNECT_TIME]             [int] NULL,
		[ACCEPTABLE]               [int] NULL,
		[ACW_TIME]                 [int] NULL,
		[ANS_CONN_CALLS1]          [int] NULL,
		[ANS_CONN_CALLS2]          [int] NULL,
		[ANS_CONN_CALLS3]          [int] NULL,
		[ANS_CONN_CALLS4]          [int] NULL,
		[ANS_CONN_CALLS5]          [int] NULL,
		[ANS_CONN_CALLS6]          [int] NULL,
		[ANS_CONN_CALLS7]          [int] NULL,
		[ANS_CONN_CALLS8]          [int] NULL,
		[ANS_CONN_CALLS9]          [int] NULL,
		[ANS_CONN_CALLS10]         [int] NULL,
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
		[PERIOD1]                  [int] NULL,
		[PERIOD2]                  [int] NULL,
		[PERIOD3]                  [int] NULL,
		[PERIOD4]                  [int] NULL,
		[PERIOD5]                  [int] NULL,
		[PERIOD6]                  [int] NULL,
		[PERIOD7]                  [int] NULL,
		[PERIOD8]                  [int] NULL,
		[PERIOD9]                  [int] NULL,
		[SVC_LEVEL_CHG]            [int] NULL,
		[PERIOD_CHG]               [int] NULL,
		[SERVICE_LEVEL]            [int] NULL,
		[ABN_RING_CALLS]           [int] NULL,
		[RING_TIME]                [int] NULL,
		[RING_CALLS]               [int] NULL,
		[HOLD_ABN_CALLS]           [int] NULL,
		[HOLD_CALLS]               [int] NULL,
		[HOLD_TIME]                [int] NULL,
		[MAX_OCW_TIME]             [int] NULL,
		[MAX_WAITING]              [int] NULL,
		[CONN_TALK_TIME]           [int] NULL,
		[NO_ANS_REDIR]             [int] NULL,
		[SKILL1]                   [int] NULL,
		[SKILL2]                   [int] NULL,
		[SKILL3]                   [int] NULL,
		[SKILL_CALLS1]             [int] NULL,
		[SKILL_CALLS2]             [int] NULL,
		[SKILL_CALLS3]             [int] NULL,
		[SKILL_TIME1]              [int] NULL,
		[SKILL_TIME2]              [int] NULL,
		[SKILL_TIME3]              [int] NULL,
		[SKILL_ACW_TIME1]          [int] NULL,
		[SKILL_ACW_TIME2]          [int] NULL,
		[SKILL_ACW_TIME3]          [int] NULL,
		[INCOMPLETE]               [int] NULL,
		[HOLD_ACD_CALLS]           [int] NULL,
		[HOLD_ACD_TIME]            [int] NULL,
		[PHANTOM_ABNS]             [int] NULL,
		[RETURN_CALLS]             [int] NULL,
		[VDISC_CALLS]              [int] NULL,
		[SLVL_ABNS]                [int] NULL,
		[SLVL_OUTFLOWS]            [int] NULL,
		[I_ARRIVED]                [int] NULL,
		[BSR_PLAN]                 [int] NULL,
		[DEFLECT_CALLS]            [int] NULL,
		[NET_DISC_CALLS]           [int] NULL,
		[NET_IN_CALLS]             [int] NULL,
		[NET_IN_TIME]              [int] NULL,
		[NET_POLLS]                [int] NULL,
		[ACD_CALLS_R1]             [int] NULL,
		[ACD_CALLS_R2]             [int] NULL,
		[AG_SURP_DELIVERIES]       [int] NULL,
		[AG_SURP_PREF_CALLS]       [int] NULL,
		[AG_SURP_NPREF_CALLS]      [int] NULL,
		[CALL_SURP_DELIVERIES]     [int] NULL,
		[ICR_PULL_CALLS]           [int] NULL,
		[ICR_PULL_TIME]            [int] NULL,
		[ICR_PULL_QUE_CALLS]       [int] NULL,
		[ICR_PULL_RING_CALLS]      [int] NULL,
		[BUSY_DISCONNECT]          [int] NULL,
		[MAIN_ACD_CALLS]           [int] NULL,
		CONSTRAINT [PK_SUM_CMS_VDN_INTERVAL]
		PRIMARY KEY
		CLUSTERED
		([PARTITION_URN], [PARTITION_ID])
	ON [SUMCMSGROUP]
) ON [SUMCMSGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_SUM_CMS_VDN_INTERVAL_ACD_URN]
	ON [dbo].[TB_SUM_CMS_VDN_INTERVAL] ([ACD_URN])
	ON [SUMCMSIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'INDEX', N'IX_SUM_CMS_VDN_INTERVAL_ACD_URN'
GO
CREATE NONCLUSTERED INDEX [IX_SUM_CMS_VDN_INTERVAL_VDN_URN]
	ON [dbo].[TB_SUM_CMS_VDN_INTERVAL] ([VDN_URN])
	ON [SUMCMSIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'INDEX', N'IX_SUM_CMS_VDN_INTERVAL_VDN_URN'
GO
CREATE NONCLUSTERED INDEX [IX_SUM_CMS_VDN_INTERVAL_VECTOR_URN]
	ON [dbo].[TB_SUM_CMS_VDN_INTERVAL] ([VECTOR_URN])
	ON [SUMCMSIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'INDEX', N'IX_SUM_CMS_VDN_INTERVAL_VECTOR_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the template table for the historical interval based call VDN summary statistics from CMS systems. This table is created at install time and the partitioning service creates various partition tables with the same schema. These partition tables are prefixed as TB_SUM_CMS_VDN_INTERVAL_ followed by the partition identifier. The partition identifier is created depending on the partition configuration, for example monthly, weekly etc. All currently active partitions are included VW_PARTITONED_SUM_CMS_VDN_INTERVAL view. Since the partitioned tables are generated at runtime and that they have the same schema no separate documentations are required for each partition table. In case of a configured Avaya CMS the data in these partition tables are sourced from the  table in cms Database.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary Key Identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'PARTITION_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column holds a value that uniquely identifies a row across all the partition tables for this partition type.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'PARTITION_GLOBAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number for the current partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from the table dbo.TB_CLU_RESOURCE indicating the source of the data..', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'CLUSTER_RESOURCE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_PERIPHERAL corresponding to an item of type PT_ACD. This corresponds to the ACD associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'ACD_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_PERIPHERAL', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'ACD_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_VECTOR_DIRECTORY_NUMBER corresponding to an item of type IT_VECTOR_DIRECTORY_NUMBER. This corresponds to the VDN associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'VDN_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_VECTOR_DIRECTORY_NUMBER', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'VDN_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_VECTOR corresponding to an item of type IT_VECTOR. This corresponds to the VECTOR associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'VECTOR_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_VECTOR', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'VECTOR_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the date associated with the record. This is calculated by the data importer based on the source data time corresponding to the start of the reporting interval from the source data.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the time associated with the record. This is calculated by the data importer based on the source data time corresponding to the start of the reporting interval from the source data.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the datetime stamp associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'DB_DATETIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The UTC start time of the interval for which data was collected. It is records in number of seconds since midnight 01/01/1970 UTC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'UTC_DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of minutes in the intrahour interval. The length of the intrahour interval can be 15, 30, or 60 minutes. INTRVL applies to intrahour tables only. The data in this column maps to the HVDN.INTRVL column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'INTRVL'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of calls that are redirected into the VDN by way of a "route to" VDN command or by Redirection on No Answer to this VDN. The data in this column maps to the HVDN.INFLOWCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'IN_FLOW_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time that split/skill and direct agent ACD calls waited while vector steps are executed, in queue, and ringing before an agent answers the call. ANSTIME includes RINGTIME.. The data in this column maps to the HVDN.ANSTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'ANS_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of split/skill and direct agent ACD calls that are answered by an agent from "queue to", "check", "messaging split/skill", "route to" split/skill or direct agent, and "adj rout link" to split/skill or direct agent. The data in this column maps to the HVDN.ACDCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'ACD_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The talk time of all ACDCALLS. ACDTIME does not include HOLDTIME. ACDTIME includes SKILLTIME1, SKILLTIME2, and SKILLTIME3. The data in this column maps to the HVDN.ACDTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'ACD_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of ACDCALLS that are delivered by a vector command other than "queue to" and answered by this split/skill plus the number of ACDCALLS that are delivered to this split/skill by a "queue to" vector command and answered by an agent who has either Reserve 1 or Reserve 2 skill levels assigned for this skill. The data in this column maps to the HVDN.BACKUPCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'BACKUP_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of calls that are transferred to another destination. TRANSFERRED includes all of the VDN calls that are transferred. The data in this column maps to the HVDN.TRANSFERRED column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'TRANSFERRED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of INCALLS that are abandoned while INPROGRESS for this VDN. This includes split/skill and direct agent ACD calls that abandon from queue or from ringing, calls that abandon from vector processing, and calls that abandon after being routed to an extension by the "route to vector command. ABNCALLS includes PHANTOMABNS, which are ACD calls and calls routed to an agent or extension with talk times less than the value of the phantom-abandon call timer.ABNCALLS includes ABNCALLS1 through ABNCALLS10, ABNQUECALLS, ABNRINGCALLS,PHANTOMABNS, and SLVLABNS.. The data in this column maps to the HVDN.ABNCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'ABN_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time that a caller spent waiting while vector steps were executed, the call was queued and ringing before abandoning. For phantom abandon calls, ABNTIME includes the total time from entering the VDN until the agent releases the call.. The data in this column maps to the HVDN.ABNTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'ABN_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of ABNCALLS that are abandoned while in a split/skill or direct agent ACD queue. The data in this column maps to the HVDN.ABNQUECALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'ABN_QUE_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of INCALLS that are given a busy signal by the communication server. This occurs when the "busy vector command executes. BUSYCALLS also occurs if a call is routed to a split/skill with coverage set to "yes" where there are no agents available, the queue is full or there is no queue, no coverage path is administered, and an announcement has played or the trunk is not a CO trunk. BUSYCALLS occurs if a call is routed to a direct agent with coverage set to "yes", the agent is not logged in, there is no coverage path administered, and an announcement has played or the trunk is not a CO trunk. The data in this column maps to the HVDN.BUSYCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'BUSY_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The duration of all BUSYCALLS before the trunk goes idle. The data in this column maps to the HVDN.BUSYTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'BUSY_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of INCALLS that were disconnected by the "disconnect" or "reply best" vector command. DISCCALLS also includes calls that are disconnected by the communication server when the vector disconnect timer expires or calls that reached the end of vector processing without being queued. DISCCALLS includes VDISCCALLS. The data in this column maps to the HVDN.DISCCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'DISC_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time that all DISCCALLS spent in this VDN. DISCTIME includes the time that elapses until the trunk drops following the forced disconnect command, or when the caller hangs up without listening to the entire announcement. When the caller listens to the entire announcement, DISCTIME is the length of time until the announcement ends and the caller is disconnected by the communication server, or when the vector disconnect timer expires. The data in this column maps to the HVDN.DISCTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'DISC_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of calls that are given a forced busy, forced disconnect, or outflowed from the communication server, and non-ACD calls that are answered (CONNECTCALLS). OTHERCALLS includes BUSYCALLS, CONNECTCALLS, DISCCALLS, and OUTFLOWCALLS. OTHERCALLS = INCALLS - ACDCALLS - ABNCALLS. The data in this column maps to the HVDN.OTHERCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'OTHER_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The total length of time that OTHERCALLS spend in the VDN until the calls leave the VDN.Instances that cause the call to leave the VDN include when the call drops, when the call is sent to another VDN, when the call is transferred, or when the call is sent outside of the communication server. OTHERTIME includes BUSYTIME, CONNECTTIME, CONNTALKTIME, DISCTIME, and OUTFLOWTIME. The data in this column maps to the HVDN.OTHERTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'OTHER_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of INCALLS that are redirected to another VDN or to a destination outside the communication server by way of a "route to" or "adj rout link" vector command, or calls that are redirected to another VDN by the Redirect on No Answer feature. Calls are only counted as outflows from the VDN when they are redirected to another VDN or to an off-communication server destination. Calls in the VDN that route to other destinations, such as split/skills or extensions, are not counted as outflows from the VDN. OUTFLOWCALLS includes INTERFLOWCALLS and SLVLOUTFLOWS. The data in this column maps to the HVDN.OUTFLOWCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'OUT_FLOW_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time that all OUTFLOWCALLS spend in the VDN before being redirected. The data in this column maps to the HVDN.OUTFLOWTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'OUT_FLOW_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of OUTFLOWCALLS that are redirected to a destination outside the communication server. INTERFLOWCALLS includes LOOKFLOWCALLS (successful Look-Ahead Interflow and BSR) and DEFLECTCALLS (successful NCR redirections).. The data in this column maps to the HVDN.INTERFLOWCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'INTERFLOW_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of INTERFLOWCALLS that are redirected by way of the Look-Ahead Interflow or BSR feature. LOOKFLOWCALLS item is available with the Look-Ahead Interflow feature. LOOKFLOWCALLS is a subset of INTERFLOWCALLS and includes LOOKATTEMPTS for the Look-Ahead Interflow or BSR interflows. With BSR interflow, every LOOKATTEMPTS should also be counted as a LOOKFLOWCALLS unless a failure occurs. The data in this column maps to the HVDN.LOOKFLOWCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'LOOKFLOW_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times that Look-Ahead Interflow or BSR Interflow was attempted for calls in this VDN. Network Call Redirection (NCD or NCT) invoke attempts are also counted as LOOKATTEMPTS. Look-Ahead Interflow and BSR interflow attempts that are successful are also counted as LOOKFLOWCALLS. NCR attempts that are successful are also counted as DEFLECTCALLS. BSR poll calls are not counted as LOOKATTEMPTS. They are counted as NETPOLLS. The data in this column maps to the HVDN.LOOKATTEMPTS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'LOOK_ATTEMPTS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of adjunct-routing calls that are redirected by an adjunct processor or host computer. ADJROUTED is available with the Vectoring and the ASAI features. The data in this column maps to the HVDN.ADJROUTED column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'ADJ_ROUTED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of adjunct-routing attempts for calls in this VDN. ADJATTEMPTS includes ADJROUTED. ADJATTEMPTS is available with the vectoring and the ASAI feature. The data in this column maps to the HVDN.ADJATTEMPTS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'ADJ_ATTEMPTS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The time spent in the VDN by calls completed during this interval. This time includes: time in vector processing, ringing, and talking with an agent until the call is terminated or is routed to another VDN off the communication server. INTIME = ACDTIME + ABNTIME + ANSTIME + HOLDTIME + OTHERTIME. The data in this column maps to the HVDN.INTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'IN_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of inbound calls that are directed to this VDN. INCALLS includes ABNCALLS, INFLOWCALLS, OTHERCALLS, RETURNCALLS, and RINGCALLS. INCALLS = ABNCALLS + ACDCALLS + OTHERCALLS. The data in this column maps to the HVDN.INCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'IN_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of non-ACD INCALLS that are delivered to a station extension (other than a VDN or direct agent login ID) by a "route to" or "adj rout link" vector command and that do not abandon. CONNECTCALLS includes ANSCONNCALLS1 through ANSCONNCALLS10. The data in this column maps to the HVDN.CONNECTCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'CONNECT_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time that CONNECTCALLS waited before being answered. The data in this column maps to the HVDN.CONNECTTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'CONNECT_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of ACDCALLS and CONNECTCALLS that are answered within the acceptable service level (SERVICELEVEL) as defined on the Call Center Administration: VDN Call Profile Setup window. The data in this column maps to the HVDN.ACCEPTABLE column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'ACCEPTABLE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time that agents spend in ACW that is associated with ACDCALLS. ACWTIME does not include the time that is spent in ACW that is not associated with an ACD call. ACWINTIME and CWOUTTIME associated with calls made or received while in ACW associated with Split/Skill and direct agent ACD calls are included. The data in this column maps to the HVDN.ACWTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'ACW_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times that calls are answered (ACDCALLS) or connected (CONNECTCALLS) during each of the service level increments PERIOD1 through PERIOD9. The service level increments are defined in the Call Center Administration: VDN Call Profile Setup window. The ANSCONNCALLS10 item counts calls answered or connected after PERIOD9. Answered and connected calls include split/skill and direct agent ACD calls and extension calls by a "route to" or "adj rout link" vector command. The data in this column maps to the HVDN.ANSCONNCALLS1 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'ANS_CONN_CALLS1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times that calls are answered (ACDCALLS) or connected (CONNECTCALLS) during each of the service level increments PERIOD1 through PERIOD9. The service level increments are defined in the Call Center Administration: VDN Call Profile Setup window. The ANSCONNCALLS10 item counts calls answered or connected after PERIOD9. Answered and connected calls include split/skill and direct agent ACD calls and extension calls by a "route to" or "adj rout link" vector command. The data in this column maps to the HVDN.ANSCONNCALLS2 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'ANS_CONN_CALLS2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times that calls are answered (ACDCALLS) or connected (CONNECTCALLS) during each of the service level increments PERIOD1 through PERIOD9. The service level increments are defined in the Call Center Administration: VDN Call Profile Setup window. The ANSCONNCALLS10 item counts calls answered or connected after PERIOD9. Answered and connected calls include split/skill and direct agent ACD calls and extension calls by a "route to" or "adj rout link" vector command. The data in this column maps to the HVDN.ANSCONNCALLS3 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'ANS_CONN_CALLS3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times that calls are answered (ACDCALLS) or connected (CONNECTCALLS) during each of the service level increments PERIOD1 through PERIOD9. The service level increments are defined in the Call Center Administration: VDN Call Profile Setup window. The ANSCONNCALLS10 item counts calls answered or connected after PERIOD9. Answered and connected calls include split/skill and direct agent ACD calls and extension calls by a "route to" or "adj rout link" vector command. The data in this column maps to the HVDN.ANSCONNCALLS4 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'ANS_CONN_CALLS4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times that calls are answered (ACDCALLS) or connected (CONNECTCALLS) during each of the service level increments PERIOD1 through PERIOD9. The service level increments are defined in the Call Center Administration: VDN Call Profile Setup window. The ANSCONNCALLS10 item counts calls answered or connected after PERIOD9. Answered and connected calls include split/skill and direct agent ACD calls and extension calls by a "route to" or "adj rout link" vector command. The data in this column maps to the HVDN.ANSCONNCALLS5 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'ANS_CONN_CALLS5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times that calls are answered (ACDCALLS) or connected (CONNECTCALLS) during each of the service level increments PERIOD1 through PERIOD9. The service level increments are defined in the Call Center Administration: VDN Call Profile Setup window. The ANSCONNCALLS10 item counts calls answered or connected after PERIOD9. Answered and connected calls include split/skill and direct agent ACD calls and extension calls by a "route to" or "adj rout link" vector command. The data in this column maps to the HVDN.ANSCONNCALLS6 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'ANS_CONN_CALLS6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times that calls are answered (ACDCALLS) or connected (CONNECTCALLS) during each of the service level increments PERIOD1 through PERIOD9. The service level increments are defined in the Call Center Administration: VDN Call Profile Setup window. The ANSCONNCALLS10 item counts calls answered or connected after PERIOD9. Answered and connected calls include split/skill and direct agent ACD calls and extension calls by a "route to" or "adj rout link" vector command. The data in this column maps to the HVDN.ANSCONNCALLS7 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'ANS_CONN_CALLS7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times that calls are answered (ACDCALLS) or connected (CONNECTCALLS) during each of the service level increments PERIOD1 through PERIOD9. The service level increments are defined in the Call Center Administration: VDN Call Profile Setup window. The ANSCONNCALLS10 item counts calls answered or connected after PERIOD9. Answered and connected calls include split/skill and direct agent ACD calls and extension calls by a "route to" or "adj rout link" vector command. The data in this column maps to the HVDN.ANSCONNCALLS8 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'ANS_CONN_CALLS8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times that calls are answered (ACDCALLS) or connected (CONNECTCALLS) during each of the service level increments PERIOD1 through PERIOD9. The service level increments are defined in the Call Center Administration: VDN Call Profile Setup window. The ANSCONNCALLS10 item counts calls answered or connected after PERIOD9. Answered and connected calls include split/skill and direct agent ACD calls and extension calls by a "route to" or "adj rout link" vector command. The data in this column maps to the HVDN.ANSCONNCALLS9 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'ANS_CONN_CALLS9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times that calls are answered (ACDCALLS) or connected (CONNECTCALLS) during each of the service level increments PERIOD1 through PERIOD9. The service level increments are defined in the Call Center Administration: VDN Call Profile Setup window. The ANSCONNCALLS10 item counts calls answered or connected after PERIOD9. Answered and connected calls include split/skill and direct agent ACD calls and extension calls by a "route to" or "adj rout link" vector command. The data in this column maps to the HVDN.ANSCONNCALLS10 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'ANS_CONN_CALLS10'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of INCALLS that are abandoned in each of the service-level increments PERIOD1 through PERIOD9, as defined on the Call Center Administration: VDN Call Profile Setup window. ABNCALLS10 counts calls that abandoned after PERIOD9. The data in this column maps to the HVDN.ABNCALLS1 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'ABN_CALLS1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of INCALLS that are abandoned in each of the service-level increments PERIOD1 through PERIOD9, as defined on the Call Center Administration: VDN Call Profile Setup window. ABNCALLS10 counts calls that abandoned after PERIOD9. The data in this column maps to the HVDN.ABNCALLS2 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'ABN_CALLS2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of INCALLS that are abandoned in each of the service-level increments PERIOD1 through PERIOD9, as defined on the Call Center Administration: VDN Call Profile Setup window. ABNCALLS10 counts calls that abandoned after PERIOD9. The data in this column maps to the HVDN.ABNCALLS3 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'ABN_CALLS3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of INCALLS that are abandoned in each of the service-level increments PERIOD1 through PERIOD9, as defined on the Call Center Administration: VDN Call Profile Setup window. ABNCALLS10 counts calls that abandoned after PERIOD9. The data in this column maps to the HVDN.ABNCALLS4 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'ABN_CALLS4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of INCALLS that are abandoned in each of the service-level increments PERIOD1 through PERIOD9, as defined on the Call Center Administration: VDN Call Profile Setup window. ABNCALLS10 counts calls that abandoned after PERIOD9. The data in this column maps to the HVDN.ABNCALLS5 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'ABN_CALLS5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of INCALLS that are abandoned in each of the service-level increments PERIOD1 through PERIOD9, as defined on the Call Center Administration: VDN Call Profile Setup window. ABNCALLS10 counts calls that abandoned after PERIOD9. The data in this column maps to the HVDN.ABNCALLS6 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'ABN_CALLS6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of INCALLS that are abandoned in each of the service-level increments PERIOD1 through PERIOD9, as defined on the Call Center Administration: VDN Call Profile Setup window. ABNCALLS10 counts calls that abandoned after PERIOD9. The data in this column maps to the HVDN.ABNCALLS7 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'ABN_CALLS7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of INCALLS that are abandoned in each of the service-level increments PERIOD1 through PERIOD9, as defined on the Call Center Administration: VDN Call Profile Setup window. ABNCALLS10 counts calls that abandoned after PERIOD9. The data in this column maps to the HVDN.ABNCALLS8 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'ABN_CALLS8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of INCALLS that are abandoned in each of the service-level increments PERIOD1 through PERIOD9, as defined on the Call Center Administration: VDN Call Profile Setup window. ABNCALLS10 counts calls that abandoned after PERIOD9. The data in this column maps to the HVDN.ABNCALLS9 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'ABN_CALLS9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of INCALLS that are abandoned in each of the service-level increments PERIOD1 through PERIOD9, as defined on the Call Center Administration: VDN Call Profile Setup window. ABNCALLS10 counts calls that abandoned after PERIOD9. The data in this column maps to the HVDN.ABNCALLS10 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'ABN_CALLS10'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length, in seconds, of each service level increment as defined in the Call Center Administration: VDN Call Profile window. Each increment represents a progressively longer wait time. CMS counts answered or abandoned calls that wait beyond the last increment, which is PERIOD9, in ANSCONNCALLS10 or ABNCALLS10. The data in this column maps to the HVDN.PERIOD1 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'PERIOD1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length, in seconds, of each service level increment as defined in the Call Center Administration: VDN Call Profile window. Each increment represents a progressively longer wait time. CMS counts answered or abandoned calls that wait beyond the last increment, which is PERIOD9, in ANSCONNCALLS10 or ABNCALLS10. The data in this column maps to the HVDN.PERIOD2 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'PERIOD2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length, in seconds, of each service level increment as defined in the Call Center Administration: VDN Call Profile window. Each increment represents a progressively longer wait time. CMS counts answered or abandoned calls that wait beyond the last increment, which is PERIOD9, in ANSCONNCALLS10 or ABNCALLS10. The data in this column maps to the HVDN.PERIOD3 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'PERIOD3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length, in seconds, of each service level increment as defined in the Call Center Administration: VDN Call Profile window. Each increment represents a progressively longer wait time. CMS counts answered or abandoned calls that wait beyond the last increment, which is PERIOD9, in ANSCONNCALLS10 or ABNCALLS10. The data in this column maps to the HVDN.PERIOD4 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'PERIOD4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length, in seconds, of each service level increment as defined in the Call Center Administration: VDN Call Profile window. Each increment represents a progressively longer wait time. CMS counts answered or abandoned calls that wait beyond the last increment, which is PERIOD9, in ANSCONNCALLS10 or ABNCALLS10. The data in this column maps to the HVDN.PERIOD5 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'PERIOD5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length, in seconds, of each service level increment as defined in the Call Center Administration: VDN Call Profile window. Each increment represents a progressively longer wait time. CMS counts answered or abandoned calls that wait beyond the last increment, which is PERIOD9, in ANSCONNCALLS10 or ABNCALLS10. The data in this column maps to the HVDN.PERIOD6 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'PERIOD6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length, in seconds, of each service level increment as defined in the Call Center Administration: VDN Call Profile window. Each increment represents a progressively longer wait time. CMS counts answered or abandoned calls that wait beyond the last increment, which is PERIOD9, in ANSCONNCALLS10 or ABNCALLS10. The data in this column maps to the HVDN.PERIOD7 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'PERIOD7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length, in seconds, of each service level increment as defined in the Call Center Administration: VDN Call Profile window. Each increment represents a progressively longer wait time. CMS counts answered or abandoned calls that wait beyond the last increment, which is PERIOD9, in ANSCONNCALLS10 or ABNCALLS10. The data in this column maps to the HVDN.PERIOD8 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'PERIOD8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length, in seconds, of each service level increment as defined in the Call Center Administration: VDN Call Profile window. Each increment represents a progressively longer wait time. CMS counts answered or abandoned calls that wait beyond the last increment, which is PERIOD9, in ANSCONNCALLS10 or ABNCALLS10. The data in this column maps to the HVDN.PERIOD9 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'PERIOD9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'An indication of whether the service level was changed during the collection interval. Valid values for SVCLEVELCHG are 0, which means that no change was made, and 1, which means that a change was made.. The data in this column maps to the HVDN.SVCLEVELCHG column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'SVC_LEVEL_CHG'
GO
EXEC sp_addextendedproperty N'MS_Description', N'An indication of whether service level increments PERIOD1 through PERIOD9 changed during the collection interval. Service level is defined on the Call Center Administration: VDN Call Profile window. Valid values for PERIODCHG are 0, which means that no change was made, and 1, which means that a change was made. The data in this column maps to the HVDN.PERIODCHG column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'PERIOD_CHG'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of seconds within which calls must be answered or connected to be considered acceptable. The acceptable service level is defined on the Call Center Administration: VDN Call Profile Setup window. The data in this column maps to the HVDN.SERVICELEVEL column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'SERVICE_LEVEL'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of split/skill and direct agent ABNCALLS that are abandoned while ringing at an agent.. The data in this column maps to the HVDN.ABNRINGCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'ABN_RING_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time that split/skill and direct agent ACD calls spend ringing at agent positions independent of disposition or other agent activity. The data in this column maps to the HVDN.RINGTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'RING_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of split/skill and direct agent ACD calls that rang at agent positions. The data in this column maps to the HVDN.RINGCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'RING_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times that callers abandoned while on hold. The HOLDABNCALLS item applies to all of the calls that the agent put on hold. The data in this column maps to the HVDN.HOLDABNCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'HOLD_ABN_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of calls that are placed on hold at least once. HOLDCALLS includes HOLDABNCALLS and HOLDACDCALLS. The HOLDCALLS item applies to all of the calls that the agent put on hold. The data in this column maps to the HVDN.HOLDCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'HOLD_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time that callers spend on hold. HOLDTIME includes HOLDACDTIME. HOLDTIME applies to all of the calls that the agent puts on hold. The data in this column maps to the HVDN.HOLDTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'HOLD_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The maximum time that a call, recorded during the collection interval, waited in the VDN before being answered (ACD calls) or connected (non-ACD calls), abandoning, being redirected, receiving a busy signal or being disconnected. This applies only to the first disposition of the call. This is a maximum value item. The data in this column maps to the HVDN.MAXOCWTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'MAX_OCW_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The maximum number of calls that are in queue, in vector processing and ringing simultaneously in the VDN during the collection interval. The data in this column maps to the HVDN.MAXWAITING column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'MAX_WAITING'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The talk time for all CONNECTCALLS. CONNTALKTIME does not include HOLDTIME. The data in this column maps to the HVDN.CONNTALKTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'CONN_TALK_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of split/skill and direct agent ACD calls that rang at agent stations and then were automatically redirected by the Redirection on No Answer feature because they were not answered. The data in this column maps to the HVDN.NOANSREDIR column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'NO_ANS_REDIR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The first, second, and third VDN skills that are assigned to this VDN. The SKILL 1 through SKILL3 items are available with the EAS feature. The data in this column maps to the HVDN.SKILL1 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'SKILL1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The first, second, and third VDN skills that are assigned to this VDN. The SKILL 1 through SKILL3 items are available with the EAS feature. The data in this column maps to the HVDN.SKILL2 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'SKILL2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The first, second, and third VDN skills that are assigned to this VDN. The SKILL 1 through SKILL3 items are available with the EAS feature. The data in this column maps to the HVDN.SKILL3 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'SKILL3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of calls that are answered by agents in each VDN skill preference. The SKILLCALLS1 through SKILLCALLS3 items are available with the EAS feature. The data in this column maps to the HVDN.SKILLCALLS1 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'SKILL_CALLS1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of calls that are answered by agents in each VDN skill preference. The SKILLCALLS1 through SKILLCALLS3 items are available with the EAS feature. The data in this column maps to the HVDN.SKILLCALLS2 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'SKILL_CALLS2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of calls that are answered by agents in each VDN skill preference. The SKILLCALLS1 through SKILLCALLS3 items are available with the EAS feature. The data in this column maps to the HVDN.SKILLCALLS3 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'SKILL_CALLS3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time that agents spend talking on calls that are answered in each VDN skill preference. The SKILLTIME1 through SKILLTIME3 items are available with the EAS feature. The data in this column maps to the HVDN.SKILLTIME1 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'SKILL_TIME1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time that agents spend talking on calls that are answered in each VDN skill preference. The SKILLTIME1 through SKILLTIME3 items are available with the EAS feature. The data in this column maps to the HVDN.SKILLTIME2 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'SKILL_TIME2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time that agents spend talking on calls that are answered in each VDN skill preference. The SKILLTIME1 through SKILLTIME3 items are available with the EAS feature. The data in this column maps to the HVDN.SKILLTIME3 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'SKILL_TIME3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time that agents spend in ACW time for calls that are answered in each VDN skill preference. The SKILLACWTIME1 through SKILLACWTIME3 items are available with the EAS feature.. The data in this column maps to the HVDN.SKILLACWTIME1 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'SKILL_ACW_TIME1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time that agents spend in ACW time for calls that are answered in each VDN skill preference. The SKILLACWTIME1 through SKILLACWTIME3 items are available with the EAS feature.. The data in this column maps to the HVDN.SKILLACWTIME2 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'SKILL_ACW_TIME2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time that agents spend in ACW time for calls that are answered in each VDN skill preference. The SKILLACWTIME1 through SKILLACWTIME3 items are available with the EAS feature.. The data in this column maps to the HVDN.SKILLACWTIME3 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'SKILL_ACW_TIME3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'An indication of whether data is complete for this collection interval. Data is incomplete whenever the link goes down and whenever tracking is aborted for calls, because of the trunk going maintenance busy with a call active, protocol failures with data collection active, or when split/skill or VDN call profile is changed with data collection active. Valid values for the INCOMPLETE item are 1, which means that the data is incomplete, and 0, which means that the data is complete. The value in the daily, weekly, and monthly tables indicates the number of incomplete intervals in the day, week, or month. The data in this column maps to the HVDN.INCOMPLETE column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'INCOMPLETE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of split/skill or direct agent ACD calls that are placed on hold at least one time. The data in this column maps to the HVDN.HOLDACDCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'HOLD_ACD_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time that split/skill or direct agent ACD callers spend on hold. The data in this column maps to the HVDN.HOLDACDTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'HOLD_ACD_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of split/skill and direct agent ACD calls and calls that were routed to an agent or extension for which talk time is less than the value set for the phantom-abandon call timer. The data in this column maps to the HVDN.PHANTOMABNS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'PHANTOM_ABNS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of calls that reached this VDN by way of the VDN return destination feature. The data in this column maps to the HVDN.RETURNCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'RETURN_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of calls that are forced to disconnect because the vector disconnect timer expired or because the call reached a vector stop without being queued. A vector stop means that the "stop" vector command is executed, the end of the vector is reached, or the call executes 1000 vector steps. The data in this column maps to the HVDN.VDISCCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'VDISC_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of ABNCALLS for which the time-to-abandon was less than or equal to the administered SERVICELEVEL for this VDN. The data in this column maps to the HVDN.SLVLABNS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'SLVL_ABNS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of OUTFLOWCALLS for which the time-to-outflow was less than or equal to the administered SERVICELEVEL for this VDN. The data in this column maps to the HVDN.SLVLOUTFLOWS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'SLVL_OUTFLOWS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of calls that reached this VDN during this interval. The data in this column maps to the HVDN.I_ARRIVED column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'I_ARRIVED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The BSR numbers associated with the VDN. The data in this column maps to the HVDN.BSRPLAN column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'BSR_PLAN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of calls that deflected to the network using NCR. Each NCR invoke attempt is counted in LOOKATTEMPTS and in INTERFLOWCALLS. The DEFLECTCALLS item is available on the DEFINITY ECS R8.3 and later Avaya communication servers. The data in this column maps to the HVDN.DEFLECTCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'DEFLECT_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of calls that disconnected as a result of the BSR reply step. The data in this column maps to the HVDN.NETDISCCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'NET_DISC_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of calls that interflowed in from the network in BSR. This is a cumulative item. The data in this column maps to the HVDN.NETINCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'NET_IN_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The time, in seconds, that the call was in a VDN somewhere else in the network. The data in this column maps to the HVDN.NETINTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'NET_IN_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of network polls for "consider" vector steps in BSR. The data in this column maps to the HVDN.NETPOLLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'NET_POLLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of ACDCALLS that are answered by a Reserve 1 Agent. The data in this column maps to the HVDN.ACDCALLS_R1 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'ACD_CALLS_R1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of ACDCALLS that are answered by a Reserve 2 Agent. The data in this column maps to the HVDN.ACDCALLS_R2 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'ACD_CALLS_R2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of calls delivered to agents via the VDN upon agent surplus condition. The data in this column maps to the HVDN.AGSURPDELIVERIES column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'AG_SURP_DELIVERIES'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of calls delivered to preferred agents via the VDN upon agent surplus condition. A preferred agent is an agent with a skill level for the skill matches the level specified in the check vector command. The data in this column maps to the HVDN.AGSURPPREFCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'AG_SURP_PREF_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of calls delivered to not preferred agents via the VDN upon agent surplus condition. A preferred agent is an agent with a skill level for the skill matches the level specified in the check vector command. The data in this column maps to the HVDN.AGSURPNPREFCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'AG_SURP_NPREF_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of calls delivered to agents via the VDN upon call surplus condition. The data in this column maps to the HVDN.CALLSURPDELIVERIES column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'CALL_SURP_DELIVERIES'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a calculated field for help in calculating the number of calls that were busy and disconnected calls .', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'BUSY_DISCONNECT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a calculated field for help in calculating the number of calls answered for main split/skill calls .', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VDN_INTERVAL', 'COLUMN', N'MAIN_ACD_CALLS'
GO
GRANT SELECT
	ON [dbo].[TB_SUM_CMS_VDN_INTERVAL]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_SUM_CMS_VDN_INTERVAL]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_SUM_CMS_VDN_INTERVAL]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_SUM_CMS_VDN_INTERVAL] SET (LOCK_ESCALATION = TABLE)
GO
