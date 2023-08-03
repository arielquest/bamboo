SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_FCT_CMS_AGENT_STATE_TRACE] (
		[PARTITION_URN]             [int] NOT NULL,
		[PARTITION_GLOBAL_URN]      [bigint] NOT NULL,
		[PARTITION_ID]              [int] NOT NULL,
		[CLUSTER_RESOURCE_URN]      [int] NOT NULL,
		[DIGITS_DIALED_URN]         [int] NOT NULL,
		[AGENT_URN]                 [int] NOT NULL,
		[ACD_URN]                   [int] NOT NULL,
		[LOC_ID_URN]                [int] NOT NULL,
		[SKILLGROUP_URN]            [int] NOT NULL,
		[LOGOUT_REASONCODE_URN]     [int] NOT NULL,
		[DATE_UTC_URN]              [int] NOT NULL,
		[TIME_UTC_URN]              [smallint] NOT NULL,
		[DB_DATETIME]               [datetime] NULL,
		[STARTTIME]                 [datetime] NULL,
		[AGT_RELEASED]              [char](1) COLLATE Latin1_General_CI_AS NULL,
		[ASSIST_ACTV]               [char](1) COLLATE Latin1_General_CI_AS NULL,
		[AUX_REASON]                [int] NULL,
		[CALLER_HOLD]               [char](1) COLLATE Latin1_General_CI_AS NULL,
		[CALLING_II]                [char](2) COLLATE Latin1_General_CI_AS NULL,
		[CALLING_PTY]               [char](24) COLLATE Latin1_General_CI_AS NULL,
		[CONFERENCE]                [char](1) COLLATE Latin1_General_CI_AS NULL,
		[DIGITS_DIALED]             [char](16) COLLATE Latin1_General_CI_AS NULL,
		[DIRECTION]                 [int] NULL,
		[DURATION]                  [int] NULL,
		[EVENT_TIME]                [int] NULL,
		[EXT_CALL_ORIG]             [char](1) COLLATE Latin1_General_CI_AS NULL,
		[INTERRUPTED]               [char](1) COLLATE Latin1_General_CI_AS NULL,
		[KEYBD_DIALED]              [char](1) COLLATE Latin1_General_CI_AS NULL,
		[LOC_ID]                    [int] NULL,
		[LOGOUT_REASON]             [int] NULL,
		[MCT]                       [char](1) COLLATE Latin1_General_CI_AS NULL,
		[RECONNECT]                 [char](1) COLLATE Latin1_General_CI_AS NULL,
		[TRANSFERRED]               [char](1) COLLATE Latin1_General_CI_AS NULL,
		[UCID]                      [char](20) COLLATE Latin1_General_CI_AS NULL,
		[WMODE_SEQ]                 [int] NULL,
		[WORKCODE]                  [char](16) COLLATE Latin1_General_CI_AS NULL,
		[WORKMODE]                  [int] NULL,
		[CUSTOM_DIMENSION_0]        [int] NOT NULL,
		[CUSTOM_DIMENSION_1]        [int] NOT NULL,
		[CUSTOM_DIMENSION_2]        [int] NOT NULL,
		[CUSTOM_DIMENSION_3]        [int] NOT NULL,
		[CUSTOM_DIMENSION_4]        [int] NOT NULL,
		[CUSTOM_DIMENSION_5]        [int] NOT NULL,
		[CUSTOM_DIMENSION_6]        [int] NOT NULL,
		[CUSTOM_DIMENSION_7]        [int] NOT NULL,
		[CUSTOM_DIMENSION_8]        [int] NOT NULL,
		[CUSTOM_DIMENSION_9]        [int] NOT NULL,
		[CUSTOM_MEASURE_0]          [int] NULL,
		[CUSTOM_MEASURE_1]          [int] NULL,
		[CUSTOM_MEASURE_2]          [int] NULL,
		[CUSTOM_MEASURE_3]          [int] NULL,
		[CUSTOM_MEASURE_4]          [int] NULL,
		[CUSTOM_MEASURE_5]          [int] NULL,
		[CUSTOM_MEASURE_6]          [int] NULL,
		[CUSTOM_MEASURE_7]          [int] NULL,
		[CUSTOM_MEASURE_8]          [int] NULL,
		[CUSTOM_MEASURE_9]          [int] NULL,
		CONSTRAINT [PK_FCT_CMS_AGENT_STATE_TRACE]
		PRIMARY KEY
		CLUSTERED
		([PARTITION_URN], [PARTITION_ID])
	ON [FCTCMSGROUP]
) ON [FCTCMSGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_FCT_CMS_AGENT_STATE_TRACE_ACD_URN]
	ON [dbo].[TB_FCT_CMS_AGENT_STATE_TRACE] ([ACD_URN])
	ON [FCTCMSIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_STATE_TRACE', 'INDEX', N'IX_FCT_CMS_AGENT_STATE_TRACE_ACD_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_CMS_AGENT_STATE_TRACE_AGENT_URN]
	ON [dbo].[TB_FCT_CMS_AGENT_STATE_TRACE] ([AGENT_URN])
	ON [FCTCMSIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_STATE_TRACE', 'INDEX', N'IX_FCT_CMS_AGENT_STATE_TRACE_AGENT_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_CMS_AGENT_STATE_TRACE_REASON_URN]
	ON [dbo].[TB_FCT_CMS_AGENT_STATE_TRACE] ([LOGOUT_REASONCODE_URN])
	ON [FCTCMSIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_STATE_TRACE', 'INDEX', N'IX_FCT_CMS_AGENT_STATE_TRACE_REASON_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_CMS_AGENT_STATE_TRACE_SKILLGROUP_URN]
	ON [dbo].[TB_FCT_CMS_AGENT_STATE_TRACE] ([SKILLGROUP_URN])
	ON [FCTCMSIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_STATE_TRACE', 'INDEX', N'IX_FCT_CMS_AGENT_STATE_TRACE_SKILLGROUP_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the template table for the historical statistics agent state trace from CMS systems. This table is created at install time and the partitioning service creates various partition tables with the same schema. These partition tables are prefixed as TB_FCT_CMS_AGENT_STATE_TRACE_ followed by the partition identifier. The partition identifier is created depending on the partition configuration, for example monthly, weekly etc. All currently active partitions are included VW_PARTITONED_FCT_CMS_AGENT_STATE_TRACE view. Since the partitioned tables are generated at runtime and that they have the same schema no separate documentations are required for each partition table. In case of a configured Avaya CMS the data in these partition tables are sourced from the  table in cms Database.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_STATE_TRACE', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary Key Identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_STATE_TRACE', 'COLUMN', N'PARTITION_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column holds a value that uniquely identifies a row across all the partition tables for this partition type.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_STATE_TRACE', 'COLUMN', N'PARTITION_GLOBAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number for the current partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_STATE_TRACE', 'COLUMN', N'PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from the table dbo.TB_CLU_RESOURCE indicating the source of the data..', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_STATE_TRACE', 'COLUMN', N'CLUSTER_RESOURCE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The unique URN on exony database that is associated the digits that the agent dialed to originate a call. The URN in this column maps to the AG_ACTV.DIGITS_DIALED column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_STATE_TRACE', 'COLUMN', N'DIGITS_DIALED_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_AGENT corresponding to an item of type IT_AGENT. This corresponds to the AGENT associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_STATE_TRACE', 'COLUMN', N'AGENT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_AGENT', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_STATE_TRACE', 'COLUMN', N'AGENT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_PERIPHERAL corresponding to an item of type PT_ACD. This corresponds to the ACD associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_STATE_TRACE', 'COLUMN', N'ACD_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_PERIPHERAL', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_STATE_TRACE', 'COLUMN', N'ACD_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The unique URN on exony database that is associated with the equipment location ID that is associated with a particular agent. The URN in this column maps to the AG_ACTV.LOC_ID column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_STATE_TRACE', 'COLUMN', N'LOC_ID_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_SKILLGROUP corresponding to an item of type IT_SKILLGROUP. This corresponds to the skillgroup associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_STATE_TRACE', 'COLUMN', N'SKILLGROUP_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_SKILLGROUP', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_STATE_TRACE', 'COLUMN', N'SKILLGROUP_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This corresponds to the PERIPHERAL_CODE_URN column in VW_DIM_PERIPHERAL_LOGOUT_REASON corresponding to the agents logout reason..', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_STATE_TRACE', 'COLUMN', N'LOGOUT_REASONCODE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the date associated with the record. This is calculated by the data importer based on the source data time corresponding to the start of the reporting interval from the source data.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_STATE_TRACE', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the time associated with the record. This is calculated by the data importer based on the source data time corresponding to the start of the reporting interval from the source data.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_STATE_TRACE', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the datetime stamp associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_STATE_TRACE', 'COLUMN', N'DB_DATETIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the start datetime of the trace event associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_STATE_TRACE', 'COLUMN', N'STARTTIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The agent released or dropped the split/skill or direct agent ACD call, including transferred and conferenced calls. Valid values are n, which means that the call was not released or dropped,and y, which means that the call was released or dropped. The data in this column maps to the AG_ACTV.AGT_RELEASED column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_STATE_TRACE', 'COLUMN', N'AGT_RELEASED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The agent requested supervisor assistance (pressed the ASSIST button).. The data in this column maps to the AG_ACTV.ASSIST_ACTV column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_STATE_TRACE', 'COLUMN', N'ASSIST_ACTV'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The reason code that is associated with the agents current state. AUXREASON is blank if the agent is not in the AUX state. On communciation servers that do not have EAS and reason codes active, AUXREASON is zero. The data in this column maps to the AG_ACTV.AUXREASON  column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_STATE_TRACE', 'COLUMN', N'AUX_REASON'
GO
EXEC sp_addextendedproperty N'MS_Description', N'An indication that the agent put the current call on hold. The data in this column maps to the AG_ACTV.CALLER_HOLD column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_STATE_TRACE', 'COLUMN', N'CALLER_HOLD'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The Information Indicator (II) digits that are associated with the call. These digits are a two-digit string that is provided by ISDN PRI to indicate the type of originating line of the caller. These digits supply information about the originator location, for example, pay phone, hospital, or prison. The column is blank if the call does not contain II digits. The data in this column maps to the AG_ACTV.CALLING_II column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_STATE_TRACE', 'COLUMN', N'CALLING_II'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The calling party identification. On communication servers without ISDN ANI delivery, the identification is the extension or trunk equipment location that identifies the originator of the call. On communication servers with ISDN ANI delivery, the identification is the ANI/SID. The CALLING_PTY item is blank if the trunk is not measured or, for internal calls, if the originating extension is not measured. This field can contain up to 24 digits. The data in this column maps to the AG_ACTV.CALLING_PTY column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_STATE_TRACE', 'COLUMN', N'CALLING_PTY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'An indication that the agent activated a conference. Valid values for CONFERENCE are 0, which means that the agent did not initiate a conference, and 1, which means that the agent did initiate a conference. The data in this column maps to the AG_ACTV.CONFERENCE column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_STATE_TRACE', 'COLUMN', N'CONFERENCE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The digits that the agent dialed to originate a call. Trunk access codes, feature access codes, account codes, and authorization codes are not included. The data in this column maps to the AG_ACTV.DIGITS_DIALED column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_STATE_TRACE', 'COLUMN', N'DIGITS_DIALED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The direction of the call that the agent is currently handling for any split/skill. Valid values are blank, IN, OUT, or as defined in Dictionary. If the agent is not on a call, the value is blank (NULL).. The data in this column maps to the AG_ACTV.DIRECTION column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_STATE_TRACE', 'COLUMN', N'DIRECTION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time of the current WORKMODE and DIRECTION for this SPLIT. For example, the length of time in current AGSTATE for this SPLIT, in which case, if the agent goes from AUX to AUXOUT and back to AUX, DURATION restarts with each change in work mode. The data in this column maps to the AG_ACTV.DURATION column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_STATE_TRACE', 'COLUMN', N'DURATION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The time of day, in hour, minute, and second format, at which the WORKMODE or DIRECTION changed. The data in this column maps to the AG_ACTV.EVENT_TIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_STATE_TRACE', 'COLUMN', N'EVENT_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'An indication that the agent originated an external, off-communication server call. The data in this column maps to the AG_ACTV.EXT_CALL_ORIG column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_STATE_TRACE', 'COLUMN', N'EXT_CALL_ORIG'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item determines whether the agent becomes available due to being interrupted from an interruptible AUX state. The data in this column maps to the AG_ACTV.INTERRUPTED column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_STATE_TRACE', 'COLUMN', N'INTERRUPTED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'An indication that the call was keyboard dialed. The KEYBD_DIALED item is available with the ASAI feature. The data in this column maps to the AG_ACTV.KEYBD_DIALED column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_STATE_TRACE', 'COLUMN', N'KEYBD_DIALED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The equipment location ID that is associated with a particular agent. This is the location ID of the terminal the agent is logged into. It is associated with a port network location ID on the communication server. The data in this column maps to the AG_ACTV.LOC_ID column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_STATE_TRACE', 'COLUMN', N'LOC_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This corresponds to the reason an agent logged out. The data in this column maps to the AG_ACTV.LOGOUT_REASON column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_STATE_TRACE', 'COLUMN', N'LOGOUT_REASON'
GO
EXEC sp_addextendedproperty N'MS_Description', N'An indication that the agent activated a malicious call trace. The data in this column maps to the AG_ACTV.MCT column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_STATE_TRACE', 'COLUMN', N'MCT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'An indication that the agent has reconnects to the call after putting it on hold. The data in this column maps to the AG_ACTV.RECONNECT column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_STATE_TRACE', 'COLUMN', N'RECONNECT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'An indication of whether the answering agent initiated a transfer for this call. Valid values for TRANSFERRED are 0, which means that "no" transfer was initiated, and 1, which means that "yes" a transfer was initiated. TRANSFERRED includes all calls that are transferred. The data in this column maps to the AG_ACTV.TRANSFERRED column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_STATE_TRACE', 'COLUMN', N'TRANSFERRED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The UCID is the Universal Call Identifier, which is a unique number that is assigned to this call segment within the customer network. The data in this column maps to the AG_ACTV.UCID column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_STATE_TRACE', 'COLUMN', N'UCID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The sequence number for events that occur in the same second. The data in this column maps to the AG_ACTV.WMODE_SEQ column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_STATE_TRACE', 'COLUMN', N'WMODE_SEQ'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The call work code that the agent entered for the call. The WORKCODE item is available when call work codes are implemented. The data in this column maps to the AG_ACTV.WORKCODE column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_STATE_TRACE', 'COLUMN', N'WORKCODE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The work mode in which the agent was working during the trace. Agent work modes include: AVAIL, ACD, ACW, AUX, DACD, DACW, RING, UNKNOWN, OTHER, and UNSTAFF. If the agent was not logged in during the collection interval, the value is blank. The data in this column maps to the AG_ACTV.WORKMODE column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_STATE_TRACE', 'COLUMN', N'WORKMODE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_STATE_TRACE', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM0', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_STATE_TRACE', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_STATE_TRACE', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM1', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_STATE_TRACE', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_STATE_TRACE', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM2', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_STATE_TRACE', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_STATE_TRACE', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM3', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_STATE_TRACE', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_STATE_TRACE', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM4', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_STATE_TRACE', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_STATE_TRACE', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM5', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_STATE_TRACE', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_STATE_TRACE', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM6', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_STATE_TRACE', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_STATE_TRACE', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM7', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_STATE_TRACE', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_STATE_TRACE', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM8', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_STATE_TRACE', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_STATE_TRACE', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM9', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_STATE_TRACE', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_STATE_TRACE', 'COLUMN', N'CUSTOM_MEASURE_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_STATE_TRACE', 'COLUMN', N'CUSTOM_MEASURE_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_STATE_TRACE', 'COLUMN', N'CUSTOM_MEASURE_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_STATE_TRACE', 'COLUMN', N'CUSTOM_MEASURE_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_STATE_TRACE', 'COLUMN', N'CUSTOM_MEASURE_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_STATE_TRACE', 'COLUMN', N'CUSTOM_MEASURE_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_STATE_TRACE', 'COLUMN', N'CUSTOM_MEASURE_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_STATE_TRACE', 'COLUMN', N'CUSTOM_MEASURE_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_STATE_TRACE', 'COLUMN', N'CUSTOM_MEASURE_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_STATE_TRACE', 'COLUMN', N'CUSTOM_MEASURE_9'
GO
GRANT SELECT
	ON [dbo].[TB_FCT_CMS_AGENT_STATE_TRACE]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_FCT_CMS_AGENT_STATE_TRACE]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_FCT_CMS_AGENT_STATE_TRACE]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_FCT_CMS_AGENT_STATE_TRACE] SET (LOCK_ESCALATION = TABLE)
GO
