SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TB_FCT_VA_SESSION] (
		[PARTITION_URN]                  [int] NOT NULL,
		[PARTITION_ID]                   [int] NOT NULL,
		[PARTITION_GLOBAL_URN]           [bigint] NOT NULL,
		[DATE_TIME_UTC]                  [datetime] NOT NULL,
		[DATE_UTC_URN]                   [int] NOT NULL,
		[TIME_UTC_URN]                   [smallint] NOT NULL,
		[CLUSTER_RESOURCE_URN]           [int] NOT NULL,
		[TENANT_URN]                     [int] NOT NULL,
		[SESSION_ID]                     [int] NOT NULL,
		[VA_ASSISTANT_URN]               [int] NOT NULL,
		[VA_CASE_GROUP_URN]              [int] NOT NULL,
		[VA_CASE_QUESTION_GROUP_URN]     [int] NOT NULL,
		[VA_KEYWORD_GROUP_URN]           [int] NOT NULL,
		[VA_DOMAIN_GROUP_URN]            [int] NOT NULL,
		[VA_CATEGORY_GROUP_URN]          [int] NOT NULL,
		[VA_ATTRIBUTE_GROUP_URN]         [int] NOT NULL,
		[VA_URL_GROUP_URN]               [int] NOT NULL,
		[SESSIONS]                       [int] NULL,
		[SERVICED]                       [int] NULL,
		[ABANDONED]                      [int] NULL,
		[RELEVANT_SESSIONS]              [int] NULL,
		[ESCALATED_SESSIONS]             [int] NULL,
		[EXCHANGES]                      [int] NULL,
		[DURATION]                       [bigint] NULL,
		CONSTRAINT [PK_FCT_VA_SESSION]
		PRIMARY KEY
		CLUSTERED
		([PARTITION_URN], [PARTITION_ID])
	ON [FCTEGNGROUP]
) ON [FCTEGNGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA_SESSION', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA_SESSION', 'COLUMN', N'PARTITION_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number for the current partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA_SESSION', 'COLUMN', N'PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column holds a value that uniquely identifies a row across all the partition tables for this partition type.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA_SESSION', 'COLUMN', N'PARTITION_GLOBAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The date and time when the event occurred in UTC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA_SESSION', 'COLUMN', N'DATE_TIME_UTC'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the date of the DATE_TIME_UTC value.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA_SESSION', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DATE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA_SESSION', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the time of the DATE_TIME_UTC value.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA_SESSION', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIME', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA_SESSION', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column gives information regarding the source of the data. This corresponds to the RESOURCE_URN from TB_CLU_RESOURCE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA_SESSION', 'COLUMN', N'CLUSTER_RESOURCE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_TENANT.ITEM_URN and refers to the Tenant (or "Department" on the source).', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA_SESSION', 'COLUMN', N'TENANT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TENANT', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA_SESSION', 'COLUMN', N'TENANT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to field SESSION_ID in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA_SESSION', 'COLUMN', N'SESSION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN that represents VA Assistant information, as TB_DIM_VA_ASSISTANT.ITEM_URN.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA_SESSION', 'COLUMN', N'VA_ASSISTANT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN that represents VA Case Group information, as TB_DIM_VA_CASE_GROUP.ITEM_URN.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA_SESSION', 'COLUMN', N'VA_CASE_GROUP_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN that represents VA Case Question Group information, as TB_DIM_VA_CASE_QUESTION_GROUP.ITEM_URN.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA_SESSION', 'COLUMN', N'VA_CASE_QUESTION_GROUP_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN that represents VA Keyword Group information, as TB_DIM_VA_KEYWORD_GROUP.ITEM_URN.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA_SESSION', 'COLUMN', N'VA_KEYWORD_GROUP_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN that represents VA Domain Group information, as TB_DIM_VA_DOMAIN_GROUP.ITEM_URN.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA_SESSION', 'COLUMN', N'VA_DOMAIN_GROUP_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN that represents VA Domain Category information, as TB_DIM_VA_CATEGORY_GROUP.ITEM_URN.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA_SESSION', 'COLUMN', N'VA_CATEGORY_GROUP_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN that represents VA Attribute Group information, as TB_DIM_VA_ATTRIBUTE_GROUP.ITEM_URN.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA_SESSION', 'COLUMN', N'VA_ATTRIBUTE_GROUP_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN that represents VA Domain Group information, as TB_DIM_VA_DOMAIN_GROUP.ITEM_URN.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA_SESSION', 'COLUMN', N'VA_URL_GROUP_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'TO-DO', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA_SESSION', 'COLUMN', N'SESSIONS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'TO-DO', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA_SESSION', 'COLUMN', N'SERVICED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'TO-DO', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA_SESSION', 'COLUMN', N'ABANDONED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'TO-DO', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA_SESSION', 'COLUMN', N'RELEVANT_SESSIONS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'TO-DO', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA_SESSION', 'COLUMN', N'ESCALATED_SESSIONS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'TO-DO', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA_SESSION', 'COLUMN', N'EXCHANGES'
GO
EXEC sp_addextendedproperty N'MS_Description', N'TO-DO', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA_SESSION', 'COLUMN', N'DURATION'
GO
GRANT SELECT
	ON [dbo].[TB_FCT_VA_SESSION]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_FCT_VA_SESSION]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_FCT_VA_SESSION]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_FCT_VA_SESSION] SET (LOCK_ESCALATION = TABLE)
GO
