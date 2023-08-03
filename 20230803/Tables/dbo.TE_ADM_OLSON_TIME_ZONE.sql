SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TE_ADM_OLSON_TIME_ZONE] (
		[OLSON_TIME_ZONE_URN]     [int] NOT NULL,
		[TIME_ZONE_URN]           [int] NOT NULL,
		[NAME]                    [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[LOCATION]                [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[ABBREVIATION]            [nvarchar](10) COLLATE Latin1_General_CI_AS NOT NULL,
		[STANDARD_UTC_OFFSET]     [smallint] NOT NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [UN_TE_ADM_OLSON_TIME_ZONE_NAME]
		UNIQUE
		NONCLUSTERED
		([NAME])
		ON [ADMINDEXGROUP],
		CONSTRAINT [PK_TE_ADM_OLSON_TIME_ZONE]
		PRIMARY KEY
		CLUSTERED
		([OLSON_TIME_ZONE_URN])
	ON [ADMGROUP]
) ON [ADMGROUP]
GO
ALTER TABLE [dbo].[TE_ADM_OLSON_TIME_ZONE]
	ADD
	CONSTRAINT [DF_TE_ADM_OLSON_TIME_ZONE_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TE_ADM_OLSON_TIME_ZONE]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TE_ADM_OLSON_TIME_ZONE_TE_ADM_TIME_ZONE]
	FOREIGN KEY ([TIME_ZONE_URN]) REFERENCES [dbo].[TE_ADM_TIME_ZONE] ([TIME_ZONE_URN])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TE_ADM_OLSON_TIME_ZONE]
	CHECK CONSTRAINT [FK_TE_ADM_OLSON_TIME_ZONE_TE_ADM_TIME_ZONE]

GO
CREATE NONCLUSTERED INDEX [IX_TE_ADM_OLSON_TIME_ZONE_TIME_ZONE_URN]
	ON [dbo].[TE_ADM_OLSON_TIME_ZONE] ([TIME_ZONE_URN])
	ON [ADMGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table stores all the timzones available to the system. This table is pre-populated at install time.', 'SCHEMA', N'dbo', 'TABLE', N'TE_ADM_OLSON_TIME_ZONE', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TE_ADM_OLSON_TIME_ZONE', 'COLUMN', N'OLSON_TIME_ZONE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key reference to TE_ADM_TIME_ZONE.', 'SCHEMA', N'dbo', 'TABLE', N'TE_ADM_OLSON_TIME_ZONE', 'COLUMN', N'TIME_ZONE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This olson name of the time zone.', 'SCHEMA', N'dbo', 'TABLE', N'TE_ADM_OLSON_TIME_ZONE', 'COLUMN', N'NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The location of the time zone.', 'SCHEMA', N'dbo', 'TABLE', N'TE_ADM_OLSON_TIME_ZONE', 'COLUMN', N'LOCATION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the time zone abbreviation.', 'SCHEMA', N'dbo', 'TABLE', N'TE_ADM_OLSON_TIME_ZONE', 'COLUMN', N'ABBREVIATION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the time zone observes daylight savings.', 'SCHEMA', N'dbo', 'TABLE', N'TE_ADM_OLSON_TIME_ZONE', 'COLUMN', N'STANDARD_UTC_OFFSET'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TE_ADM_OLSON_TIME_ZONE', 'COLUMN', N'msrepl_tran_version'
GO
GRANT SELECT
	ON [dbo].[TE_ADM_OLSON_TIME_ZONE]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TE_ADM_OLSON_TIME_ZONE]
	TO [portalrs_role]
GO
ALTER TABLE [dbo].[TE_ADM_OLSON_TIME_ZONE] SET (LOCK_ESCALATION = TABLE)
GO
