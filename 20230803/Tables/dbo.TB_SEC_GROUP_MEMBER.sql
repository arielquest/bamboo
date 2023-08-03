SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TB_SEC_GROUP_MEMBER] (
		[MEMBER_ID]                [uniqueidentifier] NOT NULL ROWGUIDCOL,
		[PARENT_ID]                [uniqueidentifier] NOT NULL,
		[CHILD_ID]                 [uniqueidentifier] NOT NULL,
		[CALCULATED]               [bit] NOT NULL,
		[CALCULATED_PARENT_ID]     [uniqueidentifier] NULL,
		[msrepl_tran_version]      [uniqueidentifier] NOT NULL,
		CONSTRAINT [UN_TB_SEC_GROUP_MEMBER]
		UNIQUE
		NONCLUSTERED
		([PARENT_ID], [CHILD_ID], [CALCULATED_PARENT_ID])
		ON [SECINDEXGROUP],
		CONSTRAINT [PK_TB_SEC_GROUP_MEMBER]
		PRIMARY KEY
		CLUSTERED
		([MEMBER_ID])
	ON [SECGROUP]
) ON [SECGROUP]
GO
ALTER TABLE [dbo].[TB_SEC_GROUP_MEMBER]
	ADD
	CONSTRAINT [CK_TB_SEC_GROUP_MEMBER_PARENT_ID_CHILD_ID]
	CHECK
	([PARENT_ID]<>[CHILD_ID])
GO
ALTER TABLE [dbo].[TB_SEC_GROUP_MEMBER]
CHECK CONSTRAINT [CK_TB_SEC_GROUP_MEMBER_PARENT_ID_CHILD_ID]
GO
ALTER TABLE [dbo].[TB_SEC_GROUP_MEMBER]
	ADD
	CONSTRAINT [DF_TB_SEC_GROUP_MEMBER_MEMBER_ID]
	DEFAULT (newid()) FOR [MEMBER_ID]
GO
ALTER TABLE [dbo].[TB_SEC_GROUP_MEMBER]
	ADD
	CONSTRAINT [DF_TB_SEC_GROUP_MEMBER_CALCULATED]
	DEFAULT ((0)) FOR [CALCULATED]
GO
ALTER TABLE [dbo].[TB_SEC_GROUP_MEMBER]
	ADD
	CONSTRAINT [DF_TB_SEC_GROUP_MEMBER_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_SEC_GROUP_MEMBER]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_SEC_GROUP_MEMBER_TB_SEC_USER_CHILD]
	FOREIGN KEY ([CHILD_ID]) REFERENCES [dbo].[TB_SEC_USER] ([USER_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_SEC_GROUP_MEMBER]
	CHECK CONSTRAINT [FK_TB_SEC_GROUP_MEMBER_TB_SEC_USER_CHILD]

GO
ALTER TABLE [dbo].[TB_SEC_GROUP_MEMBER]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_SEC_GROUP_MEMBER_TB_SEC_USER_PARENT]
	FOREIGN KEY ([PARENT_ID]) REFERENCES [dbo].[TB_SEC_USER] ([USER_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_SEC_GROUP_MEMBER]
	CHECK CONSTRAINT [FK_TB_SEC_GROUP_MEMBER_TB_SEC_USER_PARENT]

GO
ALTER TABLE [dbo].[TB_SEC_GROUP_MEMBER]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_SEC_GROUP_MEMBER_TB_SEC_USER_CALCULATED_PARENT]
	FOREIGN KEY ([CALCULATED_PARENT_ID]) REFERENCES [dbo].[TB_SEC_USER] ([USER_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_SEC_GROUP_MEMBER]
	CHECK CONSTRAINT [FK_TB_SEC_GROUP_MEMBER_TB_SEC_USER_CALCULATED_PARENT]

GO
CREATE NONCLUSTERED INDEX [IX_TB_SEC_GROUP_MEMBER_CALCULATED_PARENT_ID]
	ON [dbo].[TB_SEC_GROUP_MEMBER] ([CALCULATED_PARENT_ID])
	ON [SECGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This tables holds information about the users and group memberships in the application.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_GROUP_MEMBER', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_GROUP_MEMBER', 'COLUMN', N'MEMBER_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id of the user of type G from TB_SEC_USER which is the parent for the membership.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_GROUP_MEMBER', 'COLUMN', N'PARENT_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id of the user of type G or U from TB_SEC_USER which is the child for the membership.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_GROUP_MEMBER', 'COLUMN', N'CHILD_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the membership is direct or calculated based on other membership. Value of 1 indicates calculated membership.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_GROUP_MEMBER', 'COLUMN', N'CALCULATED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id of the user of type G from TB_SEC_USER through which the calculated membership exists. This field is set when CALCULATED is set to 1.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_GROUP_MEMBER', 'COLUMN', N'CALCULATED_PARENT_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_GROUP_MEMBER', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_SEC_GROUP_MEMBER]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_SEC_GROUP_MEMBER]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_SEC_GROUP_MEMBER]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_SEC_GROUP_MEMBER]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_SEC_GROUP_MEMBER] SET (LOCK_ESCALATION = TABLE)
GO
