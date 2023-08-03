SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_FCT_ETL_AUDIT_PROPERTY] (
		[PARTITION_URN]            [int] IDENTITY(0, 1) NOT FOR REPLICATION NOT NULL,
		[PARTITION_ID]             [int] NOT NULL,
		[PARTITION_GLOBAL_URN]     [bigint] NOT NULL,
		[UTC_DATE_TIME]            [datetime] NOT NULL,
		[ETL_AUDIT_URN]            [int] NOT NULL,
		[PROPERTY_NAME]            [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
		[PROPERTY_VALUE]           [nvarchar](100) COLLATE Latin1_General_CI_AS NOT NULL
) ON [FCTETLGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_FCT_ETL_AUDIT_PROPERTY_ETL_AUDIT_URN]
	ON [dbo].[TB_FCT_ETL_AUDIT_PROPERTY] ([ETL_AUDIT_URN])
	ON [FCTETLIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ETL_AUDIT_PROPERTY', 'INDEX', N'IX_FCT_ETL_AUDIT_PROPERTY_ETL_AUDIT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the template table to store generic name-value pairs for properties relating to an ETL audit event. This table is created as install time and the ETL service process creates various partition tables with the same schema. These partition tables are prefixed as TB_FCT_ETL_AUDIT_PROPERTY_ followed by the partition identifier. The partition identifier is created depending on the partition configuration, for example monthly, weekly etc. All currently active partitions are included VW_PARTITONED_FCT_ETL_AUDIT_PROPERTY view. Since the partitioned tables are generated at runtime and that they have the same schema no separate documentations are required for each partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ETL_AUDIT_PROPERTY', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'The identity column for the partition.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ETL_AUDIT_PROPERTY', 'COLUMN', N'PARTITION_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the unique number for the current partition table. This will be the same for all records in a single partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ETL_AUDIT_PROPERTY', 'COLUMN', N'PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a values that is globally unique accross all partition tables. This is calculated based on the PARTITION_URN and PARTITION_ID columns.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ETL_AUDIT_PROPERTY', 'COLUMN', N'PARTITION_GLOBAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the UTC datetime when the audit event was logged.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ETL_AUDIT_PROPERTY', 'COLUMN', N'UTC_DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to the PARTITION_URN in the partition table for TB_FCT_ETL_AUDIT with PARTITION_ID matching to PARTITION_ID of the current table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ETL_AUDIT_PROPERTY', 'COLUMN', N'ETL_AUDIT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the name of the property.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ETL_AUDIT_PROPERTY', 'COLUMN', N'PROPERTY_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the value for the property.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ETL_AUDIT_PROPERTY', 'COLUMN', N'PROPERTY_VALUE'
GO
GRANT SELECT
	ON [dbo].[TB_FCT_ETL_AUDIT_PROPERTY]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_FCT_ETL_AUDIT_PROPERTY]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_FCT_ETL_AUDIT_PROPERTY]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_FCT_ETL_AUDIT_PROPERTY] SET (LOCK_ESCALATION = TABLE)
GO
