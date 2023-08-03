SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_SUM_GATEWAY_REQUEST_HH] (
		[SUMMARIZED_URN]           [int] IDENTITY(0, 1) NOT FOR REPLICATION NOT NULL,
		[GATEWAY_SERVER_URN]       [int] NOT NULL,
		[GATEWAY_FUNCTION_URN]     [int] NOT NULL,
		[GATEWAY_RESULT_URN]       [int] NOT NULL,
		[DATE_URN]                 [int] NOT NULL,
		[TIME_URN]                 [smallint] NOT NULL,
		[DATE_UTC_URN]             [int] NOT NULL,
		[TIME_UTC_URN]             [smallint] NOT NULL,
		[GATEWAY_CUST_NAME]        [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[REQUEST_TOT]              [bigint] NULL,
		[REQUEST_TIME_TOT]         [bigint] NULL,
		[REQUEST_TIME_MAX]         [int] NULL,
		[REQUEST_TIME_AVG]         [int] NULL,
		[EXEC_TIME_TOT]            [bigint] NULL,
		[EXEC_TIME_MAX]            [int] NULL,
		[EXEC_TIME_AVG]            [int] NULL,
		[PARTITION_ID]             [int] NOT NULL,
		[RECOVERY_KEY]             [float] NULL,
		[DATE_TIME]                [datetime] NOT NULL,
		[CLUSTER_RESOURCE_URN]     [int] NOT NULL
) ON [SUMMMGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the template table for the historical hour hour statistics of gateway requests. This table is created as install time and the data importer creates various partition tables with the same schema. These partition tables are prefixed as TB_SUM_GATEWAY_REQUEST_HH_ followed by the partition identifier. The partition identifier is created depending on the importer configuration, for example monthly, weekly etc. All currently active partitions are included VW_PARTITONED_SUM_GATEWAY_REQUEST_HH view. Since the partitioned tables are generated at runtime and that they have the same schema no separate documentations are required for each partition table. The data in these partitioned tables are imported from the table TB_RequestHalfHour in the gateway audit database GwAudit.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_GATEWAY_REQUEST_HH', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_GATEWAY_REQUEST_HH', 'COLUMN', N'SUMMARIZED_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_GATEWAY_SERVER for an item of type IT_GATEWAY_SERVER.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_GATEWAY_REQUEST_HH', 'COLUMN', N'GATEWAY_SERVER_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_GATEWAY_FUNCTION for an item of type IT_GATEWAY_FUNCTION.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_GATEWAY_REQUEST_HH', 'COLUMN', N'GATEWAY_FUNCTION_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_GATEWAY_RESULT for an item of type IT_GATEWAY_RESULT.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_GATEWAY_REQUEST_HH', 'COLUMN', N'GATEWAY_RESULT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the date associated with the record. This is calculated by the data importer based on the source date time corresponding to the half hour interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_GATEWAY_REQUEST_HH', 'COLUMN', N'DATE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the time associated with the record. This is calculated by the data importer based on the source date time corresponding to the half hour interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_GATEWAY_REQUEST_HH', 'COLUMN', N'TIME_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the UTC date associated with the record. This is calculated by the data importer based on the source date time corresponding to the half hour interval and the time zone information from the source data.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_GATEWAY_REQUEST_HH', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the UTC time associated with the record. This is calculated by the data importer based on the source date time corresponding to the half hour interval and the time zone information from the source data.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_GATEWAY_REQUEST_HH', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to rrh_Customer column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_GATEWAY_REQUEST_HH', 'COLUMN', N'GATEWAY_CUST_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of request for the gateway function, for the customer on the particular server during the half hour interval. This maps to rrh_Count column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_GATEWAY_REQUEST_HH', 'COLUMN', N'REQUEST_TOT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total request time, in milliseconds, for the gateway function, for the customer on the particular server during the half hour interval. This maps to rrh_TotalReqTime column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_GATEWAY_REQUEST_HH', 'COLUMN', N'REQUEST_TIME_TOT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the maximum request time, in milliseconds, for the gateway function, for the customer on the particular server during the half hour interval. This maps to rrh_MaxReqTime column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_GATEWAY_REQUEST_HH', 'COLUMN', N'REQUEST_TIME_MAX'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the average request time, in milliseconds, for the gateway function, for the customer on the particular server during the half hour interval. This maps to rrh_AvgReqTime column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_GATEWAY_REQUEST_HH', 'COLUMN', N'REQUEST_TIME_AVG'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total execution time, in milliseconds, for the request for the gateway function, for the customer on the particular server during the half hour interval. This maps to rrh_TotalExecTime column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_GATEWAY_REQUEST_HH', 'COLUMN', N'EXEC_TIME_TOT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the maximum execution time, in milliseconds, for the gateway function, for the customer on the particular server during the half hour interval. This maps to rrh_MaxExecTime column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_GATEWAY_REQUEST_HH', 'COLUMN', N'EXEC_TIME_MAX'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the average request time, in milliseconds, for the gateway function, for the customer on the particular server during the half hour interval. This maps to rrh_AvgExecTime column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_GATEWAY_REQUEST_HH', 'COLUMN', N'EXEC_TIME_AVG'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number for the current partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_GATEWAY_REQUEST_HH', 'COLUMN', N'PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the surrogate key identifier for the record from the source data. The data in this column maps to rhh_ID column.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_GATEWAY_REQUEST_HH', 'COLUMN', N'RECOVERY_KEY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the datetime stamp associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_GATEWAY_REQUEST_HH', 'COLUMN', N'DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column gives information regarding the source of the data. This corresponds to the RESOURCE_URN from TB_CLU_RESOURCE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_GATEWAY_REQUEST_HH', 'COLUMN', N'CLUSTER_RESOURCE_URN'
GO
GRANT SELECT
	ON [dbo].[TB_SUM_GATEWAY_REQUEST_HH]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_SUM_GATEWAY_REQUEST_HH]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_SUM_GATEWAY_REQUEST_HH]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_SUM_GATEWAY_REQUEST_HH] SET (LOCK_ESCALATION = TABLE)
GO
