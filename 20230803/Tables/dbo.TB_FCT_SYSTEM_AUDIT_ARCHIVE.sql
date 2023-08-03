SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_FCT_SYSTEM_AUDIT_ARCHIVE] (
		[PARTITION_URN]             [int] NOT NULL,
		[PARTITION_ID]              [int] NOT NULL,
		[PARTITION_GLOBAL_URN]      [bigint] NOT NULL,
		[SESSION_ID]                [uniqueidentifier] NOT NULL,
		[AUDIT_TYPE_ID]             [uniqueidentifier] NOT NULL,
		[EVENT_UTC_DATE_TIME]       [datetime] NOT NULL,
		[EVENT_UTC_DATE_URN]        [int] NOT NULL,
		[EVENT_UTC_TIME_URN]        [int] NOT NULL,
		[INT_VAL_1]                 [int] NULL,
		[INT_VAL_2]                 [int] NULL,
		[GUID_VAL_1]                [uniqueidentifier] NULL,
		[GUID_VAL_2]                [uniqueidentifier] NULL,
		[EVENT_DESCRIPTION]         [nvarchar](500) COLLATE Latin1_General_CI_AS NOT NULL,
		[EVENT_RAW_DESCRIPTION]     [nvarchar](500) COLLATE Latin1_General_CI_AS NULL,
		[EVENT_OUTCOME]             [char](1) COLLATE Latin1_General_CI_AS NOT NULL,
		[EVENT_DURATION]            [float] NOT NULL,
		[FIELD_CHANGE_XML_DATA]     [xml](DOCUMENT [dbo].[AuditFieldChangeCollection]) NULL,
		[XML_DATA]                  [xml](DOCUMENT [dbo].[ColumnCollection]) NULL,
		[INT_VAL_3]                 [int] NULL,
		[INT_VAL_4]                 [int] NULL
) ON [FCTAUDGROUP] TEXTIMAGE_ON [FCTAUDGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_FCT_SYSTEM_AUDIT_ARCHIVE_INT_VAL_1_EXTENDED_1]
	ON [dbo].[TB_FCT_SYSTEM_AUDIT_ARCHIVE] ([INT_VAL_1], [EVENT_UTC_DATE_TIME], [AUDIT_TYPE_ID], [PARTITION_GLOBAL_URN])
	ON [FCTAUDIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SYSTEM_AUDIT_ARCHIVE', 'INDEX', N'IX_TB_FCT_SYSTEM_AUDIT_ARCHIVE_INT_VAL_1_EXTENDED_1'
GO
CREATE NONCLUSTERED INDEX [IX_TB_FCT_SYSTEM_AUDIT_ARCHIVE_INT_VAL_2_EXTENDED_1]
	ON [dbo].[TB_FCT_SYSTEM_AUDIT_ARCHIVE] ([INT_VAL_2], [EVENT_UTC_DATE_TIME], [AUDIT_TYPE_ID], [PARTITION_GLOBAL_URN], [INT_VAL_1], [SESSION_ID], [GUID_VAL_1], [GUID_VAL_2])
	INCLUDE ([EVENT_DESCRIPTION], [EVENT_OUTCOME])
	ON [FCTAUDIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SYSTEM_AUDIT_ARCHIVE', 'INDEX', N'IX_TB_FCT_SYSTEM_AUDIT_ARCHIVE_INT_VAL_2_EXTENDED_1'
GO
CREATE NONCLUSTERED INDEX [IX_TB_FCT_SYSTEM_AUDIT_ARCHIVE_INT_VALS]
	ON [dbo].[TB_FCT_SYSTEM_AUDIT_ARCHIVE] ([INT_VAL_3], [INT_VAL_1], [INT_VAL_4], [INT_VAL_2], [EVENT_UTC_DATE_TIME])
	ON [FCTAUDIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SYSTEM_AUDIT_ARCHIVE', 'INDEX', N'IX_TB_FCT_SYSTEM_AUDIT_ARCHIVE_INT_VALS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the template table for the archived audit data. This table is created at install time and the partitioning service creates various partition tables with the same schema. These partition tables are prefixed as TB_FCT_SYSTEM_AUDIT_ARCHIVE_ARCHIVE_ followed by the partition identifier. The partition identifier is created depending on the importer configuration, for example monthly, weekly etc. The default partitioning is daily. All currently active partitions are included VW_PARTITONED_FCT_SYSTEM_AUDIT_ARCHIVE view. Since the partitioned tables are generated at runtime and that they have the same schema no separate documentations are required for each partition table. The data in the various partition tables are sourced from the table TB_FCT_SYSTEM_AUDIT.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SYSTEM_AUDIT_ARCHIVE', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SYSTEM_AUDIT_ARCHIVE', 'COLUMN', N'PARTITION_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number for the current partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SYSTEM_AUDIT_ARCHIVE', 'COLUMN', N'PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column holds a value that uniquely identifies a row across all the partition tables for this partition type.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SYSTEM_AUDIT_ARCHIVE', 'COLUMN', N'PARTITION_GLOBAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id of the session during which the audit was generated. This is a foreign key to TB_ADM_SESSION table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SYSTEM_AUDIT_ARCHIVE', 'COLUMN', N'SESSION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id of the type of audit. This is a foreign key to TE_ADM_AUDIT_TYPE table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SYSTEM_AUDIT_ARCHIVE', 'COLUMN', N'AUDIT_TYPE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the UTC date time stamp corresponding to when the event occured.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SYSTEM_AUDIT_ARCHIVE', 'COLUMN', N'EVENT_UTC_DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the UTC date when the event occured. This is calculated based on EVENT_UTC_DATE_TIME.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SYSTEM_AUDIT_ARCHIVE', 'COLUMN', N'EVENT_UTC_DATE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DATE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SYSTEM_AUDIT_ARCHIVE', 'COLUMN', N'EVENT_UTC_DATE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the UTC time of UTC date when the event occured. This is calculated based on EVENT_UTC_DATE_TIME.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SYSTEM_AUDIT_ARCHIVE', 'COLUMN', N'EVENT_UTC_TIME_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIME', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SYSTEM_AUDIT_ARCHIVE', 'COLUMN', N'EVENT_UTC_TIME_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a generic column to hold any integer value depending on the audit type. For example for dimension audits this will hold the business key of the dimension associated with the audit. For member audits this will hold the business key of the parent item of the membership.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SYSTEM_AUDIT_ARCHIVE', 'COLUMN', N'INT_VAL_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a generic column to hold any integer value depending on the audit type. For example for dimension audits this will usually be empty. But may have values for Type 2 changes in which case it may hold the value of the previous surrogate value. For member audits this will hold the business key of the child item of the membership.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SYSTEM_AUDIT_ARCHIVE', 'COLUMN', N'INT_VAL_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a generic column to hold any guid value depending on the audit type. For example for equipment based dimension or member audits this will usually be the Equipment Resource ID mapped to the table TB_CLU_RESOURCE. In case of security audits this will be the ID of the security operation mapped to the table TE_SEC_OPERATION. In case of hierarchy changes this will hold the ID of the hierarchy change mapped to TB_SCH_HIERARCHY_CHANGE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SYSTEM_AUDIT_ARCHIVE', 'COLUMN', N'GUID_VAL_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a generic column to hold any guid value depending on the audit type. For example in case of security audits this will usually be the ID of the folder mapped to the table TB_SEC_FOLDER indicating the folder on which the security operation was executed.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SYSTEM_AUDIT_ARCHIVE', 'COLUMN', N'GUID_VAL_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the RESOURCE_ID as in TB_ADM_STRING_RESOURCE. This is the internationalisation key for the audit description.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SYSTEM_AUDIT_ARCHIVE', 'COLUMN', N'EVENT_DESCRIPTION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is any other description associated with the audit event that cannot be internationised.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SYSTEM_AUDIT_ARCHIVE', 'COLUMN', N'EVENT_RAW_DESCRIPTION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a charactor flag indicating the outcome of the event. Possible values are S: Success, F: Failure, N: Not applicable, U: Unknown.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SYSTEM_AUDIT_ARCHIVE', 'COLUMN', N'EVENT_OUTCOME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the duration of the event.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SYSTEM_AUDIT_ARCHIVE', 'COLUMN', N'EVENT_DURATION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column will usually hold a set of field changes associated with update audits. This will hold the name of the field that was updated along with the previous and the new value for the field.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SYSTEM_AUDIT_ARCHIVE', 'COLUMN', N'FIELD_CHANGE_XML_DATA'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This will be any other general data associated with the type of audit stored as xml.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SYSTEM_AUDIT_ARCHIVE', 'COLUMN', N'XML_DATA'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a generic column to hold any integer value depending on the audit type. For example for dimension and member audits will usually contain the type urn.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SYSTEM_AUDIT_ARCHIVE', 'COLUMN', N'INT_VAL_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a generic column to hold any integer value depending on the audit type. For example for dimension and member audits will usually contain the type urn.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_SYSTEM_AUDIT_ARCHIVE', 'COLUMN', N'INT_VAL_4'
GO
GRANT SELECT
	ON [dbo].[TB_FCT_SYSTEM_AUDIT_ARCHIVE]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_FCT_SYSTEM_AUDIT_ARCHIVE] SET (LOCK_ESCALATION = TABLE)
GO
