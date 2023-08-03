SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TE_ADM_CULTURE_LANGUAGE] (
		[LANGUAGE_URN]            [int] NOT NULL,
		[NAME]                    [nvarchar](100) COLLATE Latin1_General_CI_AS NOT NULL,
		[TWO_LETTER_CODE]         [char](2) COLLATE Latin1_General_CI_AS NOT NULL,
		[THREE_LETTER_CODE]       [varchar](7) COLLATE Latin1_General_CI_AS NOT NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TE_ADM_CULTURE_LANGUAGE]
		PRIMARY KEY
		CLUSTERED
		([LANGUAGE_URN])
	ON [ADMGROUP]
) ON [ADMGROUP]
GO
ALTER TABLE [dbo].[TE_ADM_CULTURE_LANGUAGE]
	ADD
	CONSTRAINT [DF_TE_ADM_CULTURE_LANGUAGE_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
CREATE NONCLUSTERED INDEX [IX_TE_ADM_CULTURE_LANGUAGE_TWO_LETTER_CODE]
	ON [dbo].[TE_ADM_CULTURE_LANGUAGE] ([TWO_LETTER_CODE])
	ON [ADMGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TE_ADM_CULTURE_LANGUAGE_THREE_LETTER_CODE]
	ON [dbo].[TE_ADM_CULTURE_LANGUAGE] ([THREE_LETTER_CODE])
	ON [ADMGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table contains culture language information', 'SCHEMA', N'dbo', 'TABLE', N'TE_ADM_CULTURE_LANGUAGE', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'The primary key.', 'SCHEMA', N'dbo', 'TABLE', N'TE_ADM_CULTURE_LANGUAGE', 'COLUMN', N'LANGUAGE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The name of the language in English.', 'SCHEMA', N'dbo', 'TABLE', N'TE_ADM_CULTURE_LANGUAGE', 'COLUMN', N'NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The ISO 639-1 two-letter code for the language.', 'SCHEMA', N'dbo', 'TABLE', N'TE_ADM_CULTURE_LANGUAGE', 'COLUMN', N'TWO_LETTER_CODE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The ISO 639-2 three-letter code for the language.', 'SCHEMA', N'dbo', 'TABLE', N'TE_ADM_CULTURE_LANGUAGE', 'COLUMN', N'THREE_LETTER_CODE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TE_ADM_CULTURE_LANGUAGE', 'COLUMN', N'msrepl_tran_version'
GO
GRANT SELECT
	ON [dbo].[TE_ADM_CULTURE_LANGUAGE]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TE_ADM_CULTURE_LANGUAGE]
	TO [portalrs_role]
GO
ALTER TABLE [dbo].[TE_ADM_CULTURE_LANGUAGE] SET (LOCK_ESCALATION = TABLE)
GO
