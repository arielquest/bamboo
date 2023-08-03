SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_FCT_IVR_CALL] (
		[PARTITION_URN]               [int] NOT NULL,
		[PARTITION_GLOBAL_URN]        [bigint] NOT NULL,
		[PARTITION_ID]                [int] NOT NULL,
		[START_DATE_TIME]             [datetime] NOT NULL,
		[END_DATE_TIME]               [datetime] NULL,
		[UTC_TIMEZONE]                [int] NOT NULL,
		[START_DATE_URN]              [int] NOT NULL,
		[START_TIME_URN]              [smallint] NOT NULL,
		[START_DATE_UTC_URN]          [int] NOT NULL,
		[START_TIME_UTC_URN]          [smallint] NOT NULL,
		[END_DATE_URN]                [int] NOT NULL,
		[END_TIME_URN]                [smallint] NOT NULL,
		[END_DATE_UTC_URN]            [int] NOT NULL,
		[END_TIME_UTC_URN]            [smallint] NOT NULL,
		[DIALED_NUMBER_URN]           [int] NOT NULL,
		[CALL_TYPE_CODE_URN]          [int] NOT NULL,
		[SUBSYSTEM_TYPE_CODE_URN]     [int] NOT NULL,
		[DURATION]                    [int] NOT NULL,
		[NUM_TIMEOUT]                 [int] NOT NULL,
		[NUM_ERROR]                   [int] NOT NULL,
		[NUM_HOLD]                    [int] NOT NULL,
		[NUM_APP_VISITED]             [int] NOT NULL,
		[TOTAL_TRANSFER]              [int] NOT NULL,
		[CLI_STRING]                  [varchar](32) COLLATE Latin1_General_CI_AS NULL,
		[DNIS_STRING]                 [varchar](32) COLLATE Latin1_General_CI_AS NOT NULL,
		[UUI_STRING]                  [varchar](100) COLLATE Latin1_General_CI_AS NULL,
		[IIDIGITS_STRING]             [varchar](100) COLLATE Latin1_General_CI_AS NULL,
		[UID_STRING]                  [varchar](50) COLLATE Latin1_General_CI_AS NULL,
		[DB_DATETIME]                 [datetime] NULL,
		[CALL_KEY1]                   [varchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[CALL_KEY2]                   [varchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[CLUSTER_RESOURCE_URN]        [int] NOT NULL,
		[CUSTOM_DIMENSION_0]          [int] NOT NULL,
		[CUSTOM_DIMENSION_1]          [int] NOT NULL,
		[CUSTOM_DIMENSION_2]          [int] NOT NULL,
		[CUSTOM_DIMENSION_3]          [int] NOT NULL,
		[CUSTOM_DIMENSION_4]          [int] NOT NULL,
		[CUSTOM_DIMENSION_5]          [int] NOT NULL,
		[CUSTOM_DIMENSION_6]          [int] NOT NULL,
		[CUSTOM_DIMENSION_7]          [int] NOT NULL,
		[CUSTOM_DIMENSION_8]          [int] NOT NULL,
		[CUSTOM_DIMENSION_9]          [int] NOT NULL,
		[CUSTOM_MEASURE_0]            [int] NULL,
		[CUSTOM_MEASURE_1]            [int] NULL,
		[CUSTOM_MEASURE_2]            [int] NULL,
		[CUSTOM_MEASURE_3]            [int] NULL,
		[CUSTOM_MEASURE_4]            [int] NULL,
		[CUSTOM_MEASURE_5]            [int] NULL,
		[CUSTOM_MEASURE_6]            [int] NULL,
		[CUSTOM_MEASURE_7]            [int] NULL,
		[CUSTOM_MEASURE_8]            [int] NULL,
		[CUSTOM_MEASURE_9]            [int] NULL,
		[TIDEMARK_VALUE1]             [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
		[TIDEMARK_VALUE2]             [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
		[TIDEMARK_VALUE3]             [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
		[TIDEMARK_VALUE4]             [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
		[TIDEMARK_VALUE5]             [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
		CONSTRAINT [PK_FCT_IVR_CALL]
		PRIMARY KEY
		CLUSTERED
		([PARTITION_URN], [PARTITION_ID])
	ON [FCTIVRGROUP]
) ON [FCTIVRGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_FCT_IVR_CALL_CALL_TYPE_CODE_URN]
	ON [dbo].[TB_FCT_IVR_CALL] ([CALL_TYPE_CODE_URN])
	ON [FCTIVRIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL', 'INDEX', N'IX_FCT_IVR_CALL_CALL_TYPE_CODE_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_IVR_CALL_SUBSYSTEM_TYPE_CODE_URN]
	ON [dbo].[TB_FCT_IVR_CALL] ([SUBSYSTEM_TYPE_CODE_URN])
	ON [FCTIVRIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL', 'INDEX', N'IX_FCT_IVR_CALL_SUBSYSTEM_TYPE_CODE_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_IVR_CALL_START_DATE_TIME]
	ON [dbo].[TB_FCT_IVR_CALL] ([START_DATE_TIME])
	ON [FCTIVRIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL', 'INDEX', N'IX_FCT_IVR_CALL_START_DATE_TIME'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_IVR_CALL_END_DATE_TIME]
	ON [dbo].[TB_FCT_IVR_CALL] ([END_DATE_TIME])
	ON [FCTIVRIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL', 'INDEX', N'IX_FCT_IVR_CALL_END_DATE_TIME'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_IVR_CALL_END_DATE_URN]
	ON [dbo].[TB_FCT_IVR_CALL] ([END_DATE_URN])
	ON [FCTIVRIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL', 'INDEX', N'IX_FCT_IVR_CALL_END_DATE_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_IVR_CALL_END_DATE_UTC_URN]
	ON [dbo].[TB_FCT_IVR_CALL] ([END_DATE_UTC_URN])
	ON [FCTIVRIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL', 'INDEX', N'IX_FCT_IVR_CALL_END_DATE_UTC_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_IVR_CALL_REPORTING_1X]
	ON [dbo].[TB_FCT_IVR_CALL] ([DIALED_NUMBER_URN], [START_DATE_TIME], [CALL_TYPE_CODE_URN], [SUBSYSTEM_TYPE_CODE_URN])
	INCLUDE ([DURATION], [NUM_TIMEOUT], [NUM_ERROR], [NUM_HOLD], [NUM_APP_VISITED], [TOTAL_TRANSFER], [CLI_STRING], [UUI_STRING], [IIDIGITS_STRING], [UID_STRING])
	ON [FCTIVRIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL', 'INDEX', N'IX_FCT_IVR_CALL_REPORTING_1X'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the template table for the historical data for ivr call statistics. This table is created at install time and the partitioning service creates various partition tables with the same schema. These partition tables are prefixed as TB_FCT_IVR_CALL_ followed by the partition identifier. The partition identifier is created depending on the partition configuration, for example monthly, weekly etc. All currently active partitions are included VW_PARTITONED_FCT_IVR_CALL view. Since the partitioned tables are generated at runtime and that they have the same schema no separate documentations are required for each partition table. In case of a configured Cisco Unified Customer Voice Portal (CVP) the data in these partition tables are sourced from the call table in CVP Report Server Core Database.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL', 'COLUMN', N'PARTITION_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column holds a value that uniquely identifies a row across all the partition tables for this partition type.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL', 'COLUMN', N'PARTITION_GLOBAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number for the current partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL', 'COLUMN', N'PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the date time in UTC indicating the date and time when the call was started. This maps to the column StartDateTime in Cisco CVP.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL', 'COLUMN', N'START_DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the date time in UTC indicating the date and time when the call was terminated. This maps to the column EndDateTime in Cisco CVP.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL', 'COLUMN', N'END_DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the offset from UTC in minutes. This maps to the LocalTimeZoneOffset column in Cisco CVP.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL', 'COLUMN', N'UTC_TIMEZONE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the date when call was started. This is calculated based on START_DATE_TIME and UTC_TIMEZONE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL', 'COLUMN', N'START_DATE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the time when the call was started. This is calculated based on START_DATE_TIME and UTC_TIMEZONE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL', 'COLUMN', N'START_TIME_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the UTC date when call was started. This is calculated based on START_DATE_TIME.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL', 'COLUMN', N'START_DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the UTC time of UTC date when the call was started. This is calculated based on START_DATE_TIME.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL', 'COLUMN', N'START_TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the date when call terminated. This is calculated based on END_DATE_TIME and UTC_TIMEZONE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL', 'COLUMN', N'END_DATE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the time when the call was terminated. This is calculated based on END_DATE_TIME and UTC_TIMEZONE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL', 'COLUMN', N'END_TIME_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the UTC date when call was terminated. This is calculated based on END_DATE_TIME.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL', 'COLUMN', N'END_DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the UTC time of UTC date when the call was terminated. This is calculated based on END_DATE_TIME.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL', 'COLUMN', N'END_TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DIALED_NUMBER of type IT_DIALED_NUMBER. This corresponds to the dnis associated with the call. This is looked up or generated based on DNIS column in Cisco CVP.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL', 'COLUMN', N'DIALED_NUMBER_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DIALED_NUMBER', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL', 'COLUMN', N'DIALED_NUMBER_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_CODE of type IT_CODE. This Code will be a member of the Code Group IVR Call Type. This is looked up based on the CallTypeID column in Cisco CVP.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL', 'COLUMN', N'CALL_TYPE_CODE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_CODE of type IT_CODE. This Code will be a member of the Code Group IVR Subsystem Type. This is looked up based on the SubSystemTypeID column in Cisco CVP.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL', 'COLUMN', N'SUBSYSTEM_TYPE_CODE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the duration of the call in seconds.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL', 'COLUMN', N'DURATION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number of times the call timed out. This maps to the NumTimeOut column in Cisco CVP.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL', 'COLUMN', N'NUM_TIMEOUT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number of errors that occured during the call. This maps to the NumError column in Cisco CVP.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL', 'COLUMN', N'NUM_ERROR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number of holds that occured within an IVR Script. This maps to NumOnHold column in Cisco CVP.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL', 'COLUMN', N'NUM_HOLD'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number of IVR Scripts visited during the call. This maps to NumAppVisited column in Cisco CVP.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL', 'COLUMN', N'NUM_APP_VISITED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the totalnumber ot times the call was transferred out. This maps to the TotalTransfer column in Cisco CVP.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL', 'COLUMN', N'TOTAL_TRANSFER'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the call line identifier. This maps to the ANI column in Cisco CVP.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL', 'COLUMN', N'CLI_STRING'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the DNIS associated with the call. This maps to the DNIS column in Cisco CVP.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL', 'COLUMN', N'DNIS_STRING'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to the UUI column in Cisco CVP.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL', 'COLUMN', N'UUI_STRING'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to the IIDIGITS column in Cisco CVP.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL', 'COLUMN', N'IIDIGITS_STRING'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to the UID column in Cisco CVP.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL', 'COLUMN', N'UID_STRING'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the date time when the record was written in the source database. This maps to DBDateTime column in Cisco CVP.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL', 'COLUMN', N'DB_DATETIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Identifier for the record in the source table. This maps to CallGUID column in Cisco CVP.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL', 'COLUMN', N'CALL_KEY1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Identifier for the record in the source table. This maps to CallStartDate column in Cisco CVP.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL', 'COLUMN', N'CALL_KEY2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from the table dbo.TB_CLU_RESOURCE indicating the source of the data.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL', 'COLUMN', N'CLUSTER_RESOURCE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM0', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM1', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM2', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM3', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM4', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM5', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM6', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM7', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM8', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM9', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL', 'COLUMN', N'CUSTOM_MEASURE_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL', 'COLUMN', N'CUSTOM_MEASURE_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL', 'COLUMN', N'CUSTOM_MEASURE_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL', 'COLUMN', N'CUSTOM_MEASURE_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL', 'COLUMN', N'CUSTOM_MEASURE_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL', 'COLUMN', N'CUSTOM_MEASURE_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL', 'COLUMN', N'CUSTOM_MEASURE_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL', 'COLUMN', N'CUSTOM_MEASURE_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL', 'COLUMN', N'CUSTOM_MEASURE_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL', 'COLUMN', N'CUSTOM_MEASURE_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL', 'COLUMN', N'TIDEMARK_VALUE1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL', 'COLUMN', N'TIDEMARK_VALUE2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL', 'COLUMN', N'TIDEMARK_VALUE3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL', 'COLUMN', N'TIDEMARK_VALUE4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_CALL', 'COLUMN', N'TIDEMARK_VALUE5'
GO
GRANT SELECT
	ON [dbo].[TB_FCT_IVR_CALL]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_FCT_IVR_CALL]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_FCT_IVR_CALL]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_FCT_IVR_CALL] SET (LOCK_ESCALATION = TABLE)
GO
