SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TB_SUM_CHAT_SKILLGROUP_HH] (
		[PARTITION_URN]                 [int] IDENTITY(1, 1) NOT NULL,
		[PARTITION_ID]                  [int] NOT NULL,
		[PARTITION_GLOBAL_URN]          [bigint] NOT NULL,
		[DATE_URN]                      [int] NOT NULL,
		[TIME_URN]                      [smallint] NOT NULL,
		[DATE_UTC_URN]                  [int] NOT NULL,
		[TIME_UTC_URN]                  [smallint] NOT NULL,
		[DATE_TIME]                     [datetime] NOT NULL,
		[UTC_TIMEZONE]                  [int] NOT NULL,
		[SKILLGROUP_URN]                [int] NOT NULL,
		[LOGGED_ON_TTH]                 [int] NULL,
		[HANDLED_CHATS_TTH]             [int] NULL,
		[HANDLED_CHATS_QUEUE_TTH]       [int] NULL,
		[QUEUE_TTH]                     [int] NULL,
		[HANDLED_CHATS_TH]              [int] NULL,
		[COLLABORATED_IN_CHATS_TH]      [int] NULL,
		[COLLABORATED_OUT_CHATS_TH]     [int] NULL,
		[OFFERED_CHATS_TH]              [int] NULL,
		[ANSWERED_CHATS_TH]             [int] NULL,
		[SERVICE_LEVEL_CHATS_TH]        [int] NULL,
		[ABANDONED_CHATS_TH]            [int] NULL,
		[AGENT_OUT_CHATS_TH]            [int] NULL,
		[CLUSTER_RESOURCE_URN]          [int] NOT NULL
) ON [SUMMMGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_SUM_CHAT_SKILLGROUP_HH_DATE_TIME]
	ON [dbo].[TB_SUM_CHAT_SKILLGROUP_HH] ([DATE_TIME])
	ON [SUMICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CHAT_SKILLGROUP_HH', 'INDEX', N'IX_SUM_CHAT_SKILLGROUP_HH_DATE_TIME'
GO
CREATE NONCLUSTERED INDEX [IX_SUM_CHAT_SKILLGROUP_HH_DATE_URN]
	ON [dbo].[TB_SUM_CHAT_SKILLGROUP_HH] ([DATE_URN])
	ON [SUMICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CHAT_SKILLGROUP_HH', 'INDEX', N'IX_SUM_CHAT_SKILLGROUP_HH_DATE_URN'
GO
CREATE NONCLUSTERED INDEX [IX_SUM_CHAT_SKILLGROUP_HH_SKILLGROUP_URN]
	ON [dbo].[TB_SUM_CHAT_SKILLGROUP_HH] ([SKILLGROUP_URN])
	ON [SUMICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CHAT_SKILLGROUP_HH', 'INDEX', N'IX_SUM_CHAT_SKILLGROUP_HH_SKILLGROUP_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the template table for the historical half hour summary statistics for all the chat skillgroups in the application. This table is created at install time and the partitioning service creates various partition tables with the same schema. These partition tables are prefixed as TB_SUM_CHAT_SKILLGROUP_HH_ followed by the partition identifier. The partition identifier is created depending on the importer configuration, for example monthly, weekly etc. All currently active partitions are included VW_PARTITONED_SUM_CHAT_SKILLGROUP_HH view. Since the partitioned tables are generated at runtime and that they have the same schema no separate documentations are required for each partition table. The data in these partitioned tables are source from a third party data store.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CHAT_SKILLGROUP_HH', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the partition.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CHAT_SKILLGROUP_HH', 'COLUMN', N'PARTITION_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number for the current partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CHAT_SKILLGROUP_HH', 'COLUMN', N'PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column holds a value that uniquely identifies a row across all the partition tables for this partition type.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CHAT_SKILLGROUP_HH', 'COLUMN', N'PARTITION_GLOBAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the date associated with the record. This is calculated by the data importer based on the source date time corresponding to the start of the half hour interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CHAT_SKILLGROUP_HH', 'COLUMN', N'DATE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DATE', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CHAT_SKILLGROUP_HH', 'COLUMN', N'DATE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the time associated with the record. This is calculated by the data importer based on the source date time corresponding to the start of the half hour interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CHAT_SKILLGROUP_HH', 'COLUMN', N'TIME_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIME', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CHAT_SKILLGROUP_HH', 'COLUMN', N'TIME_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the UTC date associated with the record. This is calculated by the data importer based on the source date time corresponding to the start of the half hour interval and the TimeZone information from the source data.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CHAT_SKILLGROUP_HH', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DATE', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CHAT_SKILLGROUP_HH', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the UTC time associated with the record. This is calculated by the data importer based on the source date time corresponding to the start of the half hour interval and the TimeZone information from the source data.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CHAT_SKILLGROUP_HH', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIME', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CHAT_SKILLGROUP_HH', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the wall clock date time corresponding to the start of the half hour interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CHAT_SKILLGROUP_HH', 'COLUMN', N'DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the offset in minutes from UTC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CHAT_SKILLGROUP_HH', 'COLUMN', N'UTC_TIMEZONE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_SKILLGROUP for an item of type IT_SKILLGROUP indicating the chat skillgroup.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CHAT_SKILLGROUP_HH', 'COLUMN', N'SKILLGROUP_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_SKILLGROUP', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CHAT_SKILLGROUP_HH', 'COLUMN', N'SKILLGROUP_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total logged on time in seconds for the chat skillgroup in the half hour interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CHAT_SKILLGROUP_HH', 'COLUMN', N'LOGGED_ON_TTH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time in seconds for all the chats handled by the skillgroup in the half hour interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CHAT_SKILLGROUP_HH', 'COLUMN', N'HANDLED_CHATS_TTH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is total time in seconds that all handle chats spent in the queue for the chat skillgroup in the half hour interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CHAT_SKILLGROUP_HH', 'COLUMN', N'HANDLED_CHATS_QUEUE_TTH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time in seconds for all chats that spent in the queue.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CHAT_SKILLGROUP_HH', 'COLUMN', N'QUEUE_TTH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of chats handled by the chat skillgroup in the half hour interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CHAT_SKILLGROUP_HH', 'COLUMN', N'HANDLED_CHATS_TH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of chats that were refered in or collabrated in to the chat skillgroup in the half hour interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CHAT_SKILLGROUP_HH', 'COLUMN', N'COLLABORATED_IN_CHATS_TH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of chats that were refered to other skillgroups or collabrated out to other skillgroups by the chat skillgroup in the half hour interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CHAT_SKILLGROUP_HH', 'COLUMN', N'COLLABORATED_OUT_CHATS_TH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of chats offered to the skillgroup in the half hour interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CHAT_SKILLGROUP_HH', 'COLUMN', N'OFFERED_CHATS_TH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of chats that were successfully answered by the skillgroup in the half hour interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CHAT_SKILLGROUP_HH', 'COLUMN', N'ANSWERED_CHATS_TH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of chats to the skillgroup in the half hour interval where the desired service level was met.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CHAT_SKILLGROUP_HH', 'COLUMN', N'SERVICE_LEVEL_CHATS_TH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of chats abandoned on the skillgroup during the half hour interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CHAT_SKILLGROUP_HH', 'COLUMN', N'ABANDONED_CHATS_TH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of chats initiated by all the agents in the skillgroup in the half hour interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CHAT_SKILLGROUP_HH', 'COLUMN', N'AGENT_OUT_CHATS_TH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column gives information regarding the source of the data. This corresponds to the RESOURCE_URN from TB_CLU_RESOURCE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CHAT_SKILLGROUP_HH', 'COLUMN', N'CLUSTER_RESOURCE_URN'
GO
GRANT SELECT
	ON [dbo].[TB_SUM_CHAT_SKILLGROUP_HH]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_SUM_CHAT_SKILLGROUP_HH]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_SUM_CHAT_SKILLGROUP_HH]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_SUM_CHAT_SKILLGROUP_HH] SET (LOCK_ESCALATION = TABLE)
GO
