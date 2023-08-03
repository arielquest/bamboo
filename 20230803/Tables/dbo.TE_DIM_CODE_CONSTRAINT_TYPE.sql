SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TE_DIM_CODE_CONSTRAINT_TYPE] (
		[CODE_CONSTRAINT_TYPE_ID]     [uniqueidentifier] NOT NULL ROWGUIDCOL,
		[NAME]                        [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[INTERNAL_NAME]               [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[DESCRIPTION]                 [nvarchar](100) COLLATE Latin1_General_CI_AS NULL,
		[BASE_DATA_TYPE]              [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[HIDDEN]                      [bit] NOT NULL,
		[ENABLED]                     [bit] NOT NULL,
		[SYSTEM]                      [bit] NOT NULL,
		[msrepl_tran_version]         [uniqueidentifier] NOT NULL,
		CONSTRAINT [UN_TE_DIM_CODE_CONSTRAINT_TYPE_INTERNAL_NAME]
		UNIQUE
		NONCLUSTERED
		([INTERNAL_NAME])
		ON [DIMINDEXGROUP],
		CONSTRAINT [PK_TE_DIM_CODE_CONSTRAINT_TYPE]
		PRIMARY KEY
		CLUSTERED
		([CODE_CONSTRAINT_TYPE_ID])
	ON [DIMGROUP]
) ON [DIMGROUP]
GO
ALTER TABLE [dbo].[TE_DIM_CODE_CONSTRAINT_TYPE]
	ADD
	CONSTRAINT [DF_TE_DIM_CODE_CONSTRAINT_TYPE_CODE_CONSTRAINT_TYPE_ID]
	DEFAULT (newid()) FOR [CODE_CONSTRAINT_TYPE_ID]
GO
ALTER TABLE [dbo].[TE_DIM_CODE_CONSTRAINT_TYPE]
	ADD
	CONSTRAINT [DF_TE_DIM_CODE_CONSTRAINT_TYPE_HIDDEN]
	DEFAULT ((0)) FOR [HIDDEN]
GO
ALTER TABLE [dbo].[TE_DIM_CODE_CONSTRAINT_TYPE]
	ADD
	CONSTRAINT [DF_TE_DIM_CODE_CONSTRAINT_TYPE_ENABLED]
	DEFAULT ((1)) FOR [ENABLED]
GO
ALTER TABLE [dbo].[TE_DIM_CODE_CONSTRAINT_TYPE]
	ADD
	CONSTRAINT [DF_TE_DIM_CODE_CONSTRAINT_TYPE_SYSTEM]
	DEFAULT ((1)) FOR [SYSTEM]
GO
ALTER TABLE [dbo].[TE_DIM_CODE_CONSTRAINT_TYPE]
	ADD
	CONSTRAINT [DF_TE_DIM_CODE_CONSTRAINT_TYPE_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table holds all the constraint types for the codes in TB_DIM_CODE', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_CODE_CONSTRAINT_TYPE', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_CODE_CONSTRAINT_TYPE', 'COLUMN', N'CODE_CONSTRAINT_TYPE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the display name for the constraint type.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_CODE_CONSTRAINT_TYPE', 'COLUMN', N'NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the systems internal name for the constraint type.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_CODE_CONSTRAINT_TYPE', 'COLUMN', N'INTERNAL_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This a brief description for the constraint type.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_CODE_CONSTRAINT_TYPE', 'COLUMN', N'DESCRIPTION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a string representing the base datatype for the constraint type.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_CODE_CONSTRAINT_TYPE', 'COLUMN', N'BASE_DATA_TYPE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the constraint is hidden or not.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_CODE_CONSTRAINT_TYPE', 'COLUMN', N'HIDDEN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the constraint is enabled or not.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_CODE_CONSTRAINT_TYPE', 'COLUMN', N'ENABLED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the constraint is system owned.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_CODE_CONSTRAINT_TYPE', 'COLUMN', N'SYSTEM'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_CODE_CONSTRAINT_TYPE', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TE_DIM_CODE_CONSTRAINT_TYPE]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TE_DIM_CODE_CONSTRAINT_TYPE]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TE_DIM_CODE_CONSTRAINT_TYPE]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TE_DIM_CODE_CONSTRAINT_TYPE]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TE_DIM_CODE_CONSTRAINT_TYPE]
	TO [portalrs_role]
GO
ALTER TABLE [dbo].[TE_DIM_CODE_CONSTRAINT_TYPE] SET (LOCK_ESCALATION = TABLE)
GO
