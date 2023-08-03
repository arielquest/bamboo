SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_FCT_CMS_CALL_RECORD] (
		[PARTITION_URN]            [int] IDENTITY(0, 1) NOT NULL,
		[PARTITION_GLOBAL_URN]     [bigint] NOT NULL,
		[PARTITION_ID]             [int] NOT NULL,
		[CLUSTER_RESOURCE_URN]     [int] NOT NULL,
		[ANS_AGENT_URN]            [int] NOT NULL,
		[ORIG_AGENT_URN]           [int] NOT NULL,
		[ACD_URN]                  [int] NOT NULL,
		[VDN_URN]                  [int] NOT NULL,
		[VDN2_URN]                 [int] NOT NULL,
		[VDN3_URN]                 [int] NOT NULL,
		[VDN4_URN]                 [int] NOT NULL,
		[VDN5_URN]                 [int] NOT NULL,
		[VDN6_URN]                 [int] NOT NULL,
		[VDN7_URN]                 [int] NOT NULL,
		[VDN8_URN]                 [int] NOT NULL,
		[VDN9_URN]                 [int] NOT NULL,
		[CWC1_URN]                 [int] NOT NULL,
		[CWC2_URN]                 [int] NOT NULL,
		[CWC3_URN]                 [int] NOT NULL,
		[CWC4_URN]                 [int] NOT NULL,
		[CWC5_URN]                 [int] NOT NULL,
		[CALLING_PARTY_URN]        [int] NOT NULL,
		[DIALED_NUM_URN]           [int] NOT NULL,
		[CALLID_URN]               [int] NOT NULL,
		[TRUNKGROUP_URN]           [int] NOT NULL,
		[VECTOR_URN]               [int] NOT NULL,
		[DISP_VDN_URN]             [int] NOT NULL,
		[DISP_VECTOR_URN]          [int] NOT NULL,
		[DISP_SKILLGROUP_URN]      [int] NOT NULL,
		[SKILLGROUP1_URN]          [int] NOT NULL,
		[SKILLGROUP2_URN]          [int] NOT NULL,
		[SKILLGROUP3_URN]          [int] NOT NULL,
		[START_DATE_UTC_URN]       [int] NOT NULL,
		[START_TIME_UTC_URN]       [smallint] NOT NULL,
		[STOP_DATE_UTC_URN]        [int] NOT NULL,
		[STOP_TIME_UTC_URN]        [smallint] NOT NULL,
		[SEQ_NUM]                  [int] NULL,
		[DB_DATETIME]              [datetime] NULL,
		[ACW_TIME]                 [int] NULL,
		[ANS_HOLD_TIME]            [int] NULL,
		[ASSIST]                   [int] NULL,
		[AUDIO]                    [int] NULL,
		[CALLID]                   [int] NULL,
		[CALLING_PTY]              [char](24) COLLATE Latin1_General_CI_AS NULL,
		[CONFERENCE]               [int] NULL,
		[CONSULT_TIME]             [int] NULL,
		[DA_QUEUED]                [int] NULL,
		[DIALED_NUM]               [varchar](24) COLLATE Latin1_General_CI_AS NULL,
		[DISPOSITION]              [int] NULL,
		[DISP_PRIORITY]            [int] NULL,
		[DISP_TIME]                [int] NULL,
		[DURATION]                 [int] NULL,
		[EVENT1]                   [int] NULL,
		[EVENT2]                   [int] NULL,
		[EVENT3]                   [int] NULL,
		[EVENT4]                   [int] NULL,
		[EVENT5]                   [int] NULL,
		[EVENT6]                   [int] NULL,
		[EVENT7]                   [int] NULL,
		[EVENT8]                   [int] NULL,
		[EVENT9]                   [int] NULL,
		[VDN2]                     [char](15) COLLATE Latin1_General_CI_AS NULL,
		[VDN3]                     [char](15) COLLATE Latin1_General_CI_AS NULL,
		[VDN4]                     [char](15) COLLATE Latin1_General_CI_AS NULL,
		[VDN5]                     [char](15) COLLATE Latin1_General_CI_AS NULL,
		[VDN6]                     [char](15) COLLATE Latin1_General_CI_AS NULL,
		[VDN7]                     [char](15) COLLATE Latin1_General_CI_AS NULL,
		[VDN8]                     [char](15) COLLATE Latin1_General_CI_AS NULL,
		[VDN9]                     [char](15) COLLATE Latin1_General_CI_AS NULL,
		[HELD]                     [int] NULL,
		[HOLD_ABN]                 [int] NULL,
		[LAST_CWC]                 [char](16) COLLATE Latin1_General_CI_AS NULL,
		[LAST_DIGITS]              [char](16) COLLATE Latin1_General_CI_AS NULL,
		[LAST_OBSERVER]            [char](15) COLLATE Latin1_General_CI_AS NULL,
		[MALICIOUS]                [int] NULL,
		[OBSERVING_CALL]           [int] NULL,
		[SEGMENT]                  [int] NULL,
		[START_DATE]               [datetime] NOT NULL,
		[START_DATE_UTC]           [datetime] NOT NULL,
		[STOP_DATE]                [datetime] NULL,
		[STOP_DATE_UTC]            [datetime] NULL,
		[TALK_TIME]                [int] NULL,
		[TRANSFERRED]              [int] NULL,
		[AGT_RELEASED]             [int] NULL,
		[CALLING_II]               [char](2) COLLATE Latin1_General_CI_AS NULL,
		[DISP_SKLEVEL]             [int] NULL,
		[NET_IN_TIME]              [int] NULL,
		[ORIG_HOLD_TIME]           [int] NULL,
		[UCID]                     [char](20) COLLATE Latin1_General_CI_AS NULL,
		[ANS_LOCID]                [int] NULL,
		[OBS_LOCID]                [int] NULL,
		[ORIG_LOCID]               [int] NULL,
		[CWC1]                     [char](16) COLLATE Latin1_General_CI_AS NULL,
		[CWC2]                     [char](16) COLLATE Latin1_General_CI_AS NULL,
		[CWC3]                     [char](16) COLLATE Latin1_General_CI_AS NULL,
		[CWC4]                     [char](16) COLLATE Latin1_General_CI_AS NULL,
		[CWC5]                     [char](16) COLLATE Latin1_General_CI_AS NULL,
		[QUEUE_TIME]               [int] NULL,
		[RING_TIME]                [int] NULL,
		[UUI_LEN]                  [int] NULL,
		[ASAI_UUI]                 [char](96) COLLATE Latin1_General_CI_AS NULL,
		[INTERRUPT_DEL]            [int] NULL,
		[AGENT_SURPLUS]            [int] NULL,
		[AGENT_SKILL_LEVEL]        [int] NULL,
		[PREF_SKILL_LEVEL]         [int] NULL,
		[ICR_RESENT]               [int] NULL,
		[ICR_PULL_REASON]          [int] NULL,
		[UTC_TIMEZONE]             [int] NULL,
		[CUSTOM_DIMENSION_0]       [int] NOT NULL,
		[CUSTOM_DIMENSION_1]       [int] NOT NULL,
		[CUSTOM_DIMENSION_2]       [int] NOT NULL,
		[CUSTOM_DIMENSION_3]       [int] NOT NULL,
		[CUSTOM_DIMENSION_4]       [int] NOT NULL,
		[CUSTOM_DIMENSION_5]       [int] NOT NULL,
		[CUSTOM_DIMENSION_6]       [int] NOT NULL,
		[CUSTOM_DIMENSION_7]       [int] NOT NULL,
		[CUSTOM_DIMENSION_8]       [int] NOT NULL,
		[CUSTOM_DIMENSION_9]       [int] NOT NULL,
		[CUSTOM_MEASURE_0]         [int] NULL,
		[CUSTOM_MEASURE_1]         [int] NULL,
		[CUSTOM_MEASURE_2]         [int] NULL,
		[CUSTOM_MEASURE_3]         [int] NULL,
		[CUSTOM_MEASURE_4]         [int] NULL,
		[CUSTOM_MEASURE_5]         [int] NULL,
		[CUSTOM_MEASURE_6]         [int] NULL,
		[CUSTOM_MEASURE_7]         [int] NULL,
		[CUSTOM_MEASURE_8]         [int] NULL,
		[CUSTOM_MEASURE_9]         [int] NULL,
		CONSTRAINT [PK_FCT_CMS_CALL_RECORD]
		PRIMARY KEY
		CLUSTERED
		([PARTITION_URN], [PARTITION_ID])
	ON [FCTCMSGROUP]
) ON [FCTCMSGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_FCT_CMS_CALL_RECORD_ANS_AGENT_URN]
	ON [dbo].[TB_FCT_CMS_CALL_RECORD] ([ANS_AGENT_URN])
	ON [FCTCMSIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'INDEX', N'IX_FCT_CMS_CALL_RECORD_ANS_AGENT_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_CMS_CALL_RECORD_ORIG_AGENT_URN]
	ON [dbo].[TB_FCT_CMS_CALL_RECORD] ([ORIG_AGENT_URN])
	ON [FCTCMSIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'INDEX', N'IX_FCT_CMS_CALL_RECORD_ORIG_AGENT_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_CMS_CALL_RECORD_ACD_URN]
	ON [dbo].[TB_FCT_CMS_CALL_RECORD] ([ACD_URN])
	ON [FCTCMSIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'INDEX', N'IX_FCT_CMS_CALL_RECORD_ACD_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_CMS_CALL_RECORD_TRUNKGROUP_URN]
	ON [dbo].[TB_FCT_CMS_CALL_RECORD] ([TRUNKGROUP_URN])
	ON [FCTCMSIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'INDEX', N'IX_FCT_CMS_CALL_RECORD_TRUNKGROUP_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the template table for the historical statistics call records from CMS systems. This table is created at install time and the partitioning service creates various partition tables with the same schema. These partition tables are prefixed as TB_FCT_CMS_CALL_RECORD_ followed by the partition identifier. The partition identifier is created depending on the partition configuration, for example monthly, weekly etc. All currently active partitions are included VW_PARTITONED_FCT_CMS_CALL_RECORD view. Since the partitioned tables are generated at runtime and that they have the same schema no separate documentations are required for each partition table. In case of a configured Avaya CMS the data in these partition tables are sourced from the  table in cms Database.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'PARTITION_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column holds a value that uniquely identifies a row across all the partition tables for this partition type.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'PARTITION_GLOBAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number for the current partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from the table dbo.TB_CLU_RESOURCE indicating the source of the data.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'CLUSTER_RESOURCE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_AGENT corresponding to an item of type IT_AGENT. This corresponds to the agent who answered a call associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'ANS_AGENT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_AGENT', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'ANS_AGENT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_AGENT corresponding to an item of type IT_AGENT. This corresponds to the agent who originally answered a call associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'ORIG_AGENT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_PERIPHERAL corresponding to an item of type PT_ACD. This corresponds to the ACD associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'ACD_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_PERIPHERAL', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'ACD_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_VECTOR_DIRECTORY_NUMBER corresponding to an item of type IT_VECTOR_DIRECTORY_NUMBER. This corresponds to the VDN associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'VDN_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_VECTOR_DIRECTORY_NUMBER corresponding to an item of type IT_VECTOR_DIRECTORY_NUMBER. This corresponds to the VDN2 associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'VDN2_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_VECTOR_DIRECTORY_NUMBER corresponding to an item of type IT_VECTOR_DIRECTORY_NUMBER. This corresponds to the VDN3 associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'VDN3_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_VECTOR_DIRECTORY_NUMBER corresponding to an item of type IT_VECTOR_DIRECTORY_NUMBER. This corresponds to the VDN4 associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'VDN4_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_VECTOR_DIRECTORY_NUMBER corresponding to an item of type IT_VECTOR_DIRECTORY_NUMBER. This corresponds to the VDN5 associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'VDN5_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_VECTOR_DIRECTORY_NUMBER corresponding to an item of type IT_VECTOR_DIRECTORY_NUMBER. This corresponds to the VDN6 associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'VDN6_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_VECTOR_DIRECTORY_NUMBER corresponding to an item of type IT_VECTOR_DIRECTORY_NUMBER. This corresponds to the VDN7 associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'VDN7_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_VECTOR_DIRECTORY_NUMBER corresponding to an item of type IT_VECTOR_DIRECTORY_NUMBER. This corresponds to the VDN8 associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'VDN8_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_VECTOR_DIRECTORY_NUMBER corresponding to an item of type IT_VECTOR_DIRECTORY_NUMBER. This corresponds to the VDN9 associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'VDN9_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_WRAPUP_CODE corresponding to an item of type IT_WRAPUP_CODE. This corresponds to the CWC1 associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'CWC1_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_WRAPUP_CODE corresponding to an item of type IT_WRAPUP_CODE. This corresponds to the CWC2 associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'CWC2_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_WRAPUP_CODE corresponding to an item of type IT_WRAPUP_CODE. This corresponds to the CWC3 associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'CWC3_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_WRAPUP_CODE corresponding to an item of type IT_WRAPUP_CODE. This corresponds to the CWC4 associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'CWC4_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_WRAPUP_CODE corresponding to an item of type IT_WRAPUP_CODE. This corresponds to the CWC5 associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'CWC5_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The unique URN on exony database that is associated with the equipment Calling Party. The URN in this column maps to the CALL_REC.CALLING_PTY column in the Avaya CMS database.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'CALLING_PARTY_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_DIALED_NUMBER corresponding to an item of type IT_DIALED_NUMBER. This corresponds to the DIALED_NUM associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'DIALED_NUM_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The unique URN on exony database that is associated with the equipment Call. The URN in this column maps to the CALL_REC.CALLID column in the Avaya CMS database.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'CALLID_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_TRUNK_GROUP corresponding to an item of type IT_TRUNK_GROUP. This corresponds to the tkgrp (trunk group) associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'TRUNKGROUP_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TRUNK_GROUP', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'TRUNKGROUP_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_VECTOR corresponding to an item of type IT_VECTOR. This corresponds to the VECTOR associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'VECTOR_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_VECTOR_DIRECTORY_NUMBER corresponding to an item of type IT_VECTOR_DIRECTORY_NUMBER. This corresponds to the disposition VDN associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'DISP_VDN_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_VECTOR corresponding to an item of type IT_VECTOR. This corresponds to the disposition VECTOR associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'DISP_VECTOR_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_SKILLGROUP corresponding to an item of type IT_SKILLGROUP. This corresponds to the disposition skillgroup associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'DISP_SKILLGROUP_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_SKILLGROUP corresponding to an item of type IT_SKILLGROUP. This corresponds to the skillgroup associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'SKILLGROUP1_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_SKILLGROUP corresponding to an item of type IT_SKILLGROUP. This corresponds to the skillgroup associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'SKILLGROUP2_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_SKILLGROUP corresponding to an item of type IT_SKILLGROUP. This corresponds to the skillgroup associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'SKILLGROUP3_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the call record start date associated with the record. This is calculated by the data importer based on the source data time corresponding to the call start.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'START_DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the call record start time associated with the record. This is calculated by the data importer based on the source data time corresponding to the call start.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'START_TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the call record stop date associated with the record. This is calculated by the data importer based on the source data time corresponding to the call stop.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'STOP_DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the call record stop time associated with the record. This is calculated by the data importer based on the source data time corresponding to the call stop.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'STOP_TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Sequential row identifier. The data in this column maps to the CALL_REC.SEQNUM column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'SEQ_NUM'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the datetime stamp associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'DB_DATETIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time that agents spend in ACW that is associated with this call by the answering agent in this segment. The data in this column maps to the CALL_REC.ACWTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'ACW_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The total time, in seconds, for which the call was put on hold by the answering agent in this call segment. In agent-to-agent calls, ANSHOLDTIME is accrued for the answering agent if the agent puts the call on hold. The other agent continues to accrue tal. The data in this column maps to the CALL_REC.ANSHOLDTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'ANS_HOLD_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'An indication of whether the answering agent in this call segment requested supervisor assistance on this call. Values for ASSIST are 0, which means that no request for assistance was made, and 1, which means that the agent requested assistance. The data in this column maps to the CALL_REC.ASSIST column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'ASSIST'
GO
EXEC sp_addextendedproperty N'MS_Description', N'An indication of whether an agent in this segment reported an audio difficulty problem. Values for AUDIO are 0, which means that no audio difficulty was reported, and 1, which means that audio difficulty was reported. The data in this column maps to the CALL_REC.AUDIO column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'AUDIO'
GO
EXEC sp_addextendedproperty N'MS_Description', N'A unique number that is assigned to this call and all of its call segments. For conferenced and transferred calls, two (or more) calls are associated with each other. When the entire call is recorded, one CALLID is used to join all of the associated call . The data in this column maps to the CALL_REC.CALLID column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'CALLID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The calling party identification. On communication servers without ISDN ANI delivery, the identification is the extension or trunk equipment location that identifies the originator of the call. On communication servers with ISDN ANI delivery, the identifi. The data in this column maps to the CALL_REC.CALLING_PTY column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'CALLING_PTY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'An indication that the answering agent initiated a conference on this call segment. Valid values for CONFERENCE are 0, which means that the agent did not initiate a conference, and 1, which means that the agent did initiate a conference. The data in this column maps to the CALL_REC.CONFERENCE column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'CONFERENCE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time that an agent talks on any outbound call while in AUX work, ACW, or in OTHER with a call on hold. This includes the time the originating agent spent talking to the destination party while establishing a conference or transferring a call. The data in this column maps to the CALL_REC.CONSULTTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'CONSULT_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'An indication of whether the call queued as a direct agent call. Valid values for DA_QUEUED are 0, which means that the call did not queue as a direct agent call, or 1, which means that the call did queue as a direct agent call. The data in this column maps to the CALL_REC.DA_QUEUED column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'DA_QUEUED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The data in this column maps to the CALL_REC.DIALED_NUM column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'DIALED_NUM'
GO
EXEC sp_addextendedproperty N'MS_Description', N'An indication of the call disposition. The data in this column maps to the CALL_REC.DISPOSITION column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'DISPOSITION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The priority that the call had at its disposition in this segment. The data in this column maps to the CALL_REC.DISPPRIORITY column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'DISP_PRIORITY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The wait time in the vector, in queue, and ringing that elapses until the disposition is recorded in DISPOSITION for the segment. For extension calls that are placed directly to agents and not through a VDN, this is always zero. The data in this column maps to the CALL_REC.DISPTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'DISP_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The total time that the trunk was in use. This is the overall trunk holding time from the beginning of the call segment until the caller is disconnected. For the first segment of a call, this is the trunk holding time for the caller for the entire call, f. The data in this column maps to the CALL_REC.DURATION column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'DURATION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times each event, or stroke count, feature button from 1 to 9 was pressed while the agent was on an ACD call or in call-related ACW. The data in this column maps to the CALL_REC.EVENT1 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'EVENT1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'he number of times each event, or stroke count, feature button from 1 to 9 was entered for this call segment. The data in this column maps to the CALL_REC.EVENT2 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'EVENT2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'he number of times each event, or stroke count, feature button from 1 to 9 was entered for this call segment. The data in this column maps to the CALL_REC.EVENT3 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'EVENT3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'he number of times each event, or stroke count, feature button from 1 to 9 was entered for this call segment. The data in this column maps to the CALL_REC.EVENT4 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'EVENT4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'he number of times each event, or stroke count, feature button from 1 to 9 was entered for this call segment. The data in this column maps to the CALL_REC.EVENT5 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'EVENT5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'he number of times each event, or stroke count, feature button from 1 to 9 was entered for this call segment. The data in this column maps to the CALL_REC.EVENT6 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'EVENT6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'he number of times each event, or stroke count, feature button from 1 to 9 was entered for this call segment. The data in this column maps to the CALL_REC.EVENT7 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'EVENT7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'he number of times each event, or stroke count, feature button from 1 to 9 was entered for this call segment. The data in this column maps to the CALL_REC.EVENT8 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'EVENT8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'he number of times each event, or stroke count, feature button from 1 to 9 was entered for this call segment. The data in this column maps to the CALL_REC.EVENT9 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'EVENT9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The 2nd-9th VDN associated with the call segment. The data in this column maps to the CALL_REC.VDN2 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'VDN2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The 2nd-9th VDN associated with the call segment. The data in this column maps to the CALL_REC.VDN3 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'VDN3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The 2nd-9th VDN associated with the call segment. The data in this column maps to the CALL_REC.VDN4 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'VDN4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The 2nd-9th VDN associated with the call segment. The data in this column maps to the CALL_REC.VDN5 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'VDN5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The 2nd-9th VDN associated with the call segment. The data in this column maps to the CALL_REC.VDN6 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'VDN6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The 2nd-9th VDN associated with the call segment. The data in this column maps to the CALL_REC.VDN7 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'VDN7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The 2nd-9th VDN associated with the call segment. The data in this column maps to the CALL_REC.VDN8 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'VDN8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The 2nd-9th VDN associated with the call segment. The data in this column maps to the CALL_REC.VDN9 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'VDN9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The total number of times that this call was placed on hold by the answering agent in this call segment. With agent-to-agent calls, this count is incremented for the agent who puts the call on hold but not for the calling agent. The HELD item applies to a. The data in this column maps to the CALL_REC.HELD column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'HELD'
GO
EXEC sp_addextendedproperty N'MS_Description', N'An indication of whether this call abandoned from hold in this call segment. Valid values for HOLDABN are 0, which means that the call did not abandon from hold, and 1, which means that "yes" the call did abandon from hold. The HOLDABN item applies to all. The data in this column maps to the CALL_REC.HOLDABN column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'HOLD_ABN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The last call work code, which can be comprised of up to 16 digits, that was entered by the answering agent in this call segment. The data in this column maps to the CALL_REC.LASTCWC column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'LAST_CWC'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The last set of collected digits that is sent to the CMS by the communication server for this call. These are digits that the communication server sends to the CMS when it executes a "collect" vector command. The digits may be digits that the caller was p. The data in this column maps to the CALL_REC.LASTDIGITS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'LAST_DIGITS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The login ID of the last agent who service-observed or bridged on to this call. The data in this column maps to the CALL_REC.LASTOBSERVER column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'LAST_OBSERVER'
GO
EXEC sp_addextendedproperty N'MS_Description', N'An indication of whether a MCT was activated for this call segment. Valid values for MALICIOUS are 0, which means that no MCT was activated, and 1, which means that a MCT was activated.. The data in this column maps to the CALL_REC.MALICIOUS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'MALICIOUS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'An indication of whether this call represents an agent observing or bridging on to an existing call. Valid values for OBSERVINGCALL are 0, which means that no observing took place, and 1, which means that observing did take place. The data in this column maps to the CALL_REC.OBSERVINGCALL column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'OBSERVING_CALL'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The identifying number of the call segment. Segment numbers begin with 1 and continue through the number of segments in the call. The data in this column maps to the CALL_REC.SEGMENT column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'SEGMENT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This corresponds to the start date associated with the record. This is calculated by the data importer based on the source data time corresponding to the start date of the record. The data in this column maps to the CALL_REC.START_DATE column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'START_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This corresponds to the start UTC date associated with the record. This is calculated by the data importer based on the source data time corresponding to the start date of the record. The data in this column maps to the CALL_REC.START_DATE_UTC column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'START_DATE_UTC'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This corresponds to the stop date associated with the record. This is calculated by the data importer based on the source data time corresponding to the stop date. The data in this column maps to the CALL_REC.STOP_DATE column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'STOP_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This corresponds to the stop utc date associated with the record. This is calculated by the data importer based on the source data time corresponding to the stop utc date. The data in this column maps to the CALL_REC.STOP_DATE_UTC column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'STOP_DATE_UTC'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The total talk time for the answering agent in this segment. The data in this column maps to the CALL_REC.TALKTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'TALK_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'An indication of whether the answering agent initiated a transfer for this call. Valid values for TRANSFERRED are 0, which means that "no" transfer was initiated, and 1, which means that "yes" a transfer was initiated. TRANSFERRED includes all calls that . The data in this column maps to the CALL_REC.TRANSFERRED column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'TRANSFERRED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The agent released or dropped the split/skill or direct agent ACD call, including transferred and conferenced calls. Valid values are n, which means that the call was not released or dropped,and y, which means that the call was released or dropped. The data in this column maps to the CALL_REC.AGT_RELEASED column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'AGT_RELEASED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The Information Indicator (II) digits that are associated with the call. These digits are a two-digit string that is provided by ISDN PRI to indicate the type of originating line of the caller. These digits supply information about the originator location. The data in this column maps to the CALL_REC.CALLING_II column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'CALLING_II'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The skill level, from 1 through 16, that is associated with the skill in which the agent answered the call or, for calls that abandoned from ringing or from a direct agent queue, associated with the agent from whom the call abandoned. The data in this column maps to the CALL_REC.DISPSKLEVEL column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'DISP_SKLEVEL'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The length of time that the call spends in a VDN while processing at a communication server that is located elsewhere in the network. The data in this column maps to the CALL_REC.NETINTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'NET_IN_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The total length of time for which the call was put on hold by the originating agent. The data in this column maps to the CALL_REC.ORIGHOLDTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'ORIG_HOLD_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The UCID is the Universal Call Identifier-a unique number assigned to this call segment within the customer network. The data in this column maps to the CALL_REC.UCID column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'UCID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The location ID of the answering agent. This ID number is not assigned to an agent, but rather to the agent terminal and is associated with the communication server port network ID. An agent may be associated with a location ID only upon logging into the . The data in this column maps to the CALL_REC.ANS_LOCID column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'ANS_LOCID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The location ID of an agent observing or bridging on to an existing call. The data in this column maps to the CALL_REC.OBS_LOCID column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'OBS_LOCID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The location ID of the agent who is originating the call. The data in this column maps to the CALL_REC.ORIG_LOCID column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'ORIG_LOCID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The first, second, third, fourth, or fifth Call Work Code entered by an agent for the Call Segment. Items CWC1 through CWC5 are supported by the Multiple Call Work Codes per Call Record feature that was implemented in CMS R3V11. The data in this column maps to the CALL_REC.CWC1 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'CWC1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The first, second, third, fourth, or fifth Call Work Code entered by an agent for the Call Segment. Items CWC1 through CWC5 are supported by the Multiple Call Work Codes per Call Record feature that was implemented in CMS R3V11. The data in this column maps to the CALL_REC.CWC2 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'CWC2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The first, second, third, fourth, or fifth Call Work Code entered by an agent for the Call Segment. Items CWC1 through CWC5 are supported by the Multiple Call Work Codes per Call Record feature that was implemented in CMS R3V11. The data in this column maps to the CALL_REC.CWC3 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'CWC3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The first, second, third, fourth, or fifth Call Work Code entered by an agent for the Call Segment. Items CWC1 through CWC5 are supported by the Multiple Call Work Codes per Call Record feature that was implemented in CMS R3V11. The data in this column maps to the CALL_REC.CWC4 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'CWC4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The first, second, third, fourth, or fifth Call Work Code entered by an agent for the Call Segment. Items CWC1 through CWC5 are supported by the Multiple Call Work Codes per Call Record feature that was implemented in CMS R3V11. The data in this column maps to the CALL_REC.CWC5 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'CWC5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Time the call segment spent in queue before answer. The data in this column maps to the CALL_REC.QUEUETIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'QUEUE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Time the call segment spent ringing at the agent position. The data in this column maps to the CALL_REC.RINGTIME column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'RING_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Length in bytes of the User to User Information associated with the call segment. The data in this column maps to the CALL_REC.UUI_LEN column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'UUI_LEN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The last ASAI User to User Information associated with the call segment. The data in this column maps to the CALL_REC.ASAI_UUI column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'ASAI_UUI'
GO
EXEC sp_addextendedproperty N'MS_Description', N'FUTURE USE. The data in this column maps to the CALL_REC.INTERRUPTDEL column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'INTERRUPT_DEL'
GO
EXEC sp_addextendedproperty N'MS_Description', N'FUTURE USE. The data in this column maps to the CALL_REC.AGENTSURPLUS column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'AGENT_SURPLUS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'FUTURE USE. The data in this column maps to the CALL_REC.AGENTSKILLLEVEL column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'AGENT_SKILL_LEVEL'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Future Use. The data in this column maps to the CALL_REC.PREFSKILLLEVEL column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'PREF_SKILL_LEVEL'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The data in this column maps to the CALL_REC.ICRRESENT column in the Avaya CMS database and represents whether the call was re-sent to the CM by ICR. Valid values are 0=NO, 1=YES.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'ICR_RESENT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The data in this column maps to the CALL_REC.ICRPULLREASON column in the Avaya CMS database and represents the reason a call was pulled back by ICR. Valid values are: 0=Call not pulled back. 1=Resources not available. 2=Wait time increased drastically. 3=Caller receiving treatment. 4=Network failure recovery. 5=VP failure recovery. 6=Caller interaction', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'ICR_PULL_REASON'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the offset from UTC corresponding to the record. The data in this column maps to the CALL_REC.UTC_TIMEZONE column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'UTC_TIMEZONE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM0', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM1', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM2', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM3', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM4', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM5', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM6', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM7', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM8', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM9', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'CUSTOM_MEASURE_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'CUSTOM_MEASURE_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'CUSTOM_MEASURE_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'CUSTOM_MEASURE_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'CUSTOM_MEASURE_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'CUSTOM_MEASURE_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'CUSTOM_MEASURE_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'CUSTOM_MEASURE_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'CUSTOM_MEASURE_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_CALL_RECORD', 'COLUMN', N'CUSTOM_MEASURE_9'
GO
GRANT SELECT
	ON [dbo].[TB_FCT_CMS_CALL_RECORD]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_FCT_CMS_CALL_RECORD]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_FCT_CMS_CALL_RECORD]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_FCT_CMS_CALL_RECORD] SET (LOCK_ESCALATION = TABLE)
GO
