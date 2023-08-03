SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TB_SUM_CMS_TRUNK_INTERVAL] (
		[PARTITION_URN]            [int] NOT NULL,
		[PARTITION_GLOBAL_URN]     [bigint] NOT NULL,
		[PARTITION_ID]             [int] NOT NULL,
		[CLUSTER_RESOURCE_URN]     [int] NOT NULL,
		[ACD_URN]                  [int] NOT NULL,
		[TRUNKGROUP_URN]           [int] NOT NULL,
		[TRUNK_URN]                [int] NOT NULL,
		[DATE_UTC_URN]             [int] NOT NULL,
		[TIME_UTC_URN]             [smallint] NOT NULL,
		[DB_DATETIME]              [datetime] NULL,
		[UTC_DATE_TIME]            [datetime] NOT NULL,
		[INTRVL]                   [int] NULL,
		[LOC_ID]                   [int] NULL,
		[IN_CALLS]                 [int] NULL,
		[IN_TIME]                  [int] NULL,
		[I_IN_OCC]                 [int] NULL,
		[ABN_CALLS]                [int] NULL,
		[O_ABN_CALLS]              [int] NULL,
		[OUT_CALLS]                [int] NULL,
		[OUT_TIME]                 [int] NULL,
		[I_OUT_OCC]                [int] NULL,
		[FAILURES]                 [int] NULL,
		[AUDIO]                    [int] NULL,
		[MBUSY_TIME]               [int] NULL,
		[ACD_CALLS]                [int] NULL,
		[OTHER_CALLS]              [int] NULL,
		[SHORT_CALLS]              [int] NULL,
		[O_ACD_CALLS]              [int] NULL,
		[O_OTHER_CALLS]            [int] NULL,
		[INCOMPLETE]               [int] NULL,
		[ACD_CALLS_R1]             [int] NULL,
		[ACD_CALLS_R2]             [int] NULL,
		[ICR_PULL_CALLS]           [int] NULL,
		CONSTRAINT [PK_SUM_CMS_TRUNK_INTERVAL]
		PRIMARY KEY
		CLUSTERED
		([PARTITION_URN], [PARTITION_ID])
	ON [SUMCMSGROUP]
) ON [SUMCMSGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_SUM_CMS_TRUNK_INTERVAL_ACD_URN]
	ON [dbo].[TB_SUM_CMS_TRUNK_INTERVAL] ([ACD_URN])
	ON [SUMCMSIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNK_INTERVAL', 'INDEX', N'IX_SUM_CMS_TRUNK_INTERVAL_ACD_URN'
GO
CREATE NONCLUSTERED INDEX [IX_SUM_CMS_TRUNK_INTERVAL_TRUNKGROUP_URN]
	ON [dbo].[TB_SUM_CMS_TRUNK_INTERVAL] ([TRUNKGROUP_URN])
	ON [SUMCMSIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNK_INTERVAL', 'INDEX', N'IX_SUM_CMS_TRUNK_INTERVAL_TRUNKGROUP_URN'
GO
CREATE NONCLUSTERED INDEX [IX_SUM_CMS_TRUNK_INTERVAL_TRUNK_URN]
	ON [dbo].[TB_SUM_CMS_TRUNK_INTERVAL] ([TRUNK_URN])
	ON [SUMCMSIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNK_INTERVAL', 'INDEX', N'IX_SUM_CMS_TRUNK_INTERVAL_TRUNK_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the template table for the historical interval based call trunk summary statistics from CMS systems. This table is created at install time and the partitioning service creates various partition tables with the same schema. These partition tables are prefixed as TB_SUM_CMS_TRUNK_INTERVAL_ followed by the partition identifier. The partition identifier is created depending on the partition configuration, for example monthly, weekly etc. All currently active partitions are included VW_PARTITONED_SUM_CMS_TRUNK_INTERVAL view. Since the partitioned tables are generated at runtime and that they have the same schema no separate documentations are required for each partition table. In case of a configured Avaya CMS the data in these partition tables are sourced from the  table in cms Database.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNK_INTERVAL', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary Key Identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNK_INTERVAL', 'COLUMN', N'PARTITION_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column holds a value that uniquely identifies a row across all the partition tables for this partition type.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNK_INTERVAL', 'COLUMN', N'PARTITION_GLOBAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number for the current partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNK_INTERVAL', 'COLUMN', N'PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from the table dbo.TB_CLU_RESOURCE indicating the source of the data..', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNK_INTERVAL', 'COLUMN', N'CLUSTER_RESOURCE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_PERIPHERAL corresponding to an item of type PT_ACD. This corresponds to the ACD associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNK_INTERVAL', 'COLUMN', N'ACD_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_PERIPHERAL', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNK_INTERVAL', 'COLUMN', N'ACD_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_TRUNK_GROUP corresponding to an item of type IT_TRUNK_GROUP. This corresponds to the trunkgroup associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNK_INTERVAL', 'COLUMN', N'TRUNKGROUP_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TRUNK_GROUP', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNK_INTERVAL', 'COLUMN', N'TRUNKGROUP_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_TRUNK corresponding to an item of type IT_TRUNK. This corresponds to the trunk associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNK_INTERVAL', 'COLUMN', N'TRUNK_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TRUNK', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNK_INTERVAL', 'COLUMN', N'TRUNK_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the date associated with the record. This is calculated by the data importer based on the source data time corresponding to the start of the reporting interval from the source data.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNK_INTERVAL', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the time associated with the record. This is calculated by the data importer based on the source data time corresponding to the start of the reporting interval from the source data.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNK_INTERVAL', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the datetime stamp associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNK_INTERVAL', 'COLUMN', N'DB_DATETIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The UTC start time of the interval for which data was collected. It is records in number of seconds since midnight 01/01/1970 UTC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNK_INTERVAL', 'COLUMN', N'UTC_DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of minutes in the intrahour interval. The length of the intrahour interval can be 15, 30, or 60 minutes. INTRVL applies to intrahour tables only. The data in this column maps to the HTRUNK.INTRVL column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNK_INTERVAL', 'COLUMN', N'INTRVL'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The communication server location ID that is associated with the trunk. The location ID is not directly assigned to a trunk but rather is assigned to a port network location on the communication server. Each trunk whose equipment location belongs to a specific port network will be associated with that port networks location ID. The data in this column maps to the HTRUNK.LOC_ID column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNK_INTERVAL', 'COLUMN', N'LOC_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of inbound calls carried by this trunk that completed during the collection interval. This includes calls with short holding times (SHORTCALLS). INCALLS = ABNCALLS + ACDCALLS + OTHERCALLS. The data in this column maps to the HTRUNK.INCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNK_INTERVAL', 'COLUMN', N'IN_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The trunk holding time for all INCALLS that are carried by this trunk and complete during the collection interval. Trunk holding time is the length of time from the initial trunk seizure until the trunk goes idle. The trunk goes idle when the caller drops, the agent releases the call, or the communication server disconnects the call. If an incoming call on a measured trunk is transferred off the communication server, the incoming trunk remains in use for the call and accrues trunk holding time until the caller drops or the call is released. This is a cumulative item. The data in this column maps to the HTRUNK.INTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNK_INTERVAL', 'COLUMN', N'IN_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The total length of time during the collection interval that the trunk was occupied by incoming calls. If an incoming call on a measured trunk is transferred off of the communication server, the incoming trunk remains in use for the call and accrues trunk holding time until the caller drops or the call is released. The data in this column maps to the HTRUNK.I_INOCC column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNK_INTERVAL', 'COLUMN', N'I_IN_OCC'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of calls carried by this trunk that are abandoned by the caller before they are answered by an agent. Direct calls to unmeasured stations that do not go through a measured VDN or split/skill are not recorded. ABNCALLS includes all calls abandoned by the caller that are carried by this trunk, except for direct calls to unmeasured stations that do not go through a measured VDN or split/skill. ABNCALLS includes PHANTOMABNS, which are ACD calls and calls routed to an agent or extension with talk times less than the value of the phantom-abandon call timer. Calls that abandon while listening to a forced disconnect are also included in ABNCALLS. ABNCALLS includes ABNVECCALLS, ABNQUEUECALLS, ABNRINGCALLS, and PHANTOMABNS. The data in this column maps to the HTRUNK.ABNCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNK_INTERVAL', 'COLUMN', N'ABN_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of OUTCALLS on this trunk that are offered by an adjunct as split/skill or direct agent ACD calls and were answered and then abandoned by the far end before talking to an agent. The O_ABNCALLS item is available with the ASAI feature. This is a cumulative item. The data in this column maps to the HTRUNK.O_ABNCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNK_INTERVAL', 'COLUMN', N'O_ABN_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of outbound calls that are carried by the trunk and complete during the collection interval. OUTCALLS includes COMPLETED, O_ABNCALLS, O_ACDCALLS, O_OTHERCALLS, TRANSFERRED and SHORTCALLS. OUTCALLS = O_ACDCALLS + O_ABNCALLS + O_OTHERCALLS. The data in this column maps to the HTRUNK.OUTCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNK_INTERVAL', 'COLUMN', N'OUT_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The trunk holding time for all OUTCALLS that are carried by this trunk and complete during the collection interval. Trunk holding time is the time from the initial trunk seizure until the trunk goes idle. The trunk does not go idle until the far end drops, the agent releases the call, or the communication server disconnects the call. The data in this column maps to the HTRUNK.OUT_TIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNK_INTERVAL', 'COLUMN', N'OUT_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time during the collection interval that this trunk was occupied by outbound calls. The data in this column maps to the HTRUNK.I_OUTOCC column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNK_INTERVAL', 'COLUMN', N'I_OUT_OCC'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Number of trunk hardware failures for this trunk. The data in this column maps to the HTRUNK.FAILURES column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNK_INTERVAL', 'COLUMN', N'FAILURES'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of calls for which audio difficulty problems were reported for this trunk. The data in this column maps to the HTRUNK.AUDIO column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNK_INTERVAL', 'COLUMN', N'AUDIO'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The total time during the collection interval that this trunk was maintenance busy. The data in this column maps to the HTRUNK.MBUSYTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNK_INTERVAL', 'COLUMN', N'MBUSY_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of INCALLS that are answered by an agent as a split/skill or direct agent ACD call. The data in this column maps to the HTRUNK.ACDCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNK_INTERVAL', 'COLUMN', N'ACD_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of INCALLS carried by this trunk that are not answered as split/skill or direct agent ACD calls or do not abandon. These include forced busy calls, forced disconnect calls, calls that are connected to a non-ACD destination, short inbound calls, and calls with unknown dispositions. OTHERCALLS includes BUSYCALLS, DISCCALLS, SHORTCALLS and CONNECTCALLS. OTHERCALLS = INCALLS - ACDCALLS - ABNCALLS. The data in this column maps to the HTRUNK.OTHERCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNK_INTERVAL', 'COLUMN', N'OTHER_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of inbound and outbound calls that occupied a trunk for less than 2 seconds and that did not queue to a split/skill, forward to a split/skill, get answered by an agent, get a forced busy or forced disconnect from the communication server, or produce a trunk failure or maintenance busy. SHORTCALLS includes both inbound and outbound calls. Therefore, OTHERCALLS and O_OTHERCALLS may each include some SHORTCALLS. The data in this column maps to the HTRUNK.SHORTCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNK_INTERVAL', 'COLUMN', N'SHORT_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of OUTCALLS from this trunk that are offered by an adjunct as split/skill or direct agent ACD calls and were answered by an agent. The O_ACDCALLS item is available with the ASAI feature.. The data in this column maps to the HTRUNK.O_ACDCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNK_INTERVAL', 'COLUMN', N'O_ACD_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of OUTCALLS on this trunk that are not answered or abandoned as ACD split/skill calls. O_OTHERCALLS includes extension out calls, calls forced busy and forced disconnected, short outgoing calls, and calls with unknown dispositions. O_OTHERCALLS includes SHORTCALLS. This is a cumulative item. The data in this column maps to the HTRUNK.O_OTHERCALLS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNK_INTERVAL', 'COLUMN', N'O_OTHER_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'An indication of whether data is complete for this collection interval. Data is incomplete whenever the link goes down and whenever tracking is aborted for calls, because of the trunk going maintenance busy with a call active, protocol failures with data collection active, or when split/skill or VDN call profile is changed with data collection active. Valid values for the INCOMPLETE item are 1, which means that the data is incomplete, and 0, which means that the data is complete. The value in the daily, weekly, and monthly tables indicates the number of incomplete intervals in the day, week, or month. Changing the split/skill or VDN call profile data while data collection is active only affects the respective split/skill or VDN data. The data in this column maps to the HTRUNK.INCOMPLETE column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNK_INTERVAL', 'COLUMN', N'INCOMPLETE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of ACDCALLS that are answered by a Reserve 1 Agent as a split/skill ACD call. The data in this column maps to the HTRUNK.ACDCALLS_R1 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNK_INTERVAL', 'COLUMN', N'ACD_CALLS_R1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of ACDCALLS that are answered by a Reserve 2 Agent as a split/skill ACD call. The data in this column maps to the HTRUNK.ACDCALLS_R2 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CMS_TRUNK_INTERVAL', 'COLUMN', N'ACD_CALLS_R2'
GO
GRANT SELECT
	ON [dbo].[TB_SUM_CMS_TRUNK_INTERVAL]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_SUM_CMS_TRUNK_INTERVAL]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_SUM_CMS_TRUNK_INTERVAL]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_SUM_CMS_TRUNK_INTERVAL] SET (LOCK_ESCALATION = TABLE)
GO
