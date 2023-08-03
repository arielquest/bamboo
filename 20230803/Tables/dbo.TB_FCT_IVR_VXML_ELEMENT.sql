SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_FCT_IVR_VXML_ELEMENT] (
		[PARTITION_URN]                      [int] NOT NULL,
		[PARTITION_GLOBAL_URN]               [bigint] NOT NULL,
		[PARTITION_ID]                       [int] NOT NULL,
		[START_DATE_TIME]                    [datetime] NOT NULL,
		[END_DATE_TIME]                      [datetime] NULL,
		[UTC_TIMEZONE]                       [int] NOT NULL,
		[START_DATE_UTC_URN]                 [int] NOT NULL,
		[START_TIME_UTC_URN]                 [smallint] NOT NULL,
		[END_DATE_UTC_URN]                   [int] NOT NULL,
		[END_TIME_UTC_URN]                   [smallint] NOT NULL,
		[ELEMENT_TYPE_CODE_URN]              [int] NOT NULL,
		[RESULT_CODE_URN]                    [int] NOT NULL,
		[DIALED_NUMBER_URN]                  [int] NOT NULL,
		[IVR_SCRIPT_URN]                     [int] NOT NULL,
		[SOURCE_IVR_SCRIPT_URN]              [int] NOT NULL,
		[IVR_SCRIPT_NODE_URN]                [int] NOT NULL,
		[IVR_SCRIPT_NODE_EXIT_STATE_URN]     [int] NOT NULL,
		[APPLICATION_NAME]                   [nvarchar](100) COLLATE Latin1_General_CI_AS NULL,
		[ELEMENT_NAME]                       [nvarchar](100) COLLATE Latin1_General_CI_AS NULL,
		[EXIT_STATE]                         [nvarchar](100) COLLATE Latin1_General_CI_AS NULL,
		[TOTAL_INTERACTIONS]                 [int] NULL,
		[DURATION]                           [int] NULL,
		[DB_DATETIME]                        [datetime] NULL,
		[CALL_KEY1]                          [varchar](50) COLLATE Latin1_General_CI_AS NULL,
		[CALL_KEY2]                          [varchar](50) COLLATE Latin1_General_CI_AS NULL,
		[SESSION_KEY]                        [bigint] NULL,
		[ELEMENT_KEY]                        [bigint] NULL,
		[CLUSTER_RESOURCE_URN]               [int] NOT NULL,
		[CUSTOM_DIMENSION_0]                 [int] NOT NULL,
		[CUSTOM_DIMENSION_1]                 [int] NOT NULL,
		[CUSTOM_DIMENSION_2]                 [int] NOT NULL,
		[CUSTOM_DIMENSION_3]                 [int] NOT NULL,
		[CUSTOM_DIMENSION_4]                 [int] NOT NULL,
		[CUSTOM_DIMENSION_5]                 [int] NOT NULL,
		[CUSTOM_DIMENSION_6]                 [int] NOT NULL,
		[CUSTOM_DIMENSION_7]                 [int] NOT NULL,
		[CUSTOM_DIMENSION_8]                 [int] NOT NULL,
		[CUSTOM_DIMENSION_9]                 [int] NOT NULL,
		[CUSTOM_MEASURE_0]                   [int] NULL,
		[CUSTOM_MEASURE_1]                   [int] NULL,
		[CUSTOM_MEASURE_2]                   [int] NULL,
		[CUSTOM_MEASURE_3]                   [int] NULL,
		[CUSTOM_MEASURE_4]                   [int] NULL,
		[CUSTOM_MEASURE_5]                   [int] NULL,
		[CUSTOM_MEASURE_6]                   [int] NULL,
		[CUSTOM_MEASURE_7]                   [int] NULL,
		[CUSTOM_MEASURE_8]                   [int] NULL,
		[CUSTOM_MEASURE_9]                   [int] NULL,
		[TIDEMARK_VALUE1]                    [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
		[TIDEMARK_VALUE2]                    [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
		[TIDEMARK_VALUE3]                    [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
		[TIDEMARK_VALUE4]                    [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
		[TIDEMARK_VALUE5]                    [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
		CONSTRAINT [PK_FCT_IVR_VXML_ELEMENT]
		PRIMARY KEY
		CLUSTERED
		([PARTITION_URN], [PARTITION_ID])
	ON [FCTIVRGROUP]
) ON [FCTIVRGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_FCT_IVR_VXML_ELEMENT_ELEMENT_TYPE_CODE_URN]
	ON [dbo].[TB_FCT_IVR_VXML_ELEMENT] ([ELEMENT_TYPE_CODE_URN])
	ON [FCTIVRIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_VXML_ELEMENT', 'INDEX', N'IX_FCT_IVR_VXML_ELEMENT_ELEMENT_TYPE_CODE_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_IVR_VXML_ELEMENT_RESULT_CODE_URN]
	ON [dbo].[TB_FCT_IVR_VXML_ELEMENT] ([RESULT_CODE_URN])
	ON [FCTIVRIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_VXML_ELEMENT', 'INDEX', N'IX_FCT_IVR_VXML_ELEMENT_RESULT_CODE_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_IVR_VXML_ELEMENT_START_DATE_TIME]
	ON [dbo].[TB_FCT_IVR_VXML_ELEMENT] ([START_DATE_TIME])
	ON [FCTIVRIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_VXML_ELEMENT', 'INDEX', N'IX_FCT_IVR_VXML_ELEMENT_START_DATE_TIME'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_IVR_VXML_ELEMENT_END_DATE_TIME]
	ON [dbo].[TB_FCT_IVR_VXML_ELEMENT] ([END_DATE_TIME])
	ON [FCTIVRIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_VXML_ELEMENT', 'INDEX', N'IX_FCT_IVR_VXML_ELEMENT_END_DATE_TIME'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_IVR_VXML_ELEMENT_START_DATE_UTC_URN]
	ON [dbo].[TB_FCT_IVR_VXML_ELEMENT] ([START_DATE_UTC_URN])
	ON [FCTIVRIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_VXML_ELEMENT', 'INDEX', N'IX_FCT_IVR_VXML_ELEMENT_START_DATE_UTC_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_IVR_VXML_ELEMENT_DIALED_NUMBER_URN]
	ON [dbo].[TB_FCT_IVR_VXML_ELEMENT] ([DIALED_NUMBER_URN])
	ON [FCTIVRIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_VXML_ELEMENT', 'INDEX', N'IX_FCT_IVR_VXML_ELEMENT_DIALED_NUMBER_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the template table for the historical statistics of the individual VXML Script elements during an IVR VXML Call. This table is created at install time and the partitioning service creates various partition tables with the same schema. These partition tables are prefixed as TB_FCT_IVR_VXML_ELEMENT_ followed by the partition identifier. The partition identifier is created depending on the partition configuration, for example monthly, weekly etc. All currently active partitions are included VW_PARTITONED_FCT_IVR_VXML_ELEMENT view. Since the partitioned tables are generated at runtime and that they have the same schema no separate documentations are required for each partition table. In case of a configured Cisco Unified Customer Voice Portal (CVP) the data in these partition tables are sourced from the VXMLElement table in CVP Report Server Core Database.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_VXML_ELEMENT', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_VXML_ELEMENT', 'COLUMN', N'PARTITION_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column holds a value that uniquely identifies a row across all the partition tables for this partition type.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_VXML_ELEMENT', 'COLUMN', N'PARTITION_GLOBAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number for the current partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_VXML_ELEMENT', 'COLUMN', N'PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the UTC Date Time indicating when the VXML Script Node was entered during the VXML call. This maps to the EnterDateTime in Ciso CVP.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_VXML_ELEMENT', 'COLUMN', N'START_DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the UTC Date Time indicating when the VXML Script Node was exited during the VXML call. This maps to the ExitDateTime in Ciso CVP.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_VXML_ELEMENT', 'COLUMN', N'END_DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the offset from UTC in minutes. In case of Cisco CVP this maps to the LocalTimeZoneOffset column in the table VXMLSession which is retrieved based on SessionID.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_VXML_ELEMENT', 'COLUMN', N'UTC_TIMEZONE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the UTC date when the VXML Script Node was entered during the VXML call. This is calculated based on START_DATE_TIME.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_VXML_ELEMENT', 'COLUMN', N'START_DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the UTC time of UTC date when the VXML Script Node was entered during the VXML call. This is calculated based on START_DATE_TIME.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_VXML_ELEMENT', 'COLUMN', N'START_TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the UTC date when the VXML Script Node was exited during the VXML call. This is calculated based on END_DATE_TIME.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_VXML_ELEMENT', 'COLUMN', N'END_DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the UTC time of UTC date when the VXML Script Node was exited during the VXML call. This is calculated based on END_DATE_TIME.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_VXML_ELEMENT', 'COLUMN', N'END_TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_CODE of type IT_CODE. This Code will be a member of the Code Group IVR Element Type. This is looked up based on the ElementTypeID column in Cisco CVP.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_VXML_ELEMENT', 'COLUMN', N'ELEMENT_TYPE_CODE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_CODE of type IT_CODE. This Code will be a member of the Code Group IVR Result Type. This is looked up based on the ResultID column in Cisco CVP.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_VXML_ELEMENT', 'COLUMN', N'RESULT_CODE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DIALED_NUMBER of type IT_DIALED_NUMBER. This corresponds to the dnis associated with the call. In case of Cisco CVP this is looked up or generated based on DNIS column in the Call table which is in turn retrieved based on CallGUID.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_VXML_ELEMENT', 'COLUMN', N'DIALED_NUMBER_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DIALED_NUMBER', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_VXML_ELEMENT', 'COLUMN', N'DIALED_NUMBER_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_IVR_SCRIPT of type IT_IVR_SCRIPT. This corresponds to the IVR VXML Script associated with the record. In case of Cisco CVP this is looked up or generated based on AppName column in the VXMLSession table which is retrieved based on the SessionID.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_VXML_ELEMENT', 'COLUMN', N'IVR_SCRIPT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_IVR_SCRIPT', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_VXML_ELEMENT', 'COLUMN', N'IVR_SCRIPT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_IVR_SCRIPT of type IT_IVR_SCRIPT. This corresponds to the Source IVR Script for the IVR Script associated with the record. This is looked up or generated based on SourceAppName column in Cisco CVP.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_VXML_ELEMENT', 'COLUMN', N'SOURCE_IVR_SCRIPT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_IVR_SCRIPT', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_VXML_ELEMENT', 'COLUMN', N'SOURCE_IVR_SCRIPT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_IVR_SCRIPT_NODE of type IT_IVR_SCRIPT_NODE. This corresponds to the IVR VXML Script Node within the IVR VXML Script associated with the record. This is looked up or generated based on ElementName column in Cisco CVP.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_VXML_ELEMENT', 'COLUMN', N'IVR_SCRIPT_NODE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_IVR_SCRIPT_NODE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_VXML_ELEMENT', 'COLUMN', N'IVR_SCRIPT_NODE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_IVR_SCRIPT_NODE_EXIT_STATE of type IT_IVR_SCRIPT_NODE_EXIT_STATE. This corresponds to the Exit state of IVR VXML Script Node within the IVR VXML Script associated with the record. This is looked up or generated based on ExitState column in Cisco CVP.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_VXML_ELEMENT', 'COLUMN', N'IVR_SCRIPT_NODE_EXIT_STATE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_IVR_SCRIPT_NODE_EXIT_STATE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_VXML_ELEMENT', 'COLUMN', N'IVR_SCRIPT_NODE_EXIT_STATE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This corresponds to the IVR VXML Script associated with the record. In case of Cisco CVP this is looked up or generated based on AppName column in the VXMLSession table which is retrieved based on the SessionID.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_VXML_ELEMENT', 'COLUMN', N'APPLICATION_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This corresponds to the IVR VXML Script Node associated with the record. This maps to ElementName in Cisco CVP.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_VXML_ELEMENT', 'COLUMN', N'ELEMENT_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This corresponds to the Exit state of IVR VXML Script Node within the IVR VXML Script associated with the record. This maps to the ExitState column in Cisco CVP.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_VXML_ELEMENT', 'COLUMN', N'EXIT_STATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of user interaction whithin the IVR VXML Script Node. This maps to NumberOfInteractions column in Cisco CVP.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_VXML_ELEMENT', 'COLUMN', N'TOTAL_INTERACTIONS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the lenght of time in seconds between entry and exit of the IVR VXML Script Node. This is calculated based on the START_DATE_TIME and END_DATE_TIME.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_VXML_ELEMENT', 'COLUMN', N'DURATION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the date time when the record was written in the source database. This maps to DBDateTime column in Cisco CVP.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_VXML_ELEMENT', 'COLUMN', N'DB_DATETIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Identifier for the record in the source table. This maps to CallGUID column in Cisco CVP.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_VXML_ELEMENT', 'COLUMN', N'CALL_KEY1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Identifier for the record in the source table. This maps to CallStartDate column in Cisco CVP.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_VXML_ELEMENT', 'COLUMN', N'CALL_KEY2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to the SessionID column in Cisco CVP.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_VXML_ELEMENT', 'COLUMN', N'SESSION_KEY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to the ElementID column in Cisco CVP.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_VXML_ELEMENT', 'COLUMN', N'ELEMENT_KEY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from the table dbo.TB_CLU_RESOURCE indicating the source of the data.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_VXML_ELEMENT', 'COLUMN', N'CLUSTER_RESOURCE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_VXML_ELEMENT', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM0', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_VXML_ELEMENT', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_VXML_ELEMENT', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM1', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_VXML_ELEMENT', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_VXML_ELEMENT', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM2', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_VXML_ELEMENT', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_VXML_ELEMENT', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM3', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_VXML_ELEMENT', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_VXML_ELEMENT', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM4', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_VXML_ELEMENT', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_VXML_ELEMENT', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM5', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_VXML_ELEMENT', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_VXML_ELEMENT', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM6', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_VXML_ELEMENT', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_VXML_ELEMENT', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM7', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_VXML_ELEMENT', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_VXML_ELEMENT', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM8', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_VXML_ELEMENT', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_VXML_ELEMENT', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM9', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_VXML_ELEMENT', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_VXML_ELEMENT', 'COLUMN', N'CUSTOM_MEASURE_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_VXML_ELEMENT', 'COLUMN', N'CUSTOM_MEASURE_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_VXML_ELEMENT', 'COLUMN', N'CUSTOM_MEASURE_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_VXML_ELEMENT', 'COLUMN', N'CUSTOM_MEASURE_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_VXML_ELEMENT', 'COLUMN', N'CUSTOM_MEASURE_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_VXML_ELEMENT', 'COLUMN', N'CUSTOM_MEASURE_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_VXML_ELEMENT', 'COLUMN', N'CUSTOM_MEASURE_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_VXML_ELEMENT', 'COLUMN', N'CUSTOM_MEASURE_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_VXML_ELEMENT', 'COLUMN', N'CUSTOM_MEASURE_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_VXML_ELEMENT', 'COLUMN', N'CUSTOM_MEASURE_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_VXML_ELEMENT', 'COLUMN', N'TIDEMARK_VALUE1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_VXML_ELEMENT', 'COLUMN', N'TIDEMARK_VALUE2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_VXML_ELEMENT', 'COLUMN', N'TIDEMARK_VALUE3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_VXML_ELEMENT', 'COLUMN', N'TIDEMARK_VALUE4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_IVR_VXML_ELEMENT', 'COLUMN', N'TIDEMARK_VALUE5'
GO
GRANT SELECT
	ON [dbo].[TB_FCT_IVR_VXML_ELEMENT]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_FCT_IVR_VXML_ELEMENT]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_FCT_IVR_VXML_ELEMENT]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_FCT_IVR_VXML_ELEMENT] SET (LOCK_ESCALATION = TABLE)
GO
