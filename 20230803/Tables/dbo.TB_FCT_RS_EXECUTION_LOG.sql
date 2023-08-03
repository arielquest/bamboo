SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_FCT_RS_EXECUTION_LOG] (
		[EXECUTION_LOG_URN]       [int] IDENTITY(1, 4) NOT FOR REPLICATION NOT NULL,
		[RESOURCE_ID]             [uniqueidentifier] NOT NULL,
		[MACHINE_URN]             [int] NOT NULL,
		[REPORT_ID]               [uniqueidentifier] NOT NULL,
		[REQUEST_TYPE_URN]        [int] NOT NULL,
		[FORMAT_TYPE_URN]         [int] NOT NULL,
		[STATUS_CODE_URN]         [int] NOT NULL,
		[SOURCE_TYPE_URN]         [int] NOT NULL,
		[START_DATE_TIME]         [datetime] NOT NULL,
		[END_DATE_TIME]           [datetime] NOT NULL,
		[STARTDATE_URN]           [int] NULL,
		[STARTTIME_URN]           [int] NULL,
		[ENDDATE_URN]             [int] NULL,
		[ENDTIME_URN]             [int] NULL,
		[STARTDATE_UTC_URN]       [int] NULL,
		[STARTTIME_UTC_URN]       [int] NULL,
		[ENDDATE_UTC_URN]         [int] NULL,
		[ENDTIME_UTC_URN]         [int] NULL,
		[DATA_RETRIEVAL_TIME]     [int] NOT NULL,
		[PROCESSING_TIME]         [int] NOT NULL,
		[RENDERING_TIME]          [int] NOT NULL,
		[BYTE_COUNT]              [bigint] NULL,
		[ROW_COUNT]               [bigint] NULL,
		[PARTITION_ID]            [int] NOT NULL,
		[USER_NAME]               [nvarchar](70) COLLATE Latin1_General_CI_AS NULL,
		[PARAMETER_SET_ID_1]      [uniqueidentifier] NULL,
		[PARAMETER_SET_ID_2]      [uniqueidentifier] NULL,
		[PARAMETER_SET_ID_3]      [uniqueidentifier] NULL,
		[FROM_DATE_PARAM]         [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
		[TO_DATE_PARAM]           [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
		[CUSTOM_DIMENSION_0]      [int] NOT NULL,
		[CUSTOM_DIMENSION_1]      [int] NOT NULL,
		[CUSTOM_DIMENSION_2]      [int] NOT NULL,
		[CUSTOM_DIMENSION_3]      [int] NOT NULL,
		[CUSTOM_DIMENSION_4]      [int] NOT NULL,
		[CUSTOM_DIMENSION_5]      [int] NOT NULL,
		[CUSTOM_DIMENSION_6]      [int] NOT NULL,
		[CUSTOM_DIMENSION_7]      [int] NOT NULL,
		[CUSTOM_DIMENSION_8]      [int] NOT NULL,
		[CUSTOM_DIMENSION_9]      [int] NOT NULL,
		[CUSTOM_MEASURE_0]        [int] NULL,
		[CUSTOM_MEASURE_1]        [int] NULL,
		[CUSTOM_MEASURE_2]        [int] NULL,
		[CUSTOM_MEASURE_3]        [int] NULL,
		[CUSTOM_MEASURE_4]        [int] NULL,
		[CUSTOM_MEASURE_5]        [int] NULL,
		[CUSTOM_MEASURE_6]        [int] NULL,
		[CUSTOM_MEASURE_7]        [int] NULL,
		[CUSTOM_MEASURE_8]        [int] NULL,
		[CUSTOM_MEASURE_9]        [int] NULL,
		CONSTRAINT [PK_EXECUTION_LOG_URN]
		PRIMARY KEY
		CLUSTERED
		([EXECUTION_LOG_URN])
	ON [FCTGROUP]
) ON [FCTGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_FCT_RS_EXECUTION_LOG_START_DATE_TIME]
	ON [dbo].[TB_FCT_RS_EXECUTION_LOG] ([START_DATE_TIME])
	ON [FCTIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_LOG', 'INDEX', N'IX_FCT_RS_EXECUTION_LOG_START_DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the template table for the storing the report execution logs from SQL server reporting services 2000 database. This table is created as install time and the data importer creates various partition tables with the same schema. These partition tables are prefixed as TB_FCT_RS_EXECUTION_LOG_ followed by the partition identifier. The partition identifier is created depending on the importer configuration, for example monthly, weekly etc. All currently active partitions are included VW_PARTITONED_FCT_RS_EXECUTION_LOG view. Since the partitioned tables are generated at runtime and that they have the same schema no separate documentations are required for each partition table. The data in these partitioned tables are imported from ExecutionLog table in SQL Server reporting services database.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_LOG', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_LOG', 'COLUMN', N'EXECUTION_LOG_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TB_CLU_RESOURCE corresponding to the source reporting services database from which the data is imported.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_LOG', 'COLUMN', N'RESOURCE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_RS_MACHINE corresponding to the server where the report was executed. This is calculated or looked up based on InstanceName column in the ExecutionLog table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_LOG', 'COLUMN', N'MACHINE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TB_REP_REPORT corresponding to the report that was executed. This is calculated during the import based on the content path of the report in the Reporting services database.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_LOG', 'COLUMN', N'REPORT_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TE_DIM_RS_REQUEST_TYPE corresponding to the request type for the report execution. This is looked up based on RequestType column in the ExecutionLog table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_LOG', 'COLUMN', N'REQUEST_TYPE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CODE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_LOG', 'COLUMN', N'REQUEST_TYPE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_RS_FORMAT_TYPE corresponding to the format of the report that was executed. This is looked up or generated based on the Format column in ExecutionLog table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_LOG', 'COLUMN', N'FORMAT_TYPE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_RS_STATUS_CODE corresponding to the status of the report execution. This is looked up or generated based on the Status column in ExectionLog table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_LOG', 'COLUMN', N'STATUS_CODE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TE_DIM_RS_SOURCE_TYPE corresponding to the source of the report execution. This is looked up based on the Source column in ExecutionLog table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_LOG', 'COLUMN', N'SOURCE_TYPE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CODE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_LOG', 'COLUMN', N'SOURCE_TYPE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the date time corresponding to the start of the report execution. This maps to the TimeStart column in the ExecutionLog table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_LOG', 'COLUMN', N'START_DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the date time corresponding to the end of the report execution. This maps to the TimeEnd column in the ExecutionLog table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_LOG', 'COLUMN', N'END_DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the start date of the report exection. This is calculated based on the TimeStart column in the ExecutionLog table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_LOG', 'COLUMN', N'STARTDATE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DATE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_LOG', 'COLUMN', N'STARTDATE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the time on the start date of the report exection. This is calculated based on the TimeStart column in the ExecutionLog table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_LOG', 'COLUMN', N'STARTTIME_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIME', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_LOG', 'COLUMN', N'STARTTIME_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the end date of the report exection. This is calculated based on the TimeEnd column in the ExecutionLog table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_LOG', 'COLUMN', N'ENDDATE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DATE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_LOG', 'COLUMN', N'ENDDATE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the time on the end date of the report exection. This is calculated based on the TimeEnd column in the ExecutionLog table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_LOG', 'COLUMN', N'ENDTIME_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIME', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_LOG', 'COLUMN', N'ENDTIME_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_LOG', 'COLUMN', N'STARTDATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DATE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_LOG', 'COLUMN', N'STARTDATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_LOG', 'COLUMN', N'STARTTIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIME', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_LOG', 'COLUMN', N'STARTTIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_LOG', 'COLUMN', N'ENDDATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DATE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_LOG', 'COLUMN', N'ENDDATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_LOG', 'COLUMN', N'ENDTIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIME', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_LOG', 'COLUMN', N'ENDTIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the time, in milliseconds, corresponding to time taken to execute the queries to retrieve data for the report. This maps to TimeDataRetrieval column in ExecutionLog table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_LOG', 'COLUMN', N'DATA_RETRIEVAL_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the time, in milliseconds, corresponding to time taken to process data for the report. This maps to TimeProcessing column in ExecutionLog table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_LOG', 'COLUMN', N'PROCESSING_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the time, in milliseconds, corresponding to time taken to render the report. This maps to TimeRendering column in ExecutionLog table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_LOG', 'COLUMN', N'RENDERING_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the size of rendered report in bytes. This maps to ByteCount column in the ExecutionLog table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_LOG', 'COLUMN', N'BYTE_COUNT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number of rows returned by the queries. This maps to RowCount column in the ExecutionLog table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_LOG', 'COLUMN', N'ROW_COUNT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number for the current partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_LOG', 'COLUMN', N'PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The user name from the report parameters.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_LOG', 'COLUMN', N'USER_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The first parameter set in the report.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_LOG', 'COLUMN', N'PARAMETER_SET_ID_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The second parameter set in the report.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_LOG', 'COLUMN', N'PARAMETER_SET_ID_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The third parameter set in the report.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_LOG', 'COLUMN', N'PARAMETER_SET_ID_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The from date parameter used when executing the report.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_LOG', 'COLUMN', N'FROM_DATE_PARAM'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The to date parameter used when executing the report.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_LOG', 'COLUMN', N'TO_DATE_PARAM'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_LOG', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM0', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_LOG', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_LOG', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM1', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_LOG', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_LOG', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM2', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_LOG', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_LOG', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM3', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_LOG', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_LOG', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM4', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_LOG', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_LOG', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM5', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_LOG', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_LOG', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM6', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_LOG', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_LOG', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM7', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_LOG', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_LOG', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM8', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_LOG', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_LOG', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM9', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_LOG', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_LOG', 'COLUMN', N'CUSTOM_MEASURE_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_LOG', 'COLUMN', N'CUSTOM_MEASURE_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_LOG', 'COLUMN', N'CUSTOM_MEASURE_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_LOG', 'COLUMN', N'CUSTOM_MEASURE_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_LOG', 'COLUMN', N'CUSTOM_MEASURE_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_LOG', 'COLUMN', N'CUSTOM_MEASURE_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_LOG', 'COLUMN', N'CUSTOM_MEASURE_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_LOG', 'COLUMN', N'CUSTOM_MEASURE_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_LOG', 'COLUMN', N'CUSTOM_MEASURE_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_RS_EXECUTION_LOG', 'COLUMN', N'CUSTOM_MEASURE_9'
GO
GRANT SELECT
	ON [dbo].[TB_FCT_RS_EXECUTION_LOG]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_FCT_RS_EXECUTION_LOG]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_FCT_RS_EXECUTION_LOG]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_FCT_RS_EXECUTION_LOG] SET (LOCK_ESCALATION = TABLE)
GO
