SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_FCT_JOURNAL] (
		[JOURNAL_URN]             [int] IDENTITY(1, 4) NOT FOR REPLICATION NOT NULL,
		[PARTITION_ID]            [tinyint] NOT NULL,
		[TABLE_ID]                [int] NOT NULL,
		[FACT_URN]                [int] NOT NULL,
		[CREATED_BY_ID]           [uniqueidentifier] NULL,
		[MODIFIED_BY_ID]          [uniqueidentifier] NULL,
		[CREATION_DATE]           [datetime] NOT NULL,
		[MODIFIED_DATE]           [datetime] NOT NULL,
		[JOURNAL_ENTRY]           [nvarchar](500) COLLATE Latin1_General_CI_AS NOT NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_FCT_JOURNAL_URN]
		PRIMARY KEY
		CLUSTERED
		([JOURNAL_URN])
	ON [FCTGROUP]
) ON [FCTGROUP]
GO
ALTER TABLE [dbo].[TB_FCT_JOURNAL]
	WITH NOCHECK
	ADD
	CONSTRAINT [CK_TB_FCT_JOURNAL_PARTITION_ID]
	CHECK
	NOT FOR REPLICATION
	([PARTITION_ID]=(0))
GO
ALTER TABLE [dbo].[TB_FCT_JOURNAL]
CHECK CONSTRAINT [CK_TB_FCT_JOURNAL_PARTITION_ID]
GO
ALTER TABLE [dbo].[TB_FCT_JOURNAL]
	ADD
	CONSTRAINT [DF_TB_FCT_JOURNAL_PARTITION_ID]
	DEFAULT ((0)) FOR [PARTITION_ID]
GO
ALTER TABLE [dbo].[TB_FCT_JOURNAL]
	ADD
	CONSTRAINT [DF_TB_FCT_JOURNAL_CREATION_DATE]
	DEFAULT (getutcdate()) FOR [CREATION_DATE]
GO
ALTER TABLE [dbo].[TB_FCT_JOURNAL]
	ADD
	CONSTRAINT [DF_TB_FCT_JOURNAL_MODIFIED_DATE]
	DEFAULT (getutcdate()) FOR [MODIFIED_DATE]
GO
ALTER TABLE [dbo].[TB_FCT_JOURNAL]
	ADD
	CONSTRAINT [DF_TB_FCT_JOURNAL_JOURNAL_ENTRY]
	DEFAULT (N'') FOR [JOURNAL_ENTRY]
GO
ALTER TABLE [dbo].[TB_FCT_JOURNAL]
	ADD
	CONSTRAINT [DF_TB_FCT_JOURNAL_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table is for future use. There will be schema changes in future and hence this table is not documented.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_JOURNAL', NULL, NULL
GO
GRANT DELETE
	ON [dbo].[TB_FCT_JOURNAL]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_FCT_JOURNAL]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_FCT_JOURNAL]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_FCT_JOURNAL]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_FCT_JOURNAL]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_FCT_JOURNAL]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_FCT_JOURNAL] SET (LOCK_ESCALATION = TABLE)
GO
