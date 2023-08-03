SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_REP_REPORT] (
		[REPORT_ID]                    [uniqueidentifier] NOT NULL ROWGUIDCOL,
		[LINKED_REPORT_ID]             [uniqueidentifier] NULL,
		[FOLDER_ID]                    [uniqueidentifier] NOT NULL,
		[CONTENT_PATH]                 [nvarchar](501) COLLATE Latin1_General_CI_AS NULL,
		[TIME_DIVISION]                [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
		[FORMAT]                       [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
		[BASE_NAME]                    [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
		[NAME]                         [nvarchar](255) COLLATE Latin1_General_CI_AS NOT NULL,
		[REPORT_QUESTION]              [nvarchar](100) COLLATE Latin1_General_CI_AS NOT NULL,
		[DESCRIPTION]                  [nvarchar](500) COLLATE Latin1_General_CI_AS NOT NULL,
		[HELP_TEXT]                    [nvarchar](500) COLLATE Latin1_General_CI_AS NOT NULL,
		[CREATED_BY_ID]                [uniqueidentifier] NULL,
		[MODIFIED_BY_ID]               [uniqueidentifier] NULL,
		[CREATION_DATE]                [smalldatetime] NOT NULL,
		[MODIFIED_DATE]                [smalldatetime] NOT NULL,
		[IS_CHART]                     [bit] NOT NULL,
		[IS_VERTICAL]                  [bit] NOT NULL,
		[USE_MDX_BY_DEFAULT]           [bit] NOT NULL,
		[ARCHIVED]                     [bit] NOT NULL,
		[DELETED]                      [bit] NOT NULL,
		[ENABLED]                      [bit] NOT NULL,
		[HIDDEN]                       [bit] NOT NULL,
		[SYSTEM]                       [bit] NOT NULL,
		[TEMPLATE]                     [bit] NOT NULL,
		[IS_DESIGNABLE]                [bit] NOT NULL,
		[REFRESH_TYPE]                 [char](1) COLLATE Latin1_General_CI_AS NOT NULL,
		[REPORT_MODEL_ID]              [uniqueidentifier] NULL,
		[DRILLTHROUGH_LINK_TYPE_1]     [uniqueidentifier] NULL,
		[DRILLTHROUGH_LINK_TYPE_2]     [uniqueidentifier] NULL,
		[DRILLTHROUGH_LINK_TYPE_3]     [uniqueidentifier] NULL,
		[FORCE_SYNC]                   [char](1) COLLATE Latin1_General_CI_AS NOT NULL,
		[msrepl_tran_version]          [uniqueidentifier] NOT NULL,
		CONSTRAINT [UN_TB_REP_REPORT_FOLDER_ID_NAME]
		UNIQUE
		NONCLUSTERED
		([FOLDER_ID], [NAME])
		ON [PRIMARY],
		CONSTRAINT [PK_TB_REP_REPORT]
		PRIMARY KEY
		CLUSTERED
		([REPORT_ID])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TB_REP_REPORT]
	ADD
	CONSTRAINT [CK_TB_REP_REPORT_REFRESH_TYPE]
	CHECK
	([REFRESH_TYPE]=N'D' OR [REFRESH_TYPE]=N'R' OR [REFRESH_TYPE]=N'H')
GO
ALTER TABLE [dbo].[TB_REP_REPORT]
CHECK CONSTRAINT [CK_TB_REP_REPORT_REFRESH_TYPE]
GO
ALTER TABLE [dbo].[TB_REP_REPORT]
	ADD
	CONSTRAINT [CK_TB_REP_REPORT_FORCE_SYNC]
	CHECK
	([FORCE_SYNC]=N'U' OR [FORCE_SYNC]=N'R' OR [FORCE_SYNC]=N'N')
GO
ALTER TABLE [dbo].[TB_REP_REPORT]
CHECK CONSTRAINT [CK_TB_REP_REPORT_FORCE_SYNC]
GO
ALTER TABLE [dbo].[TB_REP_REPORT]
	ADD
	CONSTRAINT [DF_TB_REP_REPORT_REPORT_ID]
	DEFAULT (newid()) FOR [REPORT_ID]
GO
ALTER TABLE [dbo].[TB_REP_REPORT]
	ADD
	CONSTRAINT [DF_TB_REP_REPORT_REPORT_QUESTION]
	DEFAULT (N'') FOR [REPORT_QUESTION]
GO
ALTER TABLE [dbo].[TB_REP_REPORT]
	ADD
	CONSTRAINT [DF_TB_REP_REPORT_DESCRIPTION]
	DEFAULT (N'') FOR [DESCRIPTION]
GO
ALTER TABLE [dbo].[TB_REP_REPORT]
	ADD
	CONSTRAINT [DF_TB_REP_REPORT_HELP_TEXT]
	DEFAULT (N'') FOR [HELP_TEXT]
GO
ALTER TABLE [dbo].[TB_REP_REPORT]
	ADD
	CONSTRAINT [DF_TB_REP_REPORT_CREATION_DATE]
	DEFAULT (getutcdate()) FOR [CREATION_DATE]
GO
ALTER TABLE [dbo].[TB_REP_REPORT]
	ADD
	CONSTRAINT [DF_TB_REP_REPORT_MODIFIED_DATE]
	DEFAULT (getutcdate()) FOR [MODIFIED_DATE]
GO
ALTER TABLE [dbo].[TB_REP_REPORT]
	ADD
	CONSTRAINT [DF_TB_REP_REPORT_IS_CHART]
	DEFAULT ((0)) FOR [IS_CHART]
GO
ALTER TABLE [dbo].[TB_REP_REPORT]
	ADD
	CONSTRAINT [DF_TB_REP_REPORT_IS_VERTICAL]
	DEFAULT ((0)) FOR [IS_VERTICAL]
GO
ALTER TABLE [dbo].[TB_REP_REPORT]
	ADD
	CONSTRAINT [DF_TB_REP_REPORT_USE_MDX_BY_DEFAULT]
	DEFAULT ((0)) FOR [USE_MDX_BY_DEFAULT]
GO
ALTER TABLE [dbo].[TB_REP_REPORT]
	ADD
	CONSTRAINT [DF_TB_REP_REPORT_ARCHIVED]
	DEFAULT ((0)) FOR [ARCHIVED]
GO
ALTER TABLE [dbo].[TB_REP_REPORT]
	ADD
	CONSTRAINT [DF_TB_REP_REPORT_DELETED]
	DEFAULT ((0)) FOR [DELETED]
GO
ALTER TABLE [dbo].[TB_REP_REPORT]
	ADD
	CONSTRAINT [DF_TB_REP_REPORT_ENABLED]
	DEFAULT ((1)) FOR [ENABLED]
GO
ALTER TABLE [dbo].[TB_REP_REPORT]
	ADD
	CONSTRAINT [DF_TB_REP_REPORT_HIDDEN]
	DEFAULT ((0)) FOR [HIDDEN]
GO
ALTER TABLE [dbo].[TB_REP_REPORT]
	ADD
	CONSTRAINT [DF_TB_REP_REPORT_SYSTEM]
	DEFAULT ((0)) FOR [SYSTEM]
GO
ALTER TABLE [dbo].[TB_REP_REPORT]
	ADD
	CONSTRAINT [DF_TB_REP_REPORT_FORCE_SYNC]
	DEFAULT (N'N') FOR [FORCE_SYNC]
GO
ALTER TABLE [dbo].[TB_REP_REPORT]
	ADD
	CONSTRAINT [DF_TB_REP_REPORT_TEMPLATE]
	DEFAULT ((0)) FOR [TEMPLATE]
GO
ALTER TABLE [dbo].[TB_REP_REPORT]
	ADD
	CONSTRAINT [DF_TB_REP_REPORT_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_REP_REPORT]
	ADD
	CONSTRAINT [DF_TB_REP_REPORT_IS_DESIGNABLE]
	DEFAULT ((0)) FOR [IS_DESIGNABLE]
GO
ALTER TABLE [dbo].[TB_REP_REPORT]
	ADD
	CONSTRAINT [DF_TB_REP_REPORT_REFRESH_TYPE]
	DEFAULT (N'H') FOR [REFRESH_TYPE]
GO
ALTER TABLE [dbo].[TB_REP_REPORT]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_REP_REPORT_TB_REP_REPORT_LINKED_REPORT]
	FOREIGN KEY ([LINKED_REPORT_ID]) REFERENCES [dbo].[TB_REP_REPORT] ([REPORT_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_REP_REPORT]
	CHECK CONSTRAINT [FK_TB_REP_REPORT_TB_REP_REPORT_LINKED_REPORT]

GO
ALTER TABLE [dbo].[TB_REP_REPORT]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_REP_REPORT_TB_SEC_FOLDER]
	FOREIGN KEY ([FOLDER_ID]) REFERENCES [dbo].[TB_SEC_FOLDER] ([FOLDER_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_REP_REPORT]
	CHECK CONSTRAINT [FK_TB_REP_REPORT_TB_SEC_FOLDER]

GO
ALTER TABLE [dbo].[TB_REP_REPORT]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_REP_REPORT_TE_DIM_ITEM_TYPE_1]
	FOREIGN KEY ([DRILLTHROUGH_LINK_TYPE_1]) REFERENCES [dbo].[TE_DIM_ITEM_TYPE] ([ITEM_TYPE_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_REP_REPORT]
	CHECK CONSTRAINT [FK_TB_REP_REPORT_TE_DIM_ITEM_TYPE_1]

GO
ALTER TABLE [dbo].[TB_REP_REPORT]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_REP_REPORT_TE_DIM_ITEM_TYPE_2]
	FOREIGN KEY ([DRILLTHROUGH_LINK_TYPE_2]) REFERENCES [dbo].[TE_DIM_ITEM_TYPE] ([ITEM_TYPE_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_REP_REPORT]
	CHECK CONSTRAINT [FK_TB_REP_REPORT_TE_DIM_ITEM_TYPE_2]

GO
ALTER TABLE [dbo].[TB_REP_REPORT]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_REP_REPORT_TE_DIM_ITEM_TYPE_3]
	FOREIGN KEY ([DRILLTHROUGH_LINK_TYPE_3]) REFERENCES [dbo].[TE_DIM_ITEM_TYPE] ([ITEM_TYPE_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_REP_REPORT]
	CHECK CONSTRAINT [FK_TB_REP_REPORT_TE_DIM_ITEM_TYPE_3]

GO
ALTER TABLE [dbo].[TB_REP_REPORT]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_REP_REPORT_TB_REP_REPORT_MODEL]
	FOREIGN KEY ([REPORT_MODEL_ID]) REFERENCES [dbo].[TB_REP_REPORT_MODEL] ([REPORT_MODEL_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_REP_REPORT]
	CHECK CONSTRAINT [FK_TB_REP_REPORT_TB_REP_REPORT_MODEL]

GO
ALTER TABLE [dbo].[TB_REP_REPORT]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_REP_REPORT_MODEL_TB_SEC_USER_MODIFIED_BY_ID]
	FOREIGN KEY ([MODIFIED_BY_ID]) REFERENCES [dbo].[TB_SEC_USER] ([USER_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_REP_REPORT]
	CHECK CONSTRAINT [FK_TB_REP_REPORT_MODEL_TB_SEC_USER_MODIFIED_BY_ID]

GO
ALTER TABLE [dbo].[TB_REP_REPORT]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_REP_REPORT_MODEL_TB_SEC_USER_CREATED_BY_ID]
	FOREIGN KEY ([CREATED_BY_ID]) REFERENCES [dbo].[TB_SEC_USER] ([USER_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_REP_REPORT]
	CHECK CONSTRAINT [FK_TB_REP_REPORT_MODEL_TB_SEC_USER_CREATED_BY_ID]

GO
CREATE NONCLUSTERED INDEX [IX_TB_REP_REPORT_NAME]
	ON [dbo].[TB_REP_REPORT] ([NAME])
	ON [ADMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_REP_REPORT_CREATED_BY_ID]
	ON [dbo].[TB_REP_REPORT] ([CREATED_BY_ID])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_TB_REP_REPORT_DRILLTHROUGH_LINK_TYPE_1]
	ON [dbo].[TB_REP_REPORT] ([DRILLTHROUGH_LINK_TYPE_1])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_TB_REP_REPORT_DRILLTHROUGH_LINK_TYPE_2]
	ON [dbo].[TB_REP_REPORT] ([DRILLTHROUGH_LINK_TYPE_2])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_TB_REP_REPORT_DRILLTHROUGH_LINK_TYPE_3]
	ON [dbo].[TB_REP_REPORT] ([DRILLTHROUGH_LINK_TYPE_3])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_TB_REP_REPORT_LINKED_REPORT_ID]
	ON [dbo].[TB_REP_REPORT] ([LINKED_REPORT_ID])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_TB_REP_REPORT_MODIFIED_BY_ID]
	ON [dbo].[TB_REP_REPORT] ([MODIFIED_BY_ID])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_TB_REP_REPORT_REPORT_MODEL_ID]
	ON [dbo].[TB_REP_REPORT] ([REPORT_MODEL_ID])
	ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table holds information about all the reports create or uploaded in the application.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_REPORT', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_REPORT', 'COLUMN', N'REPORT_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id from the same table correspoding to the report linked to the current report.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_REPORT', 'COLUMN', N'LINKED_REPORT_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id from TB_SEC_FOLDER which is the place holder for the report in the security tree.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_REPORT', 'COLUMN', N'FOLDER_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the full path for the report in the security tree. This corresponds to the full path of the folder hierarchy as appears in the PATH column in TB_SEC_FOLDER upto the place holder folder for the report, plus the report name.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_REPORT', 'COLUMN', N'CONTENT_PATH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column is deprecated and will be removed from future versions.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_REPORT', 'COLUMN', N'TIME_DIVISION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column is deprecated and will be removed from future versions.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_REPORT', 'COLUMN', N'FORMAT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column is deprecated and will be removed from future versions.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_REPORT', 'COLUMN', N'BASE_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the name of the report.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_REPORT', 'COLUMN', N'NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a user friendly question for the report.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_REPORT', 'COLUMN', N'REPORT_QUESTION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a brief description for the report.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_REPORT', 'COLUMN', N'DESCRIPTION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column is deprecated and will be removed from future versions.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_REPORT', 'COLUMN', N'HELP_TEXT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TB_SEC_USER corresponding to the user who created the report.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_REPORT', 'COLUMN', N'CREATED_BY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TB_SEC_USER corresponding to the user who last modified the report.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_REPORT', 'COLUMN', N'MODIFIED_BY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is UTC date time stamp indicating when the report was created.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_REPORT', 'COLUMN', N'CREATION_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is UTC date time stamp indicating when the report was last modified.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_REPORT', 'COLUMN', N'MODIFIED_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is flag indicating whether the report is a chart or not. Value of 1 indicates chart.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_REPORT', 'COLUMN', N'IS_CHART'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column is deprecated and will be removed from future versions.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_REPORT', 'COLUMN', N'IS_VERTICAL'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column is deprecated and will be removed from future versions.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_REPORT', 'COLUMN', N'USE_MDX_BY_DEFAULT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the report is set for archive or not. Value of 1 indicates archived.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_REPORT', 'COLUMN', N'ARCHIVED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the report is deleted or not. Value of 1 indicates deleted.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_REPORT', 'COLUMN', N'DELETED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the report is enabled or not. Value of 1 indicates enabled.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_REPORT', 'COLUMN', N'ENABLED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_REPORT', 'COLUMN', N'HIDDEN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the report is owned by system or not. Value of 1 indicates system owned report.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_REPORT', 'COLUMN', N'SYSTEM'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the report is a template for other reports. Value of 1 indicates template.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_REPORT', 'COLUMN', N'TEMPLATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the report is designable or not. Value of 1 indicates designable. This is used for reports that are created using the report builder.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_REPORT', 'COLUMN', N'IS_DESIGNABLE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This a charactor flag indicating the renderer type used to draw the reports. H: Standard renderer, R: Enhanced renderer, D: determined at runtime.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_REPORT', 'COLUMN', N'REFRESH_TYPE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the ID as in TB_REP_REPORT_MODEL indicating the report model associated with the report.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_REPORT', 'COLUMN', N'REPORT_MODEL_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column is used to store parameter set types supported by a given report. Combined these types create a report signature which may be used for intelligent drillthrough functionality', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_REPORT', 'COLUMN', N'DRILLTHROUGH_LINK_TYPE_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column is used to store parameter set types supported by a given report. Combined these types create a report signature which may be used for intelligent drillthrough functionality', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_REPORT', 'COLUMN', N'DRILLTHROUGH_LINK_TYPE_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column is used to store parameter set types supported by a given report. Combined these types create a report signature which may be used for intelligent drillthrough functionality', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_REPORT', 'COLUMN', N'DRILLTHROUGH_LINK_TYPE_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This a character flag indicating which force sync operation has be performed against the report. U: Upload Only, R: Rebuild and Upload, N: No Action.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_REPORT', 'COLUMN', N'FORCE_SYNC'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_REPORT', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_REP_REPORT]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_REP_REPORT]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_REP_REPORT]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_REP_REPORT]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_REP_REPORT]
	TO [portalrs_role]
GO
ALTER TABLE [dbo].[TB_REP_REPORT] SET (LOCK_ESCALATION = TABLE)
GO
