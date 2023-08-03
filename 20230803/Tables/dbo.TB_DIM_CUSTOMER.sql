SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_DIM_CUSTOMER] (
		[ITEM_URN]                        [int] IDENTITY(1, 4) NOT FOR REPLICATION NOT NULL,
		[TENANT_BIZ_URN]                  [int] NOT NULL,
		[CLASSIFICATION_CODE_BIZ_URN]     [int] NOT NULL,
		[CUSTOMER_TYPE]                   [char](1) COLLATE Latin1_General_CI_AS NOT NULL,
		[NAME]                            [nvarchar](255) COLLATE Latin1_General_CI_AS NOT NULL,
		[CREATION_DATE]                   [datetime] NOT NULL,
		[msrepl_tran_version]             [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TB_DIM_CUSTOMER]
		PRIMARY KEY
		CLUSTERED
		([ITEM_URN])
	ON [DIMGROUP]
) ON [DIMGROUP]
GO
ALTER TABLE [dbo].[TB_DIM_CUSTOMER]
	ADD
	CONSTRAINT [CK_TB_DIM_CUSTOMER_CUSTOMER_TYPE]
	CHECK
	([CUSTOMER_TYPE]='I' OR [CUSTOMER_TYPE]='C' OR [CUSTOMER_TYPE]='G')
GO
ALTER TABLE [dbo].[TB_DIM_CUSTOMER]
CHECK CONSTRAINT [CK_TB_DIM_CUSTOMER_CUSTOMER_TYPE]
GO
ALTER TABLE [dbo].[TB_DIM_CUSTOMER]
	ADD
	CONSTRAINT [DF_TB_DIM_CUSTOMER_TENANT_BIZ_URN]
	DEFAULT ((-1)) FOR [TENANT_BIZ_URN]
GO
ALTER TABLE [dbo].[TB_DIM_CUSTOMER]
	ADD
	CONSTRAINT [DF_TB_DIM_CUSTOMER_CLASSIFICATION_CODE_BIZ_URN]
	DEFAULT ((-1)) FOR [CLASSIFICATION_CODE_BIZ_URN]
GO
ALTER TABLE [dbo].[TB_DIM_CUSTOMER]
	ADD
	CONSTRAINT [DF_TB_DIM_CUSTOMER_CREATION_DATE]
	DEFAULT (getutcdate()) FOR [CREATION_DATE]
GO
ALTER TABLE [dbo].[TB_DIM_CUSTOMER]
	ADD
	CONSTRAINT [DF_TB_DIM_CUSTOMER_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table stores base information of all the Customers in the system', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CUSTOMER', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'The primary key.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CUSTOMER', 'COLUMN', N'ITEM_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Business key for the associated tenant in TB_DIM_TENANT', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CUSTOMER', 'COLUMN', N'TENANT_BIZ_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Customer classification, which is a pre-defined category that can be customized. Defaults: Gold, Silver, Platinum, Premium, Standard', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CUSTOMER', 'COLUMN', N'CLASSIFICATION_CODE_BIZ_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The type of customer. I = Individual, G = Group, C = Corporate', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CUSTOMER', 'COLUMN', N'CUSTOMER_TYPE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the display name for the item.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CUSTOMER', 'COLUMN', N'NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the UTC date time stamp indicating when the item was created.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CUSTOMER', 'COLUMN', N'CREATION_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_CUSTOMER', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_DIM_CUSTOMER]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_DIM_CUSTOMER]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_DIM_CUSTOMER]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_DIM_CUSTOMER]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_DIM_CUSTOMER]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_DIM_CUSTOMER]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_DIM_CUSTOMER] SET (LOCK_ESCALATION = TABLE)
GO
