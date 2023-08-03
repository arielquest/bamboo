SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_DIM_CHANNEL_ADDRESS] (
		[ITEM_URN]                    [int] IDENTITY(1, 4) NOT FOR REPLICATION NOT NULL,
		[FOLDER_ID]                   [uniqueidentifier] NOT NULL,
		[OWNER_ID]                    [uniqueidentifier] NULL,
		[CHANNEL_ADDRESS_TYPE_ID]     [uniqueidentifier] NULL,
		[ADDRESS]                     [nvarchar](255) COLLATE Latin1_General_CI_AS NULL,
		[TENANT_BIZ_URN]              [int] NOT NULL,
		[msrepl_tran_version]         [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TB_DIM_CHANNEL_ADDRESS]
		PRIMARY KEY
		CLUSTERED
		([ITEM_URN])
	ON [DIMGROUP]
) ON [DIMGROUP]
GO
ALTER TABLE [dbo].[TB_DIM_CHANNEL_ADDRESS]
	ADD
	CONSTRAINT [DF_TB_DIM_CHANNEL_ADDRESS_TENANT_BIZ_URN]
	DEFAULT ((-1)) FOR [TENANT_BIZ_URN]
GO
ALTER TABLE [dbo].[TB_DIM_CHANNEL_ADDRESS]
	ADD
	CONSTRAINT [DF_TB_DIM_CHANNEL_ADDRESS_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_DIM_CHANNEL_ADDRESS]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_DIM_CHANNEL_ADDRESS_TE_DIM_CHANNEL_ADDRESS_TYPE]
	FOREIGN KEY ([CHANNEL_ADDRESS_TYPE_ID]) REFERENCES [dbo].[TE_DIM_CHANNEL_ADDRESS_TYPE] ([TYPE_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_DIM_CHANNEL_ADDRESS]
	CHECK CONSTRAINT [FK_TB_DIM_CHANNEL_ADDRESS_TE_DIM_CHANNEL_ADDRESS_TYPE]

GO
ALTER TABLE [dbo].[TB_DIM_CHANNEL_ADDRESS]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_DIM_CHANNEL_ADDRESS_TB_SEC_FOLDER_FOLDER]
	FOREIGN KEY ([FOLDER_ID]) REFERENCES [dbo].[TB_SEC_FOLDER] ([FOLDER_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_DIM_CHANNEL_ADDRESS]
	CHECK CONSTRAINT [FK_TB_DIM_CHANNEL_ADDRESS_TB_SEC_FOLDER_FOLDER]

GO
ALTER TABLE [dbo].[TB_DIM_CHANNEL_ADDRESS]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_DIM_CHANNEL_ADDRESS_TB_SEC_FOLDER_OWNER]
	FOREIGN KEY ([OWNER_ID]) REFERENCES [dbo].[TB_SEC_FOLDER] ([FOLDER_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_DIM_CHANNEL_ADDRESS]
	CHECK CONSTRAINT [FK_TB_DIM_CHANNEL_ADDRESS_TB_SEC_FOLDER_OWNER]

GO
CREATE NONCLUSTERED INDEX [IX_TB_DIM_CHANNEL_ADDRESS_ADDRESS]
	ON [dbo].[TB_DIM_CHANNEL_ADDRESS] ([ADDRESS])
	ON [DIMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_DIM_CHANNEL_ADDRESS_CHANNEL_ADDRESS_TYPE_ID]
	ON [dbo].[TB_DIM_CHANNEL_ADDRESS] ([CHANNEL_ADDRESS_TYPE_ID])
	ON [DIMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_DIM_CHANNEL_ADDRESS_FOLDER_ID]
	ON [dbo].[TB_DIM_CHANNEL_ADDRESS] ([FOLDER_ID])
	ON [DIMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_DIM_CHANNEL_ADDRESS_OWNER_ID]
	ON [dbo].[TB_DIM_CHANNEL_ADDRESS] ([OWNER_ID])
	ON [DIMINDEXGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table defines the channels that an end-user may use to contact the enterprise or may be contacted by', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CHANNEL_ADDRESS', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CHANNEL_ADDRESS', 'COLUMN', N'ITEM_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TB_SEC_FOLDER corresponding to the place holder for the item in the security folder hierarchy. This is a foreign key to TB_SEC_FOLDER.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CHANNEL_ADDRESS', 'COLUMN', N'FOLDER_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TB_SEC_FOLDER corresponding to the tenant folder that is the root for the place holder folder as in FOLDER_ID. This is a foreign key to TB_SEC_FOLDER.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CHANNEL_ADDRESS', 'COLUMN', N'OWNER_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key to TE_DIM_CHANNEL_ADDRESS_TYPE. Defines the type of channel address.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CHANNEL_ADDRESS', 'COLUMN', N'CHANNEL_ADDRESS_TYPE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Channel address string e.g. ANI or email', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CHANNEL_ADDRESS', 'COLUMN', N'ADDRESS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Business key for the associated tenant in TB_DIM_TENANT', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CHANNEL_ADDRESS', 'COLUMN', N'TENANT_BIZ_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CHANNEL_ADDRESS', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_DIM_CHANNEL_ADDRESS]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_DIM_CHANNEL_ADDRESS]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_DIM_CHANNEL_ADDRESS]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_DIM_CHANNEL_ADDRESS]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_DIM_CHANNEL_ADDRESS]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_DIM_CHANNEL_ADDRESS]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_DIM_CHANNEL_ADDRESS] SET (LOCK_ESCALATION = TABLE)
GO
