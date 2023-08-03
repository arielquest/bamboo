SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_ETL_TIDEMARK] (
		[TIDEMARK_ID]                       [uniqueidentifier] NOT NULL ROWGUIDCOL,
		[COMPONENT_ID]                      [uniqueidentifier] NOT NULL,
		[CLUSTER_RESOURCE_ID]               [uniqueidentifier] NOT NULL,
		[TIDEMARK_TYPE]                     [char](1) COLLATE Latin1_General_CI_AS NOT NULL,
		[TIDEMARK_NAME]                     [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[TIDEMARK_VALUE1]                   [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
		[TIDEMARK_VALUE2]                   [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
		[TIDEMARK_VALUE3]                   [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
		[TIDEMARK_VALUE4]                   [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
		[DATE_TIME]                         [datetime] NOT NULL,
		[MEDIATOR_RESOURCE_INSTANCE_ID]     [uniqueidentifier] NOT NULL,
		[msrepl_tran_version]               [uniqueidentifier] NOT NULL,
		CONSTRAINT [UN_TB_ETL_TIDEMARK]
		UNIQUE
		NONCLUSTERED
		([MEDIATOR_RESOURCE_INSTANCE_ID], [COMPONENT_ID], [CLUSTER_RESOURCE_ID], [TIDEMARK_TYPE], [TIDEMARK_NAME])
		ON [ADMINDEXGROUP],
		CONSTRAINT [PK_TB_ETL_TIDEMARK]
		PRIMARY KEY
		CLUSTERED
		([TIDEMARK_ID])
	ON [ADMGROUP]
) ON [ADMGROUP]
GO
ALTER TABLE [dbo].[TB_ETL_TIDEMARK]
	WITH NOCHECK
	ADD
	CONSTRAINT [CK_TB_ETL_TIDEMARK_TIDEMARK_TYPE]
	CHECK
	NOT FOR REPLICATION
	([TIDEMARK_TYPE]='W' OR [TIDEMARK_TYPE]='P')
GO
ALTER TABLE [dbo].[TB_ETL_TIDEMARK]
CHECK CONSTRAINT [CK_TB_ETL_TIDEMARK_TIDEMARK_TYPE]
GO
ALTER TABLE [dbo].[TB_ETL_TIDEMARK]
	ADD
	CONSTRAINT [DF_TB_ETL_TIDEMARK_TIDEMARK_ID]
	DEFAULT (newid()) FOR [TIDEMARK_ID]
GO
ALTER TABLE [dbo].[TB_ETL_TIDEMARK]
	ADD
	CONSTRAINT [DF_TB_ETL_TIDEMARK_DATE_TIME]
	DEFAULT (getutcdate()) FOR [DATE_TIME]
GO
ALTER TABLE [dbo].[TB_ETL_TIDEMARK]
	ADD
	CONSTRAINT [DF_TB_ETL_TIDEMARK_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_ETL_TIDEMARK]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_ETL_TIDEMARK_TB_CLU_RESOURCE]
	FOREIGN KEY ([CLUSTER_RESOURCE_ID]) REFERENCES [dbo].[TB_CLU_RESOURCE] ([RESOURCE_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_ETL_TIDEMARK]
	CHECK CONSTRAINT [FK_TB_ETL_TIDEMARK_TB_CLU_RESOURCE]

GO
ALTER TABLE [dbo].[TB_ETL_TIDEMARK]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_ETL_TIDEMARK_TB_ETL_COMPONENT]
	FOREIGN KEY ([COMPONENT_ID]) REFERENCES [dbo].[TB_ETL_COMPONENT] ([COMPONENT_ID])
	ON DELETE CASCADE
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_ETL_TIDEMARK]
	CHECK CONSTRAINT [FK_TB_ETL_TIDEMARK_TB_ETL_COMPONENT]

GO
ALTER TABLE [dbo].[TB_ETL_TIDEMARK]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_ETL_TIDEMARK_TB_CLU_RESOURCE_INSTANCE]
	FOREIGN KEY ([MEDIATOR_RESOURCE_INSTANCE_ID]) REFERENCES [dbo].[TB_CLU_RESOURCE_INSTANCE] ([RESOURCE_INSTANCE_ID])
	ON DELETE CASCADE
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_ETL_TIDEMARK]
	CHECK CONSTRAINT [FK_TB_ETL_TIDEMARK_TB_CLU_RESOURCE_INSTANCE]

GO
CREATE NONCLUSTERED INDEX [IX_TB_ETL_TIDEMARK_CLUSTER_RESOURCE_ID]
	ON [dbo].[TB_ETL_TIDEMARK] ([CLUSTER_RESOURCE_ID])
	ON [ADMGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_ETL_TIDEMARK_COMPONENT_ID]
	ON [dbo].[TB_ETL_TIDEMARK] ([COMPONENT_ID])
	ON [ADMGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table stores the generic tidemark information used by the ETL components.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ETL_TIDEMARK', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ETL_TIDEMARK', 'COLUMN', N'TIDEMARK_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the ID as in TB_ETL_COMPONENT indicating the component to which the tidemark applies to.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ETL_TIDEMARK', 'COLUMN', N'COMPONENT_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the ID as in TB_CLU_RESOURCE indicating the source resource associated with the tidemark.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ETL_TIDEMARK', 'COLUMN', N'CLUSTER_RESOURCE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a charactor flag indicating the type of the tidemark. Possible values are: P = Processed which is set by the reader ETL components, W = Written which is set by the writer ETL components', 'SCHEMA', N'dbo', 'TABLE', N'TB_ETL_TIDEMARK', 'COLUMN', N'TIDEMARK_TYPE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the name of the source table or file from which the data is imported. This is a unique name for a source equipment.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ETL_TIDEMARK', 'COLUMN', N'TIDEMARK_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The tidemark value.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ETL_TIDEMARK', 'COLUMN', N'TIDEMARK_VALUE1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The tidemark value.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ETL_TIDEMARK', 'COLUMN', N'TIDEMARK_VALUE2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The tidemark value.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ETL_TIDEMARK', 'COLUMN', N'TIDEMARK_VALUE3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The tidemark value.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ETL_TIDEMARK', 'COLUMN', N'TIDEMARK_VALUE4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the datetime when the tidemark was inserted or last updated by the ETL component.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ETL_TIDEMARK', 'COLUMN', N'DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The Mediator resource instance ID.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ETL_TIDEMARK', 'COLUMN', N'MEDIATOR_RESOURCE_INSTANCE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ETL_TIDEMARK', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_ETL_TIDEMARK]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_ETL_TIDEMARK]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_ETL_TIDEMARK]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_ETL_TIDEMARK]
	TO [portalapp_role]
GO
GRANT DELETE
	ON [dbo].[TB_ETL_TIDEMARK]
	TO [portal_default_mediator_role]
GO
GRANT INSERT
	ON [dbo].[TB_ETL_TIDEMARK]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_ETL_TIDEMARK]
	TO [portal_default_mediator_role]
GO
GRANT UPDATE
	ON [dbo].[TB_ETL_TIDEMARK]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_ETL_TIDEMARK] SET (LOCK_ESCALATION = TABLE)
GO
