SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TB_DIM_SLA_BUCKET_INTERVAL_MAP] (
		[SLA_BUCKET_INTERVAL_MAP_URN]     [int] IDENTITY(1, 4) NOT FOR REPLICATION NOT NULL,
		[ITEM_BIZ_URN]                    [int] NOT NULL,
		[ITEM_TYPE_URN]                   [int] NOT NULL,
		[SLA_BUCKET_INTERVAL_URN]         [int] NOT NULL,
		[SLA_CHANNEL_TYPE_URN]            [bigint] NOT NULL,
		[SLA_BUCKET_INTERVAL_TYPE]        [tinyint] NOT NULL,
		[EFFECTIVE_FROM]                  [datetime] NOT NULL,
		[EFFECTIVE_TO]                    [datetime] NOT NULL,
		[CREATED_BY_ID]                   [uniqueidentifier] NOT NULL,
		[MODIFIED_BY_ID]                  [uniqueidentifier] NOT NULL,
		[CREATION_DATE]                   [datetime] NOT NULL,
		[MODIFIED_DATE]                   [datetime] NOT NULL,
		[DELETED]                         [bit] NOT NULL,
		[SYSTEM]                          [bit] NOT NULL,
		[CHANGE_STAMP]                    [int] NOT NULL,
		[msrepl_tran_version]             [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TB_DIM_SLA_BUCKET_INTERVAL_MAP]
		PRIMARY KEY
		CLUSTERED
		([SLA_BUCKET_INTERVAL_MAP_URN])
	ON [DIMINDEXGROUP]
) ON [DIMINDEXGROUP]
GO
ALTER TABLE [dbo].[TB_DIM_SLA_BUCKET_INTERVAL_MAP]
	ADD
	CONSTRAINT [CK_TB_DIM_SLA_BUCKET_INTERVAL_MAP_SLA_BUCKET_INTERVAL_TYPE]
	CHECK
	([SLA_BUCKET_INTERVAL_TYPE]=(2) OR [SLA_BUCKET_INTERVAL_TYPE]=(1) OR [SLA_BUCKET_INTERVAL_TYPE]=(0))
GO
ALTER TABLE [dbo].[TB_DIM_SLA_BUCKET_INTERVAL_MAP]
CHECK CONSTRAINT [CK_TB_DIM_SLA_BUCKET_INTERVAL_MAP_SLA_BUCKET_INTERVAL_TYPE]
GO
ALTER TABLE [dbo].[TB_DIM_SLA_BUCKET_INTERVAL_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_SLA_BUCKET_INTERVAL_MAP_SLA_BUCKET_INTERVAL_TYPE]
	DEFAULT ((0)) FOR [SLA_BUCKET_INTERVAL_TYPE]
GO
ALTER TABLE [dbo].[TB_DIM_SLA_BUCKET_INTERVAL_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_SLA_BUCKET_INTERVAL_MAP_EFFECTIVE_FROM]
	DEFAULT (getutcdate()) FOR [EFFECTIVE_FROM]
GO
ALTER TABLE [dbo].[TB_DIM_SLA_BUCKET_INTERVAL_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_SLA_BUCKET_INTERVAL_MAP_EFFECTIVE_TO]
	DEFAULT ('2079-06-06 00:00:00') FOR [EFFECTIVE_TO]
GO
ALTER TABLE [dbo].[TB_DIM_SLA_BUCKET_INTERVAL_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_SLA_BUCKET_INTERVAL_MAP_CREATION_DATE]
	DEFAULT (getutcdate()) FOR [CREATION_DATE]
GO
ALTER TABLE [dbo].[TB_DIM_SLA_BUCKET_INTERVAL_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_SLA_BUCKET_INTERVAL_MAP_MODIFIED]
	DEFAULT (getutcdate()) FOR [MODIFIED_DATE]
GO
ALTER TABLE [dbo].[TB_DIM_SLA_BUCKET_INTERVAL_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_SLA_BUCKET_INTERVAL_MAP_DELETED]
	DEFAULT ((0)) FOR [DELETED]
GO
ALTER TABLE [dbo].[TB_DIM_SLA_BUCKET_INTERVAL_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_SLA_BUCKET_INTERVAL_MAP_SYSTEM]
	DEFAULT ((0)) FOR [SYSTEM]
GO
ALTER TABLE [dbo].[TB_DIM_SLA_BUCKET_INTERVAL_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_SLA_BUCKET_INTERVAL_MAP_CHANGESTAMP]
	DEFAULT ((0)) FOR [CHANGE_STAMP]
GO
ALTER TABLE [dbo].[TB_DIM_SLA_BUCKET_INTERVAL_MAP]
	ADD
	CONSTRAINT [DF_TB_DIM_SLA_BUCKET_INTERVAL_MAP_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_DIM_SLA_BUCKET_INTERVAL_MAP]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_DIM_SLA_BUCKET_INTERVAL_MAP_TB_DIM_SLA_BUCKET_INTERVAL_URN]
	FOREIGN KEY ([SLA_BUCKET_INTERVAL_URN]) REFERENCES [dbo].[TB_DIM_SLA_BUCKET_INTERVAL] ([ITEM_URN])
	ON DELETE CASCADE
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_DIM_SLA_BUCKET_INTERVAL_MAP]
	CHECK CONSTRAINT [FK_TB_DIM_SLA_BUCKET_INTERVAL_MAP_TB_DIM_SLA_BUCKET_INTERVAL_URN]

GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_TB_DIM_SLA_BUCKET_INTERVAL_MAP_CHECK_INTERVAL_TYPE]
	ON [dbo].[TB_DIM_SLA_BUCKET_INTERVAL_MAP] ([ITEM_BIZ_URN], [ITEM_TYPE_URN], [SLA_BUCKET_INTERVAL_URN], [SLA_CHANNEL_TYPE_URN], [SLA_BUCKET_INTERVAL_TYPE])
	ON [DIMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_DIM_SLA_BUCKET_INTERVAL_MAP_SLA_BUCKET_INTERVAL_URN]
	ON [dbo].[TB_DIM_SLA_BUCKET_INTERVAL_MAP] ([SLA_BUCKET_INTERVAL_URN])
	ON [DIMINDEXGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table is used to map SLA Bucket Intervals with an item type, such as a queue.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_SLA_BUCKET_INTERVAL_MAP', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record. This is an auto generated number.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_SLA_BUCKET_INTERVAL_MAP', 'COLUMN', N'SLA_BUCKET_INTERVAL_MAP_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the ITEM_BIZ_URN from the corresponding dimension table e.g. TB_DIM_QUEUE to the item being associated with an SLA bucket interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_SLA_BUCKET_INTERVAL_MAP', 'COLUMN', N'ITEM_BIZ_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the ITEM_TYPE_URN in TE_DIM_ITEM_TYPE of the dimension being associated with an SLA bucket interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_SLA_BUCKET_INTERVAL_MAP', 'COLUMN', N'ITEM_TYPE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the ITEM_BIZ_URN from TB_DIM_SLA_BUCKET_INTERVAL which references the interval of this mapping.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_SLA_BUCKET_INTERVAL_MAP', 'COLUMN', N'SLA_BUCKET_INTERVAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the SLA_CHANNEL_TYPE_URN from VW_DIM_SLA_CHANNEL_TYPE_CUBE which references the channel type of this mapping.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_SLA_BUCKET_INTERVAL_MAP', 'COLUMN', N'SLA_CHANNEL_TYPE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is an enum and determines the type of bucket interval this mapping references.  Expected values are 0 (all), 1 (answered) and 2 (abandoned).  Note, if 1 or 2 are used then they overrule the "0" interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_SLA_BUCKET_INTERVAL_MAP', 'COLUMN', N'SLA_BUCKET_INTERVAL_TYPE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a UTC date time indicating when the item will become active.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_SLA_BUCKET_INTERVAL_MAP', 'COLUMN', N'EFFECTIVE_FROM'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a UTC date time indicating when the item will cease to exist.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_SLA_BUCKET_INTERVAL_MAP', 'COLUMN', N'EFFECTIVE_TO'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TB_SEC_USER corresponding to the user who created the item.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_SLA_BUCKET_INTERVAL_MAP', 'COLUMN', N'CREATED_BY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TB_SEC_USER corresponding to the user who last modified the item.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_SLA_BUCKET_INTERVAL_MAP', 'COLUMN', N'MODIFIED_BY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the UTC date time stamp indicating when the item was created.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_SLA_BUCKET_INTERVAL_MAP', 'COLUMN', N'CREATION_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the UTC date time stamp indicating when the item was last modified.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_SLA_BUCKET_INTERVAL_MAP', 'COLUMN', N'MODIFIED_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the item is deleted or not. Value 1 indicates deleted.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_SLA_BUCKET_INTERVAL_MAP', 'COLUMN', N'DELETED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the item is owned by the system or not. Value 1 indicates system owned item.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_SLA_BUCKET_INTERVAL_MAP', 'COLUMN', N'SYSTEM'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is an incremental number indicating the change stamp for the specific item.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_SLA_BUCKET_INTERVAL_MAP', 'COLUMN', N'CHANGE_STAMP'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_SLA_BUCKET_INTERVAL_MAP', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_DIM_SLA_BUCKET_INTERVAL_MAP]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_DIM_SLA_BUCKET_INTERVAL_MAP]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_DIM_SLA_BUCKET_INTERVAL_MAP]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_DIM_SLA_BUCKET_INTERVAL_MAP]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_DIM_SLA_BUCKET_INTERVAL_MAP]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_DIM_SLA_BUCKET_INTERVAL_MAP] SET (LOCK_ESCALATION = TABLE)
GO
