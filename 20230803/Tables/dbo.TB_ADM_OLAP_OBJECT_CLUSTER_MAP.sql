SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TB_ADM_OLAP_OBJECT_CLUSTER_MAP] (
		[OLAP_OBJECT_CLUSTER_MAP_URN]     [int] IDENTITY(1, 4) NOT FOR REPLICATION NOT NULL,
		[OLAP_OBJECT_URN]                 [int] NOT NULL,
		[OLAP_CLUSTER_RESOURCE_ID]        [uniqueidentifier] NOT NULL,
		[ENABLED]                         [int] NOT NULL,
		[TARGET_AGG_PERF_GAIN]            [int] NOT NULL,
		[RETAIN_DAYS]                     [int] NOT NULL,
		[msrepl_tran_version]             [uniqueidentifier] NOT NULL,
		CONSTRAINT [UN_TB_ADM_OLAP_OBJECT_CLUSTER_MAP]
		UNIQUE
		NONCLUSTERED
		([OLAP_OBJECT_URN], [OLAP_CLUSTER_RESOURCE_ID])
		ON [ADMINDEXGROUP],
		CONSTRAINT [PK_TB_ADM_OLAP_OBJECT_CLUSTER_MAP]
		PRIMARY KEY
		CLUSTERED
		([OLAP_OBJECT_CLUSTER_MAP_URN])
	ON [ADMGROUP]
) ON [ADMGROUP]
GO
ALTER TABLE [dbo].[TB_ADM_OLAP_OBJECT_CLUSTER_MAP]
	ADD
	CONSTRAINT [DF_TB_ADM_OLAP_OBJECT_CLUSTER_MAP_ENABLED]
	DEFAULT ((1)) FOR [ENABLED]
GO
ALTER TABLE [dbo].[TB_ADM_OLAP_OBJECT_CLUSTER_MAP]
	ADD
	CONSTRAINT [DF_TB_ADM_OLAP_OBJECT_CLUSTER_MAP_TARGET_AGG_PERF_GAIN]
	DEFAULT ((0)) FOR [TARGET_AGG_PERF_GAIN]
GO
ALTER TABLE [dbo].[TB_ADM_OLAP_OBJECT_CLUSTER_MAP]
	ADD
	CONSTRAINT [DF_TB_ADM_OLAP_OBJECT_CLUSTER_MAP_RETAIN_DAYS]
	DEFAULT ((900)) FOR [RETAIN_DAYS]
GO
ALTER TABLE [dbo].[TB_ADM_OLAP_OBJECT_CLUSTER_MAP]
	ADD
	CONSTRAINT [DF_TB_ADM_OLAP_OBJECT_CLUSTER_MAP_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_ADM_OLAP_OBJECT_CLUSTER_MAP]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_ADM_OLAP_OBJECT_CLUSTER_MAP_TB_ADM_OLAP_OBJECT]
	FOREIGN KEY ([OLAP_OBJECT_URN]) REFERENCES [dbo].[TB_ADM_OLAP_OBJECT] ([OLAP_OBJECT_URN])
	ON DELETE CASCADE
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_ADM_OLAP_OBJECT_CLUSTER_MAP]
	CHECK CONSTRAINT [FK_TB_ADM_OLAP_OBJECT_CLUSTER_MAP_TB_ADM_OLAP_OBJECT]

GO
CREATE NONCLUSTERED INDEX [IX_TB_ADM_OLAP_OBJECT_CLUSTER_MAP_OLAP_CLUSTER_RESOURCE_ID]
	ON [dbo].[TB_ADM_OLAP_OBJECT_CLUSTER_MAP] ([OLAP_CLUSTER_RESOURCE_ID])
	ON [ADMINDEXGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table holds information various analysis services database objects.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_OLAP_OBJECT_CLUSTER_MAP', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'The primary key for the mapping.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_OLAP_OBJECT_CLUSTER_MAP', 'COLUMN', N'OLAP_OBJECT_CLUSTER_MAP_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The olap object that belongs to the cluster.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_OLAP_OBJECT_CLUSTER_MAP', 'COLUMN', N'OLAP_OBJECT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The cluster resource that this olap object is mapped to.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_OLAP_OBJECT_CLUSTER_MAP', 'COLUMN', N'OLAP_CLUSTER_RESOURCE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the OLAP object is enabled or not on this cluster resource. Value of 1 indicates enabled.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_OLAP_OBJECT_CLUSTER_MAP', 'COLUMN', N'ENABLED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_OLAP_OBJECT_CLUSTER_MAP', 'COLUMN', N'TARGET_AGG_PERF_GAIN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This value represents the number of days for which the data in the OLAP objects need to be retained.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_OLAP_OBJECT_CLUSTER_MAP', 'COLUMN', N'RETAIN_DAYS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_OLAP_OBJECT_CLUSTER_MAP', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_ADM_OLAP_OBJECT_CLUSTER_MAP]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_ADM_OLAP_OBJECT_CLUSTER_MAP]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_ADM_OLAP_OBJECT_CLUSTER_MAP]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_ADM_OLAP_OBJECT_CLUSTER_MAP]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_ADM_OLAP_OBJECT_CLUSTER_MAP]
	TO [portal_database_configuration_read_role]
GO
GRANT DELETE
	ON [dbo].[TB_ADM_OLAP_OBJECT_CLUSTER_MAP]
	TO [portal_database_configuration_role]
GO
GRANT INSERT
	ON [dbo].[TB_ADM_OLAP_OBJECT_CLUSTER_MAP]
	TO [portal_database_configuration_role]
GO
GRANT SELECT
	ON [dbo].[TB_ADM_OLAP_OBJECT_CLUSTER_MAP]
	TO [portal_database_configuration_role]
GO
GRANT UPDATE
	ON [dbo].[TB_ADM_OLAP_OBJECT_CLUSTER_MAP]
	TO [portal_database_configuration_role]
GO
ALTER TABLE [dbo].[TB_ADM_OLAP_OBJECT_CLUSTER_MAP] SET (LOCK_ESCALATION = TABLE)
GO
