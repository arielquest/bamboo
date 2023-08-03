SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TB_SUM_NOTIFY_INTERVAL] (
		[PARTITION_URN]                           [int] NOT NULL,
		[PARTITION_ID]                            [int] NOT NULL,
		[PARTITION_GLOBAL_URN]                    [bigint] NOT NULL,
		[CLUSTER_RESOURCE_URN]                    [int] NOT NULL,
		[SEQUENCE_ID]                             [bigint] NOT NULL,
		[DATE_TIME_UTC]                           [datetime] NOT NULL,
		[DATE_UTC_URN]                            [int] NOT NULL,
		[TIME_UTC_URN]                            [smallint] NOT NULL,
		[TENANT_URN]                              [int] NOT NULL,
		[NOTIFY_ORIGIN_URN]                       [int] NOT NULL,
		[NOTIFY_CHANNEL_URN]                      [int] NOT NULL,
		[NOTIFY_CATEGORY_URN]                     [int] NOT NULL,
		[NOTIFY_MESSAGE_TYPE_URN]                 [int] NOT NULL,
		[LANGUAGE_URN]                            [int] NOT NULL,
		[NOTIFICATION_RECEIVED]                   [bigint] NOT NULL,
		[NOTIFICATION_GENERATED]                  [bigint] NOT NULL,
		[NOTIFICATION_SUCCESS]                    [bigint] NOT NULL,
		[NOTIFICATION_SUCCESS_FIRST_TIME]         [bigint] NOT NULL,
		[NOTIFICATION_FAILURE]                    [bigint] NOT NULL,
		[NOTIFICATION_FAILURE_DISPATCHER]         [bigint] NOT NULL,
		[NOTIFICATION_FAILURE_MAX_RETRY]          [bigint] NOT NULL,
		[NOTIFICATION_SLA_MET]                    [bigint] NOT NULL,
		[NOTIFICATION_SLA_NOT_MET]                [bigint] NOT NULL,
		[NOTIFICATION_TOTAL_DISPATCH_TIME]        [bigint] NOT NULL,
		[NOTIFICATION_MAX_DISPATCH_TIME]          [bigint] NOT NULL,
		[NOTIFICATION_MIN_DISPATCH_TIME]          [bigint] NOT NULL,
		[NOTIFICATION_DELIVERY_DELIVERED]         [bigint] NOT NULL,
		[NOTIFICATION_DELIVERY_ACKED]             [bigint] NOT NULL,
		[NOTIFICATION_DELIVERY_FAILED]            [bigint] NOT NULL,
		[NOTIFICATION_DELIVERY_READ]              [bigint] NOT NULL,
		[NOTIFICATION_DELIVERY_OTHER]             [bigint] NOT NULL,
		[NOTIFICATION_DELIVERY_RETRIED]           [bigint] NOT NULL,
		[NOTIFICATION_DELIVERY_EXPIRED]           [bigint] NOT NULL,
		[NOTIFICATION_DELIVERY_UNSUBSCRIBED]      [bigint] NOT NULL,
		[NOTIFICATION_DELIVERY_CLICKS]            [bigint] NOT NULL,
		[NOTIFICATION_DELIVERY_UNIQUE_CLICKS]     [bigint] NOT NULL,
		[CUSTOM_ATTRIBUTE_0]                      [int] NOT NULL,
		[CUSTOM_ATTRIBUTE_1]                      [int] NOT NULL,
		[CUSTOM_ATTRIBUTE_2]                      [int] NOT NULL,
		[CUSTOM_ATTRIBUTE_3]                      [int] NOT NULL,
		[CUSTOM_ATTRIBUTE_4]                      [int] NOT NULL,
		[CUSTOM_ATTRIBUTE_5]                      [int] NOT NULL,
		[CUSTOM_ATTRIBUTE_6]                      [int] NOT NULL,
		[CUSTOM_ATTRIBUTE_7]                      [int] NOT NULL,
		[CUSTOM_ATTRIBUTE_8]                      [int] NOT NULL,
		[CUSTOM_ATTRIBUTE_9]                      [int] NOT NULL,
		[CUSTOM_MEASURE_0]                        [int] NULL,
		[CUSTOM_MEASURE_1]                        [int] NULL,
		[CUSTOM_MEASURE_2]                        [int] NULL,
		[CUSTOM_MEASURE_3]                        [int] NULL,
		[CUSTOM_MEASURE_4]                        [int] NULL,
		[CUSTOM_MEASURE_5]                        [int] NULL,
		[CUSTOM_MEASURE_6]                        [int] NULL,
		[CUSTOM_MEASURE_7]                        [int] NULL,
		[CUSTOM_MEASURE_8]                        [int] NULL,
		[CUSTOM_MEASURE_9]                        [int] NULL,
		CONSTRAINT [PK_SUM_NOTIFY_INTERVAL]
		PRIMARY KEY
		CLUSTERED
		([PARTITION_URN], [PARTITION_ID])
	ON [FCTEGNGROUP]
) ON [FCTEGNGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NOTIFY_INTERVAL', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NOTIFY_INTERVAL', 'COLUMN', N'PARTITION_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number for the current partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NOTIFY_INTERVAL', 'COLUMN', N'PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column holds a value that uniquely identifies a row across all the partition tables for this partition type.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NOTIFY_INTERVAL', 'COLUMN', N'PARTITION_GLOBAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column gives information regarding the source of the data. This corresponds to the RESOURCE_URN from TB_CLU_RESOURCE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NOTIFY_INTERVAL', 'COLUMN', N'CLUSTER_RESOURCE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This the id that uniquely identifies a notification message from source.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NOTIFY_INTERVAL', 'COLUMN', N'SEQUENCE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The date and time in UTC representing the start of the interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NOTIFY_INTERVAL', 'COLUMN', N'DATE_TIME_UTC'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the date of the DATE_TIME_UTC value.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NOTIFY_INTERVAL', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DATE', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NOTIFY_INTERVAL', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the time of the DATE_TIME_UTC value.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NOTIFY_INTERVAL', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIME', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NOTIFY_INTERVAL', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_TENANT.ITEM_URN and refers to the on-boarded tenant in notify.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NOTIFY_INTERVAL', 'COLUMN', N'TENANT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TENANT', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NOTIFY_INTERVAL', 'COLUMN', N'TENANT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_NOTIFY_ORIGIN.ITEM_URN and refers to the notification origin. Note that different tenants have different meaning for this.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NOTIFY_INTERVAL', 'COLUMN', N'NOTIFY_ORIGIN_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_NOTIFY_ORIGIN', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NOTIFY_INTERVAL', 'COLUMN', N'NOTIFY_ORIGIN_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_NOTIFY_CHANNEL.ITEM_URN and indicates the notification channel, i.e. text, email etc. or variation of them. This is looked up based on channel field at source.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NOTIFY_INTERVAL', 'COLUMN', N'NOTIFY_CHANNEL_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_NOTIFY_CHANNEL', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NOTIFY_INTERVAL', 'COLUMN', N'NOTIFY_CHANNEL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_NOTIFY_CATEGORY.ITEM_URN and refers to the category of the activity. This is looked up based on message_category field at source.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NOTIFY_INTERVAL', 'COLUMN', N'NOTIFY_CATEGORY_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_NOTIFY_CATEGORY', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NOTIFY_INTERVAL', 'COLUMN', N'NOTIFY_CATEGORY_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_NOTIFY_MESSAGE_TYPE.ITEM_URN and refers to the message type for the notification. This is looked up based on message_type field at source.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NOTIFY_INTERVAL', 'COLUMN', N'NOTIFY_MESSAGE_TYPE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_NOTIFY_MESSAGE_TYPE', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NOTIFY_INTERVAL', 'COLUMN', N'NOTIFY_MESSAGE_TYPE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NOTIFY_INTERVAL', 'COLUMN', N'LANGUAGE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total inbound message requests received by the Notify platform', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NOTIFY_INTERVAL', 'COLUMN', N'NOTIFICATION_RECEIVED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total dispatch message attempts. This includes retries.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NOTIFY_INTERVAL', 'COLUMN', N'NOTIFICATION_GENERATED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of messages that were successfully sent to the channel out of the Notify platform.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NOTIFY_INTERVAL', 'COLUMN', N'NOTIFICATION_SUCCESS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of messages that were successfully sent to the channel out of the Notify platform on first attempt.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NOTIFY_INTERVAL', 'COLUMN', N'NOTIFICATION_SUCCESS_FIRST_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of messages that failed to be processed by the Notify platform.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NOTIFY_INTERVAL', 'COLUMN', N'NOTIFICATION_FAILURE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of messages that failed during a dispatch attempt.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NOTIFY_INTERVAL', 'COLUMN', N'NOTIFICATION_FAILURE_DISPATCHER'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number of messages that reached the maximum retry count and failed.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NOTIFY_INTERVAL', 'COLUMN', N'NOTIFICATION_FAILURE_MAX_RETRY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of messages that met the dispatch SLA.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NOTIFY_INTERVAL', 'COLUMN', N'NOTIFICATION_SLA_MET'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of messages that didnt meet the dispatch SLA.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NOTIFY_INTERVAL', 'COLUMN', N'NOTIFICATION_SLA_NOT_MET'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total dispatch time in milliseconds across all messages that were dispatched.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NOTIFY_INTERVAL', 'COLUMN', N'NOTIFICATION_TOTAL_DISPATCH_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the longest dispatch time in milliseconds across all messages that were dispatched.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NOTIFY_INTERVAL', 'COLUMN', N'NOTIFICATION_MAX_DISPATCH_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the shortest dispatch time in milliseconds across all messages that were dispatched.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NOTIFY_INTERVAL', 'COLUMN', N'NOTIFICATION_MIN_DISPATCH_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of messages where delivery receipts indicated that the message was delivered. Not all channels support this.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NOTIFY_INTERVAL', 'COLUMN', N'NOTIFICATION_DELIVERY_DELIVERED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NOTIFY_INTERVAL', 'COLUMN', N'NOTIFICATION_DELIVERY_ACKED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of messages where delivery receipts indicated that the message delivery failed. Not all channels support this.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NOTIFY_INTERVAL', 'COLUMN', N'NOTIFICATION_DELIVERY_FAILED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of messages where deliver receipts indicated that the message was opened or read. Not all channels support this.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NOTIFY_INTERVAL', 'COLUMN', N'NOTIFICATION_DELIVERY_READ'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of messages where deliver receipts do not fit any specific category.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NOTIFY_INTERVAL', 'COLUMN', N'NOTIFICATION_DELIVERY_OTHER'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number delivery retries across all messages.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NOTIFY_INTERVAL', 'COLUMN', N'NOTIFICATION_DELIVERY_RETRIED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of messages that were not dispatched because they went past their sent time window.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NOTIFY_INTERVAL', 'COLUMN', N'NOTIFICATION_DELIVERY_EXPIRED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NOTIFY_INTERVAL', 'COLUMN', N'NOTIFICATION_DELIVERY_UNSUBSCRIBED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of links clicked in the content of all messages that were dispatched.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NOTIFY_INTERVAL', 'COLUMN', N'NOTIFICATION_DELIVERY_CLICKS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of links clicked for the first time in the content of all messages that were dispatched.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NOTIFY_INTERVAL', 'COLUMN', N'NOTIFICATION_DELIVERY_UNIQUE_CLICKS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NOTIFY_INTERVAL', 'COLUMN', N'CUSTOM_ATTRIBUTE_0'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM_ATTRIBUTE0', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NOTIFY_INTERVAL', 'COLUMN', N'CUSTOM_ATTRIBUTE_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NOTIFY_INTERVAL', 'COLUMN', N'CUSTOM_ATTRIBUTE_1'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM_ATTRIBUTE1', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NOTIFY_INTERVAL', 'COLUMN', N'CUSTOM_ATTRIBUTE_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NOTIFY_INTERVAL', 'COLUMN', N'CUSTOM_ATTRIBUTE_2'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM_ATTRIBUTE2', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NOTIFY_INTERVAL', 'COLUMN', N'CUSTOM_ATTRIBUTE_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NOTIFY_INTERVAL', 'COLUMN', N'CUSTOM_ATTRIBUTE_3'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM_ATTRIBUTE3', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NOTIFY_INTERVAL', 'COLUMN', N'CUSTOM_ATTRIBUTE_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NOTIFY_INTERVAL', 'COLUMN', N'CUSTOM_ATTRIBUTE_4'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM_ATTRIBUTE4', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NOTIFY_INTERVAL', 'COLUMN', N'CUSTOM_ATTRIBUTE_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NOTIFY_INTERVAL', 'COLUMN', N'CUSTOM_ATTRIBUTE_5'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM_ATTRIBUTE5', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NOTIFY_INTERVAL', 'COLUMN', N'CUSTOM_ATTRIBUTE_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NOTIFY_INTERVAL', 'COLUMN', N'CUSTOM_ATTRIBUTE_6'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM_ATTRIBUTE6', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NOTIFY_INTERVAL', 'COLUMN', N'CUSTOM_ATTRIBUTE_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NOTIFY_INTERVAL', 'COLUMN', N'CUSTOM_ATTRIBUTE_7'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM_ATTRIBUTE7', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NOTIFY_INTERVAL', 'COLUMN', N'CUSTOM_ATTRIBUTE_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NOTIFY_INTERVAL', 'COLUMN', N'CUSTOM_ATTRIBUTE_8'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM_ATTRIBUTE8', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NOTIFY_INTERVAL', 'COLUMN', N'CUSTOM_ATTRIBUTE_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NOTIFY_INTERVAL', 'COLUMN', N'CUSTOM_ATTRIBUTE_9'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM_ATTRIBUTE9', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NOTIFY_INTERVAL', 'COLUMN', N'CUSTOM_ATTRIBUTE_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NOTIFY_INTERVAL', 'COLUMN', N'CUSTOM_MEASURE_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NOTIFY_INTERVAL', 'COLUMN', N'CUSTOM_MEASURE_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NOTIFY_INTERVAL', 'COLUMN', N'CUSTOM_MEASURE_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NOTIFY_INTERVAL', 'COLUMN', N'CUSTOM_MEASURE_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NOTIFY_INTERVAL', 'COLUMN', N'CUSTOM_MEASURE_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NOTIFY_INTERVAL', 'COLUMN', N'CUSTOM_MEASURE_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NOTIFY_INTERVAL', 'COLUMN', N'CUSTOM_MEASURE_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NOTIFY_INTERVAL', 'COLUMN', N'CUSTOM_MEASURE_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NOTIFY_INTERVAL', 'COLUMN', N'CUSTOM_MEASURE_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_NOTIFY_INTERVAL', 'COLUMN', N'CUSTOM_MEASURE_9'
GO
GRANT SELECT
	ON [dbo].[TB_SUM_NOTIFY_INTERVAL]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_SUM_NOTIFY_INTERVAL]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_SUM_NOTIFY_INTERVAL]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_SUM_NOTIFY_INTERVAL] SET (LOCK_ESCALATION = TABLE)
GO
