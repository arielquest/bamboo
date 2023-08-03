SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TE_DIM_PERIPHERAL_TYPE] (
		[PERIPHERAL_TYPE_ID]      [uniqueidentifier] NOT NULL ROWGUIDCOL,
		[NAME]                    [nvarchar](100) COLLATE Latin1_General_CI_AS NOT NULL,
		[INTERNAL_NAME]           [nvarchar](100) COLLATE Latin1_General_CI_AS NOT NULL,
		[DESCRIPTION]             [nvarchar](500) COLLATE Latin1_General_CI_AS NOT NULL,
		[TABLE_ID]                [int] NULL,
		[SMALL_ICON]              [nvarchar](450) COLLATE Latin1_General_CI_AS NULL,
		[LARGE_ICON]              [nvarchar](450) COLLATE Latin1_General_CI_AS NULL,
		[ARCHIVED]                [bit] NOT NULL,
		[DELETED]                 [bit] NOT NULL,
		[ENABLED]                 [bit] NOT NULL,
		[HIDDEN]                  [bit] NOT NULL,
		[SYSTEM]                  [bit] NOT NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [UN_TE_DIM_PERIPHERAL_TYPE_INTERNAL_NAME]
		UNIQUE
		NONCLUSTERED
		([INTERNAL_NAME])
		ON [DIMINDEXGROUP],
		CONSTRAINT [PK_TE_DIM_PERIPHERAL_TYPE]
		PRIMARY KEY
		CLUSTERED
		([PERIPHERAL_TYPE_ID])
	ON [DIMGROUP]
) ON [DIMGROUP]
GO
ALTER TABLE [dbo].[TE_DIM_PERIPHERAL_TYPE]
	ADD
	CONSTRAINT [DF_TE_DIM_PERIPHERAL_TYPE_TYPE]
	DEFAULT (newid()) FOR [PERIPHERAL_TYPE_ID]
GO
ALTER TABLE [dbo].[TE_DIM_PERIPHERAL_TYPE]
	ADD
	CONSTRAINT [DF_TE_DIM_PERIPHERAL_TYPE_DESCRIPTION]
	DEFAULT (N'') FOR [DESCRIPTION]
GO
ALTER TABLE [dbo].[TE_DIM_PERIPHERAL_TYPE]
	ADD
	CONSTRAINT [DF_TE_DIM_PERIPHERAL_TYPE_ARCHIVED]
	DEFAULT ((0)) FOR [ARCHIVED]
GO
ALTER TABLE [dbo].[TE_DIM_PERIPHERAL_TYPE]
	ADD
	CONSTRAINT [DF_TE_DIM_PERIPHERAL_TYPE_DELETED]
	DEFAULT ((0)) FOR [DELETED]
GO
ALTER TABLE [dbo].[TE_DIM_PERIPHERAL_TYPE]
	ADD
	CONSTRAINT [DF_TE_DIM_PERIPHERAL_TYPE_ENABLED]
	DEFAULT ((1)) FOR [ENABLED]
GO
ALTER TABLE [dbo].[TE_DIM_PERIPHERAL_TYPE]
	ADD
	CONSTRAINT [DF_TE_DIM_PERIPHERAL_TYPE_HIDDEN]
	DEFAULT ((0)) FOR [HIDDEN]
GO
ALTER TABLE [dbo].[TE_DIM_PERIPHERAL_TYPE]
	ADD
	CONSTRAINT [DF_TE_DIM_PERIPHERAL_TYPE_SYSTEM]
	DEFAULT ((0)) FOR [SYSTEM]
GO
ALTER TABLE [dbo].[TE_DIM_PERIPHERAL_TYPE]
	ADD
	CONSTRAINT [DF_TE_DIM_PERIPHERAL_TYPE_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table holds information of all possible telephony peripherals based on various vendors.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_PERIPHERAL_TYPE', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_PERIPHERAL_TYPE', 'COLUMN', N'PERIPHERAL_TYPE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the display name for the peripheral type.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_PERIPHERAL_TYPE', 'COLUMN', N'NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the systems internal name for the peripheral type. This is unique. This name is prefixed with PT_.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_PERIPHERAL_TYPE', 'COLUMN', N'INTERNAL_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a brief description for the peripheral type.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_PERIPHERAL_TYPE', 'COLUMN', N'DESCRIPTION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds the object id in sysobjects system table of the table associated with this peripheral type.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_PERIPHERAL_TYPE', 'COLUMN', N'TABLE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field stores the file name of the small icon, if an icon is to be placed besides the Peripheral Type.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_PERIPHERAL_TYPE', 'COLUMN', N'SMALL_ICON'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field stores the file name of the large icon, if an icon is to be placed besides the Peripheral Type.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_PERIPHERAL_TYPE', 'COLUMN', N'LARGE_ICON'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the peripheral type has been set for archive or not. Value of 1 indicates archived.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_PERIPHERAL_TYPE', 'COLUMN', N'ARCHIVED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the peripheral type has been deleted or not. Value of 1 indicates deleted.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_PERIPHERAL_TYPE', 'COLUMN', N'DELETED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the peripheral type is enabled or not. Value of 1 indicates enabled.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_PERIPHERAL_TYPE', 'COLUMN', N'ENABLED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the peripheral type is hidden or not. Value of 1 indicates hidden.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_PERIPHERAL_TYPE', 'COLUMN', N'HIDDEN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the peripheral type is owned by system or not. Value of 1 indicates system owned peripheral type.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_PERIPHERAL_TYPE', 'COLUMN', N'SYSTEM'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_PERIPHERAL_TYPE', 'COLUMN', N'msrepl_tran_version'
GO
GRANT SELECT
	ON [dbo].[TE_DIM_PERIPHERAL_TYPE]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TE_DIM_PERIPHERAL_TYPE] SET (LOCK_ESCALATION = TABLE)
GO
