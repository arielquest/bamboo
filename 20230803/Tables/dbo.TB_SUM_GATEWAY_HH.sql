SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TB_SUM_GATEWAY_HH] (
		[SUMMARIZED_URN]           [int] IDENTITY(0, 1) NOT FOR REPLICATION NOT NULL,
		[GATEWAY_SERVER_URN]       [int] NOT NULL,
		[DATE_URN]                 [int] NOT NULL,
		[TIME_URN]                 [smallint] NOT NULL,
		[DATE_UTC_URN]             [int] NOT NULL,
		[TIME_UTC_URN]             [smallint] NOT NULL,
		[REQUESTS_TH]              [int] NULL,
		[REJECTS_TH]               [int] NULL,
		[TIMEOUTS_TH]              [int] NULL,
		[MAXDELAY_TTH]             [int] NULL,
		[AVGDELAY_TTH]             [int] NULL,
		[UNAVAILABLE_TTH]          [int] NULL,
		[ERRORS_TH]                [int] NULL,
		[LATEST_TH]                [int] NULL,
		[PARTITION_ID]             [int] NOT NULL,
		[RECOVERY_KEY]             [float] NULL,
		[DATE_TIME]                [datetime] NOT NULL,
		[CLUSTER_RESOURCE_URN]     [int] NOT NULL
) ON [SUMMMGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table is for future use. Hence this table is not documented.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_GATEWAY_HH', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column gives information regarding the source of the data. This corresponds to the RESOURCE_URN from TB_CLU_RESOURCE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_GATEWAY_HH', 'COLUMN', N'CLUSTER_RESOURCE_URN'
GO
GRANT SELECT
	ON [dbo].[TB_SUM_GATEWAY_HH]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_SUM_GATEWAY_HH]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_SUM_GATEWAY_HH]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_SUM_GATEWAY_HH] SET (LOCK_ESCALATION = TABLE)
GO
