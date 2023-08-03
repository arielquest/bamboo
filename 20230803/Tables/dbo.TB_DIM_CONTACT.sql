SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_DIM_CONTACT] (
		[ITEM_URN]                [int] IDENTITY(1, 4) NOT FOR REPLICATION NOT NULL,
		[FOLDER_ID]               [uniqueidentifier] NOT NULL,
		[OWNER_ID]                [uniqueidentifier] NULL,
		[TITLE]                   [nvarchar](20) COLLATE Latin1_General_CI_AS NULL,
		[FIRST_NAME]              [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
		[MIDDLE_NAME]             [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
		[LAST_NAME]               [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
		[CUSTOMER_URN]            [int] NULL,
		[TENANT_BIZ_URN]          [int] NOT NULL,
		[CREATION_DATE]           [datetime] NOT NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TB_DIM_CONTACT]
		PRIMARY KEY
		CLUSTERED
		([ITEM_URN])
	ON [DIMGROUP]
) ON [DIMGROUP]
GO
ALTER TABLE [dbo].[TB_DIM_CONTACT]
	ADD
	CONSTRAINT [DF_TB_DIM_CONTACT_TENANT_BIZ_URN]
	DEFAULT ((-1)) FOR [TENANT_BIZ_URN]
GO
ALTER TABLE [dbo].[TB_DIM_CONTACT]
	ADD
	CONSTRAINT [DF_TB_DIM_CONTACT_CREATION_DATE]
	DEFAULT (getutcdate()) FOR [CREATION_DATE]
GO
ALTER TABLE [dbo].[TB_DIM_CONTACT]
	ADD
	CONSTRAINT [DF_TB_DIM_CONTACT_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_DIM_CONTACT]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_DIM_CONTACT_TB_DIM_CUSTOMER_CUSTOMER_URN]
	FOREIGN KEY ([CUSTOMER_URN]) REFERENCES [dbo].[TB_DIM_CUSTOMER] ([ITEM_URN])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_DIM_CONTACT]
	CHECK CONSTRAINT [FK_TB_DIM_CONTACT_TB_DIM_CUSTOMER_CUSTOMER_URN]

GO
CREATE NONCLUSTERED INDEX [IX_TB_DIM_CONTACT_CUSTOMER_URN]
	ON [dbo].[TB_DIM_CONTACT] ([CUSTOMER_URN])
	ON [DIMINDEXGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table contains all the customer contacts associated with the contact center business. These may be either contacting the enterprise or contacted by the enterprise.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CONTACT', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CONTACT', 'COLUMN', N'ITEM_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TB_SEC_FOLDER corresponding to the place holder for the item in the security folder hierarchy. This is a foreign key to TB_SEC_FOLDER.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CONTACT', 'COLUMN', N'FOLDER_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TB_SEC_FOLDER corresponding to the tenant folder that is the root for the place holder folder as in FOLDER_ID. This is a foreign key to TB_SEC_FOLDER.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CONTACT', 'COLUMN', N'OWNER_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The title for the contact.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CONTACT', 'COLUMN', N'TITLE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The first name of the contact', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CONTACT', 'COLUMN', N'FIRST_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Middle name of the contact', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CONTACT', 'COLUMN', N'MIDDLE_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Last name of the contact', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CONTACT', 'COLUMN', N'LAST_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key on TB_DIM_CUSTOMER. Identifies the customer represented by this contact person.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CONTACT', 'COLUMN', N'CUSTOMER_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Business key for the associated tenant in TB_DIM_TENANT', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CONTACT', 'COLUMN', N'TENANT_BIZ_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the UTC date time stamp indicating when the item was created.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CONTACT', 'COLUMN', N'CREATION_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CONTACT', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_DIM_CONTACT]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_DIM_CONTACT]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_DIM_CONTACT]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_DIM_CONTACT]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_DIM_CONTACT]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_DIM_CONTACT]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_DIM_CONTACT] SET (LOCK_ESCALATION = TABLE)
GO
