SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TE_ADM_CULTURE_COUNTRY] (
		[COUNTRY_URN]             [int] NOT NULL,
		[NAME]                    [nvarchar](100) COLLATE Latin1_General_CI_AS NOT NULL,
		[TWO_LETTER_CODE]         [char](2) COLLATE Latin1_General_CI_AS NOT NULL,
		[THREE_LETTER_CODE]       [char](3) COLLATE Latin1_General_CI_AS NOT NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TE_ADM_CULTURE_COUNTRY]
		PRIMARY KEY
		CLUSTERED
		([COUNTRY_URN])
	ON [ADMGROUP]
) ON [ADMGROUP]
GO
ALTER TABLE [dbo].[TE_ADM_CULTURE_COUNTRY]
	ADD
	CONSTRAINT [DF_TE_ADM_CULTURE_COUNTRY_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
CREATE NONCLUSTERED INDEX [IX_TE_ADM_CULTURE_COUNTRY_TWO_LETTER_CODE]
	ON [dbo].[TE_ADM_CULTURE_COUNTRY] ([TWO_LETTER_CODE])
	ON [ADMGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TE_ADM_CULTURE_COUNTRY_THREE_LETTER_CODE]
	ON [dbo].[TE_ADM_CULTURE_COUNTRY] ([THREE_LETTER_CODE])
	ON [ADMGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table contains culture country information', 'SCHEMA', N'dbo', 'TABLE', N'TE_ADM_CULTURE_COUNTRY', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'The primary key.', 'SCHEMA', N'dbo', 'TABLE', N'TE_ADM_CULTURE_COUNTRY', 'COLUMN', N'COUNTRY_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The name of the country in English.', 'SCHEMA', N'dbo', 'TABLE', N'TE_ADM_CULTURE_COUNTRY', 'COLUMN', N'NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The ISO 3166 two-letter code for the country.', 'SCHEMA', N'dbo', 'TABLE', N'TE_ADM_CULTURE_COUNTRY', 'COLUMN', N'TWO_LETTER_CODE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The ISO 3166 three-letter code for the country.', 'SCHEMA', N'dbo', 'TABLE', N'TE_ADM_CULTURE_COUNTRY', 'COLUMN', N'THREE_LETTER_CODE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TE_ADM_CULTURE_COUNTRY', 'COLUMN', N'msrepl_tran_version'
GO
GRANT SELECT
	ON [dbo].[TE_ADM_CULTURE_COUNTRY]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TE_ADM_CULTURE_COUNTRY]
	TO [portalrs_role]
GO
ALTER TABLE [dbo].[TE_ADM_CULTURE_COUNTRY] SET (LOCK_ESCALATION = TABLE)
GO
