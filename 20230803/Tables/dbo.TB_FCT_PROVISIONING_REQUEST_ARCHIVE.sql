SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_FCT_PROVISIONING_REQUEST_ARCHIVE] (
		[PARTITION_URN]            [int] NOT NULL,
		[PARTITION_GLOBAL_URN]     [bigint] NOT NULL,
		[PARTITION_ID]             [int] NOT NULL,
		[ID]                       [uniqueidentifier] NOT NULL,
		[BATCH_ID]                 [uniqueidentifier] NULL,
		[CLUSTER_RESOURCE_ID]      [uniqueidentifier] NOT NULL,
		[RESOURCE_TYPE_ID]         [uniqueidentifier] NOT NULL,
		[RESOURCE_KEY_1]           [nvarchar](40) COLLATE Latin1_General_CI_AS NOT NULL,
		[RESOURCE_KEY_2]           [nvarchar](40) COLLATE Latin1_General_CI_AS NULL,
		[OPERATION]                [char](1) COLLATE Latin1_General_CI_AS NULL,
		[RECORD_NUMBER]            [smallint] NOT NULL,
		[TOTAL_RECORDS]            [smallint] NOT NULL,
		[COMPLETION_DATE]          [datetime] NOT NULL,
		[RETRY_COUNT]              [tinyint] NULL,
		[STATUS]                   [char](1) COLLATE Latin1_General_CI_AS NULL,
		[STATUS_MESSAGE]           [nvarchar](200) COLLATE Latin1_General_CI_AS NULL,
		[CREATED_BY_ID]            [uniqueidentifier] NOT NULL,
		[MODIFIED_BY_ID]           [uniqueidentifier] NOT NULL,
		[CREATION_DATE]            [datetime] NOT NULL,
		[MODIFIED_DATE]            [datetime] NOT NULL,
		[XML_DATA]                 [xml](DOCUMENT [dbo].[ColumnCollection]) NULL
) ON [FCTAUDGROUP] TEXTIMAGE_ON [FCTAUDGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the template table for the provisioning request archived data. This table is created at install time and the partitioning service creates various partition tables with the same schema. These partition tables are prefixed as TB_FCT_PROVISIONING_REQUEST_ARCHIVE_ followed by the partition identifier. The partition identifier is created depending on the partitioning configuration, for example monthly, weekly etc. The default partitioning is daily. All currently active partitions are included VW_FCT_PROVISIONING_REQUEST_ARCHIVE view. Since the partitioned tables are generated at runtime and that they have the same schema no separate documentations are required for each partition table. The data in the various partition tables are sourced from the table TB_ADM_PROVISIONING_REQUEST.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_PROVISIONING_REQUEST_ARCHIVE', NULL, NULL
GO
GRANT SELECT
	ON [dbo].[TB_FCT_PROVISIONING_REQUEST_ARCHIVE]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_FCT_PROVISIONING_REQUEST_ARCHIVE] SET (LOCK_ESCALATION = TABLE)
GO
