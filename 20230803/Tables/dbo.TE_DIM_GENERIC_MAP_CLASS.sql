SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TE_DIM_GENERIC_MAP_CLASS] (
		[GENERIC_MAP_CLASS_ID]     [uniqueidentifier] NOT NULL ROWGUIDCOL,
		[NAME]                     [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[INTERNAL_NAME]            [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[DESCRIPTION]              [nvarchar](500) COLLATE Latin1_General_CI_AS NOT NULL,
		[ARCHIVED]                 [bit] NOT NULL,
		[DELETED]                  [bit] NOT NULL,
		[ENABLED]                  [bit] NOT NULL,
		[HIDDEN]                   [bit] NOT NULL,
		[SYSTEM]                   [bit] NOT NULL,
		[msrepl_tran_version]      [uniqueidentifier] NOT NULL,
		CONSTRAINT [UN_TE_DIM_GENERIC_MAP_CLASS_INTERNAL_NAME]
		UNIQUE
		NONCLUSTERED
		([INTERNAL_NAME])
		ON [DIMINDEXGROUP],
		CONSTRAINT [PK_TE_DIM_GENERIC_MAP_CLASS]
		PRIMARY KEY
		CLUSTERED
		([GENERIC_MAP_CLASS_ID])
	ON [DIMGROUP]
) ON [DIMGROUP]
GO
ALTER TABLE [dbo].[TE_DIM_GENERIC_MAP_CLASS]
	ADD
	CONSTRAINT [DF_TE_DIM_GENERIC_MAP_CLASS_GENERIC_MAP_TYPE_ID]
	DEFAULT (newid()) FOR [GENERIC_MAP_CLASS_ID]
GO
ALTER TABLE [dbo].[TE_DIM_GENERIC_MAP_CLASS]
	ADD
	CONSTRAINT [DF_TE_DIM_GENERIC_MAP_CLASS_DESCRIPTION]
	DEFAULT (N'') FOR [DESCRIPTION]
GO
ALTER TABLE [dbo].[TE_DIM_GENERIC_MAP_CLASS]
	ADD
	CONSTRAINT [DF_TE_DIM_GENERIC_MAP_CLASS_ARCHIVED]
	DEFAULT ((0)) FOR [ARCHIVED]
GO
ALTER TABLE [dbo].[TE_DIM_GENERIC_MAP_CLASS]
	ADD
	CONSTRAINT [DF_TE_DIM_GENERIC_MAP_CLASS_DELETED]
	DEFAULT ((0)) FOR [DELETED]
GO
ALTER TABLE [dbo].[TE_DIM_GENERIC_MAP_CLASS]
	ADD
	CONSTRAINT [DF_TE_DIM_GENERIC_MAP_CLASS_ENABLED]
	DEFAULT ((1)) FOR [ENABLED]
GO
ALTER TABLE [dbo].[TE_DIM_GENERIC_MAP_CLASS]
	ADD
	CONSTRAINT [DF_TE_DIM_GENERIC_MAP_CLASS_HIDDEN]
	DEFAULT ((0)) FOR [HIDDEN]
GO
ALTER TABLE [dbo].[TE_DIM_GENERIC_MAP_CLASS]
	ADD
	CONSTRAINT [DF_TE_DIM_GENERIC_MAP_CLASS_SYSTEM]
	DEFAULT ((0)) FOR [SYSTEM]
GO
ALTER TABLE [dbo].[TE_DIM_GENERIC_MAP_CLASS]
	ADD
	CONSTRAINT [DF_TE_DIM_GENERIC_MAP_CLASS_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table holds all the supported self care mapping classes in the application. This enumeration table is used by the Self care tool or any other mapping tool available in the application.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_GENERIC_MAP_CLASS', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_GENERIC_MAP_CLASS', 'COLUMN', N'GENERIC_MAP_CLASS_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the display name for the generic mapping class.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_GENERIC_MAP_CLASS', 'COLUMN', N'NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the systems internal name for the generic mapping class. This is unique and is prefixed with GMC_.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_GENERIC_MAP_CLASS', 'COLUMN', N'INTERNAL_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a brief description for the generic mapping class.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_GENERIC_MAP_CLASS', 'COLUMN', N'DESCRIPTION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the generic mapping class is set for archived. Value 1 indicates archived.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_GENERIC_MAP_CLASS', 'COLUMN', N'ARCHIVED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the generic mapping class is deleted. Value 1 indicates deleted.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_GENERIC_MAP_CLASS', 'COLUMN', N'DELETED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the generic mapping class is enabled. Value 1 indicates enabled.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_GENERIC_MAP_CLASS', 'COLUMN', N'ENABLED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the generic mapping class is hidden. Value 1 indicates hidden.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_GENERIC_MAP_CLASS', 'COLUMN', N'HIDDEN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the generic mapping class is owned by the system. Value 1 indicates system owned mapping class.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_GENERIC_MAP_CLASS', 'COLUMN', N'SYSTEM'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_GENERIC_MAP_CLASS', 'COLUMN', N'msrepl_tran_version'
GO
GRANT SELECT
	ON [dbo].[TE_DIM_GENERIC_MAP_CLASS]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TE_DIM_GENERIC_MAP_CLASS]
	TO [portalrs_role]
GO
ALTER TABLE [dbo].[TE_DIM_GENERIC_MAP_CLASS] SET (LOCK_ESCALATION = TABLE)
GO
