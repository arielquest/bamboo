SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_REP_PARAMETER_SET] (
		[PARAMETER_SET_ID]            [uniqueidentifier] NOT NULL ROWGUIDCOL,
		[LINKED_PARAMETER_SET_ID]     [uniqueidentifier] NULL,
		[ITEM_TYPE_ID]                [uniqueidentifier] NOT NULL,
		[FOLDER_ID]                   [uniqueidentifier] NOT NULL,
		[NAME]                        [nvarchar](255) COLLATE Latin1_General_CI_AS NOT NULL,
		[PARAMETERS]                  [nvarchar](max) COLLATE Latin1_General_CI_AS NULL,
		[ARCHIVED]                    [bit] NOT NULL,
		[ENABLED]                     [bit] NOT NULL,
		[HIDDEN]                      [bit] NOT NULL,
		[SYSTEM]                      [bit] NOT NULL,
		[USER_ID]                     [uniqueidentifier] NOT NULL,
		[msrepl_tran_version]         [uniqueidentifier] NOT NULL,
		CONSTRAINT [UN_TB_REP_PARAMETER_SET_FOLDER_ID_NAME]
		UNIQUE
		NONCLUSTERED
		([FOLDER_ID], [NAME])
		ON [PRIMARY],
		CONSTRAINT [PK_TB_REP_PARAMETER_SET]
		PRIMARY KEY
		CLUSTERED
		([PARAMETER_SET_ID])
	ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[TB_REP_PARAMETER_SET]
	ADD
	CONSTRAINT [DF_TB_REP_REPORT_PARAMETER_SET_PARAMETER_ID]
	DEFAULT (newid()) FOR [PARAMETER_SET_ID]
GO
ALTER TABLE [dbo].[TB_REP_PARAMETER_SET]
	ADD
	CONSTRAINT [DF_TB_REP_REPORT_PARAMETER_SET_ITEM_TYPE_ID]
	DEFAULT ('00000000-0000-0000-0000-000000000010') FOR [ITEM_TYPE_ID]
GO
ALTER TABLE [dbo].[TB_REP_PARAMETER_SET]
	ADD
	CONSTRAINT [DF_TB_REP_REPORT_PARAMETER_SET_ARCHIVED]
	DEFAULT ((0)) FOR [ARCHIVED]
GO
ALTER TABLE [dbo].[TB_REP_PARAMETER_SET]
	ADD
	CONSTRAINT [DF_TB_REP_REPORT_PARAMETER_SET_ENABLED]
	DEFAULT ((1)) FOR [ENABLED]
GO
ALTER TABLE [dbo].[TB_REP_PARAMETER_SET]
	ADD
	CONSTRAINT [DF_TB_REP_REPORT_PARAMETER_SET_HIDDEN]
	DEFAULT ((0)) FOR [HIDDEN]
GO
ALTER TABLE [dbo].[TB_REP_PARAMETER_SET]
	ADD
	CONSTRAINT [DF_TB_REP_REPORT_PARAMETER_SET_SYSTEM]
	DEFAULT ((0)) FOR [SYSTEM]
GO
ALTER TABLE [dbo].[TB_REP_PARAMETER_SET]
	ADD
	CONSTRAINT [DF_TB_REP_REPORT_PARAMETER_SET_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_REP_PARAMETER_SET]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_REP_REPORT_PARAMETER_SET_TB_REP_REPORT_PARAMETER_SET_LINKED_PARAMETER_SET]
	FOREIGN KEY ([LINKED_PARAMETER_SET_ID]) REFERENCES [dbo].[TB_REP_PARAMETER_SET] ([PARAMETER_SET_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_REP_PARAMETER_SET]
	CHECK CONSTRAINT [FK_TB_REP_REPORT_PARAMETER_SET_TB_REP_REPORT_PARAMETER_SET_LINKED_PARAMETER_SET]

GO
ALTER TABLE [dbo].[TB_REP_PARAMETER_SET]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_REP_REPORT_PARAMETER_SET_TE_DIM_ITEM_TYPE]
	FOREIGN KEY ([ITEM_TYPE_ID]) REFERENCES [dbo].[TE_DIM_ITEM_TYPE] ([ITEM_TYPE_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_REP_PARAMETER_SET]
	CHECK CONSTRAINT [FK_TB_REP_REPORT_PARAMETER_SET_TE_DIM_ITEM_TYPE]

GO
ALTER TABLE [dbo].[TB_REP_PARAMETER_SET]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_REP_REPORT_PARAMETER_SET_TB_SEC_FOLDER]
	FOREIGN KEY ([FOLDER_ID]) REFERENCES [dbo].[TB_SEC_FOLDER] ([FOLDER_ID])
	ON DELETE CASCADE
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_REP_PARAMETER_SET]
	CHECK CONSTRAINT [FK_TB_REP_REPORT_PARAMETER_SET_TB_SEC_FOLDER]

GO
ALTER TABLE [dbo].[TB_REP_PARAMETER_SET]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_REP_PARAMETER_SET_TB_SEC_USER]
	FOREIGN KEY ([USER_ID]) REFERENCES [dbo].[TB_SEC_USER] ([USER_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_REP_PARAMETER_SET]
	CHECK CONSTRAINT [FK_TB_REP_PARAMETER_SET_TB_SEC_USER]

GO
CREATE NONCLUSTERED INDEX [IX_TB_REP_PARAMETER_SET_ITEM_TYPE_ID]
	ON [dbo].[TB_REP_PARAMETER_SET] ([ITEM_TYPE_ID])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_TB_REP_PARAMETER_SET_LINKED_PARAMETER_SET_ID]
	ON [dbo].[TB_REP_PARAMETER_SET] ([LINKED_PARAMETER_SET_ID])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_TB_REP_PARAMETER_SET_USER_ID]
	ON [dbo].[TB_REP_PARAMETER_SET] ([USER_ID])
	ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table holds information about all parameter sets created in the application.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_PARAMETER_SET', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Composite Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_PARAMETER_SET', 'COLUMN', N'PARAMETER_SET_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id from the same table correspoding to the parameter set linked to the current parameter set.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_PARAMETER_SET', 'COLUMN', N'LINKED_PARAMETER_SET_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id in TE_DIM_ITEM_TYPE corresponding to the type of the parameter set. For example, parameter set of type Agent, Agent Team, Call Type etc.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_PARAMETER_SET', 'COLUMN', N'ITEM_TYPE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id in TB_SEC_FOLDER corresponding to the place holder for the paramter set in the security tree.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_PARAMETER_SET', 'COLUMN', N'FOLDER_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the name for the paramter set.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_PARAMETER_SET', 'COLUMN', N'NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The is a regular expression string corresponding to the values in the parameter set.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_PARAMETER_SET', 'COLUMN', N'PARAMETERS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is flag indicating whether the parameter set is set for archive or not. Value of 1 indicates archived.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_PARAMETER_SET', 'COLUMN', N'ARCHIVED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is flag indicating whether the parameter set is enabled or not. Value of 1 indicates enabled.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_PARAMETER_SET', 'COLUMN', N'ENABLED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is flag indicating whether the parameter set is hidden or not. Value of 1 indicates hidden.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_PARAMETER_SET', 'COLUMN', N'HIDDEN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is flag indicating whether the parameter set is owned by the system or not. Value of 1 indicates system owned parameter set.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_PARAMETER_SET', 'COLUMN', N'SYSTEM'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the user whos security context is used to execute the parameter set.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_PARAMETER_SET', 'COLUMN', N'USER_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_PARAMETER_SET', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_REP_PARAMETER_SET]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_REP_PARAMETER_SET]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_REP_PARAMETER_SET]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_REP_PARAMETER_SET]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_REP_PARAMETER_SET]
	TO [portalrs_role]
GO
ALTER TABLE [dbo].[TB_REP_PARAMETER_SET] SET (LOCK_ESCALATION = TABLE)
GO
