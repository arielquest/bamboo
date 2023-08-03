SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TB_SUM_NETWORK_TRUNK_GROUP_HH] (
		[SUMMARIZED_URN]               [int] IDENTITY(0, 1) NOT FOR REPLICATION NOT NULL,
		[DATE_URN]                     [int] NOT NULL,
		[TIME_URN]                     [smallint] NOT NULL,
		[DATE_UTC_URN]                 [int] NOT NULL,
		[TIME_UTC_URN]                 [smallint] NOT NULL,
		[NETWORK_TRUNK_GROUP_URN]      [int] NOT NULL,
		[ALL_TRUNKS_BUSY_TTH]          [int] NULL,
		[CALLS_ABANDONED_TTH]          [int] NULL,
		[CALLS_IN_TTH]                 [int] NULL,
		[CALLS_OUT_TTH]                [int] NULL,
		[IN_SERVICE_TIME_TTH]          [int] NULL,
		[IN_USE_INBOUND_TIME_TTH]      [int] NULL,
		[IN_USE_OUTBOUND_TIME_TTH]     [int] NULL,
		[TRUNKS_IDLE]                  [int] NULL,
		[TRUNKS_IN_SERVICE]            [int] NULL,
		[PARTITION_ID]                 [int] NOT NULL,
		[RECOVERY_KEY]                 [float] NULL,
		[DB_DATETIME]                  [datetime] NULL,
		[DATE_TIME]                    [datetime] NOT NULL,
		[CLUSTER_RESOURCE_URN]         [int] NOT NULL
) ON [SUMICMGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_SUM_NETWORK_TRUNK_GROUP_HH_AGENT_URN]
	ON [dbo].[TB_SUM_NETWORK_TRUNK_GROUP_HH] ([NETWORK_TRUNK_GROUP_URN])
	ON [SUMICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NETWORK_TRUNK_GROUP_HH', 'INDEX', N'IX_SUM_NETWORK_TRUNK_GROUP_HH_AGENT_URN'
GO
CREATE NONCLUSTERED INDEX [IX_SUM_NETWORK_TRUNK_GROUP_HH_DATE_TIME]
	ON [dbo].[TB_SUM_NETWORK_TRUNK_GROUP_HH] ([DATE_TIME])
	ON [SUMICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NETWORK_TRUNK_GROUP_HH', 'INDEX', N'IX_SUM_NETWORK_TRUNK_GROUP_HH_DATE_TIME'
GO
CREATE NONCLUSTERED INDEX [IX_SUM_NETWORK_TRUNK_GROUP_HH_DATE_URN]
	ON [dbo].[TB_SUM_NETWORK_TRUNK_GROUP_HH] ([DATE_URN])
	ON [SUMICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NETWORK_TRUNK_GROUP_HH', 'INDEX', N'IX_SUM_NETWORK_TRUNK_GROUP_HH_DATE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the template table for the historical half hour summary statistics for all the network trunk groups in the application. This table is created as install time and the data importer creates various partition tables with the same schema. These partition tables are prefixed as TB_SUM_NETWORK_TRUNK_GROUP_HH_ followed by the partition identifier. The partition identifier is created depending on the importer configuration, for example monthly, weekly etc. All currently active partitions are included VW_PARTITONED_SUM_NETWORK_TRUNK_GROUP_HH view. Since the partitioned tables are generated at runtime and that they have the same schema no separate documentations are required for each partition table. In case of Cisco ICM/IPCC the data in these partitioned tables is imported from t_Network_Trunk_Group_Half_Hour table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NETWORK_TRUNK_GROUP_HH', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NETWORK_TRUNK_GROUP_HH', 'COLUMN', N'SUMMARIZED_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the date associated with the record. This is calculated by the data importer based on the source date time corresponding to the start of the half hour interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NETWORK_TRUNK_GROUP_HH', 'COLUMN', N'DATE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DATE', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NETWORK_TRUNK_GROUP_HH', 'COLUMN', N'DATE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the time associated with the record. This is calculated by the data importer based on the source date time corresponding to the start of the half hour interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NETWORK_TRUNK_GROUP_HH', 'COLUMN', N'TIME_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIME', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NETWORK_TRUNK_GROUP_HH', 'COLUMN', N'TIME_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the UTC date associated with the record. This is calculated by the data importer based on the source date time corresponding to the start of the half hour interval and the TimeZone information from the source data.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NETWORK_TRUNK_GROUP_HH', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DATE', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NETWORK_TRUNK_GROUP_HH', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the UTC time associated with the record. This is calculated by the data importer based on the source date time corresponding to the start of the half hour interval and the TimeZone information from the source data.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NETWORK_TRUNK_GROUP_HH', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIME', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NETWORK_TRUNK_GROUP_HH', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_NETWORK_TRUNK_GROUP corresponding to an item of type IT_NETWORK_TRUNK_GROUP. This corresponds to the network trunk group associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NETWORK_TRUNK_GROUP_HH', 'COLUMN', N'NETWORK_TRUNK_GROUP_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_NETWORK_TRUNK_GROUP', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NETWORK_TRUNK_GROUP_HH', 'COLUMN', N'NETWORK_TRUNK_GROUP_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the time, in seconds, for which all trunks in the network trunk group were busy simultaneously during the half hour interval. The data in this column maps to AllTrunksBusyToHalf column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NETWORK_TRUNK_GROUP_HH', 'COLUMN', N'ALL_TRUNKS_BUSY_TTH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls to the network trunk group that were abandoned during the half hour interval. The data in this column maps to CallsAbandonedToHalf column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NETWORK_TRUNK_GROUP_HH', 'COLUMN', N'CALLS_ABANDONED_TTH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total inbound calls offered to the network trunk group during the half hour interval. The data in this column maps to CallsInToHalf column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NETWORK_TRUNK_GROUP_HH', 'COLUMN', N'CALLS_IN_TTH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total outbound calls sent on the network trunk group during the half hour interval. The data in this column maps to CallsOutToHalf column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NETWORK_TRUNK_GROUP_HH', 'COLUMN', N'CALLS_OUT_TTH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, across all the trunks in the network trunk group when they were in service during the half hour interval. The data in this column maps to InServiceTimeToHalf column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NETWORK_TRUNK_GROUP_HH', 'COLUMN', N'IN_SERVICE_TIME_TTH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, across all the trunks in the network trunk group when they were in service for inbound calls during the half hour interval. The data in this column maps to InUseInboundTimeToHalf column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NETWORK_TRUNK_GROUP_HH', 'COLUMN', N'IN_USE_INBOUND_TIME_TTH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, across all the trunks in the network trunk group when they were in service for outbound calls during the half hour interval. The data in this column maps to InUseOutboundTimeToHalf column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NETWORK_TRUNK_GROUP_HH', 'COLUMN', N'IN_USE_OUTBOUND_TIME_TTH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of trunks in the network trunk group that were idle at the end of the half hour interval. The data in this column maps to TrunksIdle column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NETWORK_TRUNK_GROUP_HH', 'COLUMN', N'TRUNKS_IDLE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of trunks in the network trunk group that were in service at the end of the half hour interval. The data in this column maps to TrunksInService column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NETWORK_TRUNK_GROUP_HH', 'COLUMN', N'TRUNKS_IN_SERVICE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number for the current partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NETWORK_TRUNK_GROUP_HH', 'COLUMN', N'PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the surrogate key identifier for the record from the source data. The data in this column maps to RecoveryKey column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NETWORK_TRUNK_GROUP_HH', 'COLUMN', N'RECOVERY_KEY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use. This is a date time stamp corresponding to when the data was written into the source database. The data in this column maps to DbDateTime column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NETWORK_TRUNK_GROUP_HH', 'COLUMN', N'DB_DATETIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the datetime stamp associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NETWORK_TRUNK_GROUP_HH', 'COLUMN', N'DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column gives information regarding the source of the data. This corresponds to the RESOURCE_URN from TB_CLU_RESOURCE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NETWORK_TRUNK_GROUP_HH', 'COLUMN', N'CLUSTER_RESOURCE_URN'
GO
GRANT SELECT
	ON [dbo].[TB_SUM_NETWORK_TRUNK_GROUP_HH]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_SUM_NETWORK_TRUNK_GROUP_HH]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_SUM_NETWORK_TRUNK_GROUP_HH]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_SUM_NETWORK_TRUNK_GROUP_HH] SET (LOCK_ESCALATION = TABLE)
GO
