SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TB_ADM_PII_OBJECT] (
		[URN]                     [bigint] IDENTITY(1, 4) NOT FOR REPLICATION NOT NULL,
		[RESOURCE_ID]             [uniqueidentifier] NOT NULL,
		[FIELD_MAP_URN]           [bigint] NOT NULL,
		[ENABLED]                 [bit] NOT NULL,
		[MODIFIED_BY_ID]          [uniqueidentifier] NOT NULL,
		[MODIFIED_DATE]           [datetime] NOT NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TB_ADM_PII_OBJECT]
		PRIMARY KEY
		CLUSTERED
		([URN])
	ON [ADMGROUP]
) ON [ADMGROUP]
GO
ALTER TABLE [dbo].[TB_ADM_PII_OBJECT]
	ADD
	CONSTRAINT [DF_TB_ADM_PII_OBJECT_ENABLED]
	DEFAULT ((1)) FOR [ENABLED]
GO
ALTER TABLE [dbo].[TB_ADM_PII_OBJECT]
	ADD
	CONSTRAINT [DF_TB_ADM_PII_OBJECT_MODIFIED_DATE]
	DEFAULT (getutcdate()) FOR [MODIFIED_DATE]
GO
ALTER TABLE [dbo].[TB_ADM_PII_OBJECT]
	ADD
	CONSTRAINT [DF_TB_ADM_PII_OBJECT_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table allows masking of PII information on a per cluster basis.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_PII_OBJECT', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record. This is an auto generated number.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_PII_OBJECT', 'COLUMN', N'URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key to TB_CLU_RESOURCE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_PII_OBJECT', 'COLUMN', N'RESOURCE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key to TB_ADM_PII_OBJECT_FIELD_MAP.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_PII_OBJECT', 'COLUMN', N'FIELD_MAP_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'A bit field to determine whether or not masking is enabled for this field on this cluster resource.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_PII_OBJECT', 'COLUMN', N'ENABLED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key for a user in TB_SEC_USER.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_PII_OBJECT', 'COLUMN', N'MODIFIED_BY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The datetime that this table/field mask was last updated.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_PII_OBJECT', 'COLUMN', N'MODIFIED_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_PII_OBJECT', 'COLUMN', N'msrepl_tran_version'
GO
GRANT INSERT
	ON [dbo].[TB_ADM_PII_OBJECT]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_ADM_PII_OBJECT]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_ADM_PII_OBJECT]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_ADM_PII_OBJECT]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_ADM_PII_OBJECT] SET (LOCK_ESCALATION = TABLE)
GO
