SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_CCM_PRODUCT_FEATURE_MAP] (
		[CCM_PRODUCT_FEATURE_MAP_URN]     [int] IDENTITY(1, 4) NOT FOR REPLICATION NOT NULL,
		[CLUSTER_RESOURCE_ID]             [uniqueidentifier] NOT NULL,
		[PRODUCT_CODE_URN]                [int] NOT NULL,
		[PROTOCOL_CODE_URN]               [int] NOT NULL,
		[FEATURE_CODE_URN]                [int] NOT NULL,
		[PKEY1]                           [int] NOT NULL,
		[PARAMETERS]                      [nvarchar](255) COLLATE Latin1_General_CI_AS NULL,
		[msrepl_tran_version]             [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TB_CCM_PRODUCT_FEATURE_MAP]
		PRIMARY KEY
		CLUSTERED
		([CCM_PRODUCT_FEATURE_MAP_URN])
	ON [DIMGROUP]
) ON [DIMGROUP]
GO
ALTER TABLE [dbo].[TB_CCM_PRODUCT_FEATURE_MAP]
	ADD
	CONSTRAINT [DF_TB_CCM_PRODUCT_FEATURE_MAP_PRODUCT_CODE_URN]
	DEFAULT ((-1)) FOR [PRODUCT_CODE_URN]
GO
ALTER TABLE [dbo].[TB_CCM_PRODUCT_FEATURE_MAP]
	ADD
	CONSTRAINT [DF_TB_CCM_PRODUCT_FEATURE_MAP_PROTOCOL_CODE_URN]
	DEFAULT ((-1)) FOR [PROTOCOL_CODE_URN]
GO
ALTER TABLE [dbo].[TB_CCM_PRODUCT_FEATURE_MAP]
	ADD
	CONSTRAINT [DF_TB_CCM_PRODUCT_FEATURE_MAP_FEATURE_CODE_URN]
	DEFAULT ((-1)) FOR [FEATURE_CODE_URN]
GO
ALTER TABLE [dbo].[TB_CCM_PRODUCT_FEATURE_MAP]
	ADD
	CONSTRAINT [DF_TB_CCM_PRODUCT_FEATURE_MAP_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_CCM_PRODUCT_FEATURE_MAP]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_CCM_PRODUCT_FEATURE_MAP_TB_DIM_CODE_PRODUCT]
	FOREIGN KEY ([PRODUCT_CODE_URN]) REFERENCES [dbo].[TB_DIM_CODE] ([ITEM_URN])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_CCM_PRODUCT_FEATURE_MAP]
	CHECK CONSTRAINT [FK_TB_CCM_PRODUCT_FEATURE_MAP_TB_DIM_CODE_PRODUCT]

GO
ALTER TABLE [dbo].[TB_CCM_PRODUCT_FEATURE_MAP]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_CCM_PRODUCT_FEATURE_MAP_TB_DIM_CODE_PROTOCOL]
	FOREIGN KEY ([PROTOCOL_CODE_URN]) REFERENCES [dbo].[TB_DIM_CODE] ([ITEM_URN])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_CCM_PRODUCT_FEATURE_MAP]
	CHECK CONSTRAINT [FK_TB_CCM_PRODUCT_FEATURE_MAP_TB_DIM_CODE_PROTOCOL]

GO
ALTER TABLE [dbo].[TB_CCM_PRODUCT_FEATURE_MAP]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_CCM_PRODUCT_FEATURE_MAP_TB_DIM_CODE_FEATURE]
	FOREIGN KEY ([FEATURE_CODE_URN]) REFERENCES [dbo].[TB_DIM_CODE] ([ITEM_URN])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_CCM_PRODUCT_FEATURE_MAP]
	CHECK CONSTRAINT [FK_TB_CCM_PRODUCT_FEATURE_MAP_TB_DIM_CODE_FEATURE]

GO
CREATE NONCLUSTERED INDEX [IX_TB_CCM_PRODUCT_FEATURE_MAP_FEATURE_CODE_URN]
	ON [dbo].[TB_CCM_PRODUCT_FEATURE_MAP] ([FEATURE_CODE_URN])
	ON [DIMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_CCM_PRODUCT_FEATURE_MAP_PRODUCT_CODE_URN]
	ON [dbo].[TB_CCM_PRODUCT_FEATURE_MAP] ([PRODUCT_CODE_URN])
	ON [DIMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_CCM_PRODUCT_FEATURE_MAP_PROTOCOL_CODE_URN]
	ON [dbo].[TB_CCM_PRODUCT_FEATURE_MAP] ([PROTOCOL_CODE_URN])
	ON [DIMINDEXGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table stores default values from Cisco CallManager systems', 'SCHEMA', N'dbo', 'TABLE', N'TB_CCM_PRODUCT_FEATURE_MAP', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_CCM_PRODUCT_FEATURE_MAP', 'COLUMN', N'CCM_PRODUCT_FEATURE_MAP_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id of the logical resoource as in TB_CLU_RESOURCE that corresponds to the source for which the mapping is defined for the given item.', 'SCHEMA', N'dbo', 'TABLE', N'TB_CCM_PRODUCT_FEATURE_MAP', 'COLUMN', N'CLUSTER_RESOURCE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key to a product code. Code type: CG_DEVICE_PRODUCT', 'SCHEMA', N'dbo', 'TABLE', N'TB_CCM_PRODUCT_FEATURE_MAP', 'COLUMN', N'PRODUCT_CODE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key to a product code. Code type: CG_DEVICE_PROTOCOL', 'SCHEMA', N'dbo', 'TABLE', N'TB_CCM_PRODUCT_FEATURE_MAP', 'COLUMN', N'PROTOCOL_CODE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key to a product code. Code type: CG_DEVICE_FEATURE', 'SCHEMA', N'dbo', 'TABLE', N'TB_CCM_PRODUCT_FEATURE_MAP', 'COLUMN', N'FEATURE_CODE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the primary identifier of the item on the specified source.', 'SCHEMA', N'dbo', 'TABLE', N'TB_CCM_PRODUCT_FEATURE_MAP', 'COLUMN', N'PKEY1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the parameters for the current feature map.', 'SCHEMA', N'dbo', 'TABLE', N'TB_CCM_PRODUCT_FEATURE_MAP', 'COLUMN', N'PARAMETERS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_CCM_PRODUCT_FEATURE_MAP', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_CCM_PRODUCT_FEATURE_MAP]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_CCM_PRODUCT_FEATURE_MAP]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_CCM_PRODUCT_FEATURE_MAP]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_CCM_PRODUCT_FEATURE_MAP]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_CCM_PRODUCT_FEATURE_MAP] SET (LOCK_ESCALATION = TABLE)
GO
