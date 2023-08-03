SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TB_SEC_POLICY_USER_ROLE] (
		[ID]                      [uniqueidentifier] NOT NULL,
		[POLICY_ID]               [uniqueidentifier] NOT NULL,
		[USER_ID]                 [uniqueidentifier] NOT NULL,
		[ROLE_ID]                 [uniqueidentifier] NOT NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [UN_TB_SEC_POLICY_USER_ROLE]
		UNIQUE
		NONCLUSTERED
		([POLICY_ID], [USER_ID], [ROLE_ID])
		ON [SECGROUP],
		CONSTRAINT [PK_TB_SEC_POLICY_USER_ROLE]
		PRIMARY KEY
		CLUSTERED
		([ID])
	ON [SECGROUP]
) ON [SECGROUP]
GO
ALTER TABLE [dbo].[TB_SEC_POLICY_USER_ROLE]
	ADD
	CONSTRAINT [DF_TB_SEC_POLICY_USER_ROLE_ID]
	DEFAULT (newid()) FOR [ID]
GO
ALTER TABLE [dbo].[TB_SEC_POLICY_USER_ROLE]
	ADD
	CONSTRAINT [DF_TB_SEC_POLICY_USER_ROLE_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_SEC_POLICY_USER_ROLE]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_SEC_POLICY_USER_ROLE_TB_SEC_USER]
	FOREIGN KEY ([USER_ID]) REFERENCES [dbo].[TB_SEC_USER] ([USER_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_SEC_POLICY_USER_ROLE]
	CHECK CONSTRAINT [FK_TB_SEC_POLICY_USER_ROLE_TB_SEC_USER]

GO
ALTER TABLE [dbo].[TB_SEC_POLICY_USER_ROLE]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_SEC_POLICY_USER_ROLE_TB_SEC_POLICY]
	FOREIGN KEY ([POLICY_ID]) REFERENCES [dbo].[TB_SEC_POLICY] ([POLICY_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_SEC_POLICY_USER_ROLE]
	CHECK CONSTRAINT [FK_TB_SEC_POLICY_USER_ROLE_TB_SEC_POLICY]

GO
ALTER TABLE [dbo].[TB_SEC_POLICY_USER_ROLE]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_SEC_POLICY_USER_ROLE_TB_SEC_ROLE]
	FOREIGN KEY ([ROLE_ID]) REFERENCES [dbo].[TB_SEC_ROLE] ([ROLE_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_SEC_POLICY_USER_ROLE]
	CHECK CONSTRAINT [FK_TB_SEC_POLICY_USER_ROLE_TB_SEC_ROLE]

GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the table which defines the rights and permissions a user or a group has on various folders in the system, based on the security policies.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_POLICY_USER_ROLE', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_POLICY_USER_ROLE', 'COLUMN', N'ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Composite unique key for the record. This is the id of the security policy from TB_SEC_POLICY for which security mappings is being defined. This is a foreign key to TB_SEC_POLICY.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_POLICY_USER_ROLE', 'COLUMN', N'POLICY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Composite unique key for the record. This is the id of the security user or group from TB_SEC_USER for which the security mapping is being defined. This is a foreign key to TB_SEC_USER.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_POLICY_USER_ROLE', 'COLUMN', N'USER_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Composite unique key for the record. This is the id of the security role from TB_SEC_ROLE which is being assigned to the the current security user or group on a security policy as part of the current mapping. This is a foreign key to TB_SEC_ROLE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_POLICY_USER_ROLE', 'COLUMN', N'ROLE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_POLICY_USER_ROLE', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_SEC_POLICY_USER_ROLE]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_SEC_POLICY_USER_ROLE]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_SEC_POLICY_USER_ROLE]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_SEC_POLICY_USER_ROLE]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_SEC_POLICY_USER_ROLE] SET (LOCK_ESCALATION = TABLE)
GO
