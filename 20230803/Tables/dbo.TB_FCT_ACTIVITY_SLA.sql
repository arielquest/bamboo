SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TB_FCT_ACTIVITY_SLA] (
		[PARTITION_URN]                         [int] NOT NULL,
		[PARTITION_ID]                          [int] NOT NULL,
		[PARTITION_GLOBAL_URN]                  [bigint] NOT NULL,
		[DATE_TIME_UTC]                         [datetime] NOT NULL,
		[DATE_UTC_URN]                          [int] NOT NULL,
		[TIME_UTC_URN]                          [smallint] NOT NULL,
		[CLUSTER_RESOURCE_URN]                  [int] NOT NULL,
		[CASE_ID]                               [numeric](19, 0) NOT NULL,
		[ACTIVITY_ID]                           [numeric](19, 0) NOT NULL,
		[ACTIVITY_URN]                          [int] NOT NULL,
		[CASE_URN]                              [int] NOT NULL,
		[ACTIVITY_TYPE_CODE_URN]                [int] NOT NULL,
		[TENANT_URN]                            [int] NOT NULL,
		[CUSTOMER_URN]                          [int] NOT NULL,
		[AGENT_TEAM_URN]                        [int] NOT NULL,
		[QUEUE_URN]                             [int] NOT NULL,
		[SLA_BUCKET_INTERVAL_URN]               [int] NOT NULL,
		[SOURCE_START_PARTITION_GLOBAL_URN]     [bigint] NOT NULL,
		[SOURCE_END_PARTITION_GLOBAL_URN]       [bigint] NOT NULL,
		[CUSTOM_ATTRIBUTE_0]                    [int] NOT NULL,
		[CUSTOM_ATTRIBUTE_1]                    [int] NOT NULL,
		[CUSTOM_ATTRIBUTE_2]                    [int] NOT NULL,
		[CUSTOM_ATTRIBUTE_3]                    [int] NOT NULL,
		[CUSTOM_ATTRIBUTE_4]                    [int] NOT NULL,
		[CUSTOM_ATTRIBUTE_5]                    [int] NOT NULL,
		[CUSTOM_ATTRIBUTE_6]                    [int] NOT NULL,
		[CUSTOM_ATTRIBUTE_7]                    [int] NOT NULL,
		[CUSTOM_ATTRIBUTE_8]                    [int] NOT NULL,
		[CUSTOM_ATTRIBUTE_9]                    [int] NOT NULL,
		[ANS_INTERVAL_1]                        [int] NOT NULL,
		[ANS_INTERVAL_2]                        [int] NOT NULL,
		[ANS_INTERVAL_3]                        [int] NOT NULL,
		[ANS_INTERVAL_4]                        [int] NOT NULL,
		[ANS_INTERVAL_5]                        [int] NOT NULL,
		[ANS_INTERVAL_6]                        [int] NOT NULL,
		[ANS_INTERVAL_7]                        [int] NOT NULL,
		[ANS_INTERVAL_8]                        [int] NOT NULL,
		[ANS_INTERVAL_9]                        [int] NOT NULL,
		[ANS_INTERVAL_10]                       [int] NOT NULL,
		[ABN_INTERVAL_1]                        [int] NOT NULL,
		[ABN_INTERVAL_2]                        [int] NOT NULL,
		[ABN_INTERVAL_3]                        [int] NOT NULL,
		[ABN_INTERVAL_4]                        [int] NOT NULL,
		[ABN_INTERVAL_5]                        [int] NOT NULL,
		[ABN_INTERVAL_6]                        [int] NOT NULL,
		[ABN_INTERVAL_7]                        [int] NOT NULL,
		[ABN_INTERVAL_8]                        [int] NOT NULL,
		[ABN_INTERVAL_9]                        [int] NOT NULL,
		[ABN_INTERVAL_10]                       [int] NOT NULL,
		CONSTRAINT [PK_FCT_ACTIVITY_SLA]
		PRIMARY KEY
		CLUSTERED
		([PARTITION_URN], [PARTITION_ID])
	ON [FCTEGNGROUP]
) ON [FCTEGNGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_SLA', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_SLA', 'COLUMN', N'PARTITION_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number for the current partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_SLA', 'COLUMN', N'PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column holds a value that uniquely identifies a row across all the partition tables for this partition type.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_SLA', 'COLUMN', N'PARTITION_GLOBAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The date and time when the event occurred in UTC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_SLA', 'COLUMN', N'DATE_TIME_UTC'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the date of the DATE_TIME_UTC value.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_SLA', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DATE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_SLA', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the time of the DATE_TIME_UTC value.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_SLA', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIME', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_SLA', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column gives information regarding the source of the data. This corresponds to the RESOURCE_URN from TB_CLU_RESOURCE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_SLA', 'COLUMN', N'CLUSTER_RESOURCE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to field CASE_ID in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_SLA', 'COLUMN', N'CASE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to field ACTIVITY_ID in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_SLA', 'COLUMN', N'ACTIVITY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN that represents Activity information, as TB_DIM_ACTIVITY.ITEM_URN.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_SLA', 'COLUMN', N'ACTIVITY_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN that represents Case information, as TB_DIM_CASE.ITEM_URN.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_SLA', 'COLUMN', N'CASE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_CODE.ITEM_URN and refers to the type of the activity (e.g. Chat or Email) associated with this event.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_SLA', 'COLUMN', N'ACTIVITY_TYPE_CODE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_TENANT.ITEM_URN and refers to the Tenant (or "Department" on the source) of the Agent.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_SLA', 'COLUMN', N'TENANT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TENANT', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_SLA', 'COLUMN', N'TENANT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_CUSTOMER.ITEM_URN and refers to the customer of the case.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_SLA', 'COLUMN', N'CUSTOMER_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_AGENT_TEAM.ITEM_URN and refers to the Agent Team of the Agent where it is is a physical member.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_SLA', 'COLUMN', N'AGENT_TEAM_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_QUEUE.ITEM_URN and refers to the Queue related to this activity.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_SLA', 'COLUMN', N'QUEUE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'To-do', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_SLA', 'COLUMN', N'SLA_BUCKET_INTERVAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The partition global urn of the start of the activity.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_SLA', 'COLUMN', N'SOURCE_START_PARTITION_GLOBAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The partition global urn of the end of the activity for the interval calculation.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_SLA', 'COLUMN', N'SOURCE_END_PARTITION_GLOBAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_SLA', 'COLUMN', N'CUSTOM_ATTRIBUTE_0'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM_ATTRIBUTE0', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_SLA', 'COLUMN', N'CUSTOM_ATTRIBUTE_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_SLA', 'COLUMN', N'CUSTOM_ATTRIBUTE_1'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM_ATTRIBUTE1', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_SLA', 'COLUMN', N'CUSTOM_ATTRIBUTE_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_SLA', 'COLUMN', N'CUSTOM_ATTRIBUTE_2'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM_ATTRIBUTE2', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_SLA', 'COLUMN', N'CUSTOM_ATTRIBUTE_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_SLA', 'COLUMN', N'CUSTOM_ATTRIBUTE_3'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM_ATTRIBUTE3', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_SLA', 'COLUMN', N'CUSTOM_ATTRIBUTE_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_SLA', 'COLUMN', N'CUSTOM_ATTRIBUTE_4'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM_ATTRIBUTE4', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_SLA', 'COLUMN', N'CUSTOM_ATTRIBUTE_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_SLA', 'COLUMN', N'CUSTOM_ATTRIBUTE_5'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM_ATTRIBUTE5', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_SLA', 'COLUMN', N'CUSTOM_ATTRIBUTE_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_SLA', 'COLUMN', N'CUSTOM_ATTRIBUTE_6'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM_ATTRIBUTE6', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_SLA', 'COLUMN', N'CUSTOM_ATTRIBUTE_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_SLA', 'COLUMN', N'CUSTOM_ATTRIBUTE_7'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM_ATTRIBUTE7', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_SLA', 'COLUMN', N'CUSTOM_ATTRIBUTE_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_SLA', 'COLUMN', N'CUSTOM_ATTRIBUTE_8'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM_ATTRIBUTE8', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_SLA', 'COLUMN', N'CUSTOM_ATTRIBUTE_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_SLA', 'COLUMN', N'CUSTOM_ATTRIBUTE_9'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM_ATTRIBUTE9', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_SLA', 'COLUMN', N'CUSTOM_ATTRIBUTE_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of activities that were responded for the first time with the first interval upper bound defined for the SLA bucket interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_SLA', 'COLUMN', N'ANS_INTERVAL_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of activities that were responded for the first time with the second interval upper bound defined for the SLA bucket interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_SLA', 'COLUMN', N'ANS_INTERVAL_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of activities that were responded for the first time with the third interval upper bound defined for the SLA bucket interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_SLA', 'COLUMN', N'ANS_INTERVAL_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of activities that were responded for the first time with the fourth interval upper bound defined for the SLA bucket interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_SLA', 'COLUMN', N'ANS_INTERVAL_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of activities that were responded for the first time with the fifth interval upper bound defined for the SLA bucket interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_SLA', 'COLUMN', N'ANS_INTERVAL_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of activities that were responded for the first time with the sixth interval upper bound defined for the SLA bucket interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_SLA', 'COLUMN', N'ANS_INTERVAL_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of activities that were responded for the first time with the seventh interval upper bound defined for the SLA bucket interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_SLA', 'COLUMN', N'ANS_INTERVAL_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of activities that were responded for the first time with the eighth interval upper bound defined for the SLA bucket interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_SLA', 'COLUMN', N'ANS_INTERVAL_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of activities that were responded for the first time with the nineth interval upper bound defined for the SLA bucket interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_SLA', 'COLUMN', N'ANS_INTERVAL_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of activities that were responded for the first time with the tenth interval upper bound defined for the SLA bucket interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_SLA', 'COLUMN', N'ANS_INTERVAL_10'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of activities that were abandoned within the first interval upper bound defined for the SLA bucket interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_SLA', 'COLUMN', N'ABN_INTERVAL_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of activities that were abandoned within the second interval upper bound defined for the SLA bucket interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_SLA', 'COLUMN', N'ABN_INTERVAL_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of activities that were abandoned within the third interval upper bound defined for the SLA bucket interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_SLA', 'COLUMN', N'ABN_INTERVAL_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of activities that were abandoned within the fourth interval upper bound defined for the SLA bucket interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_SLA', 'COLUMN', N'ABN_INTERVAL_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of activities that were abandoned within the fifth interval upper bound defined for the SLA bucket interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_SLA', 'COLUMN', N'ABN_INTERVAL_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of activities that were abandoned within the sixth interval upper bound defined for the SLA bucket interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_SLA', 'COLUMN', N'ABN_INTERVAL_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of activities that were abandoned within the seventh interval upper bound defined for the SLA bucket interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_SLA', 'COLUMN', N'ABN_INTERVAL_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of activities that were abandoned within the eighth interval upper bound defined for the SLA bucket interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_SLA', 'COLUMN', N'ABN_INTERVAL_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of activities that were abandoned within the nineth interval upper bound defined for the SLA bucket interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_SLA', 'COLUMN', N'ABN_INTERVAL_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of activities that were abandoned within the tenth interval upper bound defined for the SLA bucket interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_ACTIVITY_SLA', 'COLUMN', N'ABN_INTERVAL_10'
GO
GRANT SELECT
	ON [dbo].[TB_FCT_ACTIVITY_SLA]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_FCT_ACTIVITY_SLA]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_FCT_ACTIVITY_SLA]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_FCT_ACTIVITY_SLA] SET (LOCK_ESCALATION = TABLE)
GO
