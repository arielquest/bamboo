SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TB_SUM_CMS_VECTOR_INTERVAL] (
		[PARTITION_URN]            [int] NOT NULL,
		[PARTITION_GLOBAL_URN]     [bigint] NOT NULL,
		[PARTITION_ID]             [int] NOT NULL,
		[CLUSTER_RESOURCE_URN]     [int] NOT NULL,
		[ACD_URN]                  [int] NOT NULL,
		[VECTOR_URN]               [int] NOT NULL,
		[DATE_UTC_URN]             [int] NOT NULL,
		[TIME_UTC_URN]             [smallint] NOT NULL,
		[DB_DATETIME]              [datetime] NULL,
		[UTC_DATE_TIME]            [datetime] NOT NULL,
		[INTRVL]                   [int] NULL,
		[IN_CALLS]                 [int] NULL,
		[IN_TIME]                  [int] NULL,
		[ANS_TIME]                 [int] NULL,
		[ACD_CALLS]                [int] NULL,
		[BACKUP_CALLS]             [int] NULL,
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
		[GOTO_CALLS]               [int] NULL,
		[GOTO_TIME]                [int] NULL,
		[LOOK_ATTEMPTS]            [int] NULL,
		[LOOKFLOW_CALLS]           [int] NULL,
		[ADJ_ATTEMPTS]             [int] NULL,
		[ADJ_ROUTED]               [int] NULL,
		[IN_FLOW_CALLS]            [int] NULL,
		[ABN_RING_CALLS]           [int] NULL,
		[RING_TIME]                [int] NULL,
		[RING_CALLS]               [int] NULL,
		[INCOMPLETE]               [int] NULL,
		[PHANTOM_ABNS]             [int] NULL,
		[VDISC_CALLS]              [int] NULL,
		[DEFLECT_CALLS]            [int] NULL,
		[NET_DISC_CALLS]           [int] NULL,
		[NET_POLLS]                [int] NULL,
		[ACD_CALLS_R1]             [int] NULL,
		[ACD_CALLS_R2]             [int] NULL,
		[ICR_PULL_CALLS]           [int] NULL,
		[ICR_PULL_TIME]            [int] NULL,
		[ICR_PULL_QUE_CALLS]       [int] NULL,
		[ICR_PULL_RING_CALLS]      [int] NULL,
		CONSTRAINT [PK_SUM_CMS_VECTOR_INTERVAL]
		PRIMARY KEY
		CLUSTERED
		([PARTITION_URN], [PARTITION_ID])
	ON [SUMCMSGROUP]
) ON [SUMCMSGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_SUM_CMS_VECTOR_INTERVAL_ACD_URN]
	ON [dbo].[TB_SUM_CMS_VECTOR_INTERVAL] ([ACD_URN])
	ON [SUMCMSIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VECTOR_INTERVAL', 'INDEX', N'IX_SUM_CMS_VECTOR_INTERVAL_ACD_URN'
GO
CREATE NONCLUSTERED INDEX [IX_SUM_CMS_VECTOR_INTERVAL_VECTOR_URN]
	ON [dbo].[TB_SUM_CMS_VECTOR_INTERVAL] ([VECTOR_URN])
	ON [SUMCMSIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VECTOR_INTERVAL', 'INDEX', N'IX_SUM_CMS_VECTOR_INTERVAL_VECTOR_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the template table for the historical interval based call vector summary statistics from CMS systems. This table is created at install time and the partitioning service creates various partition tables with the same schema. These partition tables are prefixed as TB_SUM_CMS_VECTOR_INTERVAL_ followed by the partition identifier. The partition identifier is created depending on the partition configuration, for example monthly, weekly etc. All currently active partitions are included VW_PARTITONED_SUM_CMS_VECTOR_INTERVAL view. Since the partitioned tables are generated at runtime and that they have the same schema no separate documentations are required for each partition table. In case of a configured Avaya CMS the data in these partition tables are sourced from the  table in cms Database.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VECTOR_INTERVAL', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary Key Identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VECTOR_INTERVAL', 'COLUMN', N'PARTITION_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column holds a value that uniquely identifies a row across all the partition tables for this partition type.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VECTOR_INTERVAL', 'COLUMN', N'PARTITION_GLOBAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number for the current partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VECTOR_INTERVAL', 'COLUMN', N'PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from the table dbo.TB_CLU_RESOURCE indicating the source of the data..', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VECTOR_INTERVAL', 'COLUMN', N'CLUSTER_RESOURCE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_PERIPHERAL corresponding to an item of type PT_ACD. This corresponds to the ACD associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VECTOR_INTERVAL', 'COLUMN', N'ACD_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_PERIPHERAL', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VECTOR_INTERVAL', 'COLUMN', N'ACD_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_VECTOR corresponding to an item of type IT_VECTOR. This corresponds to the VECTOR associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VECTOR_INTERVAL', 'COLUMN', N'VECTOR_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_VECTOR', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VECTOR_INTERVAL', 'COLUMN', N'VECTOR_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the date associated with the record. This is calculated by the data importer based on the source data time corresponding to the start of the reporting interval from the source data.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VECTOR_INTERVAL', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the time associated with the record. This is calculated by the data importer based on the source data time corresponding to the start of the reporting interval from the source data.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VECTOR_INTERVAL', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the datetime stamp associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VECTOR_INTERVAL', 'COLUMN', N'DB_DATETIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The UTC start time of the interval for which data was collected. It is records in number of seconds since midnight 01/01/1970 UTC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VECTOR_INTERVAL', 'COLUMN', N'UTC_DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of minutes in the intrahour interval. The length of the intrahour interval can be 15, 30, or 60 minutes. INTRVL applies to intrahour tables only. The data in this column maps to the HVECTOR.INTRVL column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VECTOR_INTERVAL', 'COLUMN', N'INTRVL'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of inbound calls that are processed by this vector. INCALLS includes ABNCALLS, RINGCALLS, INFLOWCALLS, and OTHERCALLS. INCALLS = ACDCALLS + ABNCALLS + OTHERCALLS. The data in this column maps to the HVECTOR.INCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VECTOR_INTERVAL', 'COLUMN', N'IN_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time spent by INCALLS by this VECTOR executing steps. The data in this column maps to the HVECTOR.INTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VECTOR_INTERVAL', 'COLUMN', N'IN_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time that split/skill and direct agent ACD calls waited while vector steps are executed, in queue, and ringing before an agent answers the call. ANSTIME includes RINGTIME.. The data in this column maps to the HVECTOR.ANSTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VECTOR_INTERVAL', 'COLUMN', N'ANS_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of split/skill and direct agent ACD calls that are answered by an agent from "queue to," "check," "messaging split/skill," "route to," "split/skill" or "direct agent," and "adj rout link" to split/skill or direct agent.. The data in this column maps to the HVECTOR.ACDCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VECTOR_INTERVAL', 'COLUMN', N'ACD_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of ACDCALLS that are delivered by a vector command other than "queue to" and answered by this split/skill plus the number of ACDCALLS that are delivered to this split/skill by a "queue to" vector command and answered by an agent who has either Reserve 1 or Reserve 2 skill levels assigned for this skill. The data in this column maps to the HVECTOR.BACKUPCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VECTOR_INTERVAL', 'COLUMN', N'BACKUP_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of INCALLS that are abandoned while INPROGRESS for this vector. This includes split/skill and direct agent ACD calls that abandon from queue or from ringing, and calls that abandon from vector processing. ABNCALLS includes ABNQUECALLS, ABNRINGCALLS, and PHANTOMABNS. The data in this column maps to the HVECTOR.ABNCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VECTOR_INTERVAL', 'COLUMN', N'ABN_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time that a caller spent waiting while vector steps were executed, the call was queued and ringing before abandoning. For phantom abandons, ABNTIME includes the total time until the agent releases the call.. The data in this column maps to the HVECTOR.ABNTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VECTOR_INTERVAL', 'COLUMN', N'ABN_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of ABNCALLS that are abandoned while in a split/skill or direct agent ACD queue. The data in this column maps to the HVECTOR.ABNQUECALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VECTOR_INTERVAL', 'COLUMN', N'ABN_QUE_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of INCALLS that are given a busy signal by the communication server. This occurs when the "busy vector command executes. In addition, BUSYCALLS occurs if a call is routed to a split/skill with coverage set to "yes" where there are no agents available, the queue is full or there is no queue, no coverage path is administered, and an announcement has played or the trunk is not a CO trunk. BUSYCALLS occurs if a call is routed to a direct agent with coverage set to "yes", the agent is not logged in, there is no coverage path administered, and an announcement has played or the trunk is not a CO trunk. The data in this column maps to the HVECTOR.BUSYCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VECTOR_INTERVAL', 'COLUMN', N'BUSY_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time that callers wait in queue before hearing a busy tone for all BUSYCALLS. The data in this column maps to the HVECTOR.BUSYTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VECTOR_INTERVAL', 'COLUMN', N'BUSY_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of INCALLS that executed the "disconnect" and "reply best" vector command.DISCCALLS also includes calls that are disconnected by the communication server when the vector disconnect timer expires or calls that reached the end of vector processing without being queued. DISCCALLS includes VDISCCALLS. The data in this column maps to the HVECTOR.DISCCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VECTOR_INTERVAL', 'COLUMN', N'DISC_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time that all DISCCALLS spent in this VECTOR. DISCTIME includes the time that elapses until the trunk drops following the forced disconnect command, or when the caller hangs up without listening to the entire announcement. When the caller listens to the entire announcement, DISCTIME is the length of time until the announcement ends and the caller is disconnected by the communication server, or when the vector disconnect timer expires. The data in this column maps to the HVECTOR.DISCTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VECTOR_INTERVAL', 'COLUMN', N'DISC_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of INCALLS that are redirected out of the vector, given a busy signal, or are disconnected. OTHERCALLS includes BUSYCALLS, DISCCALLS, and OUTFLOWCALLS. OTHERCALLS = INCALLS - ACDCALLS - ABNCALLS. The data in this column maps to the HVECTOR.OTHERCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VECTOR_INTERVAL', 'COLUMN', N'OTHER_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time that OTHERCALLS spend in the vector until the disposition is known and the call leaves the vector. OTHERTIME includes BUSYTIME, DISCTIME, and OUTFLOWTIME. The data in this column maps to the HVECTOR.OTHERTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VECTOR_INTERVAL', 'COLUMN', N'OTHER_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of INCALLS that are redirected to another destination by way of a "go to" vector command or by a "route to" or "adj rout link" command to a destination other than a split/skill or direct agent. Calls that route to a split/skill or direct agent by way of a "route to", "adj rout link", or "messaging split/skill" vector command are still tracked in the vector. OUTFLOWCALLS includes GOTOCALLS and INTERFLOWCALLS. The data in this column maps to the HVECTOR.OUTFLOWCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VECTOR_INTERVAL', 'COLUMN', N'OUT_FLOW_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time that all OUTFLOWCALLS spend in the VECTOR before being redirected. OUTFLOWTIME includes GOTOTIME. The data in this column maps to the HVECTOR.OUTFLOWTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VECTOR_INTERVAL', 'COLUMN', N'OUT_FLOW_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of OUTFLOWCALLS that are redirected to a destination outside the communication server. INTERFLOWCALLS includes LOOKFLOWCALLS (successful Look-Ahead Interflow and BSR) and DEFLECTCALLS (successful NCR redirections).. The data in this column maps to the HVECTOR.INTERFLOWCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VECTOR_INTERVAL', 'COLUMN', N'INTERFLOW_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of OUTFLOWCALLS that are redirected to another vector by way of a "go to vector command. The data in this column maps to the HVECTOR.GOTOCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VECTOR_INTERVAL', 'COLUMN', N'GOTO_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The time that all GOTOCALLS spent in this vector before being redirected to another vector. This is a cumulative item. The data in this column maps to the HVECTOR.GOTOTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VECTOR_INTERVAL', 'COLUMN', N'GOTO_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times that Look-Ahead Interflow or BSR Interflow was attempted for calls in this vector. Network Call Redirection (Network call Deflection [NCD] or Network Call Transfer [NCT]) invoke attempts are also counted as LOOKATTEMPTS. Look-Ahead Interflow and BSR interflow attempts that are successful are also counted as LOOKFLOWCALLS. NCR attempts that are successful are also counted as DEFLECTCALLS. BSR poll calls are not counted as LOOKATTEMPTS. They are counted as NETPOLLS. The data in this column maps to the HVECTOR.LOOKATTEMPTS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VECTOR_INTERVAL', 'COLUMN', N'LOOK_ATTEMPTS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of INTERFLOWCALLS that are redirected by way of the Look-Ahead Interflow or BSR features. The LOOKFLOWCALLS item is available with the Look-Ahead Interflow feature. LOOKFLOWCALLS is a subset of INTERFLOWCALLS and includes LOOKATTEMPTS for the Look-Ahead Interflow or BSR interflows. With BSR interflow, every LOOKATTEMPTS should also be counted as a LOOKFLOWCALLS unless a failure occurs. The data in this column maps to the HVECTOR.LOOKFLOWCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VECTOR_INTERVAL', 'COLUMN', N'LOOKFLOW_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of adjunct-routing attempts for calls in this VECTOR. ADJATTEMPTS includes ADJROUTED. ADJATTEMPTS is available with the vectoring and the ASAI feature. The data in this column maps to the HVECTOR.ADJATTEMPTS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VECTOR_INTERVAL', 'COLUMN', N'ADJ_ATTEMPTS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of adjunct-routing calls that are redirected by an adjunct processor or host computer. ADJROUTED is available with the Vectoring and the ASAI features. The data in this column maps to the HVECTOR.ADJROUTED column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VECTOR_INTERVAL', 'COLUMN', N'ADJ_ROUTED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of calls that are redirected to this vector by way of a "go to vector" command, a "route to" VDN command, or by the Redirection on No Answer feature to a VDN. The data in this column maps to the HVECTOR.INFLOWCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VECTOR_INTERVAL', 'COLUMN', N'IN_FLOW_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of split/skill or direct agent ABNCALLS that are abandoned while ringing at an agent position.. The data in this column maps to the HVECTOR.ABNRINGCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VECTOR_INTERVAL', 'COLUMN', N'ABN_RING_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time that split/skill and direct agent ACD calls spend ringing at agent positions independent of disposition or other agent activity. The data in this column maps to the HVECTOR.RINGTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VECTOR_INTERVAL', 'COLUMN', N'RING_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of split/skill and direct agent ACD calls that rang at agent positions. The data in this column maps to the HVECTOR.RINGCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VECTOR_INTERVAL', 'COLUMN', N'RING_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'An indication of whether data is complete for this collection interval. Data is incomplete whenever the link goes down and whenever tracking is aborted for calls, because of the trunk going maintenance busy with a call active, protocol failures with data collection active, or when split/skill or VDN call profile is changed with data collection active. Valid values for the INCOMPLETE item are 1, which means that the data is incomplete, and 0, which means that the data is complete. The value in the daily, weekly, and monthly tables indicates the number of incomplete intervals in the day, week, or month. The data in this column maps to the HVECTOR.INCOMPLETE column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VECTOR_INTERVAL', 'COLUMN', N'INCOMPLETE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of split/skill and direct agent ACD calls and calls that were routed to an agent or extension for which talk time is less than the value of the phantom-abandon call timer. The data in this column maps to the HVECTOR.PHANTOMABNS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VECTOR_INTERVAL', 'COLUMN', N'PHANTOM_ABNS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of calls that are forced to disconnect because the vector disconnect timer expired or because the call reached a vector stop without being queued. A vector stop means that the "stop" vector command is executed, the end of the vector is reached, or the call executes 1000 vector steps. The data in this column maps to the HVECTOR.VDISCCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VECTOR_INTERVAL', 'COLUMN', N'VDISC_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of calls that are deflected to the network using Network Call Redirection (NCR). Each NCR invoke attempt is counted in LOOKATTEMPTS and in INTERFLOWCALLS. The data in this column maps to the HVECTOR.DEFLECTCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VECTOR_INTERVAL', 'COLUMN', N'DEFLECT_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of calls that disconnected as a result of the reply step in BSR. The data in this column maps to the HVECTOR.NETDISCCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VECTOR_INTERVAL', 'COLUMN', N'NET_DISC_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of network polls for the "consider" vector steps in BSR. The data in this column maps to the HVECTOR.NETPOLLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VECTOR_INTERVAL', 'COLUMN', N'NET_POLLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of ACDCALLS that are answered by a Reserve 1 Agent. The data in this column maps to the HVECTOR.ACDCALLS_R1 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VECTOR_INTERVAL', 'COLUMN', N'ACD_CALLS_R1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of ACDCALLS that are answered by a Reserve 2 Agent. The data in this column maps to the HVECTOR.ACDCALLS_R2 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_VECTOR_INTERVAL', 'COLUMN', N'ACD_CALLS_R2'
GO
GRANT SELECT
	ON [dbo].[TB_SUM_CMS_VECTOR_INTERVAL]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_SUM_CMS_VECTOR_INTERVAL]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_SUM_CMS_VECTOR_INTERVAL]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_SUM_CMS_VECTOR_INTERVAL] SET (LOCK_ESCALATION = TABLE)
GO
