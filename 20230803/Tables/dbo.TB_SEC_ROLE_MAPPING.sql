SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TB_SEC_ROLE_MAPPING] (
		[ID]                      [uniqueidentifier] NOT NULL,
		[ROLE_ID]                 [uniqueidentifier] NOT NULL,
		[TASK_ID]                 [uniqueidentifier] NOT NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [UN_TB_SEC_ROLE_MAPPING]
		UNIQUE
		NONCLUSTERED
		([ROLE_ID], [TASK_ID])
		ON [SECGROUP],
		CONSTRAINT [PK_TB_SEC_ROLE_MAPPING]
		PRIMARY KEY
		CLUSTERED
		([ID])
	ON [SECGROUP]
) ON [SECGROUP]
GO
ALTER TABLE [dbo].[TB_SEC_ROLE_MAPPING]
	ADD
	CONSTRAINT [DF_TB_SEC_ROLE_MAPPING_ID]
	DEFAULT (newid()) FOR [ID]
GO
ALTER TABLE [dbo].[TB_SEC_ROLE_MAPPING]
	ADD
	CONSTRAINT [DF_TB_SEC_ROLE_MAPPING_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_SEC_ROLE_MAPPING]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_SEC_ROLE_MAPPING_TB_SEC_ROLE]
	FOREIGN KEY ([ROLE_ID]) REFERENCES [dbo].[TB_SEC_ROLE] ([ROLE_ID])
	ON DELETE CASCADE
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_SEC_ROLE_MAPPING]
	CHECK CONSTRAINT [FK_TB_SEC_ROLE_MAPPING_TB_SEC_ROLE]

GO
ALTER TABLE [dbo].[TB_SEC_ROLE_MAPPING]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_SEC_ROLE_MAPPING_TE_SEC_TASK]
	FOREIGN KEY ([TASK_ID]) REFERENCES [dbo].[TE_SEC_TASK] ([TASK_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_SEC_ROLE_MAPPING]
	CHECK CONSTRAINT [FK_TB_SEC_ROLE_MAPPING_TE_SEC_TASK]

GO
EXEC sp_addextendedproperty N'MS_Description', N'This table stores all the mappings between a security role and the associated security tasks.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_ROLE_MAPPING', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_ROLE_MAPPING', 'COLUMN', N'ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Composite unique key for the record. This is the id of the security role in TB_SEC_ROLE for which the mapping is defined. This is a foreign key to TB_SEC_ROLE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_ROLE_MAPPING', 'COLUMN', N'ROLE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Composite unique key for the record. This is the id of the security task in TE_SEC_TASK which is associated with the security role. This is a foreign key to TE_SEC_TASK.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_ROLE_MAPPING', 'COLUMN', N'TASK_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_ROLE_MAPPING', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_SEC_ROLE_MAPPING]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_SEC_ROLE_MAPPING]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_SEC_ROLE_MAPPING]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_SEC_ROLE_MAPPING]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_SEC_ROLE_MAPPING] SET (LOCK_ESCALATION = TABLE)
GO
