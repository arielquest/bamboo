SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_FCT_CALL_DETAIL_LEG_OUTCOME] (
		[CALL_DETAIL_LEG_OUTCOME_URN]     [int] IDENTITY(0, 1) NOT FOR REPLICATION NOT NULL,
		[CALL_DETAIL_LEG_URN]             [int] NOT NULL,
		[SEQUENCE_NUMBER]                 [int] NULL,
		[LABEL_TEXT]                      [varchar](30) COLLATE Latin1_General_CI_AS NOT NULL,
		[CALL_OUTCOME]                    [tinyint] NOT NULL,
		[PARTITION_ID]                    [int] NOT NULL,
		[DATE_TIME]                       [datetime] NOT NULL,
		[CLUSTER_RESOURCE_URN]            [int] NOT NULL,
		[CUSTOM_DIMENSION_0]              [int] NOT NULL,
		[CUSTOM_DIMENSION_1]              [int] NOT NULL,
		[CUSTOM_DIMENSION_2]              [int] NOT NULL,
		[CUSTOM_DIMENSION_3]              [int] NOT NULL,
		[CUSTOM_DIMENSION_4]              [int] NOT NULL,
		[CUSTOM_DIMENSION_5]              [int] NOT NULL,
		[CUSTOM_DIMENSION_6]              [int] NOT NULL,
		[CUSTOM_DIMENSION_7]              [int] NOT NULL,
		[CUSTOM_DIMENSION_8]              [int] NOT NULL,
		[CUSTOM_DIMENSION_9]              [int] NOT NULL,
		[CUSTOM_MEASURE_0]                [int] NULL,
		[CUSTOM_MEASURE_1]                [int] NULL,
		[CUSTOM_MEASURE_2]                [int] NULL,
		[CUSTOM_MEASURE_3]                [int] NULL,
		[CUSTOM_MEASURE_4]                [int] NULL,
		[CUSTOM_MEASURE_5]                [int] NULL,
		[CUSTOM_MEASURE_6]                [int] NULL,
		[CUSTOM_MEASURE_7]                [int] NULL,
		[CUSTOM_MEASURE_8]                [int] NULL,
		[CUSTOM_MEASURE_9]                [int] NULL
) ON [FCTICMGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_FCT_CALL_DETAIL_LEG_OUTCOME_DATE_TIME]
	ON [dbo].[TB_FCT_CALL_DETAIL_LEG_OUTCOME] ([DATE_TIME])
	ON [FCTICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG_OUTCOME', 'INDEX', N'IX_FCT_CALL_DETAIL_LEG_OUTCOME_DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table is for future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG_OUTCOME', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use, primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG_OUTCOME', 'COLUMN', N'CALL_DETAIL_LEG_OUTCOME_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use, URN corresponding to the RouterCallKey and RouterCallKeyDay pair in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG_OUTCOME', 'COLUMN', N'CALL_DETAIL_LEG_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the numberic representation of the sequence of the call.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG_OUTCOME', 'COLUMN', N'SEQUENCE_NUMBER'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the text from the label.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG_OUTCOME', 'COLUMN', N'LABEL_TEXT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number representing the outcome of the call.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG_OUTCOME', 'COLUMN', N'CALL_OUTCOME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number for the current partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG_OUTCOME', 'COLUMN', N'PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is represents the datetime of the item.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG_OUTCOME', 'COLUMN', N'DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column gives information regarding the source of the data. This corresponds to the RESOURCE_URN from TB_CLU_RESOURCE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG_OUTCOME', 'COLUMN', N'CLUSTER_RESOURCE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG_OUTCOME', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM0', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG_OUTCOME', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG_OUTCOME', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM1', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG_OUTCOME', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG_OUTCOME', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM2', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG_OUTCOME', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG_OUTCOME', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM3', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG_OUTCOME', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG_OUTCOME', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM4', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG_OUTCOME', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG_OUTCOME', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM5', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG_OUTCOME', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG_OUTCOME', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM6', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG_OUTCOME', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG_OUTCOME', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM7', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG_OUTCOME', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG_OUTCOME', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM8', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG_OUTCOME', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG_OUTCOME', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM9', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG_OUTCOME', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG_OUTCOME', 'COLUMN', N'CUSTOM_MEASURE_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG_OUTCOME', 'COLUMN', N'CUSTOM_MEASURE_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG_OUTCOME', 'COLUMN', N'CUSTOM_MEASURE_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG_OUTCOME', 'COLUMN', N'CUSTOM_MEASURE_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG_OUTCOME', 'COLUMN', N'CUSTOM_MEASURE_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG_OUTCOME', 'COLUMN', N'CUSTOM_MEASURE_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG_OUTCOME', 'COLUMN', N'CUSTOM_MEASURE_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG_OUTCOME', 'COLUMN', N'CUSTOM_MEASURE_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG_OUTCOME', 'COLUMN', N'CUSTOM_MEASURE_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CALL_DETAIL_LEG_OUTCOME', 'COLUMN', N'CUSTOM_MEASURE_9'
GO
GRANT SELECT
	ON [dbo].[TB_FCT_CALL_DETAIL_LEG_OUTCOME]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_FCT_CALL_DETAIL_LEG_OUTCOME]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_FCT_CALL_DETAIL_LEG_OUTCOME]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_FCT_CALL_DETAIL_LEG_OUTCOME] SET (LOCK_ESCALATION = TABLE)
GO
