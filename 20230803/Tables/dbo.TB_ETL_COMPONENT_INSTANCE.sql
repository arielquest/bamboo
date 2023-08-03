SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TB_ETL_COMPONENT_INSTANCE] (
		[INSTANCE_URN]                  [int] IDENTITY(1, 4) NOT FOR REPLICATION NOT NULL,
		[COMPONENT_ID]                  [uniqueidentifier] NOT NULL,
		[CLUSTER_ID]                    [uniqueidentifier] NOT NULL,
		[ENABLED]                       [bit] NOT NULL,
		[EXECUTION_UPDATE_INTERVAL]     [int] NULL,
		[LAST_EXECUTION_WRITTEN]        [datetime2](7) NOT NULL,
		[msrepl_tran_version]           [uniqueidentifier] NOT NULL,
		CONSTRAINT [UN_TB_ETL_COMPONENT_INSTANCE_COMPONENT_ID_CLUSTER_ID]
		UNIQUE
		NONCLUSTERED
		([COMPONENT_ID], [CLUSTER_ID])
		ON [ADMINDEXGROUP],
		CONSTRAINT [PK_TB_ETL_COMPONENT_INSTANCE]
		PRIMARY KEY
		CLUSTERED
		([INSTANCE_URN])
	ON [ADMGROUP]
) ON [ADMGROUP]
GO
ALTER TABLE [dbo].[TB_ETL_COMPONENT_INSTANCE]
	ADD
	CONSTRAINT [DF_TB_ETL_COMPONENT_INSTANCE_ENABLED]
	DEFAULT ((1)) FOR [ENABLED]
GO
ALTER TABLE [dbo].[TB_ETL_COMPONENT_INSTANCE]
	ADD
	CONSTRAINT [DF_TB_ETL_COMPONENT_INSTANCE_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_ETL_COMPONENT_INSTANCE]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_ETL_COMPONENT_INSTANCE_TB_ETL_COMPONENT_COMPONENT_ID]
	FOREIGN KEY ([COMPONENT_ID]) REFERENCES [dbo].[TB_ETL_COMPONENT] ([COMPONENT_ID])
	ON DELETE CASCADE
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_ETL_COMPONENT_INSTANCE]
	CHECK CONSTRAINT [FK_TB_ETL_COMPONENT_INSTANCE_TB_ETL_COMPONENT_COMPONENT_ID]

GO
ALTER TABLE [dbo].[TB_ETL_COMPONENT_INSTANCE]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_ETL_COMPONENT_INSTANCE_TB_CLU_RESOURCE_CLUSTER_ID]
	FOREIGN KEY ([CLUSTER_ID]) REFERENCES [dbo].[TB_CLU_RESOURCE] ([RESOURCE_ID])
	ON DELETE CASCADE
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_ETL_COMPONENT_INSTANCE]
	CHECK CONSTRAINT [FK_TB_ETL_COMPONENT_INSTANCE_TB_CLU_RESOURCE_CLUSTER_ID]

GO
EXEC sp_addextendedproperty N'MS_Description', N'This table contains information allowing for ETL monitoring', 'SCHEMA', N'dbo', 'TABLE', N'TB_ETL_COMPONENT_INSTANCE', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ETL_COMPONENT_INSTANCE', 'COLUMN', N'INSTANCE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the ID as in TB_ETL_COMPONENT indicating the ETL component for which the current instance applies to', 'SCHEMA', N'dbo', 'TABLE', N'TB_ETL_COMPONENT_INSTANCE', 'COLUMN', N'COMPONENT_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id of the logical resource as in TB_CLU_RESOURCE that corresponds to the source for which the component instance is reading from', 'SCHEMA', N'dbo', 'TABLE', N'TB_ETL_COMPONENT_INSTANCE', 'COLUMN', N'CLUSTER_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Flag indicating whether monitoring for the ETL component instance is enabled or not. If not enabled, the component will not produce monitoring records so will not appear in any reports', 'SCHEMA', N'dbo', 'TABLE', N'TB_ETL_COMPONENT_INSTANCE', 'COLUMN', N'ENABLED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Value indicating the interval for which the execution monitoring record must be written. This overwrites the global property, unless NULL in which case the global property is used', 'SCHEMA', N'dbo', 'TABLE', N'TB_ETL_COMPONENT_INSTANCE', 'COLUMN', N'EXECUTION_UPDATE_INTERVAL'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The datetime that the ETL component instance last executed. This is denormalised to allow for quick SELECT''ing of the current snapshot', 'SCHEMA', N'dbo', 'TABLE', N'TB_ETL_COMPONENT_INSTANCE', 'COLUMN', N'LAST_EXECUTION_WRITTEN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ETL_COMPONENT_INSTANCE', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_ETL_COMPONENT_INSTANCE]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_ETL_COMPONENT_INSTANCE]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_ETL_COMPONENT_INSTANCE]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_ETL_COMPONENT_INSTANCE]
	TO [portalapp_role]
GO
GRANT DELETE
	ON [dbo].[TB_ETL_COMPONENT_INSTANCE]
	TO [portal_default_mediator_role]
GO
GRANT INSERT
	ON [dbo].[TB_ETL_COMPONENT_INSTANCE]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_ETL_COMPONENT_INSTANCE]
	TO [portal_default_mediator_role]
GO
GRANT UPDATE
	ON [dbo].[TB_ETL_COMPONENT_INSTANCE]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_ETL_COMPONENT_INSTANCE] SET (LOCK_ESCALATION = TABLE)
GO
