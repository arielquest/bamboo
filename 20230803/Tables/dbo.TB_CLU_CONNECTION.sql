SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_CLU_CONNECTION] (
		[CONNECTION_ID]                    [uniqueidentifier] NOT NULL ROWGUIDCOL,
		[SOURCE_COMPONENT_ID]              [uniqueidentifier] NOT NULL,
		[SINK_COMPONENT_ID]                [uniqueidentifier] NOT NULL,
		[COST]                             [int] NOT NULL,
		[OVERRIDE_SINK_SERVER_ADDRESS]     [nvarchar](255) COLLATE Latin1_General_CI_AS NULL,
		[ENABLED]                          [bit] NOT NULL,
		[SYSTEM]                           [bit] NOT NULL,
		[CONNECTION_TYPE_ID]               [uniqueidentifier] NOT NULL,
		[XML_DATA]                         [xml](DOCUMENT [dbo].[ColumnCollection]) NULL,
		[msrepl_tran_version]              [uniqueidentifier] NOT NULL,
		CONSTRAINT [UN_TB_CLU_CONNECTION_SOURCE_SINK_COMPONENT_ID]
		UNIQUE
		NONCLUSTERED
		([SOURCE_COMPONENT_ID], [SINK_COMPONENT_ID])
		ON [ADMINDEXGROUP],
		CONSTRAINT [PK_TB_CLU_CONNECTION]
		PRIMARY KEY
		CLUSTERED
		([CONNECTION_ID])
	ON [ADMGROUP]
) ON [ADMGROUP] TEXTIMAGE_ON [ADMGROUP]
GO
ALTER TABLE [dbo].[TB_CLU_CONNECTION]
	ADD
	CONSTRAINT [DF_TB_CLU_CONNECTION_CONNECTION_ID]
	DEFAULT (newid()) FOR [CONNECTION_ID]
GO
ALTER TABLE [dbo].[TB_CLU_CONNECTION]
	ADD
	CONSTRAINT [DF_TB_CLU_CONNECTION_COST]
	DEFAULT ((0)) FOR [COST]
GO
ALTER TABLE [dbo].[TB_CLU_CONNECTION]
	ADD
	CONSTRAINT [DF_TB_CLU_CONNECTION_ENABLED]
	DEFAULT ((1)) FOR [ENABLED]
GO
ALTER TABLE [dbo].[TB_CLU_CONNECTION]
	ADD
	CONSTRAINT [DF_TB_CLU_CONNECTION_SYSTEM]
	DEFAULT ((0)) FOR [SYSTEM]
GO
ALTER TABLE [dbo].[TB_CLU_CONNECTION]
	ADD
	CONSTRAINT [DF_TB_CLU_CONNECTION_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_CLU_CONNECTION]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_CLU_CONNECTION_TB_CLU_RESOURCE_INSTANCE_COMPONENT_SINK]
	FOREIGN KEY ([SINK_COMPONENT_ID]) REFERENCES [dbo].[TB_CLU_RESOURCE_INSTANCE_COMPONENT] ([COMPONENT_ID])
	ON DELETE CASCADE
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_CLU_CONNECTION]
	CHECK CONSTRAINT [FK_TB_CLU_CONNECTION_TB_CLU_RESOURCE_INSTANCE_COMPONENT_SINK]

GO
ALTER TABLE [dbo].[TB_CLU_CONNECTION]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_CLU_CONNECTION_TB_CLU_RESOURCE_INSTANCE_COMPONENT_SOURCE]
	FOREIGN KEY ([SOURCE_COMPONENT_ID]) REFERENCES [dbo].[TB_CLU_RESOURCE_INSTANCE_COMPONENT] ([COMPONENT_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_CLU_CONNECTION]
	CHECK CONSTRAINT [FK_TB_CLU_CONNECTION_TB_CLU_RESOURCE_INSTANCE_COMPONENT_SOURCE]

GO
ALTER TABLE [dbo].[TB_CLU_CONNECTION]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_CLU_CONNECTION_TE_CLU_CONNECTION_TYPE]
	FOREIGN KEY ([CONNECTION_TYPE_ID]) REFERENCES [dbo].[TE_CLU_CONNECTION_TYPE] ([CONNECTION_TYPE_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_CLU_CONNECTION]
	CHECK CONSTRAINT [FK_TB_CLU_CONNECTION_TE_CLU_CONNECTION_TYPE]

GO
CREATE NONCLUSTERED INDEX [IX_TB_CLU_CONNECTION_CONNECTION_TYPE_ID]
	ON [dbo].[TB_CLU_CONNECTION] ([CONNECTION_TYPE_ID])
	ON [ADMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_CLU_CONNECTION_SINK_COMPONENT_ID]
	ON [dbo].[TB_CLU_CONNECTION] ([SINK_COMPONENT_ID])
	ON [ADMINDEXGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table holds the physical connection information between various physical resources configured under cluster management.', 'SCHEMA', N'dbo', 'TABLE', N'TB_CLU_CONNECTION', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_CLU_CONNECTION', 'COLUMN', N'CONNECTION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id of the physical resource component that is the source for the connection. This is a foreign key to TB_CLU_RESOURCE_INSTANCE_COMPONENT.', 'SCHEMA', N'dbo', 'TABLE', N'TB_CLU_CONNECTION', 'COLUMN', N'SOURCE_COMPONENT_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id of the physical resource component that is the sink or target for the connection. This is a foreign key to TB_CLU_RESOURCE_INSTANCE_COMPONENT.', 'SCHEMA', N'dbo', 'TABLE', N'TB_CLU_CONNECTION', 'COLUMN', N'SINK_COMPONENT_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a system defined cost associated with the connection.', 'SCHEMA', N'dbo', 'TABLE', N'TB_CLU_CONNECTION', 'COLUMN', N'COST'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the address of the physical server of the sink physical resource if it is not the same as the default address defined for its physical server. This is ideally used in case of network address translation.', 'SCHEMA', N'dbo', 'TABLE', N'TB_CLU_CONNECTION', 'COLUMN', N'OVERRIDE_SINK_SERVER_ADDRESS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the physical connection is enabled or not. Value of 1 indicates enabled.', 'SCHEMA', N'dbo', 'TABLE', N'TB_CLU_CONNECTION', 'COLUMN', N'ENABLED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the physical connection is owned by system or not. Value of 1 indicates system owned physical connection.', 'SCHEMA', N'dbo', 'TABLE', N'TB_CLU_CONNECTION', 'COLUMN', N'SYSTEM'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Type of this connection from TE_CLU_CONNECTION_TYPE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_CLU_CONNECTION', 'COLUMN', N'CONNECTION_TYPE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'XML data block for this item', 'SCHEMA', N'dbo', 'TABLE', N'TB_CLU_CONNECTION', 'COLUMN', N'XML_DATA'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_CLU_CONNECTION', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_CLU_CONNECTION]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_CLU_CONNECTION]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_CLU_CONNECTION]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_CLU_CONNECTION]
	TO [portalapp_role]
GO
GRANT DELETE
	ON [dbo].[TB_CLU_CONNECTION]
	TO [portal_database_configuration_role]
GO
GRANT INSERT
	ON [dbo].[TB_CLU_CONNECTION]
	TO [portal_database_configuration_role]
GO
GRANT SELECT
	ON [dbo].[TB_CLU_CONNECTION]
	TO [portal_database_configuration_role]
GO
GRANT UPDATE
	ON [dbo].[TB_CLU_CONNECTION]
	TO [portal_database_configuration_role]
GO
ALTER TABLE [dbo].[TB_CLU_CONNECTION] SET (LOCK_ESCALATION = TABLE)
GO
