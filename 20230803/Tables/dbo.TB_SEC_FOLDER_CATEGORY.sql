SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TB_SEC_FOLDER_CATEGORY] (
		[FOLDER_ID]               [uniqueidentifier] NOT NULL,
		[CATEGORY_URN]            [int] NOT NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TB_SEC_FOLDER_CATEGORY]
		PRIMARY KEY
		CLUSTERED
		([FOLDER_ID], [CATEGORY_URN])
	ON [SECGROUP]
) ON [SECGROUP]
GO
ALTER TABLE [dbo].[TB_SEC_FOLDER_CATEGORY]
	ADD
	CONSTRAINT [DF_TB_SEC_FOLDER_CATEGORY_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_SEC_FOLDER_CATEGORY]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_SEC_FOLDER_CATEGORY_TB_DIM_ITEM_CATEGORY]
	FOREIGN KEY ([CATEGORY_URN]) REFERENCES [dbo].[TB_DIM_CATEGORY] ([ITEM_URN])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_SEC_FOLDER_CATEGORY]
	CHECK CONSTRAINT [FK_TB_SEC_FOLDER_CATEGORY_TB_DIM_ITEM_CATEGORY]

GO
ALTER TABLE [dbo].[TB_SEC_FOLDER_CATEGORY]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_SEC_FOLDER_CATEGORY_TB_SEC_FOLDER]
	FOREIGN KEY ([FOLDER_ID]) REFERENCES [dbo].[TB_SEC_FOLDER] ([FOLDER_ID])
	ON DELETE CASCADE
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_SEC_FOLDER_CATEGORY]
	CHECK CONSTRAINT [FK_TB_SEC_FOLDER_CATEGORY_TB_SEC_FOLDER]

GO
CREATE NONCLUSTERED INDEX [IX_TB_SEC_FOLDER_CATEGORY_CATEGORY_URN]
	ON [dbo].[TB_SEC_FOLDER_CATEGORY] ([CATEGORY_URN])
	ON [SECGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table will hold the mappings between various folders and the defined categories that they belong to.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_FOLDER_CATEGORY', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Composite Primary key identifier for the record. This is the id as in TB_SEC_FOLDER corresponding to the folder being categorized.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_FOLDER_CATEGORY', 'COLUMN', N'FOLDER_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Composite Primary key identifier for the record. This is the URN as in TB_DIM_CATEGORY of type IT_CATEGORY corresponding to the category.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_FOLDER_CATEGORY', 'COLUMN', N'CATEGORY_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SEC_FOLDER_CATEGORY', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_SEC_FOLDER_CATEGORY]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_SEC_FOLDER_CATEGORY]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_SEC_FOLDER_CATEGORY]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_SEC_FOLDER_CATEGORY]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_SEC_FOLDER_CATEGORY] SET (LOCK_ESCALATION = TABLE)
GO
