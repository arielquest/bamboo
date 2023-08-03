SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_DIM_RESERVED_NUMBER] (
		[RESERVED_NUMBER_ID]        [uniqueidentifier] NOT NULL,
		[ITEM_TYPE_ID]              [uniqueidentifier] NOT NULL,
		[PARENT_URN]                [int] NOT NULL,
		[CLUSTER_RESOURCE_ID]       [uniqueidentifier] NULL,
		[FOLDER_ID]                 [uniqueidentifier] NOT NULL,
		[OWNER_ID]                  [uniqueidentifier] NULL,
		[COLUMN_NAME]               [nvarchar](100) COLLATE Latin1_General_CI_AS NOT NULL,
		[DESCRIPTION]               [nvarchar](500) COLLATE Latin1_General_CI_AS NOT NULL,
		[NUMBER_RANGE]              [nvarchar](32) COLLATE Latin1_General_CI_AS NOT NULL,
		[NEXT_AVAILABLE_NUMBER]     [int] NOT NULL,
		[CREATION_DATE]             [smalldatetime] NOT NULL,
		[MODIFIED_DATE]             [smalldatetime] NOT NULL,
		[ARCHIVED]                  [bit] NOT NULL,
		[HIDDEN]                    [bit] NOT NULL,
		[REQUIRED]                  [bit] NOT NULL,
		[SYSTEM]                    [bit] NOT NULL,
		[msrepl_tran_version]       [uniqueidentifier] NOT NULL,
		CONSTRAINT [UN_TB_ADM_RESERVED_NUMBER_TABLE_ID_NAME]
		UNIQUE
		NONCLUSTERED
		([ITEM_TYPE_ID], [COLUMN_NAME])
		ON [DIMINDEXGROUP],
		CONSTRAINT [PK_TB_DIM_RESERVED_NUMBER]
		PRIMARY KEY
		CLUSTERED
		([RESERVED_NUMBER_ID])
	ON [DIMGROUP]
) ON [DIMGROUP]
GO
ALTER TABLE [dbo].[TB_DIM_RESERVED_NUMBER]
	ADD
	CONSTRAINT [DF_DIM_RESERVED_NUMBER_ID]
	DEFAULT (newid()) FOR [RESERVED_NUMBER_ID]
GO
ALTER TABLE [dbo].[TB_DIM_RESERVED_NUMBER]
	ADD
	CONSTRAINT [DF_DIM_RESERVED_NUMBER_PARENT_URN]
	DEFAULT ((-2)) FOR [PARENT_URN]
GO
ALTER TABLE [dbo].[TB_DIM_RESERVED_NUMBER]
	ADD
	CONSTRAINT [DF_DIM_RESERVED_NUMBER_FOLDER_ID]
	DEFAULT ('00000002-0000-0000-0000-000000000005') FOR [FOLDER_ID]
GO
ALTER TABLE [dbo].[TB_DIM_RESERVED_NUMBER]
	ADD
	CONSTRAINT [DF_DIM_RESERVED_NUMBER_DESCRIPTION]
	DEFAULT (N'') FOR [DESCRIPTION]
GO
ALTER TABLE [dbo].[TB_DIM_RESERVED_NUMBER]
	ADD
	CONSTRAINT [DF_DIM_RESERVED_NUMBER_NUMBER_RANGE]
	DEFAULT (N'[1]XXX') FOR [NUMBER_RANGE]
GO
ALTER TABLE [dbo].[TB_DIM_RESERVED_NUMBER]
	ADD
	CONSTRAINT [DF_DIM_RESERVED_NUMBER_NEXT_AVAILABLE_NUMBER]
	DEFAULT ((-1)) FOR [NEXT_AVAILABLE_NUMBER]
GO
ALTER TABLE [dbo].[TB_DIM_RESERVED_NUMBER]
	ADD
	CONSTRAINT [DF_DIM_RESERVED_NUMBER_CREATION_DATE]
	DEFAULT (getutcdate()) FOR [CREATION_DATE]
GO
ALTER TABLE [dbo].[TB_DIM_RESERVED_NUMBER]
	ADD
	CONSTRAINT [DF_DIM_RESERVED_NUMBER_MODIFIED_DATE]
	DEFAULT (getutcdate()) FOR [MODIFIED_DATE]
GO
ALTER TABLE [dbo].[TB_DIM_RESERVED_NUMBER]
	ADD
	CONSTRAINT [DF_DIM_RESERVED_NUMBER_ARCHIVED]
	DEFAULT ((0)) FOR [ARCHIVED]
GO
ALTER TABLE [dbo].[TB_DIM_RESERVED_NUMBER]
	ADD
	CONSTRAINT [DF_DIM_RESERVED_NUMBER_HIDDEN]
	DEFAULT ((0)) FOR [HIDDEN]
GO
ALTER TABLE [dbo].[TB_DIM_RESERVED_NUMBER]
	ADD
	CONSTRAINT [DF_DIM_RESERVED_NUMBER_REQUIRED]
	DEFAULT ((0)) FOR [REQUIRED]
GO
ALTER TABLE [dbo].[TB_DIM_RESERVED_NUMBER]
	ADD
	CONSTRAINT [DF_DIM_RESERVED_NUMBER_SYSTEM]
	DEFAULT ((0)) FOR [SYSTEM]
GO
ALTER TABLE [dbo].[TB_DIM_RESERVED_NUMBER]
	ADD
	CONSTRAINT [DF_DIM_RESERVED_NUMBER_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_DIM_RESERVED_NUMBER]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_DIM_RESERVED_NUMBER_TE_DIM_ITEM_TYPE]
	FOREIGN KEY ([ITEM_TYPE_ID]) REFERENCES [dbo].[TE_DIM_ITEM_TYPE] ([ITEM_TYPE_ID])
	ON DELETE CASCADE
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_DIM_RESERVED_NUMBER]
	CHECK CONSTRAINT [FK_TB_DIM_RESERVED_NUMBER_TE_DIM_ITEM_TYPE]

GO
ALTER TABLE [dbo].[TB_DIM_RESERVED_NUMBER]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_DIM_RESERVED_NUMBER_TB_SEC_FOLDER_FOLDER_ID]
	FOREIGN KEY ([FOLDER_ID]) REFERENCES [dbo].[TB_SEC_FOLDER] ([FOLDER_ID])
	ON DELETE CASCADE
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_DIM_RESERVED_NUMBER]
	CHECK CONSTRAINT [FK_TB_DIM_RESERVED_NUMBER_TB_SEC_FOLDER_FOLDER_ID]

GO
ALTER TABLE [dbo].[TB_DIM_RESERVED_NUMBER]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_DIM_RESERVED_NUMBER_TB_SEC_FOLDER_OWNER_ID]
	FOREIGN KEY ([OWNER_ID]) REFERENCES [dbo].[TB_SEC_FOLDER] ([FOLDER_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_DIM_RESERVED_NUMBER]
	CHECK CONSTRAINT [FK_TB_DIM_RESERVED_NUMBER_TB_SEC_FOLDER_OWNER_ID]

GO
ALTER TABLE [dbo].[TB_DIM_RESERVED_NUMBER]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_DIM_RESERVED_NUMBER_TB_CLU_RESOURCE]
	FOREIGN KEY ([CLUSTER_RESOURCE_ID]) REFERENCES [dbo].[TB_CLU_RESOURCE] ([RESOURCE_ID])
	ON DELETE CASCADE
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_DIM_RESERVED_NUMBER]
	CHECK CONSTRAINT [FK_TB_DIM_RESERVED_NUMBER_TB_CLU_RESOURCE]

GO
CREATE NONCLUSTERED INDEX [IX_TB_DIM_RESERVED_NUMBER_CLUSTER_RESOURCE_ID]
	ON [dbo].[TB_DIM_RESERVED_NUMBER] ([CLUSTER_RESOURCE_ID])
	ON [DIMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_DIM_RESERVED_NUMBER_FOLDER_ID]
	ON [dbo].[TB_DIM_RESERVED_NUMBER] ([FOLDER_ID])
	ON [DIMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_DIM_RESERVED_NUMBER_OWNER_ID]
	ON [dbo].[TB_DIM_RESERVED_NUMBER] ([OWNER_ID])
	ON [DIMINDEXGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table is a pre-ennumerated table that holds the details for the columns of tables to have unique numbers based on certain patterns.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_RESERVED_NUMBER', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_RESERVED_NUMBER', 'COLUMN', N'RESERVED_NUMBER_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the foreign key from TE_DIM_ITEM_TYPE that indicates the item type to which this reserved number belongs.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_RESERVED_NUMBER', 'COLUMN', N'ITEM_TYPE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use. This field indicates the parent item (usually peripheral) to which this reserved number belongs.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_RESERVED_NUMBER', 'COLUMN', N'PARENT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use. This is a foreign key from TB_CLU_RESOURCE that indicates the cluster resource to which this reserved number pertains to.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_RESERVED_NUMBER', 'COLUMN', N'CLUSTER_RESOURCE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field indicates the place holder for the reserved number in the resource tree. This defaults to the Unallocated folder.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_RESERVED_NUMBER', 'COLUMN', N'FOLDER_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field indicates the owner for the reserved number in the resource tree. This defaults to Unallocated folder.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_RESERVED_NUMBER', 'COLUMN', N'OWNER_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field indicates the field name of the item type (as mentioned in ITEM_TYPE_ID) on which the reserved number is to be applied.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_RESERVED_NUMBER', 'COLUMN', N'COLUMN_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds any additional information relating to reserved number.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_RESERVED_NUMBER', 'COLUMN', N'DESCRIPTION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds the format of the number range that is to be used to generate the next available unique number.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_RESERVED_NUMBER', 'COLUMN', N'NUMBER_RANGE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds the last used number.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_RESERVED_NUMBER', 'COLUMN', N'NEXT_AVAILABLE_NUMBER'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a UTC date time stamp indicating when the record created.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_RESERVED_NUMBER', 'COLUMN', N'CREATION_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a UTC date time stamp indicating when the record last modified.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_RESERVED_NUMBER', 'COLUMN', N'MODIFIED_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the record is set as archieved. Value 1 indicates archived.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_RESERVED_NUMBER', 'COLUMN', N'ARCHIVED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the record is hidden. Value 1 indicates hidden.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_RESERVED_NUMBER', 'COLUMN', N'HIDDEN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_RESERVED_NUMBER', 'COLUMN', N'REQUIRED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the record is owned by the system or not. Value 1 indicates system owned record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_RESERVED_NUMBER', 'COLUMN', N'SYSTEM'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_RESERVED_NUMBER', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_DIM_RESERVED_NUMBER]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_DIM_RESERVED_NUMBER]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_DIM_RESERVED_NUMBER]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_DIM_RESERVED_NUMBER]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_DIM_RESERVED_NUMBER] SET (LOCK_ESCALATION = TABLE)
GO
