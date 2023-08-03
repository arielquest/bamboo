SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_DIM_GENERIC_MAP] (
		[GENERIC_MAP_ID]           [uniqueidentifier] NOT NULL ROWGUIDCOL,
		[FOLDER_ID]                [uniqueidentifier] NOT NULL,
		[GENERIC_MAP_TYPE_ID]      [uniqueidentifier] NOT NULL,
		[GENERIC_MAP_CLASS_ID]     [uniqueidentifier] NOT NULL,
		[NAME]                     [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[INTERNAL_NAME]            [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[DESCRIPTION]              [nvarchar](500) COLLATE Latin1_General_CI_AS NOT NULL,
		[EFFECTIVE_FROM]           [datetime] NOT NULL,
		[EFFECTIVE_TO]             [datetime] NOT NULL,
		[ARCHIVED]                 [bit] NOT NULL,
		[DELETED]                  [bit] NOT NULL,
		[ENABLED]                  [bit] NOT NULL,
		[HIDDEN]                   [bit] NOT NULL,
		[SYSTEM]                   [bit] NOT NULL,
		[msrepl_tran_version]      [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TB_DIM_GENERIC_MAP]
		PRIMARY KEY
		CLUSTERED
		([GENERIC_MAP_ID])
	ON [DIMGROUP]
) ON [DIMGROUP]
GO
ALTER TABLE [dbo].[TB_DIM_GENERIC_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_GENERIC_MAP_GENERIC_MAP_ID]
	DEFAULT (newid()) FOR [GENERIC_MAP_ID]
GO
ALTER TABLE [dbo].[TB_DIM_GENERIC_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_GENERIC_MAP_DESCRIPTION]
	DEFAULT (N'') FOR [DESCRIPTION]
GO
ALTER TABLE [dbo].[TB_DIM_GENERIC_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_GENERIC_MAP_EFFECTIVE_FROM]
	DEFAULT (getutcdate()) FOR [EFFECTIVE_FROM]
GO
ALTER TABLE [dbo].[TB_DIM_GENERIC_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_GENERIC_MAP_EFFECTIVE_TO]
	DEFAULT ('2079-06-06 00:00:00') FOR [EFFECTIVE_TO]
GO
ALTER TABLE [dbo].[TB_DIM_GENERIC_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_GENERIC_MAP_ARCHIVED]
	DEFAULT ((0)) FOR [ARCHIVED]
GO
ALTER TABLE [dbo].[TB_DIM_GENERIC_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_GENERIC_MAP_DELETED]
	DEFAULT ((0)) FOR [DELETED]
GO
ALTER TABLE [dbo].[TB_DIM_GENERIC_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_GENERIC_MAP_ENABLED]
	DEFAULT ((1)) FOR [ENABLED]
GO
ALTER TABLE [dbo].[TB_DIM_GENERIC_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_GENERIC_MAP_HIDDEN]
	DEFAULT ((0)) FOR [HIDDEN]
GO
ALTER TABLE [dbo].[TB_DIM_GENERIC_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_GENERIC_MAP_SYSTEM]
	DEFAULT ((0)) FOR [SYSTEM]
GO
ALTER TABLE [dbo].[TB_DIM_GENERIC_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_GENERIC_MAP_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_DIM_GENERIC_MAP]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_DIM_GENERIC_MAP_TB_SEC_FOLDER]
	FOREIGN KEY ([FOLDER_ID]) REFERENCES [dbo].[TB_SEC_FOLDER] ([FOLDER_ID])
	ON DELETE CASCADE
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_DIM_GENERIC_MAP]
	CHECK CONSTRAINT [FK_TB_DIM_GENERIC_MAP_TB_SEC_FOLDER]

GO
ALTER TABLE [dbo].[TB_DIM_GENERIC_MAP]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_DIM_GENERIC_MAP_TE_DIM_GENERIC_MAP_TYPE]
	FOREIGN KEY ([GENERIC_MAP_TYPE_ID]) REFERENCES [dbo].[TE_DIM_GENERIC_MAP_TYPE] ([GENERIC_MAP_TYPE_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_DIM_GENERIC_MAP]
	CHECK CONSTRAINT [FK_TB_DIM_GENERIC_MAP_TE_DIM_GENERIC_MAP_TYPE]

GO
ALTER TABLE [dbo].[TB_DIM_GENERIC_MAP]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_DIM_GENERIC_MAP_TE_DIM_GENERIC_MAP_CLASS]
	FOREIGN KEY ([GENERIC_MAP_CLASS_ID]) REFERENCES [dbo].[TE_DIM_GENERIC_MAP_CLASS] ([GENERIC_MAP_CLASS_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_DIM_GENERIC_MAP]
	CHECK CONSTRAINT [FK_TB_DIM_GENERIC_MAP_TE_DIM_GENERIC_MAP_CLASS]

GO
CREATE NONCLUSTERED INDEX [IX_TB_DIM_GENERIC_MAP_FOLDER_ID]
	ON [dbo].[TB_DIM_GENERIC_MAP] ([FOLDER_ID])
	ON [DIMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_DIM_GENERIC_MAP_GENERIC_MAP_CLASS_ID]
	ON [dbo].[TB_DIM_GENERIC_MAP] ([GENERIC_MAP_CLASS_ID])
	ON [DIMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_DIM_GENERIC_MAP_GENERIC_MAP_TYPE_ID]
	ON [dbo].[TB_DIM_GENERIC_MAP] ([GENERIC_MAP_TYPE_ID])
	ON [DIMINDEXGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table holds information about the various self care groupings created in the application. This table is used by the Self care tool of the application.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_GENERIC_MAP', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_GENERIC_MAP', 'COLUMN', N'GENERIC_MAP_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TB_SEC_FOLDER corresponding to the security folder on which the map is defined.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_GENERIC_MAP', 'COLUMN', N'FOLDER_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TE_DIM_GENERIC_MAP_TYPE indicating the generic mapping type for the mapping group.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_GENERIC_MAP', 'COLUMN', N'GENERIC_MAP_TYPE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TE_DIM_GENERIC_MAP_CLASS indicating the generic mapping class for the mapping group.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_GENERIC_MAP', 'COLUMN', N'GENERIC_MAP_CLASS_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a display name for the mapping group.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_GENERIC_MAP', 'COLUMN', N'NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the systems internal name for the mapping group.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_GENERIC_MAP', 'COLUMN', N'INTERNAL_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a brief description for the mapping group.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_GENERIC_MAP', 'COLUMN', N'DESCRIPTION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the UTC date time idicating when the mapping group will become active.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_GENERIC_MAP', 'COLUMN', N'EFFECTIVE_FROM'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the UTC date time indicating when the mapping group will cease to exist.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_GENERIC_MAP', 'COLUMN', N'EFFECTIVE_TO'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the mapping group is set for archive. Value 1 indicates archived.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_GENERIC_MAP', 'COLUMN', N'ARCHIVED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the mapping group is deleted. Value 1 indicates deleted.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_GENERIC_MAP', 'COLUMN', N'DELETED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the mapping group is enabled. Value 1 indicates enabled.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_GENERIC_MAP', 'COLUMN', N'ENABLED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the mapping group is hidden. Value 1 indicates hidden.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_GENERIC_MAP', 'COLUMN', N'HIDDEN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the mapping group is owned by the sytem. Value 1 indicates system owned mapping group.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_GENERIC_MAP', 'COLUMN', N'SYSTEM'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_GENERIC_MAP', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_DIM_GENERIC_MAP]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_DIM_GENERIC_MAP]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_DIM_GENERIC_MAP]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_DIM_GENERIC_MAP]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_DIM_GENERIC_MAP] SET (LOCK_ESCALATION = TABLE)
GO
