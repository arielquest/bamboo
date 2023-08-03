SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TB_FCT_OFFERS_DETAIL] (
		[PARTITION_URN]            [int] NOT NULL,
		[PARTITION_GLOBAL_URN]     [bigint] NOT NULL,
		[PARTITION_ID]             [int] NOT NULL,
		[DATE_TIME_UTC]            [datetime] NOT NULL,
		[DATE_UTC_URN]             [int] NOT NULL,
		[TIME_UTC_URN]             [smallint] NOT NULL,
		[CLUSTER_RESOURCE_URN]     [int] NOT NULL,
		[SKEY]                     [numeric](19, 0) NOT NULL,
		[SESSION_KEY]              [numeric](19, 0) NOT NULL,
		[OFFER_URN]                [int] NOT NULL,
		[OFFER_BANNER_URN]         [int] NOT NULL,
		[CONTENT_URL_URN]          [int] NOT NULL,
		[CUSTOMER_URN]             [int] NOT NULL,
		[OFFER_TYPE_CODE_URN]      [int] NOT NULL,
		[IS_STICKY_OFFER]          [bit] NOT NULL,
		[VISITS_CNTR]              [int] NOT NULL,
		[ELIGIBLE_CNTR]            [int] NOT NULL,
		[PRESENTED_CNTR]           [int] NOT NULL,
		[ACCEPTED_CNTR]            [int] NOT NULL,
		[ACCEPTED_CLICK_CNTR]      [int] NOT NULL,
		[FIRST_RESPONSE_CNTR]      [int] NOT NULL,
		[REJECTED_CNTR]            [int] NOT NULL,
		[IGNORED_CNTR]             [int] NOT NULL,
		[ENGAGED_CNTR]             [int] NOT NULL,
		[CONVERTED_CNTR]           [int] NOT NULL,
		[CUSTOM_DIMENSION_0]       [int] NOT NULL,
		[CUSTOM_DIMENSION_1]       [int] NOT NULL,
		[CUSTOM_DIMENSION_2]       [int] NOT NULL,
		[CUSTOM_DIMENSION_3]       [int] NOT NULL,
		[CUSTOM_DIMENSION_4]       [int] NOT NULL,
		[CUSTOM_DIMENSION_5]       [int] NOT NULL,
		[CUSTOM_DIMENSION_6]       [int] NOT NULL,
		[CUSTOM_DIMENSION_7]       [int] NOT NULL,
		[CUSTOM_DIMENSION_8]       [int] NOT NULL,
		[CUSTOM_DIMENSION_9]       [int] NOT NULL,
		[CUSTOM_MEASURE_0]         [int] NULL,
		[CUSTOM_MEASURE_1]         [int] NULL,
		[CUSTOM_MEASURE_2]         [int] NULL,
		[CUSTOM_MEASURE_3]         [int] NULL,
		[CUSTOM_MEASURE_4]         [int] NULL,
		[CUSTOM_MEASURE_5]         [int] NULL,
		[CUSTOM_MEASURE_6]         [int] NULL,
		[CUSTOM_MEASURE_7]         [int] NULL,
		[CUSTOM_MEASURE_8]         [int] NULL,
		[CUSTOM_MEASURE_9]         [int] NULL,
		CONSTRAINT [PK_FCT_OFFERS_DETAIL]
		PRIMARY KEY
		CLUSTERED
		([PARTITION_URN], [PARTITION_ID])
	ON [FCTEGNIDXGROUP]
) ON [FCTEGNIDXGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the template table for metrics or facts relating to the eGain offers. It is equivalent to EGDM_OFR_FCT_OFFER_METRICS in the eGain Analytics Database.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_OFFERS_DETAIL', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_OFFERS_DETAIL', 'COLUMN', N'PARTITION_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column holds a value that uniquely identifies a row across all the partition tables for this partition type.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_OFFERS_DETAIL', 'COLUMN', N'PARTITION_GLOBAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number for the current partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_OFFERS_DETAIL', 'COLUMN', N'PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The date and time when the event occurred in UTC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_OFFERS_DETAIL', 'COLUMN', N'DATE_TIME_UTC'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the date of the DATE_TIME_UTC value.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_OFFERS_DETAIL', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the time of the DATE_TIME_UTC value.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_OFFERS_DETAIL', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column gives information regarding the source of the data. This corresponds to the RESOURCE_URN from TB_CLU_RESOURCE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_OFFERS_DETAIL', 'COLUMN', N'CLUSTER_RESOURCE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the primary key on the source and is used for debugging. This maps to field PKEY in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_OFFERS_DETAIL', 'COLUMN', N'SKEY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the session if assigned to the offer. This maps to field SESSION_KEY in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_OFFERS_DETAIL', 'COLUMN', N'SESSION_KEY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_OFFER.ITEM_URN and refers to the eGain Offer.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_OFFERS_DETAIL', 'COLUMN', N'OFFER_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_OFFER', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_OFFERS_DETAIL', 'COLUMN', N'OFFER_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_OFFER_BANNER.ITEM_URN and refers to the banner associated with the eGain Offer.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_OFFERS_DETAIL', 'COLUMN', N'OFFER_BANNER_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_OFFER_BANNER', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_OFFERS_DETAIL', 'COLUMN', N'OFFER_BANNER_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_CONTENT_URL.ITEM_URN and refers to the page where the eGain Offer was configured.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_OFFERS_DETAIL', 'COLUMN', N'CONTENT_URL_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CONTENT_URL', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_OFFERS_DETAIL', 'COLUMN', N'CONTENT_URL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_CUSTOMER.ITEM_URN and refers to the customer associated with the activity.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_OFFERS_DETAIL', 'COLUMN', N'CUSTOMER_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_CODE.ITEM_URN and refers to an Offer Type in the Offer Type Code Group.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_OFFERS_DETAIL', 'COLUMN', N'OFFER_TYPE_CODE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a boolean flag indicating if the eGain Offer associated with the activity is a sticky offer of not. This maps to IS_FIXED field in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_OFFERS_DETAIL', 'COLUMN', N'IS_STICKY_OFFER'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number of times the page on which the offer is configured was visited.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_OFFERS_DETAIL', 'COLUMN', N'VISITS_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number of times visitors became eligible for the offer.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_OFFERS_DETAIL', 'COLUMN', N'ELIGIBLE_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number of times the offer was presented.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_OFFERS_DETAIL', 'COLUMN', N'PRESENTED_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This indicates whether a presented offer was accepted. An offer is considered accepted when the visitor clicks the Accept button on the offer banner.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_OFFERS_DETAIL', 'COLUMN', N'ACCEPTED_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number of times the presented offer was accepted. An offer is considered accepted when the visitor clicks the Accept button on the offer banner. Note that a sticky offer can be accepted more than once because it remains on the page.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_OFFERS_DETAIL', 'COLUMN', N'ACCEPTED_CLICK_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number of times a visitor, who accepted the chat offer, started a chat and then responded to the first chat message from the agent.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_OFFERS_DETAIL', 'COLUMN', N'FIRST_RESPONSE_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number of times the presented offer was rejected. An offer is considered rejected when the visitor clicks the Reject button on the offer banner.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_OFFERS_DETAIL', 'COLUMN', N'REJECTED_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number of times an offer was ignored. An offer is considered ignored when it is presented but the visitor neither accepted nor rejected the offer. This is not relevant for sticky offers.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_OFFERS_DETAIL', 'COLUMN', N'IGNORED_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number of times a visitor engaged with an agent as a result of the offer. Relevant for Chat Offers, visitor are considered as being engaged if they accept a chat offer, complete the chat pre-login form, and start the chat. Note: In anonymous chats that do not have a pre-login form, the visitor is considered engaged when the chat offer is accepted.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_OFFERS_DETAIL', 'COLUMN', N'ENGAGED_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number of times an offer is converted. Relevant for Chat Offers, an offeris marked converted when the agent clicks the Convert button in the Agent Console.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_OFFERS_DETAIL', 'COLUMN', N'CONVERTED_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_OFFERS_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM0', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_OFFERS_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_OFFERS_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM1', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_OFFERS_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_OFFERS_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM2', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_OFFERS_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_OFFERS_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM3', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_OFFERS_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_OFFERS_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM4', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_OFFERS_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_OFFERS_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM5', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_OFFERS_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_OFFERS_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM6', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_OFFERS_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_OFFERS_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM7', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_OFFERS_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_OFFERS_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM8', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_OFFERS_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_OFFERS_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM9', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_OFFERS_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_OFFERS_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_OFFERS_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_OFFERS_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_OFFERS_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_OFFERS_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_OFFERS_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_OFFERS_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_OFFERS_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_OFFERS_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_OFFERS_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_9'
GO
GRANT SELECT
	ON [dbo].[TB_FCT_OFFERS_DETAIL]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_FCT_OFFERS_DETAIL]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_FCT_OFFERS_DETAIL]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_FCT_OFFERS_DETAIL] SET (LOCK_ESCALATION = TABLE)
GO
