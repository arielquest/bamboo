SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_DIM_FISCAL_WEEK] (
		[FISCAL_WEEK_URN]         [int] IDENTITY(1, 4) NOT FOR REPLICATION NOT NULL,
		[FISCAL_YEAR_URN]         [int] NOT NULL,
		[NAME]                    [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[START_DATE_TIME]         [datetime] NOT NULL,
		[END_DATE_TIME]           [datetime] NOT NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TB_DIM_FISCAL_WEEK]
		PRIMARY KEY
		CLUSTERED
		([FISCAL_WEEK_URN])
	ON [DIMGROUP]
) ON [DIMGROUP]
GO
ALTER TABLE [dbo].[TB_DIM_FISCAL_WEEK]
	ADD
	CONSTRAINT [DF_TB_DIM_FISCAL_WEEK_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_DIM_FISCAL_WEEK]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_DIM_FISCAL_WEEK_TB_DIM_FISCAL_YEAR]
	FOREIGN KEY ([FISCAL_YEAR_URN]) REFERENCES [dbo].[TB_DIM_FISCAL_YEAR] ([FISCAL_YEAR_URN])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_DIM_FISCAL_WEEK]
	CHECK CONSTRAINT [FK_TB_DIM_FISCAL_WEEK_TB_DIM_FISCAL_YEAR]

GO
CREATE NONCLUSTERED INDEX [IX_TB_DIM_FISCAL_WEEK_START_DATE_TIME]
	ON [dbo].[TB_DIM_FISCAL_WEEK] ([START_DATE_TIME])
	ON [DIMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_DIM_FISCAL_WEEK_END_DATE_TIME]
	ON [dbo].[TB_DIM_FISCAL_WEEK] ([END_DATE_TIME])
	ON [DIMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_DIM_FISCAL_WEEK_FISCAL_YEAR_URN]
	ON [dbo].[TB_DIM_FISCAL_WEEK] ([FISCAL_YEAR_URN])
	ON [DIMINDEXGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table is a repository of all the fiscal weeks for all the fiscal years that are configured in the application. The data in this table is customized depending on requirements.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_FISCAL_WEEK', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record. This is a system generated number.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_FISCAL_WEEK', 'COLUMN', N'FISCAL_WEEK_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_FISCAL_YEAR corresponding to the fiscal year to which the fiscal week belongs.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_FISCAL_WEEK', 'COLUMN', N'FISCAL_YEAR_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a name for the fiscal week.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_FISCAL_WEEK', 'COLUMN', N'NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the start date for the fiscal week. Note that the time part is not used. It will always be 00:00:00', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_FISCAL_WEEK', 'COLUMN', N'START_DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the end date for the fiscal week. Note that the time part is not used. It will always be 00:00:00', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_FISCAL_WEEK', 'COLUMN', N'END_DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_FISCAL_WEEK', 'COLUMN', N'msrepl_tran_version'
GO
DENY DELETE
	ON [dbo].[TB_DIM_FISCAL_WEEK]
	TO [portalapp_role]
GO
DENY INSERT
	ON [dbo].[TB_DIM_FISCAL_WEEK]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_DIM_FISCAL_WEEK]
	TO [portalapp_role]
GO
DENY UPDATE
	ON [dbo].[TB_DIM_FISCAL_WEEK]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_DIM_FISCAL_WEEK] SET (LOCK_ESCALATION = TABLE)
GO
