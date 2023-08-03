SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_REP_ANALYZER_MODEL] (
		[ANALYZER_MODEL_URN]      [int] IDENTITY(1, 4) NOT FOR REPLICATION NOT NULL,
		[NAME]                    [nvarchar](100) COLLATE Latin1_General_CI_AS NOT NULL,
		[DESCRIPTION]             [nvarchar](500) COLLATE Latin1_General_CI_AS NOT NULL,
		[ANALYZER_MODEL]          [xml] NOT NULL,
		[DELETED]                 [bit] NOT NULL,
		[SYSTEM]                  [bit] NOT NULL,
		[CREATED_BY_ID]           [uniqueidentifier] NOT NULL,
		[MODIFIED_BY_ID]          [uniqueidentifier] NOT NULL,
		[CREATION_DATE]           [datetime] NOT NULL,
		[MODIFIED_DATE]           [datetime] NOT NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TB_REP_ANALYZER_MODEL]
		PRIMARY KEY
		CLUSTERED
		([ANALYZER_MODEL_URN])
	ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[TB_REP_ANALYZER_MODEL]
	ADD
	CONSTRAINT [DF_TB_REP_ANALYZER_MODEL_DESCRIPTION]
	DEFAULT (N'') FOR [DESCRIPTION]
GO
ALTER TABLE [dbo].[TB_REP_ANALYZER_MODEL]
	ADD
	CONSTRAINT [DF_TB_REP_ANALYZER_MODEL_CREATION_DATE]
	DEFAULT (getutcdate()) FOR [CREATION_DATE]
GO
ALTER TABLE [dbo].[TB_REP_ANALYZER_MODEL]
	ADD
	CONSTRAINT [DF_TB_REP_ANALYZER_MODEL_MODIFIED_DATE]
	DEFAULT (getutcdate()) FOR [MODIFIED_DATE]
GO
ALTER TABLE [dbo].[TB_REP_ANALYZER_MODEL]
	ADD
	CONSTRAINT [DF_TB_REP_ANALYZER_MODEL_DELETED]
	DEFAULT ((0)) FOR [DELETED]
GO
ALTER TABLE [dbo].[TB_REP_ANALYZER_MODEL]
	ADD
	CONSTRAINT [DF_TB_REP_ANALYZER_MODEL_SYSTEM]
	DEFAULT ((0)) FOR [SYSTEM]
GO
ALTER TABLE [dbo].[TB_REP_ANALYZER_MODEL]
	ADD
	CONSTRAINT [DF_TB_REP_ANALYZER_MODEL_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table contains the Analyzer tool''s models (Measures, Dimensions, Axis) defined in XML.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_ANALYZER_MODEL', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier. Referenced by TB_REP_ANALYZER_VIEW', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_ANALYZER_MODEL', 'COLUMN', N'ANALYZER_MODEL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The name of the Analyzer Model.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_ANALYZER_MODEL', 'COLUMN', N'NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'A description of the Analyzer Model.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_ANALYZER_MODEL', 'COLUMN', N'DESCRIPTION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The Analyzer Model defined in XML.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_ANALYZER_MODEL', 'COLUMN', N'ANALYZER_MODEL'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Whether or not the Analyzer Model has been deleted.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_ANALYZER_MODEL', 'COLUMN', N'DELETED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Whether or not the Analyzer Model is owned by the system.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_ANALYZER_MODEL', 'COLUMN', N'SYSTEM'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the ID as in TB_SEC_USER indicating the user who created the analyzer model.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_ANALYZER_MODEL', 'COLUMN', N'CREATED_BY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the ID as in TB_SEC_USER indicating the user who last modified the analyzer model.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_ANALYZER_MODEL', 'COLUMN', N'MODIFIED_BY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the date and time when the analyzer model was created.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_ANALYZER_MODEL', 'COLUMN', N'CREATION_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the date and time when the analyzer model was last modified.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_ANALYZER_MODEL', 'COLUMN', N'MODIFIED_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_ANALYZER_MODEL', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_REP_ANALYZER_MODEL]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_REP_ANALYZER_MODEL]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_REP_ANALYZER_MODEL]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_REP_ANALYZER_MODEL]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_REP_ANALYZER_MODEL] SET (LOCK_ESCALATION = TABLE)
GO
