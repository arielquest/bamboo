SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TB_SUM_TRUNK_GROUP_5M] (
		[SUMMARIZED_URN]           [int] IDENTITY(0, 1) NOT FOR REPLICATION NOT NULL,
		[TRUNK_GROUP_URN]          [int] NOT NULL,
		[DATE_URN]                 [int] NOT NULL,
		[TIME_URN]                 [smallint] NOT NULL,
		[DATE_UTC_URN]             [int] NOT NULL,
		[TIME_UTC_URN]             [smallint] NOT NULL,
		[TRUNKS_IN_SERVICE]        [int] NULL,
		[ALL_TRUNKS_BUSY_TH]       [int] NULL,
		[TRUNKS_IDLE]              [int] NULL,
		[PARTITION_ID]             [int] NOT NULL,
		[RECOVERY_KEY]             [float] NULL,
		[DATE_TIME]                [datetime] NOT NULL,
		[CLUSTER_RESOURCE_URN]     [int] NOT NULL
) ON [SUMICMGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the template table for the historical five minute summary statistics of all the trunk groups in the application. This table is created as install time and the data importer creates various partition tables with the same schema. These partition tables are prefixed as TB_SUM_TRUNK_GROUP_5M_ followed by the partition identifier. The partition identifier is created depending on the importer configuration, for example monthly, weekly etc. All currently active partitions are included VW_PARTITONED_SUM_TRUNK_GROUP_5M view. Since the partitioned tables are generated at runtime and that they have the same schema no separate documentations are required for each partition table. In case of Cisco ICM/IPCC the data in these partitioned tables is imported from t_Trunk_Group_Five_Minute table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_TRUNK_GROUP_5M', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_TRUNK_GROUP_5M', 'COLUMN', N'SUMMARIZED_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TRUNK_GROUP for an item of type IT_TRUNK_GROUP. This is the trunk group associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_TRUNK_GROUP_5M', 'COLUMN', N'TRUNK_GROUP_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the date associated with the record. This is calculated by the data importer based on the source date time corresponding to the start of the five minute interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_TRUNK_GROUP_5M', 'COLUMN', N'DATE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the time associated with the record. This is calculated by the data importer based on the source date time corresponding to the start of the five minute interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_TRUNK_GROUP_5M', 'COLUMN', N'TIME_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the UTC date associated with the record. This is calculated by the data importer based on the source date time corresponding to the start of the five minute interval and the TimeZone information from the source data.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_TRUNK_GROUP_5M', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the UTC time associated with the record. This is calculated by the data importer based on the source date time corresponding to the start of the five minute interval and the TimeZone information from the source data.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_TRUNK_GROUP_5M', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of trunks in the trunk group that were in service at the end of the five minute interval. In Cisco ICM/IPCC this maps to TrunksInService column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_TRUNK_GROUP_5M', 'COLUMN', N'TRUNKS_IN_SERVICE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, during the current half-hour interval that all trunks in the trunk group were busy. In Cisco ICM/IPCC this maps to AllTrunksBusyToHalf column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_TRUNK_GROUP_5M', 'COLUMN', N'ALL_TRUNKS_BUSY_TH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of trunks in the trunk group that were idle at the end of the five minute interval. In Cisco ICM/IPCC this maps to TrunksIdle column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_TRUNK_GROUP_5M', 'COLUMN', N'TRUNKS_IDLE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number for the current partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_TRUNK_GROUP_5M', 'COLUMN', N'PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the surrogate key identifier for the record from the source data. The data in this column maps to RecoveryKey column in Cisco ICM/IPCC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_TRUNK_GROUP_5M', 'COLUMN', N'RECOVERY_KEY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the datetime stamp associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_TRUNK_GROUP_5M', 'COLUMN', N'DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column gives information regarding the source of the data. This corresponds to the RESOURCE_URN from TB_CLU_RESOURCE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_TRUNK_GROUP_5M', 'COLUMN', N'CLUSTER_RESOURCE_URN'
GO
GRANT SELECT
	ON [dbo].[TB_SUM_TRUNK_GROUP_5M]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_SUM_TRUNK_GROUP_5M]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_SUM_TRUNK_GROUP_5M]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_SUM_TRUNK_GROUP_5M] SET (LOCK_ESCALATION = TABLE)
GO
