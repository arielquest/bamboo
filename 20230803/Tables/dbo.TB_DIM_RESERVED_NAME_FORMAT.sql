SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_DIM_RESERVED_NAME_FORMAT] (
		[RESERVED_NAME_FORMAT_ID]     [uniqueidentifier] NOT NULL,
		[ITEM_TYPE_ID]                [uniqueidentifier] NOT NULL,
		[PARENT_URN]                  [int] NOT NULL,
		[CLUSTER_RESOURCE_ID]         [uniqueidentifier] NULL,
		[FOLDER_ID]                   [uniqueidentifier] NOT NULL,
		[OWNER_ID]                    [uniqueidentifier] NULL,
		[TENANT_LENGTH]               [int] NOT NULL,
		[TENANT_ADJUNCT]              [nvarchar](2) COLLATE Latin1_General_CI_AS NOT NULL,
		[PARENT_LENGTH]               [int] NOT NULL,
		[PARENT_ADJUNCT]              [nvarchar](2) COLLATE Latin1_General_CI_AS NOT NULL,
		[SEED1_LENGTH]                [int] NOT NULL,
		[SEED1_ADJUNCT]               [nvarchar](2) COLLATE Latin1_General_CI_AS NULL,
		[SEED2_LENGTH]                [int] NOT NULL,
		[SEED2_ADJUNCT]               [nvarchar](2) COLLATE Latin1_General_CI_AS NULL,
		[SEED3_LENGTH]                [int] NOT NULL,
		[SEED3_ADJUNCT]               [nvarchar](2) COLLATE Latin1_General_CI_AS NULL,
		[POSTFIX]                     [nvarchar](5) COLLATE Latin1_General_CI_AS NOT NULL,
		[CREATION_DATE]               [smalldatetime] NOT NULL,
		[MODIFIED_DATE]               [smalldatetime] NOT NULL,
		[ARCHIVED]                    [bit] NOT NULL,
		[HIDDEN]                      [bit] NOT NULL,
		[REQUIRED]                    [bit] NOT NULL,
		[SYSTEM]                      [bit] NOT NULL,
		[msrepl_tran_version]         [uniqueidentifier] NOT NULL,
		CONSTRAINT [UN_DIM_RESERVED_NAME_FORMAT_ITEM_TYPE_ID]
		UNIQUE
		NONCLUSTERED
		([ITEM_TYPE_ID])
		ON [DIMINDEXGROUP],
		CONSTRAINT [PK_TB_DIM_RESERVED_NAME_FORMAT]
		PRIMARY KEY
		CLUSTERED
		([RESERVED_NAME_FORMAT_ID])
	ON [DIMGROUP]
) ON [DIMGROUP]
GO
ALTER TABLE [dbo].[TB_DIM_RESERVED_NAME_FORMAT]
	ADD
	CONSTRAINT [DF_DIM_RESERVED_NAME_FORMAT_ID]
	DEFAULT (newid()) FOR [RESERVED_NAME_FORMAT_ID]
GO
ALTER TABLE [dbo].[TB_DIM_RESERVED_NAME_FORMAT]
	ADD
	CONSTRAINT [DF_DIM_RESERVED_NAME_FORMAT_PARENT_URN]
	DEFAULT ((-2)) FOR [PARENT_URN]
GO
ALTER TABLE [dbo].[TB_DIM_RESERVED_NAME_FORMAT]
	ADD
	CONSTRAINT [DF_DIM_RESERVED_NAME_FORMAT_FOLDER_ID]
	DEFAULT ('00000002-0000-0000-0000-000000000005') FOR [FOLDER_ID]
GO
ALTER TABLE [dbo].[TB_DIM_RESERVED_NAME_FORMAT]
	ADD
	CONSTRAINT [DF_DIM_RESERVED_NAME_FORMAT_TENANT_LENGTH]
	DEFAULT ((0)) FOR [TENANT_LENGTH]
GO
ALTER TABLE [dbo].[TB_DIM_RESERVED_NAME_FORMAT]
	ADD
	CONSTRAINT [DF_DIM_RESERVED_NAME_FORMAT_TENANT_ADJUNCT]
	DEFAULT (N'') FOR [TENANT_ADJUNCT]
GO
ALTER TABLE [dbo].[TB_DIM_RESERVED_NAME_FORMAT]
	ADD
	CONSTRAINT [DF_DIM_RESERVED_NAME_FORMAT_PARENT_LENGTH]
	DEFAULT ((0)) FOR [PARENT_LENGTH]
GO
ALTER TABLE [dbo].[TB_DIM_RESERVED_NAME_FORMAT]
	ADD
	CONSTRAINT [DF_DIM_RESERVED_NAME_FORMAT_PARENT_ADJUNCT]
	DEFAULT (N'.') FOR [PARENT_ADJUNCT]
GO
ALTER TABLE [dbo].[TB_DIM_RESERVED_NAME_FORMAT]
	ADD
	CONSTRAINT [DF_DIM_RESERVED_NAME_FORMAT_SEED1_LENGTH]
	DEFAULT ((0)) FOR [SEED1_LENGTH]
GO
ALTER TABLE [dbo].[TB_DIM_RESERVED_NAME_FORMAT]
	ADD
	CONSTRAINT [DF_DIM_RESERVED_NAME_FORMAT_SEED1_ADJUNCT]
	DEFAULT (N'') FOR [SEED1_ADJUNCT]
GO
ALTER TABLE [dbo].[TB_DIM_RESERVED_NAME_FORMAT]
	ADD
	CONSTRAINT [DF_DIM_RESERVED_NAME_FORMAT_SEED2_LENGTH]
	DEFAULT ((0)) FOR [SEED2_LENGTH]
GO
ALTER TABLE [dbo].[TB_DIM_RESERVED_NAME_FORMAT]
	ADD
	CONSTRAINT [DF_DIM_RESERVED_NAME_FORMAT_SEED2_ADJUNCT]
	DEFAULT (N'') FOR [SEED2_ADJUNCT]
GO
ALTER TABLE [dbo].[TB_DIM_RESERVED_NAME_FORMAT]
	ADD
	CONSTRAINT [DF_DIM_RESERVED_NAME_FORMAT_SEED3_LENGTH]
	DEFAULT ((0)) FOR [SEED3_LENGTH]
GO
ALTER TABLE [dbo].[TB_DIM_RESERVED_NAME_FORMAT]
	ADD
	CONSTRAINT [DF_DIM_RESERVED_NAME_FORMAT_SEED3_ADJUNCT]
	DEFAULT (N'') FOR [SEED3_ADJUNCT]
GO
ALTER TABLE [dbo].[TB_DIM_RESERVED_NAME_FORMAT]
	ADD
	CONSTRAINT [DF_DIM_RESERVED_NAME_FORMAT_POSTFIX]
	DEFAULT (N'') FOR [POSTFIX]
GO
ALTER TABLE [dbo].[TB_DIM_RESERVED_NAME_FORMAT]
	ADD
	CONSTRAINT [DF_DIM_RESERVED_NAME_FORMAT_CREATION_DATE]
	DEFAULT (getutcdate()) FOR [CREATION_DATE]
GO
ALTER TABLE [dbo].[TB_DIM_RESERVED_NAME_FORMAT]
	ADD
	CONSTRAINT [DF_DIM_RESERVED_NAME_FORMAT_MODIFIED_DATE]
	DEFAULT (getutcdate()) FOR [MODIFIED_DATE]
GO
ALTER TABLE [dbo].[TB_DIM_RESERVED_NAME_FORMAT]
	ADD
	CONSTRAINT [DF_DIM_RESERVED_NAME_FORMAT_ARCHIVED]
	DEFAULT ((0)) FOR [ARCHIVED]
GO
ALTER TABLE [dbo].[TB_DIM_RESERVED_NAME_FORMAT]
	ADD
	CONSTRAINT [DF_DIM_RESERVED_NAME_FORMAT_HIDDEN]
	DEFAULT ((0)) FOR [HIDDEN]
GO
ALTER TABLE [dbo].[TB_DIM_RESERVED_NAME_FORMAT]
	ADD
	CONSTRAINT [DF_DIM_RESERVED_NAME_FORMAT_REQUIRED]
	DEFAULT ((0)) FOR [REQUIRED]
GO
ALTER TABLE [dbo].[TB_DIM_RESERVED_NAME_FORMAT]
	ADD
	CONSTRAINT [DF_DIM_RESERVED_NAME_FORMAT_SYSTEM]
	DEFAULT ((0)) FOR [SYSTEM]
GO
ALTER TABLE [dbo].[TB_DIM_RESERVED_NAME_FORMAT]
	ADD
	CONSTRAINT [DF_DIM_RESERVED_NAME_FORMAT_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table holds the format for the reserved names that are to be used by the application. This table is used to auto generate system internal names for any item type globally or on specific source equipments.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_RESERVED_NAME_FORMAT', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_RESERVED_NAME_FORMAT', 'COLUMN', N'RESERVED_NAME_FORMAT_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the foreign key from TE_DIM_ITEM_TYPE that indicates the item type to which this reserved name format belongs.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_RESERVED_NAME_FORMAT', 'COLUMN', N'ITEM_TYPE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use. This field indicates the parent item to which this reserved name format belongs. This defaults to None.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_RESERVED_NAME_FORMAT', 'COLUMN', N'PARENT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use. This is a foreign key from TB_CLU_RESOURCE that indicates the cluster resource to which this reserved name format pertains to. This defaults to Null.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_RESERVED_NAME_FORMAT', 'COLUMN', N'CLUSTER_RESOURCE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field indicates the place holder for the reserved name format in the resource tree. This defaults to the Unallocated folder.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_RESERVED_NAME_FORMAT', 'COLUMN', N'FOLDER_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field indicates the owner for the reserved name in the resource tree. This defaults to Null.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_RESERVED_NAME_FORMAT', 'COLUMN', N'OWNER_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds the number of characters of the tenant name that is to be used to create a reserved name (Internal Name).', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_RESERVED_NAME_FORMAT', 'COLUMN', N'TENANT_LENGTH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds the character saperator that is to be used during creation of Internal Name. This will be used after the character length as specified in TENANT_LENGTH.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_RESERVED_NAME_FORMAT', 'COLUMN', N'TENANT_ADJUNCT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds the number of characters of the parent name that is to be used to create a reserved name (Internal Name).', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_RESERVED_NAME_FORMAT', 'COLUMN', N'PARENT_LENGTH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds the character saperator that is to be used during creation of Internal Name. This will be used after the character length as specified in PARENT_LENGTH.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_RESERVED_NAME_FORMAT', 'COLUMN', N'PARENT_ADJUNCT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is first the optional length of characters that can be used to generate the Internal Name.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_RESERVED_NAME_FORMAT', 'COLUMN', N'SEED1_LENGTH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds the optional character saperator that can be used during creation of Internal Name. This will be used after the character length as specified in SEED1_LENGTH.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_RESERVED_NAME_FORMAT', 'COLUMN', N'SEED1_ADJUNCT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the second optional length of characters that can be used to generate the Internal Name.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_RESERVED_NAME_FORMAT', 'COLUMN', N'SEED2_LENGTH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds the optional character saperator that can be used during creation of Internal Name. This will be used after the character length as specified in SEED2_LENGTH.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_RESERVED_NAME_FORMAT', 'COLUMN', N'SEED2_ADJUNCT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the third optional length of characters that can be used to generate the Internal Name.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_RESERVED_NAME_FORMAT', 'COLUMN', N'SEED3_LENGTH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds the optional character saperator that can be used during creation of Internal Name. This will be used after the character length as specified in SEED3_LENGTH.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_RESERVED_NAME_FORMAT', 'COLUMN', N'SEED3_ADJUNCT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds the charactrs that will make up the suffix of the Internal Name.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_RESERVED_NAME_FORMAT', 'COLUMN', N'POSTFIX'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a UTC date time stamp indicating when the record created.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_RESERVED_NAME_FORMAT', 'COLUMN', N'CREATION_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a UTC date time stamp indicating when the record last modified.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_RESERVED_NAME_FORMAT', 'COLUMN', N'MODIFIED_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the record is set as archieved. Value 1 indicates archived.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_RESERVED_NAME_FORMAT', 'COLUMN', N'ARCHIVED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the record is hidden. Value 1 indicates hidden.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_RESERVED_NAME_FORMAT', 'COLUMN', N'HIDDEN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_RESERVED_NAME_FORMAT', 'COLUMN', N'REQUIRED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the record is owned by the system or not. Value 1 indicates system owned record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_RESERVED_NAME_FORMAT', 'COLUMN', N'SYSTEM'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_RESERVED_NAME_FORMAT', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_DIM_RESERVED_NAME_FORMAT]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_DIM_RESERVED_NAME_FORMAT]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_DIM_RESERVED_NAME_FORMAT]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_DIM_RESERVED_NAME_FORMAT]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_DIM_RESERVED_NAME_FORMAT] SET (LOCK_ESCALATION = TABLE)
GO
