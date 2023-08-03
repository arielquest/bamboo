SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TS_SYS_MON_ETL_COMPONENT_OLAP_MEASURE_DETAIL] (
		[DB_DATETIME]                                   [datetime] NOT NULL,
		[RESOURCE_URN]                                  [int] NOT NULL,
		[RESOURCE_ID]                                   [uniqueidentifier] NOT NULL,
		[CLUSTER_NAME]                                  [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[ETL_COMPONENT]                                 [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[ETL_MAX_DESTINATION_DATETIME]                  [datetime] NULL,
		[ETL_MAX_SOURCE_DATETIME]                       [datetime] NULL,
		[OLAP_MEASURE_GROUP]                            [varchar](128) COLLATE Latin1_General_CI_AS NOT NULL,
		[OLAP_MAX_SOURCE_AVAILABLE_DATETIME]            AS (dateadd(minute,(datediff(minute,(0),[ETL_MAX_SOURCE_DATETIME])/(15))*(15),(0))),
		[OLAP_MEASURE_GROUP_MAX_AVAILABLE_DATETIME]     AS (dateadd(minute,(datediff(minute,(0),[ETL_MAX_DESTINATION_DATETIME])/(15))*(15),(0))),
		[OLAP_MEASURE_GROUP_MAX_WRITTEN_DATETIME]       [datetime] NULL,
		[OLAP_LAG_SOURCE_SECONDS]                       AS (case when datediff_big(second,isnull([OLAP_MEASURE_GROUP_MAX_WRITTEN_DATETIME],'1900-01-01'),dateadd(minute,(datediff(minute,(0),[ETL_MAX_SOURCE_DATETIME])/(15))*(15),(0)))<(0) then (0) else datediff_big(second,isnull([OLAP_MEASURE_GROUP_MAX_WRITTEN_DATETIME],'1900-01-01'),dateadd(minute,(datediff(minute,(0),[ETL_MAX_SOURCE_DATETIME])/(15))*(15),(0))) end),
		[OLAP_LAG_SOURCE_DAYS]                          AS (case when datediff_big(day,isnull([OLAP_MEASURE_GROUP_MAX_WRITTEN_DATETIME],'1900-01-01'),dateadd(minute,(datediff(minute,(0),[ETL_MAX_SOURCE_DATETIME])/(15))*(15),(0)))<(0) then (0) else datediff_big(day,isnull([OLAP_MEASURE_GROUP_MAX_WRITTEN_DATETIME],'1900-01-01'),dateadd(minute,(datediff(minute,(0),[ETL_MAX_SOURCE_DATETIME])/(15))*(15),(0))) end),
		[OLAP_LAG_DESTINATION_SECONDS]                  AS (case when datediff_big(second,isnull([OLAP_MEASURE_GROUP_MAX_WRITTEN_DATETIME],'1900-01-01'),dateadd(minute,(datediff(minute,(0),[ETL_MAX_DESTINATION_DATETIME])/(15))*(15),(0)))<(0) then (0) else datediff_big(second,isnull([OLAP_MEASURE_GROUP_MAX_WRITTEN_DATETIME],'1900-01-01'),dateadd(minute,(datediff(minute,(0),[ETL_MAX_DESTINATION_DATETIME])/(15))*(15),(0))) end),
		[OLAP_LAG_DESTINATION_DAYS]                     AS (case when datediff_big(day,isnull([OLAP_MEASURE_GROUP_MAX_WRITTEN_DATETIME],'1900-01-01'),dateadd(minute,(datediff(minute,(0),[ETL_MAX_DESTINATION_DATETIME])/(15))*(15),(0)))<(0) then (0) else datediff_big(day,isnull([OLAP_MEASURE_GROUP_MAX_WRITTEN_DATETIME],'1900-01-01'),dateadd(minute,(datediff(minute,(0),[ETL_MAX_DESTINATION_DATETIME])/(15))*(15),(0))) end),
		[ETL_LAG_SECONDS]                               AS (case when datediff_big(second,isnull([ETL_MAX_DESTINATION_DATETIME],'1900-01-01'),[ETL_MAX_SOURCE_DATETIME])<(0) then (0) else datediff_big(second,isnull([ETL_MAX_DESTINATION_DATETIME],'1900-01-01'),[ETL_MAX_SOURCE_DATETIME]) end),
		[ETL_LAG_DAYS]                                  AS (case when datediff_big(day,isnull([ETL_MAX_DESTINATION_DATETIME],'1900-01-01'),[ETL_MAX_SOURCE_DATETIME])<(0) then (0) else datediff_big(day,isnull([ETL_MAX_DESTINATION_DATETIME],'1900-01-01'),[ETL_MAX_SOURCE_DATETIME]) end)
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TS_SYS_MON_ETL_COMPONENT_OLAP_MEASURE_DETAIL]
	ADD
	CONSTRAINT [DF_TS_SYS_MON_ETL_COMPONENT_OLAP_MEASURE_DETAIL_DATETIME]
	DEFAULT (getutcdate()) FOR [DB_DATETIME]
GO
GRANT SELECT
	ON [dbo].[TS_SYS_MON_ETL_COMPONENT_OLAP_MEASURE_DETAIL]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TS_SYS_MON_ETL_COMPONENT_OLAP_MEASURE_DETAIL] SET (LOCK_ESCALATION = TABLE)
GO
