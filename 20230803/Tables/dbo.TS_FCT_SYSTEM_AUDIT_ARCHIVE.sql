SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TS_FCT_SYSTEM_AUDIT_ARCHIVE] (
		[AUDIT_URN]                 [bigint] NOT NULL,
		[SESSION_ID]                [uniqueidentifier] NOT NULL,
		[AUDIT_TYPE_ID]             [uniqueidentifier] NOT NULL,
		[EVENT_UTC_DATE_TIME]       [datetime] NOT NULL,
		[EVENT_UTC_DATE_URN]        [int] NOT NULL,
		[EVENT_UTC_TIME_URN]        [int] NOT NULL,
		[INT_VAL_1]                 [int] NULL,
		[INT_VAL_2]                 [int] NULL,
		[INT_VAL_3]                 [int] NULL,
		[INT_VAL_4]                 [int] NULL,
		[GUID_VAL_1]                [uniqueidentifier] NULL,
		[GUID_VAL_2]                [uniqueidentifier] NULL,
		[EVENT_DESCRIPTION]         [nvarchar](500) COLLATE Latin1_General_CI_AS NOT NULL,
		[EVENT_RAW_DESCRIPTION]     [nvarchar](500) COLLATE Latin1_General_CI_AS NULL,
		[EVENT_OUTCOME]             [char](1) COLLATE Latin1_General_CI_AS NOT NULL,
		[EVENT_DURATION]            [float] NOT NULL,
		[FIELD_CHANGE_XML_DATA]     [nvarchar](max) COLLATE Latin1_General_CI_AS NULL,
		[XML_DATA]                  [nvarchar](max) COLLATE Latin1_General_CI_AS NULL,
		[PARTITION_URN]             [int] NULL,
		[PARTITION_ID]              [int] NULL,
		[PARTITION_GLOBAL_URN]      [bigint] NULL
) ON [STGGROUP] TEXTIMAGE_ON [STGGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a staging table used during the process of archive audit data from TB_FCT_SYSTEM_AUDIT into archive partition schema.', 'SCHEMA', N'dbo', 'TABLE', N'TS_FCT_SYSTEM_AUDIT_ARCHIVE', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the corresponding column in the table TB_FCT_SYSTEM_AUDIT.', 'SCHEMA', N'dbo', 'TABLE', N'TS_FCT_SYSTEM_AUDIT_ARCHIVE', 'COLUMN', N'AUDIT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the corresponding column in the table TB_FCT_SYSTEM_AUDIT.', 'SCHEMA', N'dbo', 'TABLE', N'TS_FCT_SYSTEM_AUDIT_ARCHIVE', 'COLUMN', N'SESSION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the corresponding column in the table TB_FCT_SYSTEM_AUDIT.', 'SCHEMA', N'dbo', 'TABLE', N'TS_FCT_SYSTEM_AUDIT_ARCHIVE', 'COLUMN', N'AUDIT_TYPE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the corresponding column in the table TB_FCT_SYSTEM_AUDIT.', 'SCHEMA', N'dbo', 'TABLE', N'TS_FCT_SYSTEM_AUDIT_ARCHIVE', 'COLUMN', N'EVENT_UTC_DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the corresponding column in the table TB_FCT_SYSTEM_AUDIT.', 'SCHEMA', N'dbo', 'TABLE', N'TS_FCT_SYSTEM_AUDIT_ARCHIVE', 'COLUMN', N'EVENT_UTC_DATE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the corresponding column in the table TB_FCT_SYSTEM_AUDIT.', 'SCHEMA', N'dbo', 'TABLE', N'TS_FCT_SYSTEM_AUDIT_ARCHIVE', 'COLUMN', N'EVENT_UTC_TIME_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the corresponding column in the table TB_FCT_SYSTEM_AUDIT.', 'SCHEMA', N'dbo', 'TABLE', N'TS_FCT_SYSTEM_AUDIT_ARCHIVE', 'COLUMN', N'INT_VAL_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the corresponding column in the table TB_FCT_SYSTEM_AUDIT.', 'SCHEMA', N'dbo', 'TABLE', N'TS_FCT_SYSTEM_AUDIT_ARCHIVE', 'COLUMN', N'INT_VAL_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the corresponding column in the table TB_FCT_SYSTEM_AUDIT.', 'SCHEMA', N'dbo', 'TABLE', N'TS_FCT_SYSTEM_AUDIT_ARCHIVE', 'COLUMN', N'INT_VAL_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the corresponding column in the table TB_FCT_SYSTEM_AUDIT.', 'SCHEMA', N'dbo', 'TABLE', N'TS_FCT_SYSTEM_AUDIT_ARCHIVE', 'COLUMN', N'INT_VAL_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the corresponding column in the table TB_FCT_SYSTEM_AUDIT.', 'SCHEMA', N'dbo', 'TABLE', N'TS_FCT_SYSTEM_AUDIT_ARCHIVE', 'COLUMN', N'GUID_VAL_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the corresponding column in the table TB_FCT_SYSTEM_AUDIT.', 'SCHEMA', N'dbo', 'TABLE', N'TS_FCT_SYSTEM_AUDIT_ARCHIVE', 'COLUMN', N'GUID_VAL_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the corresponding column in the table TB_FCT_SYSTEM_AUDIT.', 'SCHEMA', N'dbo', 'TABLE', N'TS_FCT_SYSTEM_AUDIT_ARCHIVE', 'COLUMN', N'EVENT_DESCRIPTION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the corresponding column in the table TB_FCT_SYSTEM_AUDIT.', 'SCHEMA', N'dbo', 'TABLE', N'TS_FCT_SYSTEM_AUDIT_ARCHIVE', 'COLUMN', N'EVENT_RAW_DESCRIPTION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the corresponding column in the table TB_FCT_SYSTEM_AUDIT.', 'SCHEMA', N'dbo', 'TABLE', N'TS_FCT_SYSTEM_AUDIT_ARCHIVE', 'COLUMN', N'EVENT_OUTCOME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the corresponding column in the table TB_FCT_SYSTEM_AUDIT.', 'SCHEMA', N'dbo', 'TABLE', N'TS_FCT_SYSTEM_AUDIT_ARCHIVE', 'COLUMN', N'EVENT_DURATION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the corresponding column in the table TB_FCT_SYSTEM_AUDIT.', 'SCHEMA', N'dbo', 'TABLE', N'TS_FCT_SYSTEM_AUDIT_ARCHIVE', 'COLUMN', N'FIELD_CHANGE_XML_DATA'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column maps to the corresponding column in the table TB_FCT_SYSTEM_AUDIT.', 'SCHEMA', N'dbo', 'TABLE', N'TS_FCT_SYSTEM_AUDIT_ARCHIVE', 'COLUMN', N'XML_DATA'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to the PARTITION_URN column in the target partition table for TB_FCT_SYSTEM_AUDIT_ARCHIVE. This value is calculated based on the data in the staging table during the archive process.', 'SCHEMA', N'dbo', 'TABLE', N'TS_FCT_SYSTEM_AUDIT_ARCHIVE', 'COLUMN', N'PARTITION_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to the PARTITION_ID column in the target partition table for TB_FCT_SYSTEM_AUDIT_ARCHIVE. This value is calculated based on the data in the staging table during the archive process.', 'SCHEMA', N'dbo', 'TABLE', N'TS_FCT_SYSTEM_AUDIT_ARCHIVE', 'COLUMN', N'PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to the PARTITION_GLOBAL_URN column in the target partition table for TB_FCT_SYSTEM_AUDIT_ARCHIVE. This value is calculated based on the data in the staging table during the archive process.', 'SCHEMA', N'dbo', 'TABLE', N'TS_FCT_SYSTEM_AUDIT_ARCHIVE', 'COLUMN', N'PARTITION_GLOBAL_URN'
GO
GRANT DELETE
	ON [dbo].[TS_FCT_SYSTEM_AUDIT_ARCHIVE]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TS_FCT_SYSTEM_AUDIT_ARCHIVE]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TS_FCT_SYSTEM_AUDIT_ARCHIVE]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TS_FCT_SYSTEM_AUDIT_ARCHIVE]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TS_FCT_SYSTEM_AUDIT_ARCHIVE] SET (LOCK_ESCALATION = TABLE)
GO
