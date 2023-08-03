SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_ADM_PII_OBJECT_FIELD_MAP] (
		[FIELD_MAP_URN]           [bigint] IDENTITY(1, 4) NOT FOR REPLICATION NOT NULL,
		[TABLE]                   [nvarchar](255) COLLATE Latin1_General_CI_AS NOT NULL,
		[OBJECT_TYPE]             [char](1) COLLATE Latin1_General_CI_AS NOT NULL,
		[FIELD]                   [nvarchar](255) COLLATE Latin1_General_CI_AS NOT NULL,
		[DISPLAY_NAME]            [nvarchar](512) COLLATE Latin1_General_CI_AS NOT NULL,
		[DESCRIPTION]             [nvarchar](max) COLLATE Latin1_General_CI_AS NULL,
		[GROUP_MASK]              [tinyint] NOT NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TB_ADM_PII_OBJECT_FIELD_MAP]
		PRIMARY KEY
		CLUSTERED
		([FIELD_MAP_URN])
	ON [ADMGROUP]
) ON [ADMGROUP] TEXTIMAGE_ON [ADMGROUP]
GO
ALTER TABLE [dbo].[TB_ADM_PII_OBJECT_FIELD_MAP]
	ADD
	CONSTRAINT [CK_TB_ADM_PII_OBJECT_FIELD_MAP_GROUP_MASK]
	CHECK
	([GROUP_MASK]>(0))
GO
ALTER TABLE [dbo].[TB_ADM_PII_OBJECT_FIELD_MAP]
CHECK CONSTRAINT [CK_TB_ADM_PII_OBJECT_FIELD_MAP_GROUP_MASK]
GO
ALTER TABLE [dbo].[TB_ADM_PII_OBJECT_FIELD_MAP]
	ADD
	CONSTRAINT [CK_TB_ADM_PII_OBJECT_FIELD_MAP_OBJECT_TYPE]
	CHECK
	([OBJECT_TYPE]='T' OR [OBJECT_TYPE]='P')
GO
ALTER TABLE [dbo].[TB_ADM_PII_OBJECT_FIELD_MAP]
CHECK CONSTRAINT [CK_TB_ADM_PII_OBJECT_FIELD_MAP_OBJECT_TYPE]
GO
ALTER TABLE [dbo].[TB_ADM_PII_OBJECT_FIELD_MAP]
	ADD
	CONSTRAINT [DF_TB_ADM_PII_OBJECT_FIELD_MAP_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
CREATE UNIQUE NONCLUSTERED INDEX [UN_TB_ADM_PII_OBJECT_FIELD_MAP_TABLE_FIELD]
	ON [dbo].[TB_ADM_PII_OBJECT_FIELD_MAP] ([TABLE], [FIELD])
	ON [ADMINDEXGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table maps database objects with their PII objects. This table is read-only.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_PII_OBJECT_FIELD_MAP', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record. This is an auto generated number.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_PII_OBJECT_FIELD_MAP', 'COLUMN', N'FIELD_MAP_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The name of the table or partition.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_PII_OBJECT_FIELD_MAP', 'COLUMN', N'TABLE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Flag determining the object type. P = partition, T = table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_PII_OBJECT_FIELD_MAP', 'COLUMN', N'OBJECT_TYPE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The name of the column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_PII_OBJECT_FIELD_MAP', 'COLUMN', N'FIELD'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The friendly name for this table/field mask.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_PII_OBJECT_FIELD_MAP', 'COLUMN', N'DISPLAY_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'A description for this table/field mask.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_PII_OBJECT_FIELD_MAP', 'COLUMN', N'DESCRIPTION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Bit mask determining which group this data-set belongs to. 1 = eGain, 2 = Cisco, 4 = Avaya, 8 = CVP.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_PII_OBJECT_FIELD_MAP', 'COLUMN', N'GROUP_MASK'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_PII_OBJECT_FIELD_MAP', 'COLUMN', N'msrepl_tran_version'
GO
GRANT SELECT
	ON [dbo].[TB_ADM_PII_OBJECT_FIELD_MAP]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_ADM_PII_OBJECT_FIELD_MAP]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_ADM_PII_OBJECT_FIELD_MAP] SET (LOCK_ESCALATION = TABLE)
GO
