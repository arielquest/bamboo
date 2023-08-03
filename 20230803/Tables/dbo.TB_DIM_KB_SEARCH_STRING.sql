SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_DIM_KB_SEARCH_STRING] (
		[ITEM_URN]                [int] IDENTITY(1, 4) NOT FOR REPLICATION NOT NULL,
		[SEARCH_STRING]           [nvarchar](2000) COLLATE Latin1_General_CI_AS NOT NULL,
		[TENANT_BIZ_URN]          [int] NOT NULL,
		[SEARCH_STRING_HASH]      AS (CONVERT([varbinary](64),hashbytes('SHA2_512',[SEARCH_STRING]))) PERSISTED,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TB_DIM_KB_SEARCH_STRING]
		PRIMARY KEY
		CLUSTERED
		([ITEM_URN])
	ON [DIMGROUP]
) ON [DIMGROUP]
GO
ALTER TABLE [dbo].[TB_DIM_KB_SEARCH_STRING]
	ADD
	CONSTRAINT [DF_TB_DIM_KB_SEARCH_STRING_SEARCH_STRING]
	DEFAULT ('') FOR [SEARCH_STRING]
GO
ALTER TABLE [dbo].[TB_DIM_KB_SEARCH_STRING]
	ADD
	CONSTRAINT [DF_TB_DIM_KB_SEARCH_STRING_TENANT_BIZ_URN]
	DEFAULT ((-1)) FOR [TENANT_BIZ_URN]
GO
ALTER TABLE [dbo].[TB_DIM_KB_SEARCH_STRING]
	ADD
	CONSTRAINT [DF_TB_DIM_KB_SEARCH_STRING_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
SET ANSI_PADDING ON
GO
CREATE NONCLUSTERED INDEX [IX_TB_DIM_KB_SEARCH_STRING_SEARCH_STRING_HASH_TENANT_BIZ_URN]
	ON [dbo].[TB_DIM_KB_SEARCH_STRING] ([SEARCH_STRING_HASH], [TENANT_BIZ_URN])
	WHERE (([SEARCH_STRING]<>''))
	ON [DIMINDEXGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table stores base information of all the KB search strings in the system', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_KB_SEARCH_STRING', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record. This is an auto generated number.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_KB_SEARCH_STRING', 'COLUMN', N'ITEM_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The string used in this item search.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_KB_SEARCH_STRING', 'COLUMN', N'SEARCH_STRING'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Business key for the associated tenant in TB_DIM_TENANT', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_KB_SEARCH_STRING', 'COLUMN', N'TENANT_BIZ_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Used by targetted index for cluster duplicate check', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_KB_SEARCH_STRING', 'COLUMN', N'SEARCH_STRING_HASH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_KB_SEARCH_STRING', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_DIM_KB_SEARCH_STRING]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_DIM_KB_SEARCH_STRING]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_DIM_KB_SEARCH_STRING]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_DIM_KB_SEARCH_STRING]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_DIM_KB_SEARCH_STRING]
	TO [portalrs_role]
GO
GRANT INSERT
	ON [dbo].[TB_DIM_KB_SEARCH_STRING]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_DIM_KB_SEARCH_STRING]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_DIM_KB_SEARCH_STRING] SET (LOCK_ESCALATION = TABLE)
GO
