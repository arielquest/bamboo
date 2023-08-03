SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_DIM_FISCAL_MONTH] (
		[FISCAL_MONTH_URN]        [int] IDENTITY(1, 4) NOT FOR REPLICATION NOT NULL,
		[FISCAL_QUARTER_URN]      [int] NOT NULL,
		[NAME]                    [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[START_DATE_TIME]         [datetime] NOT NULL,
		[END_DATE_TIME]           [datetime] NOT NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TB_DIM_FISCAL_MONTH]
		PRIMARY KEY
		CLUSTERED
		([FISCAL_MONTH_URN])
	ON [DIMGROUP]
) ON [DIMGROUP]
GO
ALTER TABLE [dbo].[TB_DIM_FISCAL_MONTH]
	ADD
	CONSTRAINT [DF_TB_DIM_FISCAL_MONTH_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_DIM_FISCAL_MONTH]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_DIM_FISCAL_MONTH_TB_DIM_FISCAL_QUARTER]
	FOREIGN KEY ([FISCAL_QUARTER_URN]) REFERENCES [dbo].[TB_DIM_FISCAL_QUARTER] ([FISCAL_QUARTER_URN])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_DIM_FISCAL_MONTH]
	CHECK CONSTRAINT [FK_TB_DIM_FISCAL_MONTH_TB_DIM_FISCAL_QUARTER]

GO
CREATE NONCLUSTERED INDEX [IX_TB_DIM_FISCAL_MONTH_START_DATE_TIME]
	ON [dbo].[TB_DIM_FISCAL_MONTH] ([START_DATE_TIME])
	ON [DIMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_DIM_FISCAL_MONTH_END_DATE_TIME]
	ON [dbo].[TB_DIM_FISCAL_MONTH] ([END_DATE_TIME])
	ON [DIMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_DIM_FISCAL_MONTH_FISCAL_QUARTER_URN]
	ON [dbo].[TB_DIM_FISCAL_MONTH] ([FISCAL_QUARTER_URN])
	ON [DIMINDEXGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table is a repository of all the fiscal months for all the fiscal years that are configured in the application. The data in this table is customized depending on requirements.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_FISCAL_MONTH', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record. This is a system generated number.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_FISCAL_MONTH', 'COLUMN', N'FISCAL_MONTH_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_FISCAL_QUARTER corresponding to the fiscal quarter of the year to which the fiscal month belongs.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_FISCAL_MONTH', 'COLUMN', N'FISCAL_QUARTER_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the name for the fiscal month.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_FISCAL_MONTH', 'COLUMN', N'NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the start date for the fiscal month. Note that the time part is not used. It will always be 00:00:00', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_FISCAL_MONTH', 'COLUMN', N'START_DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the end date for the fiscal month. Note that the time part is not used. It will always be 00:00:00', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_FISCAL_MONTH', 'COLUMN', N'END_DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_FISCAL_MONTH', 'COLUMN', N'msrepl_tran_version'
GO
DENY DELETE
	ON [dbo].[TB_DIM_FISCAL_MONTH]
	TO [portalapp_role]
GO
DENY INSERT
	ON [dbo].[TB_DIM_FISCAL_MONTH]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_DIM_FISCAL_MONTH]
	TO [portalapp_role]
GO
DENY UPDATE
	ON [dbo].[TB_DIM_FISCAL_MONTH]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_DIM_FISCAL_MONTH] SET (LOCK_ESCALATION = TABLE)
GO
