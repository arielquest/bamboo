SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_DIM_GENERIC_MAPPING] (
		[GENERIC_MAPPING_ID]      [uniqueidentifier] NOT NULL ROWGUIDCOL,
		[GENERIC_MAP_ID]          [uniqueidentifier] NOT NULL,
		[FROM_ITEM_URN]           [int] NOT NULL,
		[TO_ITEM_URN]             [int] NOT NULL,
		[SEQUENCE]                [int] NOT NULL,
		[INT_VAL]                 [int] NULL,
		[FLOAT_VAL]               [float] NULL,
		[STRING_VAL]              [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
		[ARCHIVED]                [bit] NOT NULL,
		[DELETED]                 [bit] NOT NULL,
		[ENABLED]                 [bit] NOT NULL,
		[HIDDEN]                  [bit] NOT NULL,
		[SYSTEM]                  [bit] NOT NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [UN_TB_DIM_GENERIC_MAPPING]
		UNIQUE
		NONCLUSTERED
		([GENERIC_MAP_ID], [FROM_ITEM_URN], [TO_ITEM_URN])
		ON [DIMINDEXGROUP],
		CONSTRAINT [PK_TB_DIM_GENERIC_MAPPING]
		PRIMARY KEY
		CLUSTERED
		([GENERIC_MAPPING_ID])
	ON [DIMGROUP]
) ON [DIMGROUP]
GO
ALTER TABLE [dbo].[TB_DIM_GENERIC_MAPPING]
	ADD
	CONSTRAINT [DF_TB_DIM_GENERIC_MAPPING_GENERIC_MAPPING_ID]
	DEFAULT (newid()) FOR [GENERIC_MAPPING_ID]
GO
ALTER TABLE [dbo].[TB_DIM_GENERIC_MAPPING]
	ADD
	CONSTRAINT [DF_TB_DIM_GENERIC_MAPPING_SEQUENCE]
	DEFAULT ((0)) FOR [SEQUENCE]
GO
ALTER TABLE [dbo].[TB_DIM_GENERIC_MAPPING]
	ADD
	CONSTRAINT [DF_TB_DIM_GENERIC_MAPPING_ARCHIVED]
	DEFAULT ((0)) FOR [ARCHIVED]
GO
ALTER TABLE [dbo].[TB_DIM_GENERIC_MAPPING]
	ADD
	CONSTRAINT [DF_TB_DIM_GENERIC_MAPPING_DELETED]
	DEFAULT ((0)) FOR [DELETED]
GO
ALTER TABLE [dbo].[TB_DIM_GENERIC_MAPPING]
	ADD
	CONSTRAINT [DF_TB_DIM_GENERIC_MAPPING_ENABLED]
	DEFAULT ((1)) FOR [ENABLED]
GO
ALTER TABLE [dbo].[TB_DIM_GENERIC_MAPPING]
	ADD
	CONSTRAINT [DF_TB_DIM_GENERIC_MAPPING_HIDDEN]
	DEFAULT ((0)) FOR [HIDDEN]
GO
ALTER TABLE [dbo].[TB_DIM_GENERIC_MAPPING]
	ADD
	CONSTRAINT [DF_TB_DIM_GENERIC_MAPPING_SYSTEM]
	DEFAULT ((0)) FOR [SYSTEM]
GO
ALTER TABLE [dbo].[TB_DIM_GENERIC_MAPPING]
	ADD
	CONSTRAINT [DF_TB_DIM_GENERIC_MAPPING_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_DIM_GENERIC_MAPPING]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_DIM_GENERIC_MAPPING_TB_DIM_GENERIC_MAP]
	FOREIGN KEY ([GENERIC_MAP_ID]) REFERENCES [dbo].[TB_DIM_GENERIC_MAP] ([GENERIC_MAP_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_DIM_GENERIC_MAPPING]
	CHECK CONSTRAINT [FK_TB_DIM_GENERIC_MAPPING_TB_DIM_GENERIC_MAP]

GO
EXEC sp_addextendedproperty N'MS_Description', N'This table holds all the mappings between two items within a mapping group. This table is used by the Self care tool of the application.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_GENERIC_MAPPING', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_GENERIC_MAPPING', 'COLUMN', N'GENERIC_MAPPING_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TB_DIM_GENERIC_MAP corresponding to the mapping group, which the current mapping belong to.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_GENERIC_MAPPING', 'COLUMN', N'GENERIC_MAP_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a URN (from a dimension table) indicating the source item for the mapping.  The logic of which dimension table is inferred from the calling algorithm.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_GENERIC_MAPPING', 'COLUMN', N'FROM_ITEM_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN (from a dimension table) indicating the target item for the mapping.  The logic of which dimension table is inferred from the calling algorithm.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_GENERIC_MAPPING', 'COLUMN', N'TO_ITEM_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a priority order in which the current mapping needs to be treated in the mapping group.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_GENERIC_MAPPING', 'COLUMN', N'SEQUENCE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is any configuration value of type Integer associated with the mapping if specified.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_GENERIC_MAPPING', 'COLUMN', N'INT_VAL'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is any configuration value of type Float associated with the mapping if specified.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_GENERIC_MAPPING', 'COLUMN', N'FLOAT_VAL'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is any configuration value of type String associated with the mapping if specified.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_GENERIC_MAPPING', 'COLUMN', N'STRING_VAL'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the mapping is set for archive. Value 1 indicates archived.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_GENERIC_MAPPING', 'COLUMN', N'ARCHIVED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the mapping is deleted. Value 1 indicates deleted.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_GENERIC_MAPPING', 'COLUMN', N'DELETED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the mapping is enabled. Value 1 indicates enabled.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_GENERIC_MAPPING', 'COLUMN', N'ENABLED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the mapping is hidden. Value 1 indicates hidden.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_GENERIC_MAPPING', 'COLUMN', N'HIDDEN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the mapping is owned by system. Value 1 indicates system owned mapping.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_GENERIC_MAPPING', 'COLUMN', N'SYSTEM'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_GENERIC_MAPPING', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_DIM_GENERIC_MAPPING]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_DIM_GENERIC_MAPPING]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_DIM_GENERIC_MAPPING]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_DIM_GENERIC_MAPPING]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_DIM_GENERIC_MAPPING] SET (LOCK_ESCALATION = TABLE)
GO
