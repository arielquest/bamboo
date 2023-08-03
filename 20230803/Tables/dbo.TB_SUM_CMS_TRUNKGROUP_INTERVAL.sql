SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TB_SUM_CMS_TRUNKGROUP_INTERVAL] (
		[PARTITION_URN]            [int] NOT NULL,
		[PARTITION_GLOBAL_URN]     [bigint] NOT NULL,
		[PARTITION_ID]             [int] NOT NULL,
		[CLUSTER_RESOURCE_URN]     [int] NOT NULL,
		[ACD_URN]                  [int] NOT NULL,
		[VDN_URN]                  [int] NOT NULL,
		[SKILLGROUP_URN]           [int] NOT NULL,
		[TRUNKGROUP_URN]           [int] NOT NULL,
		[DATE_UTC_URN]             [int] NOT NULL,
		[TIME_UTC_URN]             [smallint] NOT NULL,
		[DB_DATETIME]              [datetime] NULL,
		[UTC_DATE_TIME]            [datetime] NOT NULL,
		[INTRVL]                   [int] NULL,
		[TRUNKS]                   [int] NULL,
		[IN_CALLS]                 [int] NULL,
		[IN_TIME]                  [int] NULL,
		[I_IN_OCC]                 [int] NULL,
		[ACD_CALLS]                [int] NULL,
		[BACKUP_CALLS]             [int] NULL,
		[TRANSFERRED]              [int] NULL,
		[ABN_CALLS]                [int] NULL,
		[ABN_VEC_CALLS]            [int] NULL,
		[ABN_QUE_CALLS]            [int] NULL,
		[BUSY_CALLS]               [int] NULL,
		[DISC_CALLS]               [int] NULL,
		[OTHER_CALLS]              [int] NULL,
		[OUT_CALLS]                [int] NULL,
		[OUT_TIME]                 [int] NULL,
		[I_OUT_OCC]                [int] NULL,
		[COMPLETED]                [int] NULL,
		[SETUP_TIME]               [int] NULL,
		[O_ACD_CALLS]              [int] NULL,
		[O_ABN_CALLS]              [int] NULL,
		[O_OTHER_CALLS]            [int] NULL,
		[BLOCKAGE]                 [int] NULL,
		[FAILURES]                 [int] NULL,
		[AUDIO]                    [int] NULL,
		[MBUSY_TIME]               [int] NULL,
		[ALL_IN_USE_TIME]          [int] NULL,
		[CONNECT_CALLS]            [int] NULL,
		[SHORT_CALLS]              [int] NULL,
		[ABN_RING_CALLS]           [int] NULL,
		[INCOMPLETE]               [int] NULL,
		[ACD_CALLS_R1]             [int] NULL,
		[ACD_CALLS_R2]             [int] NULL,
		[ICR_PULL_CALLS]           [int] NULL,
		[ICR_PULL_VEC_CALLS]       [int] NULL,
		[ICR_PULL_QUE_CALLS]       [int] NULL,
		[ICR_PULL_RING_CALLS]      [int] NULL,
		[TRK_HOLD_TIME]            [int] NULL,
		[TRK_HOLD_CALLS]           [int] NULL,
		CONSTRAINT [PK_SUM_CMS_TRUNKGROUP_INTERVAL]
		PRIMARY KEY
		CLUSTERED
		([PARTITION_URN], [PARTITION_ID])
	ON [SUMCMSGROUP]
) ON [SUMCMSGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_SUM_CMS_TRUNKGROUP_INTERVAL_ACD_URN]
	ON [dbo].[TB_SUM_CMS_TRUNKGROUP_INTERVAL] ([ACD_URN])
	ON [SUMCMSIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNKGROUP_INTERVAL', 'INDEX', N'IX_SUM_CMS_TRUNKGROUP_INTERVAL_ACD_URN'
GO
CREATE NONCLUSTERED INDEX [IX_SUM_CMS_TRUNKGROUP_INTERVAL_SKILLGROUP_URN]
	ON [dbo].[TB_SUM_CMS_TRUNKGROUP_INTERVAL] ([SKILLGROUP_URN])
	ON [SUMCMSIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNKGROUP_INTERVAL', 'INDEX', N'IX_SUM_CMS_TRUNKGROUP_INTERVAL_SKILLGROUP_URN'
GO
CREATE NONCLUSTERED INDEX [IX_SUM_CMS_TRUNKGROUP_INTERVAL_TRUNKGROUP_URN]
	ON [dbo].[TB_SUM_CMS_TRUNKGROUP_INTERVAL] ([TRUNKGROUP_URN])
	ON [SUMCMSIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNKGROUP_INTERVAL', 'INDEX', N'IX_SUM_CMS_TRUNKGROUP_INTERVAL_TRUNKGROUP_URN'
GO
CREATE NONCLUSTERED INDEX [IX_SUM_CMS_TRUNKGROUP_INTERVAL_VDN_URN]
	ON [dbo].[TB_SUM_CMS_TRUNKGROUP_INTERVAL] ([VDN_URN])
	ON [SUMCMSIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNKGROUP_INTERVAL', 'INDEX', N'IX_SUM_CMS_TRUNKGROUP_INTERVAL_VDN_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the template table for the historical interval based call trunk group summary statistics from CMS systems. This table is created at install time and the partitioning service creates various partition tables with the same schema. These partition tables are prefixed as TB_SUM_CMS_TRUNKGROUP_INTERVAL_ followed by the partition identifier. The partition identifier is created depending on the partition configuration, for example monthly, weekly etc. All currently active partitions are included VW_PARTITONED_SUM_CMS_TRUNKGROUP_INTERVAL view. Since the partitioned tables are generated at runtime and that they have the same schema no separate documentations are required for each partition table. In case of a configured Avaya CMS the data in these partition tables are sourced from the  table in cms Database.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNKGROUP_INTERVAL', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary Key Identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNKGROUP_INTERVAL', 'COLUMN', N'PARTITION_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column holds a value that uniquely identifies a row across all the partition tables for this partition type.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNKGROUP_INTERVAL', 'COLUMN', N'PARTITION_GLOBAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number for the current partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNKGROUP_INTERVAL', 'COLUMN', N'PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from the table dbo.TB_CLU_RESOURCE indicating the source of the data..', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNKGROUP_INTERVAL', 'COLUMN', N'CLUSTER_RESOURCE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_PERIPHERAL corresponding to an item of type PT_ACD. This corresponds to the ACD associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNKGROUP_INTERVAL', 'COLUMN', N'ACD_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_PERIPHERAL', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNKGROUP_INTERVAL', 'COLUMN', N'ACD_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_VECTOR_DIRECTORY_NUMBER corresponding to an item of type IT_VECTOR_DIRECTORY_NUMBER. This corresponds to the VDN associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNKGROUP_INTERVAL', 'COLUMN', N'VDN_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_VECTOR_DIRECTORY_NUMBER', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNKGROUP_INTERVAL', 'COLUMN', N'VDN_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_SKILLGROUP corresponding to an item of type IT_SKILLGROUP. This corresponds to the skillgroup associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNKGROUP_INTERVAL', 'COLUMN', N'SKILLGROUP_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_SKILLGROUP', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNKGROUP_INTERVAL', 'COLUMN', N'SKILLGROUP_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_TRUNK corresponding to an item of type IT_TRUNKGROUP. This corresponds to the trunkgroup associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNKGROUP_INTERVAL', 'COLUMN', N'TRUNKGROUP_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TRUNK_GROUP', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNKGROUP_INTERVAL', 'COLUMN', N'TRUNKGROUP_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the date associated with the record. This is calculated by the data importer based on the source data time corresponding to the start of the reporting interval from the source data.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNKGROUP_INTERVAL', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the time associated with the record. This is calculated by the data importer based on the source data time corresponding to the start of the reporting interval from the source data.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNKGROUP_INTERVAL', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the datetime stamp associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNKGROUP_INTERVAL', 'COLUMN', N'DB_DATETIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The UTC start time of the interval for which data was collected. It is records in number of seconds since midnight 01/01/1970 UTC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNKGROUP_INTERVAL', 'COLUMN', N'UTC_DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of minutes in the intrahour interval. The length of the intrahour interval can be 15, 30, or 60 minutes. INTRVL applies to intrahour tables only. The data in this column maps to the HTKGRP.INTRVL column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNKGROUP_INTERVAL', 'COLUMN', N'INTRVL'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of trunks that are currently assigned to this TKGRP. The data in this column maps to the HTKGRP.TRUNKS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNKGROUP_INTERVAL', 'COLUMN', N'TRUNKS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of inbound calls that are carried by this TKGRP and that completed during the collection interval. INCALLS includes ABNCALLS, ACDCALLS, OTHERCALLS, CONNECTCALLS, and TRANSFERRED. INCALLS = ACDCALLS + ABNCALLS + OTHERCALLS. The data in this column maps to the HTKGRP.INCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNKGROUP_INTERVAL', 'COLUMN', N'IN_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The trunk holding time for all INCALLS that are carried by trunks in this trunk group and complete during the collection interval. Trunk holding time is the length of time from the initial trunk seizure until the trunk goes idle. The trunk goes idle when the caller drops, the agent releases the call, or the communication server disconnects the call. If an incoming call on a measured trunk is transferred off the communication server, the incoming trunk remains in use for the call and accrues trunk holding time until the caller drops or the call is released. The data in this column maps to the HTKGRP.INTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNKGROUP_INTERVAL', 'COLUMN', N'IN_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The total length of time during the collection interval that trunks in the trunk group were occupied by incoming calls. If an incoming call on a measured trunk is transferred off of the communication server, the incoming trunk remains in use for the call and accrues trunk holding time until the caller drops or the call is released. The data in this column maps to the HTKGRP.I_INOCC column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNKGROUP_INTERVAL', 'COLUMN', N'I_IN_OCC'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of INCALLS that are answered by an agent as a split/skill or direct agent ACD call. The data in this column maps to the HTKGRP.ACDCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNKGROUP_INTERVAL', 'COLUMN', N'ACD_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of ACDCALLS that are delivered by a vector command other than "queue to" and answered by this split/skill plus the number of ACDCALLS that are delivered to this split/skill by a "queue to" vector command and answered by an agent who has either Reserve 1 or Reserve 2 skill levels assigned for this skill. The data in this column maps to the HTKGRP.BACKUPCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNKGROUP_INTERVAL', 'COLUMN', N'BACKUP_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of calls that the agent transferred to another destination. TRANSFERRED calls include both inbound and outbound calls. Therefore, OTHERCALLS and O_OTHERCALLS may each include some TRANSFERRED. TRANSFERRED includes all calls that are transferred.. The data in this column maps to the HTKGRP.TRANSFERRED column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNKGROUP_INTERVAL', 'COLUMN', N'TRANSFERRED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of calls carried by this trunk group that are abandoned by the caller before being answered by an agent. ABNCALLS includes PHANTOMABNS, which are ACD calls and calls routed to an agent or extension with talk times less than the value of the phantom-abandon call timer. The data in this column maps to the HTKGRP.ABNCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNKGROUP_INTERVAL', 'COLUMN', N'ABN_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of ABNCALLS that abandoned while in vector processing. This includes vector calls that abandoned while in queue or while ringing at an agent position. The ABNVECCALLS item is available with the Vectoring feature. The data in this column maps to the HTKGRP.ABNVECCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNKGROUP_INTERVAL', 'COLUMN', N'ABN_VEC_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of ABNCALLS that are abandoned while in a split/skill or direct agent ACD queue. The data in this column maps to the HTKGRP.ABNQUECALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNKGROUP_INTERVAL', 'COLUMN', N'ABN_QUE_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of INCALLS that are given a busy signal by the communication server. This occurs when the "busy" vector command executes. BUSYCALLS occurs if a call is routed to a split/skill with coverage set to "yes" and there are no agents available, the queue is full or there is no queue, there is no coverage, and an announcement has played or the trunk is not a CO trunk.BUSYCALLS can occur if a call is routed to a direct agent with coverage set to "yes", the agent is not logged in, no coverage path is administered, and an announcement has played or the trunk is not a CO trunk. BUSYCALLS can occur without vectoring when a split queue is full or there are no queue slots available, no busy coverage is administered and an announcement has played, or the trunk is not a CO trunk. The data in this column maps to the HTKGRP.BUSYCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNKGROUP_INTERVAL', 'COLUMN', N'BUSY_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of INCALLS that are disconnected by the communication server by the "disconnect" vector command. DISCCALLS also includes calls that are disconnected by the communication server when the vector disconnect timer expires or calls that reached the end of vector processing without being queued. The data in this column maps to the HTKGRP.DISCCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNKGROUP_INTERVAL', 'COLUMN', N'DISC_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of INCALLS carried by this trunk group that are not answered as split/skill or direct agent ACD calls or do not abandon. These include forced busy calls, forced disconnect calls, calls that are connected to a non-ACD destination, short inbound calls, calls that outflowed off the communication server, and calls with unknown dispositions. OTHERCALLS includes BUSYCALLS, DISCCALLS, SHORTCALLS, and CONNECTCALLS. OTHERCALLS = INCALLS - ACDCALLS - ABNCALLS. The data in this column maps to the HTKGRP.OTHERCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNKGROUP_INTERVAL', 'COLUMN', N'OTHER_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of outbound calls that are carried by this TKGRP and complete during the collection interval. OUTCALLS includes COMPLETED, O_ABNCALLS, O_ACDCALLS, O_OTHERCALLS, TRANSFERRED, and SHORTCALLS. OUTCALLS = O_ACDCALLS + O_ABNCALLS + O_OTHERCALLS. The data in this column maps to the HTKGRP.OUTCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNKGROUP_INTERVAL', 'COLUMN', N'OUT_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The trunk holding time for all OUTCALLS that are carried by trunks in this trunk group and complete during the collection interval. Trunk holding time is the time from the initial trunk seizure until the trunk goes idle. The trunk does not go idle until far end drops, the agent releases the call, or the communication server disconnects the call. OUTTIME includes SETUPTIME.. The data in this column maps to the HTKGRP.OUT_TIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNKGROUP_INTERVAL', 'COLUMN', N'OUT_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that trunks in this trunk group were occupied by outgoing calls. The data in this column maps to the HTKGRP.I_OUTOCC column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNKGROUP_INTERVAL', 'COLUMN', N'I_OUT_OCC'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of OUTCALLS that are completed by being answered at the far end. The data in this column maps to the HTKGRP.COMPLETED column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNKGROUP_INTERVAL', 'COLUMN', N'COMPLETED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time from trunk seizure until OUTCALLS complete at the far end. The data in this column maps to the HTKGRP.SETUPTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNKGROUP_INTERVAL', 'COLUMN', N'SETUP_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of OUTCALLS from this trunk group that are offered by an adjunct to one or more splits/skills and were answered by an agent. The O_ACDCALLS item is available with the ASAI feature.. The data in this column maps to the HTKGRP.O_ACDCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNKGROUP_INTERVAL', 'COLUMN', N'O_ACD_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of OUTCALLS on this trunk group that are offered by an adjunct as split/skill or direct agent ACD calls and were answered and then abandoned by the far end. The O_ABNCALLS item is available with the ASAI feature. The data in this column maps to the HTKGRP.O_ABNCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNKGROUP_INTERVAL', 'COLUMN', N'O_ABN_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of OUTCALLS on this trunk group that are not answered or abandoned as ACD split/skill calls. O_OTHERCALLS includes extension out calls, calls forced busy and forced disconnected, short outgoing calls, and calls with unknown dispositions. O_OTHERCALLS includes SHORTCALLS. The data in this column maps to the HTKGRP.O_OTHERCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNKGROUP_INTERVAL', 'COLUMN', N'O_OTHER_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of outbound call attempts that are blocked because all trunks are busy. This item is available for G2 only and is no longer supported. The data in this column maps to the HTKGRP.BLOCKAGE column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNKGROUP_INTERVAL', 'COLUMN', N'BLOCKAGE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Number of trunk hardware failures for this trunk group. The data in this column maps to the HTKGRP.FAILURES column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNKGROUP_INTERVAL', 'COLUMN', N'FAILURES'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of calls for which audio difficulty problems were reported for a trunk or for trunks in this trunk group. The data in this column maps to the HTKGRP.AUDIO column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNKGROUP_INTERVAL', 'COLUMN', N'AUDIO'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The total time during the collection interval that trunks in the trunk group were maintenance busy. The data in this column maps to the HTKGRP.MBUSYTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNKGROUP_INTERVAL', 'COLUMN', N'MBUSY_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the interval that all trunks in the trunk group are in use. Usage for a trunk is on a call or maintenance busy. The data in this column maps to the HTKGRP.ALLINUSETIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNKGROUP_INTERVAL', 'COLUMN', N'ALL_IN_USE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of INCALLS that are answered at a station and are not split/skill or direct agent ACD calls. The data in this column maps to the HTKGRP.CONNECTCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNKGROUP_INTERVAL', 'COLUMN', N'CONNECT_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of inbound and outbound calls that occupied a trunk in the trunk group for less than 2 seconds and that did not queue to a split/skill, forward to a split/skill, get answered by an agent, get a forced busy or forced disconnect from the communication server, or produce a trunk failure or maintenance busy. SHORTCALLS includes both inbound and outbound calls. Therefore, OTHERCALLS and O_OTHERCALLS may each include some SHORTCALLS. The data in this column maps to the HTKGRP.SHORTCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNKGROUP_INTERVAL', 'COLUMN', N'SHORT_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of split/skill or direct agent ABNCALLS that are abandoned while ringing at an agent position. The data in this column maps to the HTKGRP.ABNRINGCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNKGROUP_INTERVAL', 'COLUMN', N'ABN_RING_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'An indication of whether data is complete for this collection interval. Data is incomplete whenever the link goes down and whenever tracking is aborted for calls, because of the trunk going maintenance busy with a call active, protocol failures with data collection active, or when split/skill or VDN call profile is changed with data collection active. Valid values for the INCOMPLETE item are 1, which means that the data is incomplete, and 0, which means that the data is complete. The value in the daily, weekly, and monthly tables indicates the number of incomplete intervals in the day, week, or month. The data in this column maps to the HTKGRP.INCOMPLETE column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNKGROUP_INTERVAL', 'COLUMN', N'INCOMPLETE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of ACDCALLS that are answered by a Reserve 1 Agent as a split/skill ACD call. The data in this column maps to the HTKGRP.ACDCALLS_R1 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNKGROUP_INTERVAL', 'COLUMN', N'ACD_CALLS_R1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of ACDCALLS that are answered by a Reserve 2 Agent as a split/skill ACD call. The data in this column maps to the HTKGRP.ACDCALLS_R2 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNKGROUP_INTERVAL', 'COLUMN', N'ACD_CALLS_R2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a calculated field for help in calculating Average trunk holding time.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNKGROUP_INTERVAL', 'COLUMN', N'TRK_HOLD_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a calculated field for help in calculating Average trunk holding calls.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNKGROUP_INTERVAL', 'COLUMN', N'TRK_HOLD_CALLS'
GO
GRANT SELECT
	ON [dbo].[TB_SUM_CMS_TRUNKGROUP_INTERVAL]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_SUM_CMS_TRUNKGROUP_INTERVAL]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_SUM_CMS_TRUNKGROUP_INTERVAL]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_SUM_CMS_TRUNKGROUP_INTERVAL] SET (LOCK_ESCALATION = TABLE)
GO
