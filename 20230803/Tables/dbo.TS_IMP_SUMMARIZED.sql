SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TS_IMP_SUMMARIZED] (
		[OLAP_OBJECT_URN]     [int] NOT NULL,
		[PRIMARY_TABLE]       [nvarchar](255) COLLATE Latin1_General_CI_AS NOT NULL,
		[ROW_URN]             [int] NOT NULL,
		[ACTION]              [char](1) COLLATE Latin1_General_CI_AS NOT NULL,
		[STATUS]              [tinyint] NOT NULL
) ON [STGGROUP]
GO
ALTER TABLE [dbo].[TS_IMP_SUMMARIZED]
	ADD
	CONSTRAINT [CK_IMP_SUMMARIZED_STATUS]
	CHECK
	([STATUS]=(3) OR [STATUS]=(2) OR [STATUS]=(1) OR [STATUS]=(0))
GO
ALTER TABLE [dbo].[TS_IMP_SUMMARIZED]
CHECK CONSTRAINT [CK_IMP_SUMMARIZED_STATUS]
GO
ALTER TABLE [dbo].[TS_IMP_SUMMARIZED]
	ADD
	CONSTRAINT [CK_IMP_SUMMARIZED_ACTION]
	CHECK
	([ACTION]='D' OR [ACTION]='U' OR [ACTION]='I')
GO
ALTER TABLE [dbo].[TS_IMP_SUMMARIZED]
CHECK CONSTRAINT [CK_IMP_SUMMARIZED_ACTION]
GO
ALTER TABLE [dbo].[TS_IMP_SUMMARIZED]
	ADD
	CONSTRAINT [DF_IMP_SUMMARIZED_ACTION]
	DEFAULT ('I') FOR [ACTION]
GO
ALTER TABLE [dbo].[TS_IMP_SUMMARIZED]
	ADD
	CONSTRAINT [DF_IMP_SUMMARIZED_STATUS]
	DEFAULT ((0)) FOR [STATUS]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a staging table that holds the details of the dimension records that need to be processed by the Olap Processor. Once processed the table is automatically truncated.', 'SCHEMA', N'dbo', 'TABLE', N'TS_IMP_SUMMARIZED', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field indicates the Dimension OLAP Object that requires processing. This is the foreign key from TB_ADM_OLAP_OBJECT.', 'SCHEMA', N'dbo', 'TABLE', N'TS_IMP_SUMMARIZED', 'COLUMN', N'OLAP_OBJECT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field indicates the name of the table or view in the RDBMS database, which is the primary or the base table for the OLAP object.', 'SCHEMA', N'dbo', 'TABLE', N'TS_IMP_SUMMARIZED', 'COLUMN', N'PRIMARY_TABLE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field indicates the identifier of the dimension (ITEM_URN from VW_DIM_ITEM that corresponds to a particular item type) that requires processing.', 'SCHEMA', N'dbo', 'TABLE', N'TS_IMP_SUMMARIZED', 'COLUMN', N'ROW_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field indicates whether the record was inserted (indicated by I), updated (indicated by U) or deleted (indicated by D).', 'SCHEMA', N'dbo', 'TABLE', N'TS_IMP_SUMMARIZED', 'COLUMN', N'ACTION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds a flag that indicates the status of the process. When a row is inserted it defaults to 0. 1 indicates that the row is being processed and 2 indicates that it has processed. When the STATUS value becomes 2, the row gets truncated from the table.', 'SCHEMA', N'dbo', 'TABLE', N'TS_IMP_SUMMARIZED', 'COLUMN', N'STATUS'
GO
GRANT DELETE
	ON [dbo].[TS_IMP_SUMMARIZED]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TS_IMP_SUMMARIZED]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TS_IMP_SUMMARIZED]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TS_IMP_SUMMARIZED]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TS_IMP_SUMMARIZED]
	TO [portalrs_role]
GO
ALTER TABLE [dbo].[TS_IMP_SUMMARIZED] SET (LOCK_ESCALATION = TABLE)
GO
