SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_DIM_HIERARCHY_LEVEL] (
		[HIERARCHY_LEVEL_URN]        [int] IDENTITY(1, 4) NOT FOR REPLICATION NOT NULL,
		[HIERARCHY_BUSINESS_URN]     [int] NOT NULL,
		[NAME]                       [nvarchar](100) COLLATE Latin1_General_CI_AS NULL,
		[DESCRIPTION]                [nvarchar](500) COLLATE Latin1_General_CI_AS NOT NULL,
		[CARDINALITY]                [int] NOT NULL,
		[msrepl_tran_version]        [uniqueidentifier] NOT NULL,
		CONSTRAINT [UN_TB_DIM_HIERARCHY_LEVEL]
		UNIQUE
		NONCLUSTERED
		([HIERARCHY_BUSINESS_URN], [CARDINALITY])
		ON [DIMINDEXGROUP],
		CONSTRAINT [PK_TB_DIM_HIERARCHY_LEVEL]
		PRIMARY KEY
		CLUSTERED
		([HIERARCHY_LEVEL_URN])
	ON [DIMGROUP]
) ON [DIMGROUP]
GO
ALTER TABLE [dbo].[TB_DIM_HIERARCHY_LEVEL]
	ADD
	CONSTRAINT [DF_TB_DIM_HIERARCHY_LEVEL_CARDINALITY]
	DEFAULT ((0)) FOR [CARDINALITY]
GO
ALTER TABLE [dbo].[TB_DIM_HIERARCHY_LEVEL]
	ADD
	CONSTRAINT [DF_TB_DIM_HIERARCHY_LEVEL_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table stores all the specific information for items in TB_DIM_HIERARCHY of type IT_HIERARCHY_LEVEL. Defines an individual level within a fixed level hierarchy.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_HIERARCHY_LEVEL', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record. The values in this column correspond to the ITEM_URN in TB_DIM_HIERARCHY for items whose item type is IT_HIERARCHY_LEVEL.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_HIERARCHY_LEVEL', 'COLUMN', N'HIERARCHY_LEVEL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key to the hierarchy business URN (TB_DIM_HIERARCHY) that this level belongs to.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_HIERARCHY_LEVEL', 'COLUMN', N'HIERARCHY_BUSINESS_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the display name for the item.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_HIERARCHY_LEVEL', 'COLUMN', N'NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a brief description for the item.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_HIERARCHY_LEVEL', 'COLUMN', N'DESCRIPTION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The cardinality of this level within the hiearchy', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_HIERARCHY_LEVEL', 'COLUMN', N'CARDINALITY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_HIERARCHY_LEVEL', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_DIM_HIERARCHY_LEVEL]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_DIM_HIERARCHY_LEVEL]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_DIM_HIERARCHY_LEVEL]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_DIM_HIERARCHY_LEVEL]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_DIM_HIERARCHY_LEVEL] SET (LOCK_ESCALATION = TABLE)
GO
