SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TE_DIM_CHANNEL_TYPE] (
		[TYPE_ID]                 [uniqueidentifier] NOT NULL,
		[NAME]                    [nvarchar](100) COLLATE Latin1_General_CI_AS NOT NULL,
		[INTERNAL_NAME]           [nvarchar](100) COLLATE Latin1_General_CI_AS NOT NULL,
		[DESCRIPTION]             [nvarchar](500) COLLATE Latin1_General_CI_AS NOT NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TE_DIM_CHANNEL_TYPE]
		PRIMARY KEY
		CLUSTERED
		([TYPE_ID])
	ON [DIMINDEXGROUP]
) ON [DIMINDEXGROUP]
GO
ALTER TABLE [dbo].[TE_DIM_CHANNEL_TYPE]
	ADD
	CONSTRAINT [DF_TE_DIM_CHANNEL_TYPE_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table defines the channels that an end-user may use to contact the enterprise or may be contacted by', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_CHANNEL_TYPE', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_CHANNEL_TYPE', 'COLUMN', N'TYPE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Name for this channel type.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_CHANNEL_TYPE', 'COLUMN', N'NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Internal ame for this channel type.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_CHANNEL_TYPE', 'COLUMN', N'INTERNAL_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Description for this channel type.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_CHANNEL_TYPE', 'COLUMN', N'DESCRIPTION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TE_DIM_CHANNEL_TYPE', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TE_DIM_CHANNEL_TYPE]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TE_DIM_CHANNEL_TYPE]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TE_DIM_CHANNEL_TYPE]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TE_DIM_CHANNEL_TYPE]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TE_DIM_CHANNEL_TYPE] SET (LOCK_ESCALATION = TABLE)
GO
