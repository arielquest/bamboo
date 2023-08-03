SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TB_CLU_RESOURCE_MEMBER] (
		[RESOURCE_MEMBER_ID]      [uniqueidentifier] NOT NULL ROWGUIDCOL,
		[PARENT_RESOURCE_ID]      [uniqueidentifier] NOT NULL,
		[CHILD_RESOURCE_ID]       [uniqueidentifier] NOT NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [UN_TB_CLU_RESOURCE_MEMBER_PARENT_CHILD]
		UNIQUE
		NONCLUSTERED
		([PARENT_RESOURCE_ID], [CHILD_RESOURCE_ID])
		ON [ADMINDEXGROUP],
		CONSTRAINT [PK_TB_CLU_RESOURCE_MEMBER]
		PRIMARY KEY
		CLUSTERED
		([RESOURCE_MEMBER_ID])
	ON [ADMGROUP]
) ON [ADMGROUP]
GO
ALTER TABLE [dbo].[TB_CLU_RESOURCE_MEMBER]
	ADD
	CONSTRAINT [DF_TB_CLU_RESOURCE_MEMBER_RESOURCE_MEMBER_ID]
	DEFAULT (newid()) FOR [RESOURCE_MEMBER_ID]
GO
ALTER TABLE [dbo].[TB_CLU_RESOURCE_MEMBER]
	ADD
	CONSTRAINT [DF_TB_CLU_RESOURCE_MEMBER_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_CLU_RESOURCE_MEMBER]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_CLU_RESOURCE_MEMBER_TB_CLU_RESOURCE_CHILD]
	FOREIGN KEY ([CHILD_RESOURCE_ID]) REFERENCES [dbo].[TB_CLU_RESOURCE] ([RESOURCE_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_CLU_RESOURCE_MEMBER]
	CHECK CONSTRAINT [FK_TB_CLU_RESOURCE_MEMBER_TB_CLU_RESOURCE_CHILD]

GO
ALTER TABLE [dbo].[TB_CLU_RESOURCE_MEMBER]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_CLU_RESOURCE_MEMBER_TB_CLU_RESOURCE_PARENT]
	FOREIGN KEY ([PARENT_RESOURCE_ID]) REFERENCES [dbo].[TB_CLU_RESOURCE] ([RESOURCE_ID])
	ON DELETE CASCADE
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_CLU_RESOURCE_MEMBER]
	CHECK CONSTRAINT [FK_TB_CLU_RESOURCE_MEMBER_TB_CLU_RESOURCE_PARENT]

GO
CREATE NONCLUSTERED INDEX [IX_TB_CLU_RESOURCE_MEMBER_CHILD_RESOURCE_ID]
	ON [dbo].[TB_CLU_RESOURCE_MEMBER] ([CHILD_RESOURCE_ID])
	ON [ADMINDEXGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This tables holds all the dependencies between various resource equipments. For example, the dependency between CICMs and INs i.e. how many CICM resources does an IN resource depends on.', 'SCHEMA', N'dbo', 'TABLE', N'TB_CLU_RESOURCE_MEMBER', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_CLU_RESOURCE_MEMBER', 'COLUMN', N'RESOURCE_MEMBER_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TB_CLU_RESOURCE corresponding to the resource that is the parent of the current relationship.', 'SCHEMA', N'dbo', 'TABLE', N'TB_CLU_RESOURCE_MEMBER', 'COLUMN', N'PARENT_RESOURCE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TB_CLU_RESOURCE corresponding to the resource that is the child of the current relationship.', 'SCHEMA', N'dbo', 'TABLE', N'TB_CLU_RESOURCE_MEMBER', 'COLUMN', N'CHILD_RESOURCE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_CLU_RESOURCE_MEMBER', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_CLU_RESOURCE_MEMBER]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_CLU_RESOURCE_MEMBER]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_CLU_RESOURCE_MEMBER]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_CLU_RESOURCE_MEMBER]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_CLU_RESOURCE_MEMBER]
	TO [portalrs_role]
GO
GRANT SELECT
	ON [dbo].[TB_CLU_RESOURCE_MEMBER]
	TO [portal_default_mediator_role]
GO
GRANT DELETE
	ON [dbo].[TB_CLU_RESOURCE_MEMBER]
	TO [portal_database_configuration_role]
GO
GRANT INSERT
	ON [dbo].[TB_CLU_RESOURCE_MEMBER]
	TO [portal_database_configuration_role]
GO
GRANT SELECT
	ON [dbo].[TB_CLU_RESOURCE_MEMBER]
	TO [portal_database_configuration_role]
GO
GRANT UPDATE
	ON [dbo].[TB_CLU_RESOURCE_MEMBER]
	TO [portal_database_configuration_role]
GO
ALTER TABLE [dbo].[TB_CLU_RESOURCE_MEMBER] SET (LOCK_ESCALATION = TABLE)
GO
