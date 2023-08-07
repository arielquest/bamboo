SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TB_DIM_ITEM_HIERARCHY_NODE_MEMBER] (
		[MEMBER_URN]              [int] IDENTITY(1, 4) NOT FOR REPLICATION NOT NULL,
		[ITEM_URN]                [int] NOT NULL,
		[ITEM_TYPE_URN]           [int] NOT NULL,
		[HIERARCHY_NODE_URN]      [int] NOT NULL,
		[PRECEDENCE]              [int] NOT NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [UN_TB_DIM_ITEM_HIERARCHY_NODE_MEMBER]
		UNIQUE
		NONCLUSTERED
		([ITEM_URN], [ITEM_TYPE_URN], [HIERARCHY_NODE_URN], [PRECEDENCE])
		ON [DIMINDEXGROUP],
		CONSTRAINT [PK_TB_DIM_ITEM_HIERARCHY_NODE_MEMBER]
		PRIMARY KEY
		CLUSTERED
		([MEMBER_URN])
	ON [DIMGROUP]
) ON [DIMGROUP]
GO
ALTER TABLE [dbo].[TB_DIM_ITEM_HIERARCHY_NODE_MEMBER]
	ADD
	CONSTRAINT [DF_TB_DIM_ITEM_HIERARCHY_NODE_MEMBER_PRECEDENCE]
	DEFAULT ((0)) FOR [PRECEDENCE]
GO
ALTER TABLE [dbo].[TB_DIM_ITEM_HIERARCHY_NODE_MEMBER]
	ADD
	CONSTRAINT [DF_TB_DIM_ITEM_HIERARCHY_NODE_MEMBER_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_DIM_ITEM_HIERARCHY_NODE_MEMBER]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_DIM_ITEM_HIERARCHY_NODE_MEMBER_TB_DIM_HIERARCHY_NODE]
	FOREIGN KEY ([HIERARCHY_NODE_URN]) REFERENCES [dbo].[TB_DIM_HIERARCHY_NODE] ([ITEM_URN])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_DIM_ITEM_HIERARCHY_NODE_MEMBER]
	CHECK CONSTRAINT [FK_TB_DIM_ITEM_HIERARCHY_NODE_MEMBER_TB_DIM_HIERARCHY_NODE]

GO
ALTER TABLE [dbo].[TB_DIM_ITEM_HIERARCHY_NODE_MEMBER]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_DIM_ITEM_HIERARCHY_NODE_MEMBER_TE_DIM_ITEM_TYPE]
	FOREIGN KEY ([ITEM_TYPE_URN]) REFERENCES [dbo].[TE_DIM_ITEM_TYPE] ([ITEM_TYPE_URN])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_DIM_ITEM_HIERARCHY_NODE_MEMBER]
	CHECK CONSTRAINT [FK_TB_DIM_ITEM_HIERARCHY_NODE_MEMBER_TE_DIM_ITEM_TYPE]

GO
CREATE NONCLUSTERED INDEX [IX_TB_DIM_ITEM_HIERARCHY_NODE_MEMBER_HIERARCHY_NODE_URN]
	ON [dbo].[TB_DIM_ITEM_HIERARCHY_NODE_MEMBER] ([HIERARCHY_NODE_URN])
	ON [DIMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_DIM_ITEM_HIERARCHY_NODE_MEMBER_ITEM_TYPE_URN]
	ON [dbo].[TB_DIM_ITEM_HIERARCHY_NODE_MEMBER] ([ITEM_TYPE_URN])
	ON [DIMINDEXGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table stores all the specific information for memberships in TB_DIM_ITEM_HIERARCHY_NODE_MEMBER whose member type is MT_ITEM_HIERARCHY_NODE_MEMBER. ', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_ITEM_HIERARCHY_NODE_MEMBER', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record. The values in this column correspond to the MEMBER_URN in TB_DIM_ITEM_HIERARCHY_NODE_MEMBER for memberhsips whose member type is MT_ITEM_HIERARCHY_NODE_MEMBER.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_ITEM_HIERARCHY_NODE_MEMBER', 'COLUMN', N'MEMBER_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key to dimension table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_ITEM_HIERARCHY_NODE_MEMBER', 'COLUMN', N'ITEM_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key to the dimension type table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_ITEM_HIERARCHY_NODE_MEMBER', 'COLUMN', N'ITEM_TYPE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key to TB_DIM_HIERARCHY_NODE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_ITEM_HIERARCHY_NODE_MEMBER', 'COLUMN', N'HIERARCHY_NODE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The precedence of this membership. Used to support primary, secondary, tertiary hierarchy memberships (e.g. speciality).', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_ITEM_HIERARCHY_NODE_MEMBER', 'COLUMN', N'PRECEDENCE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_ITEM_HIERARCHY_NODE_MEMBER', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_DIM_ITEM_HIERARCHY_NODE_MEMBER]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_DIM_ITEM_HIERARCHY_NODE_MEMBER]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_DIM_ITEM_HIERARCHY_NODE_MEMBER]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_DIM_ITEM_HIERARCHY_NODE_MEMBER]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_DIM_ITEM_HIERARCHY_NODE_MEMBER] SET (LOCK_ESCALATION = TABLE)
GO