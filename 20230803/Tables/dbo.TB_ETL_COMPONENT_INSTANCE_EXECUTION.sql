SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_ETL_COMPONENT_INSTANCE_EXECUTION] (
		[INSTANCE_EXECUTION_URN]          [int] IDENTITY(1, 4) NOT FOR REPLICATION NOT NULL,
		[INSTANCE_URN]                    [int] NOT NULL,
		[SECONDARY_SOURCE_CLUSTER_ID]     [uniqueidentifier] NULL,
		[MAX_SOURCE_DATETIME]             [datetime] NULL,
		[MAX_DESTINATION_DATETIME]        [datetime] NULL,
		[ROWS_PROCESSED]                  [int] NULL,
		[EXECUTION_START_DATETIME]        [datetime2](7) NOT NULL,
		[EXECUTION_END_DATETIME]          [datetime2](7) NOT NULL,
		[EXECUTION_DURATION_MS]           AS (datediff_big(millisecond,[EXECUTION_START_DATETIME],[EXECUTION_END_DATETIME])) PERSISTED,
		[msrepl_tran_version]             [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TB_ETL_COMPONENT_INSTANCE_EXECUTION]
		PRIMARY KEY
		CLUSTERED
		([INSTANCE_EXECUTION_URN])
	ON [ADMGROUP]
) ON [ADMGROUP]
GO
ALTER TABLE [dbo].[TB_ETL_COMPONENT_INSTANCE_EXECUTION]
	ADD
	CONSTRAINT [DF_TB_ETL_COMPONENT_INSTANCE_EXECUTION_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_ETL_COMPONENT_INSTANCE_EXECUTION]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_ETL_COMPONENT_INSTANCE_EXECUTION_TB_ETL_COMPONENT_INSTANCE_INSTANCE_URN]
	FOREIGN KEY ([INSTANCE_URN]) REFERENCES [dbo].[TB_ETL_COMPONENT_INSTANCE] ([INSTANCE_URN])
	ON DELETE CASCADE
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_ETL_COMPONENT_INSTANCE_EXECUTION]
	CHECK CONSTRAINT [FK_TB_ETL_COMPONENT_INSTANCE_EXECUTION_TB_ETL_COMPONENT_INSTANCE_INSTANCE_URN]

GO
ALTER TABLE [dbo].[TB_ETL_COMPONENT_INSTANCE_EXECUTION]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_ETL_COMPONENT_INSTANCE_EXECUTION_TB_CLU_RESOURCE_SECONDARY_SOURCE_CLUSTER_ID]
	FOREIGN KEY ([SECONDARY_SOURCE_CLUSTER_ID]) REFERENCES [dbo].[TB_CLU_RESOURCE] ([RESOURCE_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_ETL_COMPONENT_INSTANCE_EXECUTION]
	CHECK CONSTRAINT [FK_TB_ETL_COMPONENT_INSTANCE_EXECUTION_TB_CLU_RESOURCE_SECONDARY_SOURCE_CLUSTER_ID]

GO
EXEC sp_addextendedproperty N'MS_Description', N'This table contains information allowing for ETL monitoring', 'SCHEMA', N'dbo', 'TABLE', N'TB_ETL_COMPONENT_INSTANCE_EXECUTION', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ETL_COMPONENT_INSTANCE_EXECUTION', 'COLUMN', N'INSTANCE_EXECUTION_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_ETL_COMPONENT_INSTANCE indicating the ETL component instance for which this current instance status applies to', 'SCHEMA', N'dbo', 'TABLE', N'TB_ETL_COMPONENT_INSTANCE_EXECUTION', 'COLUMN', N'INSTANCE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is identifier of the logical resource as in TB_CLU_RESOURCE that corresponds to the source for which the component instance originally read from.  If NULL, refer to the CLUSTER_ID on TB_ETL_COMPONENT_INSTANCE', 'SCHEMA', N'dbo', 'TABLE', N'TB_ETL_COMPONENT_INSTANCE_EXECUTION', 'COLUMN', N'SECONDARY_SOURCE_CLUSTER_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the maximum written datetime on the source during this execution of the component instance.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ETL_COMPONENT_INSTANCE_EXECUTION', 'COLUMN', N'MAX_SOURCE_DATETIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the maximum written datetime on the destination during this execution of the component instance.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ETL_COMPONENT_INSTANCE_EXECUTION', 'COLUMN', N'MAX_DESTINATION_DATETIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number of rows processed during this execution of the component instance.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ETL_COMPONENT_INSTANCE_EXECUTION', 'COLUMN', N'ROWS_PROCESSED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the start datetime of this execution of the component instance.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ETL_COMPONENT_INSTANCE_EXECUTION', 'COLUMN', N'EXECUTION_START_DATETIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the end datetime of this execution of the component instance.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ETL_COMPONENT_INSTANCE_EXECUTION', 'COLUMN', N'EXECUTION_END_DATETIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This persisted computed column is the difference in milliseconds between the start datetime and the end datetime of this execution of the component instance.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ETL_COMPONENT_INSTANCE_EXECUTION', 'COLUMN', N'EXECUTION_DURATION_MS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ETL_COMPONENT_INSTANCE_EXECUTION', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_ETL_COMPONENT_INSTANCE_EXECUTION]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_ETL_COMPONENT_INSTANCE_EXECUTION]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_ETL_COMPONENT_INSTANCE_EXECUTION]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_ETL_COMPONENT_INSTANCE_EXECUTION]
	TO [portalapp_role]
GO
GRANT DELETE
	ON [dbo].[TB_ETL_COMPONENT_INSTANCE_EXECUTION]
	TO [portal_default_mediator_role]
GO
GRANT INSERT
	ON [dbo].[TB_ETL_COMPONENT_INSTANCE_EXECUTION]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_ETL_COMPONENT_INSTANCE_EXECUTION]
	TO [portal_default_mediator_role]
GO
GRANT UPDATE
	ON [dbo].[TB_ETL_COMPONENT_INSTANCE_EXECUTION]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_ETL_COMPONENT_INSTANCE_EXECUTION] SET (LOCK_ESCALATION = TABLE)
GO
