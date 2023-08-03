SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TB_FCT_CALLTRACK_DETAIL] (
		[PARTITION_URN]                  [int] NOT NULL,
		[PARTITION_GLOBAL_URN]           [bigint] NOT NULL,
		[PARTITION_ID]                   [int] NOT NULL,
		[COMPLETED_DATE_TIME_UTC]        [datetime] NOT NULL,
		[COMPLETED_DATE_UTC_URN]         [int] NOT NULL,
		[COMPLETED_TIME_UTC_URN]         [smallint] NOT NULL,
		[CLUSTER_RESOURCE_URN]           [int] NOT NULL,
		[ACTIVITY_ID]                    [numeric](19, 0) NOT NULL,
		[ACTIVITY_URN]                   [int] NOT NULL,
		[CREATED_TIME]                   [datetime] NOT NULL,
		[CALL_DIRECTION]                 [int] NOT NULL,
		[ACTIVITY_SUB_TYPE_CODE_URN]     [int] NOT NULL,
		[CASE_ID]                        [numeric](19, 0) NOT NULL,
		[CASE_URN]                       [int] NOT NULL,
		[CASE_TYPE]                      [int] NOT NULL,
		[CUSTOMER_URN]                   [int] NOT NULL,
		[CONTACT_POINT_URN]              [int] NOT NULL,
		[TENANT_URN]                     [int] NOT NULL,
		[QUEUE_URN]                      [int] NOT NULL,
		[AGENT_URN]                      [int] NOT NULL,
		[PRIORITY]                       [int] NOT NULL,
		[CONFIRMATIONS_SENT_CNTR]        [int] NOT NULL,
		[COMPLETED_CNTR]                 [int] NOT NULL,
		[ACTIVITY_DURATION]              [int] NOT NULL,
		[COMPLETED_MET_SLA_CNTR]         [int] NOT NULL,
		[HANDLE_TIME]                    [int] NOT NULL,
		CONSTRAINT [PK_FCT_CALLTRACK_DETAIL]
		PRIMARY KEY
		CLUSTERED
		([PARTITION_URN])
	ON [FCTEGNGROUP]
) ON [FCTEGNGROUP]
GO
GRANT SELECT
	ON [dbo].[TB_FCT_CALLTRACK_DETAIL]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_FCT_CALLTRACK_DETAIL]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_FCT_CALLTRACK_DETAIL]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_FCT_CALLTRACK_DETAIL] SET (LOCK_ESCALATION = TABLE)
GO
