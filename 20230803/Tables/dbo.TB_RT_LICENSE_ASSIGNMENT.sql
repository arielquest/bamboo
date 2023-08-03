SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_RT_LICENSE_ASSIGNMENT] (
		[LICENSE_ASSIGNMENT_URN]                             [bigint] IDENTITY(1, 2) NOT NULL,
		[CLUSTER_RESOURCE_URN]                               [int] NOT NULL,
		[TENANT_URN]                                         [int] NOT NULL,
		[AGENT_URN]                                          [int] NOT NULL,
		[USER_ID]                                            [bigint] NOT NULL,
		[USER_LOGIN_NAME]                                    [nvarchar](255) COLLATE Latin1_General_CI_AS NOT NULL,
		[USER_FIRST_NAME]                                    [nvarchar](255) COLLATE Latin1_General_CI_AS NOT NULL,
		[USER_LAST_NAME]                                     [nvarchar](255) COLLATE Latin1_General_CI_AS NOT NULL,
		[PRODUCT_NAME]                                       [nvarchar](255) COLLATE Latin1_General_CI_AS NOT NULL,
		[SNAPSHOT_DATE_TIME_UTC]                             [datetime] NOT NULL,
		[LICENSE_ASSIGNMENT_CREATION_DATE_TIME_UTC]          [datetime] NOT NULL,
		[LICENSE_ASSIGNMENT_LAST_MODIFIED_DATE_TIME_UTC]     [datetime] NOT NULL,
		[USER_CREATION_DATE_TIME_UTC]                        [datetime] NOT NULL,
		[USER_LAST_MODIFIED_DATE_TIME_UTC]                   [datetime] NULL,
		[USER_LAST_LOGIN_OR_LOGOUT_DATE_TIME_UTC]            [datetime] NULL,
		[USER_STATE]                                         [smallint] NOT NULL,
		[msrepl_tran_version]                                [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_RT_LICENSE_ASSIGNMENT]
		PRIMARY KEY
		CLUSTERED
		([LICENSE_ASSIGNMENT_URN])
	ON [FCTEGNGROUP]
) ON [FCTEGNGROUP]
GO
ALTER TABLE [dbo].[TB_RT_LICENSE_ASSIGNMENT]
	ADD
	CONSTRAINT [DF_RT_LICENSE_ASSIGNMENT_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
CREATE NONCLUSTERED INDEX [IX_RT_LICENSE_ASSIGNMENT_TENANT_URN]
	ON [dbo].[TB_RT_LICENSE_ASSIGNMENT] ([TENANT_URN])
	ON [FCTEGNIDXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_RT_LICENSE_ASSIGNMENT_AGENT_URN]
	ON [dbo].[TB_RT_LICENSE_ASSIGNMENT] ([AGENT_URN])
	ON [FCTEGNIDXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_RT_LICENSE_ASSIGNMENT_CLUSTER_RESOURCE_URN]
	ON [dbo].[TB_RT_LICENSE_ASSIGNMENT] ([CLUSTER_RESOURCE_URN])
	ON [FCTEGNIDXGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table contains information on user license ASSIGNMENTs.', 'SCHEMA', N'dbo', 'TABLE', N'TB_RT_LICENSE_ASSIGNMENT', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_RT_LICENSE_ASSIGNMENT', 'COLUMN', N'LICENSE_ASSIGNMENT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from the table dbo.TB_CLU_RESOURCE indicating the source of the data.', 'SCHEMA', N'dbo', 'TABLE', N'TB_RT_LICENSE_ASSIGNMENT', 'COLUMN', N'CLUSTER_RESOURCE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_TENANT.ITEM_URN and refers to the eGain department the Agent is assigned to.', 'SCHEMA', N'dbo', 'TABLE', N'TB_RT_LICENSE_ASSIGNMENT', 'COLUMN', N'TENANT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_AGENT.ITEM_URN and refers to the Agent this license is assigned to.', 'SCHEMA', N'dbo', 'TABLE', N'TB_RT_LICENSE_ASSIGNMENT', 'COLUMN', N'AGENT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the source ID of the user.', 'SCHEMA', N'dbo', 'TABLE', N'TB_RT_LICENSE_ASSIGNMENT', 'COLUMN', N'USER_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the login name of the User.', 'SCHEMA', N'dbo', 'TABLE', N'TB_RT_LICENSE_ASSIGNMENT', 'COLUMN', N'USER_LOGIN_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the first name of the User.', 'SCHEMA', N'dbo', 'TABLE', N'TB_RT_LICENSE_ASSIGNMENT', 'COLUMN', N'USER_FIRST_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the last name of the User.', 'SCHEMA', N'dbo', 'TABLE', N'TB_RT_LICENSE_ASSIGNMENT', 'COLUMN', N'USER_LAST_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is name of the product the license is assigned to.', 'SCHEMA', N'dbo', 'TABLE', N'TB_RT_LICENSE_ASSIGNMENT', 'COLUMN', N'PRODUCT_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the Date/Time stamp in UTC the record was written to this table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_RT_LICENSE_ASSIGNMENT', 'COLUMN', N'SNAPSHOT_DATE_TIME_UTC'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the Date/Time stamp in UTC when the license was assigned to this User.', 'SCHEMA', N'dbo', 'TABLE', N'TB_RT_LICENSE_ASSIGNMENT', 'COLUMN', N'LICENSE_ASSIGNMENT_CREATION_DATE_TIME_UTC'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the Date/Time stamp in UTC when the license was last modified on this User.', 'SCHEMA', N'dbo', 'TABLE', N'TB_RT_LICENSE_ASSIGNMENT', 'COLUMN', N'LICENSE_ASSIGNMENT_LAST_MODIFIED_DATE_TIME_UTC'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the Date/Time stamp in UTC when the User was created.', 'SCHEMA', N'dbo', 'TABLE', N'TB_RT_LICENSE_ASSIGNMENT', 'COLUMN', N'USER_CREATION_DATE_TIME_UTC'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the Date/Time stamp in UTC when the User was last modified.', 'SCHEMA', N'dbo', 'TABLE', N'TB_RT_LICENSE_ASSIGNMENT', 'COLUMN', N'USER_LAST_MODIFIED_DATE_TIME_UTC'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the Date/Time stamp in UTC when the User either last logged in or logged out.', 'SCHEMA', N'dbo', 'TABLE', N'TB_RT_LICENSE_ASSIGNMENT', 'COLUMN', N'USER_LAST_LOGIN_OR_LOGOUT_DATE_TIME_UTC'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the state of the User.', 'SCHEMA', N'dbo', 'TABLE', N'TB_RT_LICENSE_ASSIGNMENT', 'COLUMN', N'USER_STATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_RT_LICENSE_ASSIGNMENT', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_RT_LICENSE_ASSIGNMENT]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_RT_LICENSE_ASSIGNMENT]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_RT_LICENSE_ASSIGNMENT]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_RT_LICENSE_ASSIGNMENT]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_RT_LICENSE_ASSIGNMENT]
	TO [portalrs_role]
GO
ALTER TABLE [dbo].[TB_RT_LICENSE_ASSIGNMENT] SET (LOCK_ESCALATION = TABLE)
GO
