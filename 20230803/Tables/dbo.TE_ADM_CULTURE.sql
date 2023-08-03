SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TE_ADM_CULTURE] (
		[CULTURE_URN]              [int] NOT NULL,
		[CULTURE_NAME]             [nvarchar](40) COLLATE Latin1_General_CI_AS NOT NULL,
		[CULTURE_LANGUAGE_URN]     [int] NOT NULL,
		[CULTURE_COUNTRY_URN]      [int] NOT NULL,
		[msrepl_tran_version]      [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TE_ADM_CULTURE]
		PRIMARY KEY
		CLUSTERED
		([CULTURE_URN])
	ON [ADMGROUP]
) ON [ADMGROUP]
GO
ALTER TABLE [dbo].[TE_ADM_CULTURE]
	ADD
	CONSTRAINT [DF_TE_ADM_CULTURE_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TE_ADM_CULTURE]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TE_ADM_CULTURE_TE_ADM_CULTURE_LANGUAGE_CULTURE_LANGUAGE_URN]
	FOREIGN KEY ([CULTURE_LANGUAGE_URN]) REFERENCES [dbo].[TE_ADM_CULTURE_LANGUAGE] ([LANGUAGE_URN])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TE_ADM_CULTURE]
	CHECK CONSTRAINT [FK_TE_ADM_CULTURE_TE_ADM_CULTURE_LANGUAGE_CULTURE_LANGUAGE_URN]

GO
ALTER TABLE [dbo].[TE_ADM_CULTURE]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TE_ADM_CULTURE_TE_ADM_CULTURE_COUNTRY_CULTURE_COUNTRY_URN]
	FOREIGN KEY ([CULTURE_COUNTRY_URN]) REFERENCES [dbo].[TE_ADM_CULTURE_COUNTRY] ([COUNTRY_URN])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TE_ADM_CULTURE]
	CHECK CONSTRAINT [FK_TE_ADM_CULTURE_TE_ADM_CULTURE_COUNTRY_CULTURE_COUNTRY_URN]

GO
CREATE NONCLUSTERED INDEX [IX_TE_ADM_CULTURE_CULTURE_LANGUAGE_URN]
	ON [dbo].[TE_ADM_CULTURE] ([CULTURE_LANGUAGE_URN])
	ON [ADMGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TE_ADM_CULTURE_CULTURE_COUNTRY_URN]
	ON [dbo].[TE_ADM_CULTURE] ([CULTURE_COUNTRY_URN])
	ON [ADMGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table contains culture information', 'SCHEMA', N'dbo', 'TABLE', N'TE_ADM_CULTURE', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'The primary key.', 'SCHEMA', N'dbo', 'TABLE', N'TE_ADM_CULTURE', 'COLUMN', N'CULTURE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The culture name in the format languagecode2-country/regioncode2. languagecode2 is a lowercase two-letter code derived from ISO 639-1. country/regioncode2 is derived from ISO 3166 and usually consists of two uppercase letters.', 'SCHEMA', N'dbo', 'TABLE', N'TE_ADM_CULTURE', 'COLUMN', N'CULTURE_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'A foreign key to the language of this culture in TE_ADM_LANGUAGE.', 'SCHEMA', N'dbo', 'TABLE', N'TE_ADM_CULTURE', 'COLUMN', N'CULTURE_LANGUAGE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'A foreign key to the country of this culture in TE_ADM_COUNTRY.', 'SCHEMA', N'dbo', 'TABLE', N'TE_ADM_CULTURE', 'COLUMN', N'CULTURE_COUNTRY_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TE_ADM_CULTURE', 'COLUMN', N'msrepl_tran_version'
GO
GRANT SELECT
	ON [dbo].[TE_ADM_CULTURE]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TE_ADM_CULTURE]
	TO [portalrs_role]
GO
ALTER TABLE [dbo].[TE_ADM_CULTURE] SET (LOCK_ESCALATION = TABLE)
GO
