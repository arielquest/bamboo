SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_FCT_VA3_SESSION_EXCHANGE] (
		[PARTITION_URN]            [int] NOT NULL,
		[PARTITION_ID]             [int] NOT NULL,
		[PARTITION_GLOBAL_URN]     [bigint] NOT NULL,
		[DATE_TIME_UTC]            [datetime] NOT NULL,
		[DATE_UTC_URN]             [int] NOT NULL,
		[TIME_UTC_URN]             [smallint] NOT NULL,
		[CLUSTER_RESOURCE_URN]     [int] NOT NULL,
		[TENANT_URN]               [int] NOT NULL,
		[SEQ_ID]                   [bigint] NOT NULL,
		[SESSION_ID]               [int] NOT NULL,
		[EXCHANGE_NUMBER]          [int] NOT NULL,
		[VA_ASSISTANT_URN]         [int] NOT NULL,
		[VA_INTENT_URN]            [int] NOT NULL,
		[VA_CATEGORY_URN]          [int] NOT NULL,
		[VA_CLASSFIER_URN]         [int] NOT NULL,
		[VA_DOMAIN_URN]            [int] NOT NULL,
		[VA_SCORE_TYPE_URN]        [int] NOT NULL,
		[VA_URL_URN]               [int] NOT NULL,
		[VA_CHANNEL_URN]           [int] NOT NULL,
		[KB_ARTICLE_URN]           [int] NOT NULL,
		[LANGUAGE_URN]             [int] NOT NULL,
		[EXCHANGE_LABEL_URN]       [int] NULL,
		[EXCHANGE]                 [int] NULL,
		[ARTICLE_SHOWN]            [int] NULL,
		[INTENT_IDENTIFIED]        [int] NULL,
		[SCORE]                    [float] NULL,
		[URL_PUSHED]               [int] NULL,
		[CHATS_ACCEPTED]           [int] NULL,
		[CHATS_ELIGIBLE]           [int] NULL,
		[CHATS_MISSED]             [int] NULL,
		[CHATS_OFF_HOURS]          [int] NULL,
		[CHATS_OFFERED]            [int] NULL,
		[CHATS_REJECTED]           [int] NULL,
		[ESCALATION_ACCEPTED]      [int] NULL,
		[ESCALATION_ELIGIBLE]      [int] NULL,
		[ESCALATION_MISSED]        [int] NULL,
		[ESCALATION_OFF_HOURS]     [int] NULL,
		[ESCALATION_OFFERED]       [int] NULL,
		[ESCALATION_REJECTED]      [int] NULL,
		[WARM_XFER_ACCEPTED]       [int] NULL,
		[WARM_XFER_ELIGIBLE]       [int] NULL,
		[WARM_XFER_MISSED]         [int] NULL,
		[WARM_XFER_OFF_HOURS]      [int] NULL,
		[WARM_XFER_OFFERED]        [int] NULL,
		[WARM_XFER_REJECTED]       [int] NULL,
		[ASK]                      [nvarchar](max) COLLATE Latin1_General_CI_AS NULL,
		[REPLY]                    [nvarchar](max) COLLATE Latin1_General_CI_AS NULL,
		CONSTRAINT [PK_FCT_VA3_SESSION_EXCHANGE]
		PRIMARY KEY
		CLUSTERED
		([PARTITION_URN], [PARTITION_ID])
	ON [FCTEGNGROUP]
) ON [FCTEGNGROUP] TEXTIMAGE_ON [FCTEGNGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA3_SESSION_EXCHANGE', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA3_SESSION_EXCHANGE', 'COLUMN', N'PARTITION_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number for the current partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA3_SESSION_EXCHANGE', 'COLUMN', N'PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column holds a value that uniquely identifies a row across all the partition tables for this partition type.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA3_SESSION_EXCHANGE', 'COLUMN', N'PARTITION_GLOBAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The date and time when the event occurred in UTC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA3_SESSION_EXCHANGE', 'COLUMN', N'DATE_TIME_UTC'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the date of the DATE_TIME_UTC value.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA3_SESSION_EXCHANGE', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DATE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA3_SESSION_EXCHANGE', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the time of the DATE_TIME_UTC value.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA3_SESSION_EXCHANGE', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIME', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA3_SESSION_EXCHANGE', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column gives information regarding the source of the data. This corresponds to the RESOURCE_URN from TB_CLU_RESOURCE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA3_SESSION_EXCHANGE', 'COLUMN', N'CLUSTER_RESOURCE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_TENANT.ITEM_URN and refers to the Tenant (or "Department" on the source).', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA3_SESSION_EXCHANGE', 'COLUMN', N'TENANT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TENANT', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA3_SESSION_EXCHANGE', 'COLUMN', N'TENANT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to field SEQ_ID in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA3_SESSION_EXCHANGE', 'COLUMN', N'SEQ_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to field SESSION_ID in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA3_SESSION_EXCHANGE', 'COLUMN', N'SESSION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'TO-DO', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA3_SESSION_EXCHANGE', 'COLUMN', N'EXCHANGE_NUMBER'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN that represents VA Assistant information, as TB_DIM_VA_ASSISTANT.ITEM_URN.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA3_SESSION_EXCHANGE', 'COLUMN', N'VA_ASSISTANT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN that represents VA Intent information, as TB_DIM_VA_INTENT.ITEM_URN.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA3_SESSION_EXCHANGE', 'COLUMN', N'VA_INTENT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN that represents VA Category information, as TB_DIM_VA_CATEGORY.ITEM_URN.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA3_SESSION_EXCHANGE', 'COLUMN', N'VA_CATEGORY_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN that represents VA Classifier information, as TB_DIM_VA_CLASSFIER.ITEM_URN.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA3_SESSION_EXCHANGE', 'COLUMN', N'VA_CLASSFIER_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN that represents VA Domain information, as TB_DIM_VA_DOMAIN.ITEM_URN.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA3_SESSION_EXCHANGE', 'COLUMN', N'VA_DOMAIN_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'A score type eg: very high, high, medium, low, very low that was given as part of the Intent. This is the URN that represents VA Score type information, as VW_DIM_VA_SCORE_TYPE_CUBE.VA_SCORE_TYPE_URN.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA3_SESSION_EXCHANGE', 'COLUMN', N'VA_SCORE_TYPE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN that represents VA Url information, as TB_DIM_VA_URL.ITEM_URN.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA3_SESSION_EXCHANGE', 'COLUMN', N'VA_URL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'TO-DO', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA3_SESSION_EXCHANGE', 'COLUMN', N'VA_CHANNEL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN that represents KB Article information, as TB_DIM_KB_ARTICLE.ITEM_URN.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA3_SESSION_EXCHANGE', 'COLUMN', N'KB_ARTICLE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN that represents the the visitor speach as TE_ADM_CULTURE_LANGUAGE.LANGUAGE_URN.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA3_SESSION_EXCHANGE', 'COLUMN', N'LANGUAGE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'A label describing the type of session.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA3_SESSION_EXCHANGE', 'COLUMN', N'EXCHANGE_LABEL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Every message sent by VA, either as a greeting or in response to a customer message.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA3_SESSION_EXCHANGE', 'COLUMN', N'EXCHANGE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This represents every exchange where an article was shown.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA3_SESSION_EXCHANGE', 'COLUMN', N'ARTICLE_SHOWN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Every exchange where the classifier returned an intent and score.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA3_SESSION_EXCHANGE', 'COLUMN', N'INTENT_IDENTIFIED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'A score that was given as part of the Intent.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA3_SESSION_EXCHANGE', 'COLUMN', N'SCORE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Every exchange where a URL was page-pushed.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA3_SESSION_EXCHANGE', 'COLUMN', N'URL_PUSHED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'TO-DO', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA3_SESSION_EXCHANGE', 'COLUMN', N'CHATS_ACCEPTED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'TO-DO', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA3_SESSION_EXCHANGE', 'COLUMN', N'CHATS_ELIGIBLE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'TO-DO', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA3_SESSION_EXCHANGE', 'COLUMN', N'CHATS_MISSED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'TO-DO', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA3_SESSION_EXCHANGE', 'COLUMN', N'CHATS_OFF_HOURS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'TO-DO', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA3_SESSION_EXCHANGE', 'COLUMN', N'CHATS_OFFERED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'TO-DO', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA3_SESSION_EXCHANGE', 'COLUMN', N'CHATS_REJECTED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'TO-DO', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA3_SESSION_EXCHANGE', 'COLUMN', N'ESCALATION_ACCEPTED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'TO-DO', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA3_SESSION_EXCHANGE', 'COLUMN', N'ESCALATION_ELIGIBLE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'TO-DO', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA3_SESSION_EXCHANGE', 'COLUMN', N'ESCALATION_MISSED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'TO-DO', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA3_SESSION_EXCHANGE', 'COLUMN', N'ESCALATION_OFF_HOURS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'TO-DO', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA3_SESSION_EXCHANGE', 'COLUMN', N'ESCALATION_OFFERED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'TO-DO', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA3_SESSION_EXCHANGE', 'COLUMN', N'ESCALATION_REJECTED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Every exchange where the customer was eligible for a transfer and an agent is available and the customer accepts the offer.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA3_SESSION_EXCHANGE', 'COLUMN', N'WARM_XFER_ACCEPTED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Every exchange where the customer was eligible for a transfer, whether or not agent is available.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA3_SESSION_EXCHANGE', 'COLUMN', N'WARM_XFER_ELIGIBLE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'TO-DO', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA3_SESSION_EXCHANGE', 'COLUMN', N'WARM_XFER_MISSED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Every exchange where the customer was eligible for a transfer but no agent is available.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA3_SESSION_EXCHANGE', 'COLUMN', N'WARM_XFER_OFF_HOURS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Every exchange where the customer was eligible for a transfer and an agent is available.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA3_SESSION_EXCHANGE', 'COLUMN', N'WARM_XFER_OFFERED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Every exchange where the customer was eligible for a transfer and an agent is available but the customer rejects (or ignores) the offer.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA3_SESSION_EXCHANGE', 'COLUMN', N'WARM_XFER_REJECTED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'TO-DO', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA3_SESSION_EXCHANGE', 'COLUMN', N'ASK'
GO
EXEC sp_addextendedproperty N'MS_Description', N'TO-DO', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VA3_SESSION_EXCHANGE', 'COLUMN', N'REPLY'
GO
GRANT SELECT
	ON [dbo].[TB_FCT_VA3_SESSION_EXCHANGE]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_FCT_VA3_SESSION_EXCHANGE]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_FCT_VA3_SESSION_EXCHANGE]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_FCT_VA3_SESSION_EXCHANGE] SET (LOCK_ESCALATION = TABLE)
GO
