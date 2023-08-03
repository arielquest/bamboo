SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_SEC_POLICY] (
		[POLICY_ID]               [uniqueidentifier] NOT NULL ROWGUIDCOL,
		[NAME]                    [nvarchar](450) COLLATE Latin1_General_CI_AS NOT NULL,
		[DESCRIPTION]             [nvarchar](500) COLLATE Latin1_General_CI_AS NOT NULL,
		[GLOBAL_POLICY]           [bit] NOT NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [UN_TB_SEC_POLICY_NAME]
		UNIQUE
		NONCLUSTERED
		([NAME])
		ON [SECINDEXGROUP],
		CONSTRAINT [PK_TB_SEC_POLICY]
		PRIMARY KEY
		CLUSTERED
		([POLICY_ID])
	ON [SECGROUP]
) ON [SECGROUP]
GO
ALTER TABLE [dbo].[TB_SEC_POLICY]
	ADD
	CONSTRAINT [DF_TB_SEC_POLICY_POLICY_ID]
	DEFAULT (newid()) FOR [POLICY_ID]
GO
ALTER TABLE [dbo].[TB_SEC_POLICY]
	ADD
	CONSTRAINT [DF_TB_SEC_POLICY_DESCRIPTION]
	DEFAULT (N'') FOR [DESCRIPTION]
GO
ALTER TABLE [dbo].[TB_SEC_POLICY]
	ADD
	CONSTRAINT [DF_TB_SEC_POLICY_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table stores all the security policies of the application.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_POLICY', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_POLICY', 'COLUMN', N'POLICY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the name for the security policy. This is unique.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_POLICY', 'COLUMN', N'NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a brief description for the security policy.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_POLICY', 'COLUMN', N'DESCRIPTION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the security policy is global or not. Value of 1 indicates global policy.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_POLICY', 'COLUMN', N'GLOBAL_POLICY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_POLICY', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_SEC_POLICY]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_SEC_POLICY]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_SEC_POLICY]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_SEC_POLICY]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_SEC_POLICY] SET (LOCK_ESCALATION = TABLE)
GO
