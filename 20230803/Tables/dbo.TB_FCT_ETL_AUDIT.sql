SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_FCT_ETL_AUDIT] (
		[PARTITION_URN]                     [int] IDENTITY(0, 1) NOT FOR REPLICATION NOT NULL,
		[PARTITION_ID]                      [int] NOT NULL,
		[PARTITION_GLOBAL_URN]              [bigint] NOT NULL,
		[DATE_URN]                          [int] NOT NULL,
		[TIME_URN]                          [int] NOT NULL,
		[DATE_UTC_URN]                      [int] NOT NULL,
		[TIME_UTC_URN]                      [int] NOT NULL,
		[UTC_DATE_TIME]                     [datetime] NOT NULL,
		[TIMEZONE_OFFSET]                   [int] NOT NULL,
		[MEDIATOR_RESOURCE_INSTANCE_ID]     [uniqueidentifier] NULL,
		[AUDIT_TYPE_ID]                     [uniqueidentifier] NOT NULL,
		[SESSION_ID]                        [uniqueidentifier] NOT NULL,
		[COMPONENT_ID]                      [uniqueidentifier] NOT NULL,
		[SEQUENCE_NUMBER]                   [int] NOT NULL,
		[CLUSTER_RESOURCE_ID]               [uniqueidentifier] NULL,
		[DESCRIPTION]                       [nvarchar](200) COLLATE Latin1_General_CI_AS NULL,
		[RAW_DESCRIPTION]                   [nvarchar](200) COLLATE Latin1_General_CI_AS NULL,
		[DURATION]                          [int] NULL,
		[PROCESSED_ROW_COUNT]               [int] NULL,
		[ERROR_COUNT]                       [int] NULL,
		[HAS_PROPERTIES]                    [bit] NOT NULL,
		[RELATED_SESSION_ID]                [uniqueidentifier] NULL,
		[RELATED_SEQUENCE_NUMBER]           [int] NULL
) ON [FCTETLGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_FCT_ETL_AUDIT_UTC_DATE_TIME]
	ON [dbo].[TB_FCT_ETL_AUDIT] ([UTC_DATE_TIME])
	ON [FCTETLIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ETL_AUDIT', 'INDEX', N'IX_FCT_ETL_AUDIT_UTC_DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the template table to store audit information posted by all ETL components configured in the system. This table is created as install time and the ETL service process creates various partition tables with the same schema. These partition tables are prefixed as TB_FCT_ETL_AUDIT_ followed by the partition identifier. The partition identifier is created depending on the partition configuration, for example monthly, weekly etc. All currently active partitions are included VW_PARTITONED_FCT_ETL_AUDIT view. Since the partitioned tables are generated at runtime and that they have the same schema no separate documentations are required for each partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ETL_AUDIT', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'The identity column for the partition.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ETL_AUDIT', 'COLUMN', N'PARTITION_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the unique number for the current partition table. This will be the same for all records in a single partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ETL_AUDIT', 'COLUMN', N'PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a values that is globally unique accross all partition tables. This is calculated based on the PARTITION_URN and PARTITION_ID columns.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ETL_AUDIT', 'COLUMN', N'PARTITION_GLOBAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the wall clock date of the audit event.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ETL_AUDIT', 'COLUMN', N'DATE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DATE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ETL_AUDIT', 'COLUMN', N'DATE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the wall clock time of the audit event.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ETL_AUDIT', 'COLUMN', N'TIME_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIME', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ETL_AUDIT', 'COLUMN', N'TIME_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the wall UTC date of the audit event.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ETL_AUDIT', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DATE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ETL_AUDIT', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the wall UTC time of the audit event.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ETL_AUDIT', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIME', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ETL_AUDIT', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the UTC datetime when the audit event was logged.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ETL_AUDIT', 'COLUMN', N'UTC_DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the offset from UTC for the machine that logged the audit event.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ETL_AUDIT', 'COLUMN', N'TIMEZONE_OFFSET'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the ID as in TB_CLU_RESOURCE_INSTANCE corresponding to the instance of the mediator resource that created the audit.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ETL_AUDIT', 'COLUMN', N'MEDIATOR_RESOURCE_INSTANCE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the ID as in TE_ETL_AUDIT_TYPE corresponding to the type of the component audit.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ETL_AUDIT', 'COLUMN', N'AUDIT_TYPE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the ID as in TB_ADM_SESSION corresponding to the session during which the audit was logged.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ETL_AUDIT', 'COLUMN', N'SESSION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the ID as in TB_ETL_COMPONENT indicating the ETL component that logged the audit.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ETL_AUDIT', 'COLUMN', N'COMPONENT_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the cycle number of the ETL component during which the audit was logged.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ETL_AUDIT', 'COLUMN', N'SEQUENCE_NUMBER'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the ID as in TB_CLU_RESOURCE indicating the source equipment associated with the audit.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ETL_AUDIT', 'COLUMN', N'CLUSTER_RESOURCE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a globalized description key for the audit event. The key corresponds to that in TB_ADM_STRING_RESOURCE table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ETL_AUDIT', 'COLUMN', N'DESCRIPTION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is non-globalized description for the audit event.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ETL_AUDIT', 'COLUMN', N'RAW_DESCRIPTION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This the duration in seconds taken for any component to finish processing.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ETL_AUDIT', 'COLUMN', N'DURATION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number of rows processed during the component execution.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ETL_AUDIT', 'COLUMN', N'PROCESSED_ROW_COUNT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number of errors occured during the compnent execution.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ETL_AUDIT', 'COLUMN', N'ERROR_COUNT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the audit record has any properties associated with it in the corresponding audit properties partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ETL_AUDIT', 'COLUMN', N'HAS_PROPERTIES'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This the ID as in TB_ADM_SESSION indicating the session in which the currently processed data was created.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ETL_AUDIT', 'COLUMN', N'RELATED_SESSION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The sequence number in which the currently processed data was created.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ETL_AUDIT', 'COLUMN', N'RELATED_SEQUENCE_NUMBER'
GO
GRANT SELECT
	ON [dbo].[TB_FCT_ETL_AUDIT]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_FCT_ETL_AUDIT]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_FCT_ETL_AUDIT]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_FCT_ETL_AUDIT] SET (LOCK_ESCALATION = TABLE)
GO
