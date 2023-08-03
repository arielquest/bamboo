SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TB_SUM_PERIPHERAL_INTERVAL] (
		[SUMMARIZED_URN]                      [int] NOT NULL,
		[DATE_UTC_URN]                        [int] NOT NULL,
		[TIME_UTC_URN]                        [smallint] NOT NULL,
		[DATE_URN]                            [int] NOT NULL,
		[TIME_URN]                            [smallint] NOT NULL,
		[PERIPHERAL_URN]                      [int] NOT NULL,
		[ACTIVE_PERIPHERAL_DATA_TIME]         [int] NULL,
		[ACTIVE_ROUTING_CLIENT_TIME]          [int] NULL,
		[ACTIVE_PERIPHERAL_TIME]              [int] NULL,
		[ACTIVE_CTI_SERVER_TIME]              [int] NULL,
		[CALLS_OFFERED]                       [int] NULL,
		[SERVICE_LEVEL_CALLS_OFFERED]         [int] NULL,
		[SERVICE_LEVEL_CALLS]                 [int] NULL,
		[SERVICE_LEVEL_ABAND]                 [int] NULL,
		[SERVICE_LEVEL]                       [int] NULL,
		[PARTITION_ID]                        [int] NOT NULL,
		[RECOVERY_KEY]                        [float] NULL,
		[DB_DATETIME]                         [datetime] NULL,
		[MEDIA_ROUTING_DOMAIN_URN]            [int] NULL,
		[NUMBER_OF_SAMPLES]                   [int] NULL,
		[MAX_CALLS_IN_PROGRESS]               [int] NULL,
		[TOTAL_CALLS_IN_PROGRESS_SAMPLES]     [int] NULL,
		[DATE_TIME]                           [datetime] NOT NULL,
		[SERVICE_LEVEL_TYPE]                  [int] NULL,
		[MAX_NUMBER_LOGGED_ON_AGENTS]         [int] NULL,
		[REPORTING_HALF_HOUR]                 [int] NULL,
		[REPORTING_INTERVAL]                  [int] NULL,
		[TIME_ZONE]                           [int] NULL,
		[CLUSTER_RESOURCE_URN]                [int] NOT NULL,
		[MAX_CVP_CALL_CONTROL_PORTS]          [int] NULL,
		[MAX_VRU_PORTS]                       [int] NULL
) ON [SUMICMGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_SUM_PERIPHERAL_INTERVAL_DATE_TIME]
	ON [dbo].[TB_SUM_PERIPHERAL_INTERVAL] ([DATE_TIME])
	ON [SUMICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_PERIPHERAL_INTERVAL', 'INDEX', N'IX_SUM_PERIPHERAL_INTERVAL_DATE_TIME'
GO
CREATE NONCLUSTERED INDEX [IX_SUM_PERIPHERAL_INTERVAL_DATE_URN]
	ON [dbo].[TB_SUM_PERIPHERAL_INTERVAL] ([DATE_URN])
	ON [SUMICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_PERIPHERAL_INTERVAL', 'INDEX', N'IX_SUM_PERIPHERAL_INTERVAL_DATE_URN'
GO
CREATE NONCLUSTERED INDEX [IX_SUM_PERIPHERAL_INTERVAL_PERIPHERAL_URN]
	ON [dbo].[TB_SUM_PERIPHERAL_INTERVAL] ([PERIPHERAL_URN])
	ON [SUMICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_PERIPHERAL_INTERVAL', 'INDEX', N'IX_SUM_PERIPHERAL_INTERVAL_PERIPHERAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the template table for the historical summary statistics for all the peripherals in the application. This table is created at install time and the partitioning service creates various partition tables with the same schema. These partition tables are prefixed as TB_SUM_PERIPHERAL_INTERVAL_ followed by the partition identifier. The partition identifier is created depending on the partition configuration, for example monthly, weekly etc. All currently active partitions are included VW_PARTITONED_SUM_PERIPHERAL_INTERVAL view. Since the partitioned tables are generated at runtime and that they have the same schema no separate documentations are required for each partition table. In case of Cisco ICM/IPCC the data in these partitioned tables is imported from t_Peripheral_Half_Hour or t_Peripheral_Interval table for version 8.0 or higher.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_PERIPHERAL_INTERVAL', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_PERIPHERAL_INTERVAL', 'COLUMN', N'SUMMARIZED_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the UTC date associated with the record. This is calculated by the data importer based on the source date time corresponding to the start of the reporting interval and the TimeZone information from the source data.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_PERIPHERAL_INTERVAL', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DATE', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_PERIPHERAL_INTERVAL', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the UTC time associated with the record. This is calculated by the data importer based on the source date time corresponding to the start of the reporting interval and the TimeZone information from the source data.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_PERIPHERAL_INTERVAL', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIME', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_PERIPHERAL_INTERVAL', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the date associated with the record. This is calculated by the data importer based on the source date time corresponding to the start of the reporting interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_PERIPHERAL_INTERVAL', 'COLUMN', N'DATE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DATE', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_PERIPHERAL_INTERVAL', 'COLUMN', N'DATE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the time associated with the record. This is calculated by the data importer based on the source date time corresponding to the start of the reporting interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_PERIPHERAL_INTERVAL', 'COLUMN', N'TIME_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIME', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_PERIPHERAL_INTERVAL', 'COLUMN', N'TIME_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_PERIPHERAL corresponding to an item of type IT_PERIPHERAL. This corresponds to the peripheral associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_PERIPHERAL_INTERVAL', 'COLUMN', N'PERIPHERAL_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_PERIPHERAL', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_PERIPHERAL_INTERVAL', 'COLUMN', N'PERIPHERAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, the associated peripheral gateway was able to provide peripheral data services to the CallRouter during the reporting interval. The data in this column maps to ActivePeripheralDataTimeToHalf or ActivePeripheralDataTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_PERIPHERAL_INTERVAL', 'COLUMN', N'ACTIVE_PERIPHERAL_DATA_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, the associated peripheral gateway was able to provide routing client support to the CallRouter during the reporting interval. The data in this column maps to ActiveRoutingClientTimeToHalf or ActiveRoutingClientTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_PERIPHERAL_INTERVAL', 'COLUMN', N'ACTIVE_ROUTING_CLIENT_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, the associated peripheral gateway''s connection to the peripheral were active during the reporting interval. The data in this column maps to ActivePeripheralTimeToHalf or ActivePeripheralTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_PERIPHERAL_INTERVAL', 'COLUMN', N'ACTIVE_PERIPHERAL_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, the associated CTI Server was in active state during the reporting interval. The data in this column maps to ActiveCTIServerTimeToHalf or ActiveCTIServerTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_PERIPHERAL_INTERVAL', 'COLUMN', N'ACTIVE_CTI_SERVER_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of incoming ACD and internal ACD calls that were offered to the peripheral during the reporting interval. The data in this column maps to CallsOfferedToHalf or CallsOffered column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_PERIPHERAL_INTERVAL', 'COLUMN', N'CALLS_OFFERED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls to the peripheral that had service level events during the reporting interval. The data in this column maps to ServiceLevelCallsOfferedToHalf or ServiceLevelCallsOffered column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_PERIPHERAL_INTERVAL', 'COLUMN', N'SERVICE_LEVEL_CALLS_OFFERED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls to the peripheral that were answered within the service level threshold during the reporting interval. The data in this column maps to ServiceLevelCallsToHalf or ServiceLevelCalls column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_PERIPHERAL_INTERVAL', 'COLUMN', N'SERVICE_LEVEL_CALLS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls to the peripheral that were abandoned within the service level threshold during the reporting interval. The data in this column maps to ServiceLevelAbandToHalf or ServiceLevelAband column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_PERIPHERAL_INTERVAL', 'COLUMN', N'SERVICE_LEVEL_ABAND'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the service level for the peripheral during the reporting interval. The data in this column maps to ServiceLevelToHalf or ServiceLevel column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_PERIPHERAL_INTERVAL', 'COLUMN', N'SERVICE_LEVEL'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number for the current partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_PERIPHERAL_INTERVAL', 'COLUMN', N'PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the surrogate key identifier for the record from the source data. The data in this column maps to RecoveryKey column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_PERIPHERAL_INTERVAL', 'COLUMN', N'RECOVERY_KEY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use. This is a date time stamp corresponding to when the data was written into the source database. The data in this column maps to DbDateTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_PERIPHERAL_INTERVAL', 'COLUMN', N'DB_DATETIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_MEDIA_ROUTING_DOMAIN corresponding to an item of type IT_MEDIA_ROUTING_DOMAIN. This corresponds to the media routing domain associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_PERIPHERAL_INTERVAL', 'COLUMN', N'MEDIA_ROUTING_DOMAIN_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_MEDIA_ROUTING_DOMAIN', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_PERIPHERAL_INTERVAL', 'COLUMN', N'MEDIA_ROUTING_DOMAIN_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls in progress sample periods. The data in this column maps to NumberOfSamples column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_PERIPHERAL_INTERVAL', 'COLUMN', N'NUMBER_OF_SAMPLES'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the maximum number of calls in progress at any sample point. The data in this column maps to MaxCallsInProgress column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_PERIPHERAL_INTERVAL', 'COLUMN', N'MAX_CALLS_IN_PROGRESS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls in progress at all sample points during the reporting interval. The data in this column maps to TotalCallsInProgressSamples column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_PERIPHERAL_INTERVAL', 'COLUMN', N'TOTAL_CALLS_IN_PROGRESS_SAMPLES'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the datetime stamp associated with the record. This corresponds to the start of the reporting interval. This maps to the DateTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_PERIPHERAL_INTERVAL', 'COLUMN', N'DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the service level type used to calculate the service level for the reporting interval. This maps to the ServiceLevelType column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_PERIPHERAL_INTERVAL', 'COLUMN', N'SERVICE_LEVEL_TYPE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the maximumn number of agents logged on in the reporting interval. This maps to the MaxNumberLoggedOnAgents column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_PERIPHERAL_INTERVAL', 'COLUMN', N'MAX_NUMBER_LOGGED_ON_AGENTS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to the ReportingHalfHour column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_PERIPHERAL_INTERVAL', 'COLUMN', N'REPORTING_HALF_HOUR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to the ReportingInterval column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_PERIPHERAL_INTERVAL', 'COLUMN', N'REPORTING_INTERVAL'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the offset in minutes from UTC for the date and time. This maps to the TimeZone column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_PERIPHERAL_INTERVAL', 'COLUMN', N'TIME_ZONE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column gives information regarding the source of the data. This corresponds to the RESOURCE_URN from TB_CLU_RESOURCE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_PERIPHERAL_INTERVAL', 'COLUMN', N'CLUSTER_RESOURCE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_PERIPHERAL_INTERVAL', 'COLUMN', N'MAX_CVP_CALL_CONTROL_PORTS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_PERIPHERAL_INTERVAL', 'COLUMN', N'MAX_VRU_PORTS'
GO
GRANT SELECT
	ON [dbo].[TB_SUM_PERIPHERAL_INTERVAL]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_SUM_PERIPHERAL_INTERVAL]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_SUM_PERIPHERAL_INTERVAL]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_SUM_PERIPHERAL_INTERVAL] SET (LOCK_ESCALATION = TABLE)
GO
