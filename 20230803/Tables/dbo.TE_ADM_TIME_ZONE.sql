SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TE_ADM_TIME_ZONE] (
		[TIME_ZONE_URN]              [int] NOT NULL,
		[STANDARD_NAME]              [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[DAYLIGHT_NAME]              [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[DISPLAY_NAME]               [nvarchar](100) COLLATE Latin1_General_CI_AS NOT NULL,
		[OBSERVES_DAYLIGHT]          [bit] NOT NULL,
		[STANDARD_UTC_OFFSET]        [smallint] NOT NULL,
		[CALL_MANAGER_TYPE_ENUM]     [int] NULL,
		[DEPRECATED]                 [bit] NOT NULL,
		[msrepl_tran_version]        [uniqueidentifier] NOT NULL,
		CONSTRAINT [UN_TE_ADM_TIME_ZONE_STANDARD_NAME]
		UNIQUE
		NONCLUSTERED
		([STANDARD_NAME])
		ON [ADMINDEXGROUP],
		CONSTRAINT [PK_TE_ADM_TIME_ZONE]
		PRIMARY KEY
		CLUSTERED
		([TIME_ZONE_URN])
	ON [ADMGROUP]
) ON [ADMGROUP]
GO
ALTER TABLE [dbo].[TE_ADM_TIME_ZONE]
	ADD
	CONSTRAINT [DF_TE_ADM_TIME_ZONE_DEPRECATED]
	DEFAULT ((0)) FOR [DEPRECATED]
GO
ALTER TABLE [dbo].[TE_ADM_TIME_ZONE]
	ADD
	CONSTRAINT [DF_TE_ADM_TIME_ZONE_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table stores all the timzones available to the system. This table is pre-populated at install time.', 'SCHEMA', N'dbo', 'TABLE', N'TE_ADM_TIME_ZONE', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TE_ADM_TIME_ZONE', 'COLUMN', N'TIME_ZONE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the name of the time zone. (corresponds to windows name)', 'SCHEMA', N'dbo', 'TABLE', N'TE_ADM_TIME_ZONE', 'COLUMN', N'STANDARD_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the name of the time zone during daylight time.', 'SCHEMA', N'dbo', 'TABLE', N'TE_ADM_TIME_ZONE', 'COLUMN', N'DAYLIGHT_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the windows display name of the time zone.', 'SCHEMA', N'dbo', 'TABLE', N'TE_ADM_TIME_ZONE', 'COLUMN', N'DISPLAY_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the time zone observes daylight savings.', 'SCHEMA', N'dbo', 'TABLE', N'TE_ADM_TIME_ZONE', 'COLUMN', N'OBSERVES_DAYLIGHT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the time zone offset in minutes from utc time during standard time.', 'SCHEMA', N'dbo', 'TABLE', N'TE_ADM_TIME_ZONE', 'COLUMN', N'STANDARD_UTC_OFFSET'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the enum id that the call manager uses to represent this time zone in the typetimezone table.', 'SCHEMA', N'dbo', 'TABLE', N'TE_ADM_TIME_ZONE', 'COLUMN', N'CALL_MANAGER_TYPE_ENUM'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Indicates if the timezone is deprecated and is no longer an active timezone in Windows.', 'SCHEMA', N'dbo', 'TABLE', N'TE_ADM_TIME_ZONE', 'COLUMN', N'DEPRECATED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TE_ADM_TIME_ZONE', 'COLUMN', N'msrepl_tran_version'
GO
GRANT SELECT
	ON [dbo].[TE_ADM_TIME_ZONE]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TE_ADM_TIME_ZONE]
	TO [portalrs_role]
GO
GRANT SELECT
	ON [dbo].[TE_ADM_TIME_ZONE]
	TO [portal_database_configuration_read_role]
GO
GRANT DELETE
	ON [dbo].[TE_ADM_TIME_ZONE]
	TO [portal_database_configuration_role]
GO
GRANT INSERT
	ON [dbo].[TE_ADM_TIME_ZONE]
	TO [portal_database_configuration_role]
GO
GRANT SELECT
	ON [dbo].[TE_ADM_TIME_ZONE]
	TO [portal_database_configuration_role]
GO
GRANT UPDATE
	ON [dbo].[TE_ADM_TIME_ZONE]
	TO [portal_database_configuration_role]
GO
ALTER TABLE [dbo].[TE_ADM_TIME_ZONE] SET (LOCK_ESCALATION = TABLE)
GO
