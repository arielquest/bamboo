SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_ADM_GADGET_VERSION] (
		[ID]                      [uniqueidentifier] NOT NULL,
		[GADGET_ID]               [uniqueidentifier] NOT NULL,
		[MAJOR_VERSION]           [int] NOT NULL,
		[MINOR_VERSION]           [int] NULL,
		[BUILD_VERSION]           [int] NULL,
		[REVISION_NUMBER]         [int] NULL,
		[GADGET_VERSION]          AS (concat([MAJOR_VERSION],'.',isnull([MINOR_VERSION],(0)),'.',isnull([BUILD_VERSION],(0)),'.',isnull([REVISION_NUMBER],(0)))),
		[NAME]                    [nvarchar](100) COLLATE Latin1_General_CI_AS NOT NULL,
		[DESCRIPTION]             [nvarchar](500) COLLATE Latin1_General_CI_AS NULL,
		[FRAMEWORK_VERSION]       [smallint] NOT NULL,
		[DEFAULT_WIDTH]           [int] NOT NULL,
		[DEFAULT_HEIGHT]          [int] NOT NULL,
		[MIN_WIDTH]               [int] NULL,
		[MIN_HEIGHT]              [int] NULL,
		[MAX_WIDTH]               [int] NULL,
		[MAX_HEIGHT]              [int] NULL,
		[CREATED_BY_ID]           [uniqueidentifier] NOT NULL,
		[MODIFIED_BY_ID]          [uniqueidentifier] NOT NULL,
		[CREATION_DATE]           [datetime] NOT NULL,
		[MODIFIED_DATE]           [datetime] NOT NULL,
		[CHANGE_STAMP]            [int] NOT NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [UN_TB_ADM_GADGET_VERSION_ID_VERSION]
		UNIQUE
		NONCLUSTERED
		([GADGET_ID], [GADGET_VERSION])
		ON [ADMINDEXGROUP],
		CONSTRAINT [PK_TB_ADM_GADGET_VERSION]
		PRIMARY KEY
		CLUSTERED
		([ID])
	ON [ADMGROUP]
) ON [ADMGROUP]
GO
ALTER TABLE [dbo].[TB_ADM_GADGET_VERSION]
	ADD
	CONSTRAINT [DF_TB_ADM_GADGET_VERSION_ID]
	DEFAULT (newid()) FOR [ID]
GO
ALTER TABLE [dbo].[TB_ADM_GADGET_VERSION]
	ADD
	CONSTRAINT [DF_TB_ADM_GADGET_VERSION_FRAMEWORK_VERSION]
	DEFAULT ((1)) FOR [FRAMEWORK_VERSION]
GO
ALTER TABLE [dbo].[TB_ADM_GADGET_VERSION]
	ADD
	CONSTRAINT [DF_TB_ADM_GADGET_VERSION_DEFAULT_WIDTH]
	DEFAULT ((500)) FOR [DEFAULT_WIDTH]
GO
ALTER TABLE [dbo].[TB_ADM_GADGET_VERSION]
	ADD
	CONSTRAINT [DF_TB_ADM_GADGET_VERSION_DEFAULT_HEIGHT]
	DEFAULT ((450)) FOR [DEFAULT_HEIGHT]
GO
ALTER TABLE [dbo].[TB_ADM_GADGET_VERSION]
	ADD
	CONSTRAINT [DF_TB_ADM_GADGET_VERSION_CREATION_DATE]
	DEFAULT (getutcdate()) FOR [CREATION_DATE]
GO
ALTER TABLE [dbo].[TB_ADM_GADGET_VERSION]
	ADD
	CONSTRAINT [DF_TB_ADM_GADGET_VERSION_MODIFIED_DATE]
	DEFAULT (getutcdate()) FOR [MODIFIED_DATE]
GO
ALTER TABLE [dbo].[TB_ADM_GADGET_VERSION]
	ADD
	CONSTRAINT [DF_TB_ADM_GADGET_VERSION_CHANGE_STAMP]
	DEFAULT ((0)) FOR [CHANGE_STAMP]
GO
ALTER TABLE [dbo].[TB_ADM_GADGET_VERSION]
	ADD
	CONSTRAINT [DF_TB_ADM_GADGET_VERSION_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_ADM_GADGET_VERSION]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_ADM_GADGET_VERSION_TB_ADM_GADGET_ID]
	FOREIGN KEY ([GADGET_ID]) REFERENCES [dbo].[TB_ADM_GADGET] ([ID])
	ON DELETE CASCADE
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_ADM_GADGET_VERSION]
	CHECK CONSTRAINT [FK_TB_ADM_GADGET_VERSION_TB_ADM_GADGET_ID]

GO
EXEC sp_addextendedproperty N'MS_Description', N'This table contains version information for all deployed gadgets.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_GADGET_VERSION', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_GADGET_VERSION', 'COLUMN', N'ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key to TB_ADM_GADGET.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_GADGET_VERSION', 'COLUMN', N'GADGET_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Major version of this gadget.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_GADGET_VERSION', 'COLUMN', N'MAJOR_VERSION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Minor version number of this gadget.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_GADGET_VERSION', 'COLUMN', N'MINOR_VERSION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The build version number of this gadget.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_GADGET_VERSION', 'COLUMN', N'BUILD_VERSION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The revision number of this gadget.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_GADGET_VERSION', 'COLUMN', N'REVISION_NUMBER'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Computed 4-part version number, i.e. {MAJOR_VERSION}.{MINOR_VERSION}.{BUILD_VERSION}.{REVISION_NUMBER}, where NULLs are displayed as "0".', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_GADGET_VERSION', 'COLUMN', N'GADGET_VERSION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Name of the gadget version.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_GADGET_VERSION', 'COLUMN', N'NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The description of this gadget version.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_GADGET_VERSION', 'COLUMN', N'DESCRIPTION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'To allow simultaneous usage of either the Bootstrap 3 or Bootstrap 4 based frameworks.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_GADGET_VERSION', 'COLUMN', N'FRAMEWORK_VERSION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The default width (in pixels) of the gadget.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_GADGET_VERSION', 'COLUMN', N'DEFAULT_WIDTH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The default height (in pixels) of the gadget.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_GADGET_VERSION', 'COLUMN', N'DEFAULT_HEIGHT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The minimum width (in pixels) of the gadget.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_GADGET_VERSION', 'COLUMN', N'MIN_WIDTH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The minimum height (in pixels) of the gadget.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_GADGET_VERSION', 'COLUMN', N'MIN_HEIGHT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The maximum width (in pixels) of the gadget.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_GADGET_VERSION', 'COLUMN', N'MAX_WIDTH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The maximum height (in pixels) of the gadget.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_GADGET_VERSION', 'COLUMN', N'MAX_HEIGHT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TB_SEC_USER corresponding to the user who created the item.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_GADGET_VERSION', 'COLUMN', N'CREATED_BY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TB_SEC_USER corresponding to the user who last modified the item.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_GADGET_VERSION', 'COLUMN', N'MODIFIED_BY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the UTC date time stamp indicating when the item was created.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_GADGET_VERSION', 'COLUMN', N'CREATION_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the UTC date time stamp indicating when the item was last modified.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_GADGET_VERSION', 'COLUMN', N'MODIFIED_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is an incremental number indicating the change stamp for the specific item.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_GADGET_VERSION', 'COLUMN', N'CHANGE_STAMP'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_GADGET_VERSION', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_ADM_GADGET_VERSION]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_ADM_GADGET_VERSION]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_ADM_GADGET_VERSION]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_ADM_GADGET_VERSION]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_ADM_GADGET_VERSION] SET (LOCK_ESCALATION = TABLE)
GO
