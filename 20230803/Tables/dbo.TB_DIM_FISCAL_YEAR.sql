SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_DIM_FISCAL_YEAR] (
		[FISCAL_YEAR_URN]         [int] IDENTITY(1, 4) NOT FOR REPLICATION NOT NULL,
		[NAME]                    [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[START_DATE_TIME]         [datetime] NOT NULL,
		[END_DATE_TIME]           [datetime] NOT NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TB_DIM_FISCAL_YEAR]
		PRIMARY KEY
		CLUSTERED
		([FISCAL_YEAR_URN])
	ON [DIMGROUP]
) ON [DIMGROUP]
GO
ALTER TABLE [dbo].[TB_DIM_FISCAL_YEAR]
	ADD
	CONSTRAINT [DF_TB_DIM_FISCAL_YEAR_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
CREATE NONCLUSTERED INDEX [IX_TB_DIM_FISCAL_YEAR_START_DATE_TIME]
	ON [dbo].[TB_DIM_FISCAL_YEAR] ([START_DATE_TIME])
	ON [DIMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_DIM_FISCAL_YEAR_END_DATE_TIME]
	ON [dbo].[TB_DIM_FISCAL_YEAR] ([END_DATE_TIME])
	ON [DIMINDEXGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table is a repository of all the fiscal years that are configured in the application. The data in this table is customized depending on requirements.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_FISCAL_YEAR', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record. This is a system generated number.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_FISCAL_YEAR', 'COLUMN', N'FISCAL_YEAR_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the name given to the fiscal year.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_FISCAL_YEAR', 'COLUMN', N'NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the start date for the fiscal year. Note that the time part is not used. It will always be 00:00:00', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_FISCAL_YEAR', 'COLUMN', N'START_DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the end date for the fiscal year. Note that the time part is not used. It will always be 00:00:00', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_FISCAL_YEAR', 'COLUMN', N'END_DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_FISCAL_YEAR', 'COLUMN', N'msrepl_tran_version'
GO
DENY DELETE
	ON [dbo].[TB_DIM_FISCAL_YEAR]
	TO [portalapp_role]
GO
DENY INSERT
	ON [dbo].[TB_DIM_FISCAL_YEAR]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_DIM_FISCAL_YEAR]
	TO [portalapp_role]
GO
DENY UPDATE
	ON [dbo].[TB_DIM_FISCAL_YEAR]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_DIM_FISCAL_YEAR] SET (LOCK_ESCALATION = TABLE)
GO
