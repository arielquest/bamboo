SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_FCT_VA_SESSION_EXCHANGE] (
		[PARTITION_URN]                  [int] NOT NULL,
		[PARTITION_ID]                   [int] NOT NULL,
		[PARTITION_GLOBAL_URN]           [bigint] NOT NULL,
		[DATE_TIME_UTC]                  [datetime] NOT NULL,
		[DATE_UTC_URN]                   [int] NOT NULL,
		[TIME_UTC_URN]                   [smallint] NOT NULL,
		[CLUSTER_RESOURCE_URN]           [int] NOT NULL,
		[TENANT_URN]                     [int] NOT NULL,
		[SEQ_ID]                         [bigint] NOT NULL,
		[SESSION_ID]                     [int] NOT NULL,
		[EXCHANGE_NUMBER]                [int] NOT NULL,
		[DATE_TIME]                      [datetime] NOT NULL,
		[VA_ASSISTANT_URN]               [int] NOT NULL,
		[VA_DOMAIN_URN]                  [int] NOT NULL,
		[VA_CATEGORY_URN]                [int] NOT NULL,
		[VA_CASE_GROUP_URN]              [int] NOT NULL,
		[VA_CASE_QUESTION_GROUP_URN]     [int] NOT NULL,
		[VA_KEYWORD_GROUP_URN]           [int] NOT NULL,
		[VA_ATTRIBUTE_GROUP_URN]         [int] NOT NULL,
		[VA_URL_GROUP_URN]               [int] NOT NULL,
		[ASK]                            [nvarchar](max) COLLATE Latin1_General_CI_AS NULL,
		[REPLY]                          [nvarchar](max) COLLATE Latin1_General_CI_AS NULL,
		[EXCHANGES]                      [int] NULL,
		[RELEVANT_EXCHANGES]             [int] NULL,
		[CLARIFICATIONS]                 [int] NULL,
		[OUT_OF_DOMAIN]                  [int] NULL,
		[URL_PUSHED]                     [int] NULL,
		[FAILED]                         [int] NULL,
		CONSTRAINT [PK_FCT_VA_SESSION_EXCHANGE]
		PRIMARY KEY
		CLUSTERED
		([PARTITION_URN], [PARTITION_ID])
	ON [FCTEGNGROUP]
) ON [FCTEGNGROUP] TEXTIMAGE_ON [FCTEGNGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA_SESSION_EXCHANGE', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA_SESSION_EXCHANGE', 'COLUMN', N'PARTITION_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number for the current partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA_SESSION_EXCHANGE', 'COLUMN', N'PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column holds a value that uniquely identifies a row across all the partition tables for this partition type.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA_SESSION_EXCHANGE', 'COLUMN', N'PARTITION_GLOBAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The date and time when the event occurred in UTC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA_SESSION_EXCHANGE', 'COLUMN', N'DATE_TIME_UTC'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the date of the DATE_TIME_UTC value.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA_SESSION_EXCHANGE', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DATE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA_SESSION_EXCHANGE', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the time of the DATE_TIME_UTC value.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA_SESSION_EXCHANGE', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIME', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA_SESSION_EXCHANGE', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column gives information regarding the source of the data. This corresponds to the RESOURCE_URN from TB_CLU_RESOURCE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA_SESSION_EXCHANGE', 'COLUMN', N'CLUSTER_RESOURCE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_TENANT.ITEM_URN and refers to the Tenant (or "Department" on the source).', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA_SESSION_EXCHANGE', 'COLUMN', N'TENANT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TENANT', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA_SESSION_EXCHANGE', 'COLUMN', N'TENANT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to field SEQ_ID in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA_SESSION_EXCHANGE', 'COLUMN', N'SEQ_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to field SESSION_ID in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA_SESSION_EXCHANGE', 'COLUMN', N'SESSION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'TO-DO', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA_SESSION_EXCHANGE', 'COLUMN', N'EXCHANGE_NUMBER'
GO
EXEC sp_addextendedproperty N'MS_Description', N'TO-DO', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA_SESSION_EXCHANGE', 'COLUMN', N'DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN that represents VA Assistant information, as TB_DIM_VA_ASSISTANT.ITEM_URN.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA_SESSION_EXCHANGE', 'COLUMN', N'VA_ASSISTANT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN that represents VA Domain information, as TB_DIM_VA_DOMAIN_.ITEM_URN.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA_SESSION_EXCHANGE', 'COLUMN', N'VA_DOMAIN_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN that represents VA Category information, as TB_DIM_VA_CATEGORY.ITEM_URN.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA_SESSION_EXCHANGE', 'COLUMN', N'VA_CATEGORY_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN that represents VA Case Group information, as TB_DIM_VA_CASE_GROUP.ITEM_URN.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA_SESSION_EXCHANGE', 'COLUMN', N'VA_CASE_GROUP_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN that represents VA Case Question Group information, as TB_DIM_VA_CASE_QUESTION_GROUP.ITEM_URN.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA_SESSION_EXCHANGE', 'COLUMN', N'VA_CASE_QUESTION_GROUP_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN that represents VA Keyword Group information, as TB_DIM_VA_KEYWORD_GROUP.ITEM_URN.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA_SESSION_EXCHANGE', 'COLUMN', N'VA_KEYWORD_GROUP_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN that represents VA Attribute Group information, as TB_DIM_VA_ATTRIBUTE_GROUP.ITEM_URN.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA_SESSION_EXCHANGE', 'COLUMN', N'VA_ATTRIBUTE_GROUP_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN that represents VA Url Group information, as TB_DIM_VA_URL_GROUP.ITEM_URN.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA_SESSION_EXCHANGE', 'COLUMN', N'VA_URL_GROUP_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'TO-DO', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA_SESSION_EXCHANGE', 'COLUMN', N'ASK'
GO
EXEC sp_addextendedproperty N'MS_Description', N'TO-DO', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA_SESSION_EXCHANGE', 'COLUMN', N'REPLY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'TO-DO', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA_SESSION_EXCHANGE', 'COLUMN', N'EXCHANGES'
GO
EXEC sp_addextendedproperty N'MS_Description', N'TO-DO', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA_SESSION_EXCHANGE', 'COLUMN', N'RELEVANT_EXCHANGES'
GO
EXEC sp_addextendedproperty N'MS_Description', N'TO-DO', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA_SESSION_EXCHANGE', 'COLUMN', N'CLARIFICATIONS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'TO-DO', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA_SESSION_EXCHANGE', 'COLUMN', N'OUT_OF_DOMAIN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'TO-DO', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA_SESSION_EXCHANGE', 'COLUMN', N'URL_PUSHED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'TO-DO', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA_SESSION_EXCHANGE', 'COLUMN', N'FAILED'
GO
GRANT SELECT
	ON [dbo].[TB_FCT_VA_SESSION_EXCHANGE]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_FCT_VA_SESSION_EXCHANGE]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_FCT_VA_SESSION_EXCHANGE]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_FCT_VA_SESSION_EXCHANGE] SET (LOCK_ESCALATION = TABLE)
GO
