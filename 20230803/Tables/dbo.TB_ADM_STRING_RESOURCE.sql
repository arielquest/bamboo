SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_ADM_STRING_RESOURCE] (
		[RESOURCE_ID]             [nvarchar](250) COLLATE Latin1_General_CI_AS NOT NULL,
		[CATEGORY]                [char](1) COLLATE Latin1_General_CI_AS NOT NULL,
		[CULTURE]                 [nvarchar](10) COLLATE Latin1_General_CI_AS NOT NULL,
		[DISPLAY_STRING]          [nvarchar](2000) COLLATE Latin1_General_CI_AS NOT NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TB_ADM_STRING_RESOURCE]
		PRIMARY KEY
		CLUSTERED
		([RESOURCE_ID], [CATEGORY], [CULTURE])
	ON [ADMGROUP]
) ON [ADMGROUP]
GO
ALTER TABLE [dbo].[TB_ADM_STRING_RESOURCE]
	ADD
	CONSTRAINT [DF_TB_ADM_STRING_RESOURCE_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table holds a repository of iternationlized string resource used in the application.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_STRING_RESOURCE', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Composite Primary key identifier. This is the search key string resource.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_STRING_RESOURCE', 'COLUMN', N'RESOURCE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Composite Primary key identifier. This is a charactor flag indicating the category of the string resource. For example D indicates Display Name', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_STRING_RESOURCE', 'COLUMN', N'CATEGORY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Composite Primary key identifier. This is a string representing the culture and locale of the string resource.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_STRING_RESOURCE', 'COLUMN', N'CULTURE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the display string for the composite key RESOURCE_ID, CATEGORY, CULTURE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_STRING_RESOURCE', 'COLUMN', N'DISPLAY_STRING'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_STRING_RESOURCE', 'COLUMN', N'msrepl_tran_version'
GO
DENY DELETE
	ON [dbo].[TB_ADM_STRING_RESOURCE]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_ADM_STRING_RESOURCE]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_ADM_STRING_RESOURCE]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_ADM_STRING_RESOURCE]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_ADM_STRING_RESOURCE] SET (LOCK_ESCALATION = TABLE)
GO
