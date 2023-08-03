SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_REP_REPORT_MODEL] (
		[REPORT_MODEL_ID]               [uniqueidentifier] NOT NULL ROWGUIDCOL,
		[FOLDER_ID]                     [uniqueidentifier] NOT NULL,
		[NAME]                          [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[REPORT_MODEL]                  [varbinary](max) NOT NULL,
		[ENABLED]                       [bit] NOT NULL,
		[DELETED]                       [bit] NOT NULL,
		[HIDDEN]                        [bit] NOT NULL,
		[SYSTEM]                        [bit] NOT NULL,
		[CREATED_BY_ID]                 [uniqueidentifier] NULL,
		[MODIFIED_BY_ID]                [uniqueidentifier] NULL,
		[CREATION_DATE]                 [smalldatetime] NOT NULL,
		[MODIFIED_DATE]                 [smalldatetime] NOT NULL,
		[TIME_RANGE]                    [char](1) COLLATE Latin1_General_CI_AS NOT NULL,
		[DISPLAY_NAME_LOOKUP_VALUE]     [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[DESCRIPTION_LOOKUP_VALUE]      [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[msrepl_tran_version]           [uniqueidentifier] NOT NULL,
		CONSTRAINT [UN_TB_REP_REPORT_MODEL_NAME]
		UNIQUE
		NONCLUSTERED
		([NAME])
		ON [PRIMARY],
		CONSTRAINT [PK_TB_REP_REPORT_MODEL]
		PRIMARY KEY
		CLUSTERED
		([REPORT_MODEL_ID])
	ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[TB_REP_REPORT_MODEL]
	WITH NOCHECK
	ADD
	CONSTRAINT [CK_TB_REP_REPORT_MODEL_TIME_RANGE]
	CHECK
	NOT FOR REPLICATION
	([TIME_RANGE]=N'R' OR ([TIME_RANGE]=N'H' OR [TIME_RANGE]=N'U'))
GO
ALTER TABLE [dbo].[TB_REP_REPORT_MODEL]
CHECK CONSTRAINT [CK_TB_REP_REPORT_MODEL_TIME_RANGE]
GO
ALTER TABLE [dbo].[TB_REP_REPORT_MODEL]
	ADD
	CONSTRAINT [DF_TB_REP_REPORT_MODEL_REPORT_MODEL_ID]
	DEFAULT (newid()) FOR [REPORT_MODEL_ID]
GO
ALTER TABLE [dbo].[TB_REP_REPORT_MODEL]
	ADD
	CONSTRAINT [DF_TB_REP_REPORT_MODEL_ENABLED]
	DEFAULT ((1)) FOR [ENABLED]
GO
ALTER TABLE [dbo].[TB_REP_REPORT_MODEL]
	ADD
	CONSTRAINT [DF_TB_REP_REPORT_MODEL_DELETED]
	DEFAULT ((0)) FOR [DELETED]
GO
ALTER TABLE [dbo].[TB_REP_REPORT_MODEL]
	ADD
	CONSTRAINT [DF_TB_REP_REPORT_MODEL_HIDDEN]
	DEFAULT ((0)) FOR [HIDDEN]
GO
ALTER TABLE [dbo].[TB_REP_REPORT_MODEL]
	ADD
	CONSTRAINT [DF_TB_REP_REPORT_MODEL_SYSTEM]
	DEFAULT ((1)) FOR [SYSTEM]
GO
ALTER TABLE [dbo].[TB_REP_REPORT_MODEL]
	ADD
	CONSTRAINT [DF_TB_REP_REPORT_MODEL_CREATION_DATE]
	DEFAULT (getutcdate()) FOR [CREATION_DATE]
GO
ALTER TABLE [dbo].[TB_REP_REPORT_MODEL]
	ADD
	CONSTRAINT [DF_TB_REP_REPORT_MODEL_MODIFIED_DATE]
	DEFAULT (getutcdate()) FOR [MODIFIED_DATE]
GO
ALTER TABLE [dbo].[TB_REP_REPORT_MODEL]
	ADD
	CONSTRAINT [DF_TB_REP_REPORT_MODEL_TIME_RANGE]
	DEFAULT ('U') FOR [TIME_RANGE]
GO
ALTER TABLE [dbo].[TB_REP_REPORT_MODEL]
	ADD
	CONSTRAINT [DF_TB_REP_REPORT_MODEL_DISPLAY_NAME_LOOKUP_VALUE]
	DEFAULT (N'') FOR [DISPLAY_NAME_LOOKUP_VALUE]
GO
ALTER TABLE [dbo].[TB_REP_REPORT_MODEL]
	ADD
	CONSTRAINT [DF_TB_REP_REPORT_MODEL_DESCRIPTION_LOOKUP_VALUE]
	DEFAULT (N'') FOR [DESCRIPTION_LOOKUP_VALUE]
GO
ALTER TABLE [dbo].[TB_REP_REPORT_MODEL]
	ADD
	CONSTRAINT [DF_TB_REP_REPORT_MODEL_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_REP_REPORT_MODEL]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_REP_REPORT_MODEL_TB_SEC_FOLDER]
	FOREIGN KEY ([FOLDER_ID]) REFERENCES [dbo].[TB_SEC_FOLDER] ([FOLDER_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_REP_REPORT_MODEL]
	CHECK CONSTRAINT [FK_TB_REP_REPORT_MODEL_TB_SEC_FOLDER]

GO
CREATE NONCLUSTERED INDEX [IX_TB_REP_REPORT_MODEL_FOLDER_ID]
	ON [dbo].[TB_REP_REPORT_MODEL] ([FOLDER_ID])
	ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table holds all the report models for building reports', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_REPORT_MODEL', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_REPORT_MODEL', 'COLUMN', N'REPORT_MODEL_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the ID as in TB_SEC_FOLDER indicating the location of the model in the folder hierarchy.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_REPORT_MODEL', 'COLUMN', N'FOLDER_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the name for the report model. This is unique.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_REPORT_MODEL', 'COLUMN', N'NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the complete report model definition.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_REPORT_MODEL', 'COLUMN', N'REPORT_MODEL'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is flag indicating whether the report model is enabled for use or not.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_REPORT_MODEL', 'COLUMN', N'ENABLED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is flag indicating whether the report model is deleted or not.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_REPORT_MODEL', 'COLUMN', N'DELETED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is flag indicating whether the report model is hidden or not.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_REPORT_MODEL', 'COLUMN', N'HIDDEN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is flag indicating whether the report model is system internal or not.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_REPORT_MODEL', 'COLUMN', N'SYSTEM'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the ID as in TB_SEC_USER indicating the user who created the report model.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_REPORT_MODEL', 'COLUMN', N'CREATED_BY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the ID as in TB_SEC_USER indicating the user who last modified the report model.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_REPORT_MODEL', 'COLUMN', N'MODIFIED_BY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the date and time when the report model was created.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_REPORT_MODEL', 'COLUMN', N'CREATION_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the date and time when the report model was last modified.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_REPORT_MODEL', 'COLUMN', N'MODIFIED_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a charactor flag indicating the time range of associated with the report model. Possible values are R: Real Time, H: Historical, U: Unknown.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_REPORT_MODEL', 'COLUMN', N'TIME_RANGE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the Lookup Value (from TB_REP_STRING) which points to the localized version if the display name.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_REPORT_MODEL', 'COLUMN', N'DISPLAY_NAME_LOOKUP_VALUE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the Lookup Value (from TB_REP_STRING) which points to the localized version if the description.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_REPORT_MODEL', 'COLUMN', N'DESCRIPTION_LOOKUP_VALUE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_REPORT_MODEL', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_REP_REPORT_MODEL]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_REP_REPORT_MODEL]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_REP_REPORT_MODEL]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_REP_REPORT_MODEL]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_REP_REPORT_MODEL] SET (LOCK_ESCALATION = TABLE)
GO
