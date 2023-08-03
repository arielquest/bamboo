SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_ADM_TIME_ZONE_CONFIG] (
		[TIME_ZONE_CONFIG_URN]         [int] NOT NULL,
		[TIME_ZONE_URN]                [int] NOT NULL,
		[OLAP_CUBE_DIMENSION_NAME]     [varchar](128) COLLATE Latin1_General_CI_AS NOT NULL,
		[IS_DEFAULT]                   [bit] NOT NULL,
		[CREATE_OLAP_AGGREGATION]      [bit] NOT NULL,
		[ENABLED]                      [int] NOT NULL,
		[msrepl_tran_version]          [uniqueidentifier] NOT NULL,
		CONSTRAINT [UQ_ADM_TIME_ZONE_URN_OLAP_CUBE_DIMENSION_NAME]
		UNIQUE
		NONCLUSTERED
		([TIME_ZONE_URN], [OLAP_CUBE_DIMENSION_NAME])
		ON [ADMINDEXGROUP],
		CONSTRAINT [PK_TB_ADM_TIME_ZONE_CONFIG]
		PRIMARY KEY
		CLUSTERED
		([TIME_ZONE_CONFIG_URN])
	ON [ADMGROUP]
) ON [ADMGROUP]
GO
ALTER TABLE [dbo].[TB_ADM_TIME_ZONE_CONFIG]
	ADD
	CONSTRAINT [DF_TB_ADM_TIME_ZONE_CONFIG_IS_DEFAULT]
	DEFAULT ((0)) FOR [IS_DEFAULT]
GO
ALTER TABLE [dbo].[TB_ADM_TIME_ZONE_CONFIG]
	ADD
	CONSTRAINT [DF_TB_ADM_TIME_ZONE_CONFIG_CREATE_OLAP_AGGREGATION]
	DEFAULT ((0)) FOR [CREATE_OLAP_AGGREGATION]
GO
ALTER TABLE [dbo].[TB_ADM_TIME_ZONE_CONFIG]
	ADD
	CONSTRAINT [DF_TB_ADM_TIME_ZONE_CONFIG_ENABLED]
	DEFAULT ((1)) FOR [ENABLED]
GO
ALTER TABLE [dbo].[TB_ADM_TIME_ZONE_CONFIG]
	ADD
	CONSTRAINT [DF_TB_ADM_TIME_ZONE_CONFIG_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_ADM_TIME_ZONE_CONFIG]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_ADM_TIME_ZONE_CONFIG_TE_ADM_TIME_ZONE]
	FOREIGN KEY ([TIME_ZONE_URN]) REFERENCES [dbo].[TE_ADM_TIME_ZONE] ([TIME_ZONE_URN])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_ADM_TIME_ZONE_CONFIG]
	CHECK CONSTRAINT [FK_TB_ADM_TIME_ZONE_CONFIG_TE_ADM_TIME_ZONE]

GO
EXEC sp_addextendedproperty N'MS_Description', N'This table holds information relating to mappings between Time Zones and OLAP Cube Dimension Names.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_TIME_ZONE_CONFIG', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_TIME_ZONE_CONFIG', 'COLUMN', N'TIME_ZONE_CONFIG_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field is the foreign key from the TB_ADM_TIME_ZONE that indicates the TIME_ZONE of the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_TIME_ZONE_CONFIG', 'COLUMN', N'TIME_ZONE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds the name of the cube dimension.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_TIME_ZONE_CONFIG', 'COLUMN', N'OLAP_CUBE_DIMENSION_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the Time Zone record is default value. If the timezone as selected by user during reporting does not exist in this table then this default (value of 1) would be considered.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_TIME_ZONE_CONFIG', 'COLUMN', N'IS_DEFAULT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This flag indicats whether Aggregations for the Time Zone in the OLAP database is to be created or not.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_TIME_ZONE_CONFIG', 'COLUMN', N'CREATE_OLAP_AGGREGATION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the Time Zone record is enabled or not. Value of 1 indicates enabled.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_TIME_ZONE_CONFIG', 'COLUMN', N'ENABLED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_TIME_ZONE_CONFIG', 'COLUMN', N'msrepl_tran_version'
GO
GRANT SELECT
	ON [dbo].[TB_ADM_TIME_ZONE_CONFIG]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_ADM_TIME_ZONE_CONFIG]
	TO [portal_database_configuration_read_role]
GO
GRANT DELETE
	ON [dbo].[TB_ADM_TIME_ZONE_CONFIG]
	TO [portal_database_configuration_role]
GO
GRANT INSERT
	ON [dbo].[TB_ADM_TIME_ZONE_CONFIG]
	TO [portal_database_configuration_role]
GO
GRANT SELECT
	ON [dbo].[TB_ADM_TIME_ZONE_CONFIG]
	TO [portal_database_configuration_role]
GO
GRANT UPDATE
	ON [dbo].[TB_ADM_TIME_ZONE_CONFIG]
	TO [portal_database_configuration_role]
GO
ALTER TABLE [dbo].[TB_ADM_TIME_ZONE_CONFIG] SET (LOCK_ESCALATION = TABLE)
GO
