SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TS_FCT_AUDIT_ARCHIVE_HOLDER] (
		[AUDIT_URN]                 [bigint] NOT NULL,
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
		[EVENT_OUTCOME]             [char](1) COLLATE Latin1_General_CI_AS NULL,
		[EVENT_DURATION]            [float] NOT NULL,
		[FIELD_CHANGE_XML_DATA]     [xml](DOCUMENT [dbo].[AuditFieldChangeCollection]) NULL,
		[XML_DATA]                  [xml](DOCUMENT [dbo].[ColumnCollection]) NULL,
		[INT_VAL_3]                 [int] NULL,
		[INT_VAL_4]                 [int] NULL,
		[msrepl_tran_version]       [uniqueidentifier] NOT NULL
) ON [FCTAUDGROUP] TEXTIMAGE_ON [FCTAUDGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table is used by the Audit Archive workflow as a minimally logged delete of large numbers of rows.', 'SCHEMA', N'dbo', 'TABLE', N'TS_FCT_AUDIT_ARCHIVE_HOLDER', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TS_FCT_AUDIT_ARCHIVE_HOLDER', 'COLUMN', N'AUDIT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id of the session during which the audit was generated. This is a foreign key to TB_ADM_SESSION table.', 'SCHEMA', N'dbo', 'TABLE', N'TS_FCT_AUDIT_ARCHIVE_HOLDER', 'COLUMN', N'SESSION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id of the type of audit. This is a foreign key to TE_ADM_AUDIT_TYPE table.', 'SCHEMA', N'dbo', 'TABLE', N'TS_FCT_AUDIT_ARCHIVE_HOLDER', 'COLUMN', N'AUDIT_TYPE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the UTC date time stamp corresponding to when the event occured.', 'SCHEMA', N'dbo', 'TABLE', N'TS_FCT_AUDIT_ARCHIVE_HOLDER', 'COLUMN', N'EVENT_UTC_DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the UTC date when the event occured. This is calculated based on EVENT_UTC_DATE_TIME.', 'SCHEMA', N'dbo', 'TABLE', N'TS_FCT_AUDIT_ARCHIVE_HOLDER', 'COLUMN', N'EVENT_UTC_DATE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the UTC time of UTC date when the event occured. This is calculated based on EVENT_UTC_DATE_TIME.', 'SCHEMA', N'dbo', 'TABLE', N'TS_FCT_AUDIT_ARCHIVE_HOLDER', 'COLUMN', N'EVENT_UTC_TIME_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a generic column to hold any integer value depending on the audit type. For example for dimension audits this will hold the business key of the dimension associated with the audit. For member audits this will hold the business key of the parent item of the membership.', 'SCHEMA', N'dbo', 'TABLE', N'TS_FCT_AUDIT_ARCHIVE_HOLDER', 'COLUMN', N'INT_VAL_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a generic column to hold any integer value depending on the audit type. For example for dimension audits this will usually be empty. But may have values for Type 2 changes in which case it may hold the value of the previous surrogate value. For member audits this will hold the business key of the child item of the membership.', 'SCHEMA', N'dbo', 'TABLE', N'TS_FCT_AUDIT_ARCHIVE_HOLDER', 'COLUMN', N'INT_VAL_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a generic column to hold any guid value depending on the audit type. For example for equipment based dimension or member audits this will usually be the Equipment Resource ID mapped to the table TB_CLU_RESOURCE. In case of security audits this will be the ID of the security operation mapped to the table TE_SEC_OPERATION. In case of hierarchy changes this will hold the ID of the hierarchy change mapped to TB_SCH_HIERARCHY_CHANGE.', 'SCHEMA', N'dbo', 'TABLE', N'TS_FCT_AUDIT_ARCHIVE_HOLDER', 'COLUMN', N'GUID_VAL_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a generic column to hold any guid value depending on the audit type. For example in case of security audits this will usually be the ID of the folder mapped to the table TB_SEC_FOLDER indicating the folder on which the security operation was executed.', 'SCHEMA', N'dbo', 'TABLE', N'TS_FCT_AUDIT_ARCHIVE_HOLDER', 'COLUMN', N'GUID_VAL_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the RESOURCE_ID as in TB_ADM_STRING_RESOURCE. This is the internationalisation key for the audit description.', 'SCHEMA', N'dbo', 'TABLE', N'TS_FCT_AUDIT_ARCHIVE_HOLDER', 'COLUMN', N'EVENT_DESCRIPTION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is any other description associated with the audit event that cannot be internationised.', 'SCHEMA', N'dbo', 'TABLE', N'TS_FCT_AUDIT_ARCHIVE_HOLDER', 'COLUMN', N'EVENT_RAW_DESCRIPTION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a charactor flag indicating the outcome of the event. Possible values are S: Success, F: Failure, N: Not applicable, U: Unknown.', 'SCHEMA', N'dbo', 'TABLE', N'TS_FCT_AUDIT_ARCHIVE_HOLDER', 'COLUMN', N'EVENT_OUTCOME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the duration of the event.', 'SCHEMA', N'dbo', 'TABLE', N'TS_FCT_AUDIT_ARCHIVE_HOLDER', 'COLUMN', N'EVENT_DURATION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column will usually hold a set of field changes associated with update audits. This will hold the name of the field that was updated along with the previous and the new value for the field.', 'SCHEMA', N'dbo', 'TABLE', N'TS_FCT_AUDIT_ARCHIVE_HOLDER', 'COLUMN', N'FIELD_CHANGE_XML_DATA'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This will be any other general data associated with the type of audit stored as xml.', 'SCHEMA', N'dbo', 'TABLE', N'TS_FCT_AUDIT_ARCHIVE_HOLDER', 'COLUMN', N'XML_DATA'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a generic column to hold any integer value depending on the audit type. For example for dimension and member audits will usually contain the type urn.', 'SCHEMA', N'dbo', 'TABLE', N'TS_FCT_AUDIT_ARCHIVE_HOLDER', 'COLUMN', N'INT_VAL_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a generic column to hold any integer value depending on the audit type. For example for dimension and member audits will usually contain the type urn.', 'SCHEMA', N'dbo', 'TABLE', N'TS_FCT_AUDIT_ARCHIVE_HOLDER', 'COLUMN', N'INT_VAL_4'
GO
ALTER TABLE [dbo].[TS_FCT_AUDIT_ARCHIVE_HOLDER] SET (LOCK_ESCALATION = TABLE)
GO
