SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_ADM_PROPERTY] (
		[PROPERTY_ID]             [uniqueidentifier] NOT NULL ROWGUIDCOL,
		[PROPERTY_KEY]            [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[PROPERTY_VALUE]          [nvarchar](max) COLLATE Latin1_General_CI_AS NULL,
		[MODIFIED_DATE]           [smalldatetime] NOT NULL,
		[SYSTEM]                  [bit] NOT NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [UN_TB_ADM_PROPERTY_PROPERTY_KEY]
		UNIQUE
		NONCLUSTERED
		([PROPERTY_KEY])
		ON [ADMINDEXGROUP],
		CONSTRAINT [PK_TB_ADM_PROPERTY]
		PRIMARY KEY
		CLUSTERED
		([PROPERTY_ID])
	ON [ADMGROUP]
) ON [ADMGROUP] TEXTIMAGE_ON [ADMGROUP]
GO
ALTER TABLE [dbo].[TB_ADM_PROPERTY]
	ADD
	CONSTRAINT [DF_TB_ADM_PROPERTY_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_ADM_PROPERTY]
	ADD
	CONSTRAINT [DF_TB_ADM_PROPERTY_PROPERTY_ID]
	DEFAULT (newid()) FOR [PROPERTY_ID]
GO
ALTER TABLE [dbo].[TB_ADM_PROPERTY]
	ADD
	CONSTRAINT [DF_TB_ADM_PROPERTY_MODIFIED_DATE]
	DEFAULT (getutcdate()) FOR [MODIFIED_DATE]
GO
ALTER TABLE [dbo].[TB_ADM_PROPERTY]
	ADD
	CONSTRAINT [DF_TB_ADM_PROPERTY_SYSTEM]
	DEFAULT ((0)) FOR [SYSTEM]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This tables holds various global property settings. The data in this table should not be modified for any reason.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_PROPERTY', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_PROPERTY', 'COLUMN', N'PROPERTY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the key for the property. This is unique. This value is set and modified by application should not be modified manually.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_PROPERTY', 'COLUMN', N'PROPERTY_KEY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field indicates the string value for the property if specified.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_PROPERTY', 'COLUMN', N'PROPERTY_VALUE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the utc datetime when the property was last modified.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_PROPERTY', 'COLUMN', N'MODIFIED_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the property is owned by system or not. Value of 1 indicates system owned property.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_PROPERTY', 'COLUMN', N'SYSTEM'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_PROPERTY', 'COLUMN', N'msrepl_tran_version'
GO
DENY DELETE
	ON [dbo].[TB_ADM_PROPERTY]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_ADM_PROPERTY]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_ADM_PROPERTY]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_ADM_PROPERTY]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_ADM_PROPERTY]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_ADM_PROPERTY]
	TO [portal_database_configuration_read_role]
GO
GRANT DELETE
	ON [dbo].[TB_ADM_PROPERTY]
	TO [portal_database_configuration_role]
GO
GRANT INSERT
	ON [dbo].[TB_ADM_PROPERTY]
	TO [portal_database_configuration_role]
GO
GRANT SELECT
	ON [dbo].[TB_ADM_PROPERTY]
	TO [portal_database_configuration_role]
GO
GRANT UPDATE
	ON [dbo].[TB_ADM_PROPERTY]
	TO [portal_database_configuration_role]
GO
ALTER TABLE [dbo].[TB_ADM_PROPERTY] SET (LOCK_ESCALATION = TABLE)
GO
