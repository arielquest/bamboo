SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TE_DIM_GENERIC_MAP_TYPE] (
		[GENERIC_MAP_TYPE_ID]     [uniqueidentifier] NOT NULL ROWGUIDCOL,
		[NAME]                    [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[INTERNAL_NAME]           [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[DESCRIPTION]             [nvarchar](500) COLLATE Latin1_General_CI_AS NOT NULL,
		[MAP_TYPE_DESCRIPTOR]     [nvarchar](5) COLLATE Latin1_General_CI_AS NOT NULL,
		[ARCHIVED]                [bit] NOT NULL,
		[DELETED]                 [bit] NOT NULL,
		[ENABLED]                 [bit] NOT NULL,
		[HIDDEN]                  [bit] NOT NULL,
		[SYSTEM]                  [bit] NOT NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [UN_TE_DIM_GENERIC_MAP_TYPE_INTERNAL_NAME]
		UNIQUE
		NONCLUSTERED
		([INTERNAL_NAME])
		ON [DIMINDEXGROUP],
		CONSTRAINT [PK_TE_DIM_GENERIC_MAP_TYPE]
		PRIMARY KEY
		CLUSTERED
		([GENERIC_MAP_TYPE_ID])
	ON [DIMGROUP]
) ON [DIMGROUP]
GO
ALTER TABLE [dbo].[TE_DIM_GENERIC_MAP_TYPE]
	ADD
	CONSTRAINT [DF_TE_DIM_GENERIC_MAP_TYPE_GENERIC_MAP_TYPE_ID]
	DEFAULT (newid()) FOR [GENERIC_MAP_TYPE_ID]
GO
ALTER TABLE [dbo].[TE_DIM_GENERIC_MAP_TYPE]
	ADD
	CONSTRAINT [DF_TE_DIM_GENERIC_MAP_TYPE_DESCRIPTION]
	DEFAULT (N'') FOR [DESCRIPTION]
GO
ALTER TABLE [dbo].[TE_DIM_GENERIC_MAP_TYPE]
	ADD
	CONSTRAINT [DF_TE_DIM_GENERIC_MAP_TYPE_ARCHIVED]
	DEFAULT ((0)) FOR [ARCHIVED]
GO
ALTER TABLE [dbo].[TE_DIM_GENERIC_MAP_TYPE]
	ADD
	CONSTRAINT [DF_TE_DIM_GENERIC_MAP_TYPE_DELETED]
	DEFAULT ((0)) FOR [DELETED]
GO
ALTER TABLE [dbo].[TE_DIM_GENERIC_MAP_TYPE]
	ADD
	CONSTRAINT [DF_TE_DIM_GENERIC_MAP_TYPE_ENABLED]
	DEFAULT ((1)) FOR [ENABLED]
GO
ALTER TABLE [dbo].[TE_DIM_GENERIC_MAP_TYPE]
	ADD
	CONSTRAINT [DF_TE_DIM_GENERIC_MAP_TYPE_HIDDEN]
	DEFAULT ((0)) FOR [HIDDEN]
GO
ALTER TABLE [dbo].[TE_DIM_GENERIC_MAP_TYPE]
	ADD
	CONSTRAINT [DF_TE_DIM_GENERIC_MAP_TYPE_SYSTEM]
	DEFAULT ((0)) FOR [SYSTEM]
GO
ALTER TABLE [dbo].[TE_DIM_GENERIC_MAP_TYPE]
	ADD
	CONSTRAINT [DF_TE_DIM_GENERIC_MAP_TYPE_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table holds all the supported self care mapping types in the application. This enumeration table is used by the Self care tool in the application.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_GENERIC_MAP_TYPE', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_GENERIC_MAP_TYPE', 'COLUMN', N'GENERIC_MAP_TYPE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a display name for the mapping type.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_GENERIC_MAP_TYPE', 'COLUMN', N'NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the systems internal name for the mapping type. These are prefixed with GMT_.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_GENERIC_MAP_TYPE', 'COLUMN', N'INTERNAL_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a brief description for the mapping type.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_GENERIC_MAP_TYPE', 'COLUMN', N'DESCRIPTION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is any string descriptor for the mapping type.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_GENERIC_MAP_TYPE', 'COLUMN', N'MAP_TYPE_DESCRIPTOR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the mapping type is set for archived. Value 1 indicates archived.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_GENERIC_MAP_TYPE', 'COLUMN', N'ARCHIVED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the mapping type is deleted. Value 1 indicates deleted.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_GENERIC_MAP_TYPE', 'COLUMN', N'DELETED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the mapping type is enabled. Value 1 indicates enabled.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_GENERIC_MAP_TYPE', 'COLUMN', N'ENABLED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the mapping type is hidden. Value 1 indicates hidden.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_GENERIC_MAP_TYPE', 'COLUMN', N'HIDDEN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the mapping type is owned by the system. Value 1 indicates system owned mapping type.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_GENERIC_MAP_TYPE', 'COLUMN', N'SYSTEM'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_GENERIC_MAP_TYPE', 'COLUMN', N'msrepl_tran_version'
GO
GRANT SELECT
	ON [dbo].[TE_DIM_GENERIC_MAP_TYPE]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TE_DIM_GENERIC_MAP_TYPE]
	TO [portalrs_role]
GO
ALTER TABLE [dbo].[TE_DIM_GENERIC_MAP_TYPE] SET (LOCK_ESCALATION = TABLE)
GO
