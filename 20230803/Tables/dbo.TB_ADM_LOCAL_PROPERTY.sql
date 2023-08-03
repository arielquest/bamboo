SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_ADM_LOCAL_PROPERTY] (
		[PROPERTY_KEY]            [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[PROPERTY_VALUE]          [nvarchar](max) COLLATE Latin1_General_CI_AS NULL,
		[MODIFIED_DATE]           [smalldatetime] NOT NULL,
		[SYSTEM]                  [bit] NOT NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TB_ADM_LOCAL_PROPERTY]
		PRIMARY KEY
		CLUSTERED
		([PROPERTY_KEY])
	ON [ADMGROUP]
) ON [ADMGROUP] TEXTIMAGE_ON [ADMGROUP]
GO
ALTER TABLE [dbo].[TB_ADM_LOCAL_PROPERTY]
	ADD
	CONSTRAINT [DF_TB_ADM_LOCAL_PROPERTY_MODIFIED_DATE]
	DEFAULT (getutcdate()) FOR [MODIFIED_DATE]
GO
ALTER TABLE [dbo].[TB_ADM_LOCAL_PROPERTY]
	ADD
	CONSTRAINT [DF_TB_ADM_LOCAL_PROPERTY_SYSTEM]
	DEFAULT ((0)) FOR [SYSTEM]
GO
ALTER TABLE [dbo].[TB_ADM_LOCAL_PROPERTY]
	ADD
	CONSTRAINT [DF_TB_ADM_LOCAL_PROPERTY_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This tables holds various local property settings. This table is not replicated in case of a distributed database setup. The data in this table should not be modified for any reason.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_LOCAL_PROPERTY', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record. This is the key for the property. This value is set during install time and should not be modified.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_LOCAL_PROPERTY', 'COLUMN', N'PROPERTY_KEY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field indicates the string value for the property if specified.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_LOCAL_PROPERTY', 'COLUMN', N'PROPERTY_VALUE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the utc datetime when the property was last modified.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_LOCAL_PROPERTY', 'COLUMN', N'MODIFIED_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the property is owned by system or not. Value of 1 indicates system owned property.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_LOCAL_PROPERTY', 'COLUMN', N'SYSTEM'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier. This column is deprected and will be removed in future versions.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_LOCAL_PROPERTY', 'COLUMN', N'msrepl_tran_version'
GO
DENY DELETE
	ON [dbo].[TB_ADM_LOCAL_PROPERTY]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_ADM_LOCAL_PROPERTY]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_ADM_LOCAL_PROPERTY]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_ADM_LOCAL_PROPERTY]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_ADM_LOCAL_PROPERTY]
	TO [portal_database_configuration_read_role]
GO
GRANT DELETE
	ON [dbo].[TB_ADM_LOCAL_PROPERTY]
	TO [portal_database_configuration_role]
GO
GRANT INSERT
	ON [dbo].[TB_ADM_LOCAL_PROPERTY]
	TO [portal_database_configuration_role]
GO
GRANT SELECT
	ON [dbo].[TB_ADM_LOCAL_PROPERTY]
	TO [portal_database_configuration_role]
GO
GRANT UPDATE
	ON [dbo].[TB_ADM_LOCAL_PROPERTY]
	TO [portal_database_configuration_role]
GO
ALTER TABLE [dbo].[TB_ADM_LOCAL_PROPERTY] SET (LOCK_ESCALATION = TABLE)
GO
