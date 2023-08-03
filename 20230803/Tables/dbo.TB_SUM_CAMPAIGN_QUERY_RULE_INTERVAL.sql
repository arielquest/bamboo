SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TB_SUM_CAMPAIGN_QUERY_RULE_INTERVAL] (
		[SUMMARIZED_URN]                 [int] NOT NULL,
		[CAMPAIGN_URN]                   [int] NOT NULL,
		[QUERY_RULE_URN]                 [int] NOT NULL,
		[DATE_URN]                       [int] NOT NULL,
		[TIME_URN]                       [smallint] NOT NULL,
		[DATE_UTC_URN]                   [int] NOT NULL,
		[TIME_UTC_URN]                   [smallint] NOT NULL,
		[ABANDON_DETECT]                 [int] NULL,
		[ABANDON_TO_IVR]                 [int] NULL,
		[AGENT_CLOSED_DETECT]            [int] NULL,
		[AGENT_REJECTED_DETECT]          [int] NULL,
		[ANSWERING_MACHINE_DETECT]       [int] NULL,
		[BUSY_DETECT]                    [int] NULL,
		[CALLBACK_COUNT]                 [int] NULL,
		[CANCELLED_DETECT]               [int] NULL,
		[CONTACTS_ATTEMPTED]             [int] NULL,
		[CUSTOMER_ABANDON_DETECT]        [int] NULL,
		[CUSTOMER_NOT_HOME]              [int] NULL,
		[FAX_DETECT]                     [int] NULL,
		[NETWORK_ANS_MACHINE_DETECT]     [int] NULL,
		[NO_ANSWER_DETECT]               [int] NULL,
		[NO_DIAL_TONE_DETECT]            [int] NULL,
		[NO_RINGBACK_DETECT]             [int] NULL,
		[PERSONAL_CALLBACK_COUNT]        [int] NULL,
		[WRONG_NUMBER_COUNT]             [int] NULL,
		[VOICE_DETECT]                   [int] NULL,
		[SIT_TONE_DETECT]                [int] NULL,
		[TALK_TIME]                      [int] NULL,
		[WRAPUP_TIME]                    [int] NULL,
		[DB_DATETIME]                    [datetime] NULL,
		[PARTITION_ID]                   [int] NOT NULL,
		[RECOVERY_KEY]                   [float] NULL,
		[DATE_TIME]                      [datetime] NOT NULL,
		[CAMPAIGN_OUT_OF_NUMBERS]        [int] NULL,
		[LOW_NOISE_VOLUME]               [int] NULL,
		[QUERY_RULE_ACTIVE_TIME]         [int] NULL,
		[REPORTING_HALF_HOUR]            [int] NULL,
		[REPORTING_INTERVAL]             [int] NULL,
		[TIME_ZONE]                      [int] NULL,
		[CLUSTER_RESOURCE_URN]           [int] NOT NULL
) ON [SUMICMGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_SUM_CAMPAIGN_QUERY_RULE_INTERVAL_CAMPAIGN_URN]
	ON [dbo].[TB_SUM_CAMPAIGN_QUERY_RULE_INTERVAL] ([CAMPAIGN_URN])
	ON [SUMICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CAMPAIGN_QUERY_RULE_INTERVAL', 'INDEX', N'IX_SUM_CAMPAIGN_QUERY_RULE_INTERVAL_CAMPAIGN_URN'
GO
CREATE NONCLUSTERED INDEX [IX_SUM_CAMPAIGN_QUERY_RULE_INTERVAL_DATE_TIME]
	ON [dbo].[TB_SUM_CAMPAIGN_QUERY_RULE_INTERVAL] ([DATE_TIME])
	ON [SUMICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CAMPAIGN_QUERY_RULE_INTERVAL', 'INDEX', N'IX_SUM_CAMPAIGN_QUERY_RULE_INTERVAL_DATE_TIME'
GO
CREATE NONCLUSTERED INDEX [IX_SUM_CAMPAIGN_QUERY_RULE_INTERVAL_DATE_URN]
	ON [dbo].[TB_SUM_CAMPAIGN_QUERY_RULE_INTERVAL] ([DATE_URN])
	ON [SUMICMIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CAMPAIGN_QUERY_RULE_INTERVAL', 'INDEX', N'IX_SUM_CAMPAIGN_QUERY_RULE_INTERVAL_DATE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the template table for the historical summary statistics for all the campaign and query rule combination. This table is created at install time and the partitioning service creates various partition tables with the same schema. These partition tables are prefixed as TB_SUM_CAMPAIGN_QUERY_RULE_INTERVAL_ followed by the partition identifier. The partition identifier is created depending on the partition configuration, for example monthly, weekly etc. All currently active partitions are included VW_PARTITONED_SUM_CAMPAIGN_QUERY_RULE_INTERVAL view. Since the partitioned tables are generated at runtime and that they have the same schema no separate documentations are required for each partition table. In case of Cisco ICM/IPCC the data in these partitioned tables is imported from t_Campaign_Query_Rule_Half_Hou or t_Campaign_Query_Rule_Interval table for version 8.0 or higher.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CAMPAIGN_QUERY_RULE_INTERVAL', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CAMPAIGN_QUERY_RULE_INTERVAL', 'COLUMN', N'SUMMARIZED_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_CAMPAIGN for an item of type IT_CAMPAIGN. This is the campaign associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CAMPAIGN_QUERY_RULE_INTERVAL', 'COLUMN', N'CAMPAIGN_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CAMPAIGN', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CAMPAIGN_QUERY_RULE_INTERVAL', 'COLUMN', N'CAMPAIGN_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_QUERY_RULE for an item of type IT_QUERY_RULE. This is the query rule associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CAMPAIGN_QUERY_RULE_INTERVAL', 'COLUMN', N'QUERY_RULE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_QUERY_RULE', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CAMPAIGN_QUERY_RULE_INTERVAL', 'COLUMN', N'QUERY_RULE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the date associated with the record. This is calculated by the data importer based on the source date time corresponding to the start of the reporting interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CAMPAIGN_QUERY_RULE_INTERVAL', 'COLUMN', N'DATE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DATE', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CAMPAIGN_QUERY_RULE_INTERVAL', 'COLUMN', N'DATE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the time associated with the record. This is calculated by the data importer based on the source date time corresponding to the start of the reporting interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CAMPAIGN_QUERY_RULE_INTERVAL', 'COLUMN', N'TIME_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIME', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CAMPAIGN_QUERY_RULE_INTERVAL', 'COLUMN', N'TIME_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the UTC date associated with the record. This is calculated by the data importer based on the source date time corresponding to the start of the reporting interval and the TimeZone information from the source data.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CAMPAIGN_QUERY_RULE_INTERVAL', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DATE', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CAMPAIGN_QUERY_RULE_INTERVAL', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the UTC time associated with the record. This is calculated by the data importer based on the source date time corresponding to the start of the reporting interval and the TimeZone information from the source data.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CAMPAIGN_QUERY_RULE_INTERVAL', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIME', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CAMPAIGN_QUERY_RULE_INTERVAL', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that were abandoned by the dialer during the reporting interval. This maps to AbandonDetectToHalf or AbandonDetect column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CAMPAIGN_QUERY_RULE_INTERVAL', 'COLUMN', N'ABANDON_DETECT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that were abandoned after being transferred into the IVR during the reporting interval. This maps to AbandonToIVRToHalf or AbandonToIVR column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CAMPAIGN_QUERY_RULE_INTERVAL', 'COLUMN', N'ABANDON_TO_IVR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of preview or callback calls that were closed by the agent during the reporting interval. This maps to AgentClosedDetectToHalf or AgentClosedDetect column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CAMPAIGN_QUERY_RULE_INTERVAL', 'COLUMN', N'AGENT_CLOSED_DETECT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of preview or callback calls that were rejected by the agent during the reporting interval. This maps to AgentRejectedDetectToHalf or AgentRejectedDetect column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CAMPAIGN_QUERY_RULE_INTERVAL', 'COLUMN', N'AGENT_REJECTED_DETECT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls where an answering was detected during the reporting interval. This maps to AnsweringMachineDetectToHalf or AnsweringMachineDetect column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CAMPAIGN_QUERY_RULE_INTERVAL', 'COLUMN', N'ANSWERING_MACHINE_DETECT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls where a busy tone was detected during the reporting interval. This maps to BusyDetectToHalf or BusyDetect column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CAMPAIGN_QUERY_RULE_INTERVAL', 'COLUMN', N'BUSY_DETECT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that were scheduled for callback during the reporting interval. This maps to CallbackCountToHalf or CallbackCount column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CAMPAIGN_QUERY_RULE_INTERVAL', 'COLUMN', N'CALLBACK_COUNT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls were the dialer cancelled whils it was ringing at the customer site during the reporting interval. This maps to CancelledDetectToHalf or CancelledDetect column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CAMPAIGN_QUERY_RULE_INTERVAL', 'COLUMN', N'CANCELLED_DETECT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number calls attempted during the reporting interval. This maps to ContactsAttemptedToHalf or ContactsAttempted column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CAMPAIGN_QUERY_RULE_INTERVAL', 'COLUMN', N'CONTACTS_ATTEMPTED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that were abandoned by the customer after picking it up during the reporting interval. This maps to CustomerAbandonDetectToHalf or CustomerAbandonDetect column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CAMPAIGN_QUERY_RULE_INTERVAL', 'COLUMN', N'CUSTOMER_ABANDON_DETECT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that were answered by persons other that the intended customer during the reporting interval. This maps to CustomerNotHomeCountToHalf or CustomerNotHomeCount column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CAMPAIGN_QUERY_RULE_INTERVAL', 'COLUMN', N'CUSTOMER_NOT_HOME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls were a fax machine was detected during the reporting interval. This maps to FaxDetectToHalf or FaxDetect column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CAMPAIGN_QUERY_RULE_INTERVAL', 'COLUMN', N'FAX_DETECT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls where a network answering machine was detected during the reporting interval. This maps to NetworkAnsMachineDetectToHalf or NetworkAnsMachineDetect column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CAMPAIGN_QUERY_RULE_INTERVAL', 'COLUMN', N'NETWORK_ANS_MACHINE_DETECT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that were not answered by the customer during the reporting interval. This maps to NoAnswerDetectToHalf or NoAnswerDetect column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CAMPAIGN_QUERY_RULE_INTERVAL', 'COLUMN', N'NO_ANSWER_DETECT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls where a dial tone was not recieved during the reporting interval. This maps to NoDialToneDetectToHalf or NoDialToneDetect column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CAMPAIGN_QUERY_RULE_INTERVAL', 'COLUMN', N'NO_DIAL_TONE_DETECT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that did not recieve a ring back message during the reporting interval. This maps to NoRingBackDetectToHalf or NoRingBackDetect column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CAMPAIGN_QUERY_RULE_INTERVAL', 'COLUMN', N'NO_RINGBACK_DETECT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls where the customer asked for a personal ring back during the reporting interval. This maps to PersonalCallbackCountToHalf or PersonalCallbackCount column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CAMPAIGN_QUERY_RULE_INTERVAL', 'COLUMN', N'PERSONAL_CALLBACK_COUNT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that resulted in a wrond number during the reporting interval. This maps to WrongNumberCountToHalf or WrongNumberCount column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CAMPAIGN_QUERY_RULE_INTERVAL', 'COLUMN', N'WRONG_NUMBER_COUNT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls that ended with agent answering the call during the reporting interval. This maps to VoiceDetectToHalf or VoiceDetect column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CAMPAIGN_QUERY_RULE_INTERVAL', 'COLUMN', N'VOICE_DETECT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls were a network SIT tone was detected during the reporting interval. This maps to SITToneDetectToHalf or SITToneDetect column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CAMPAIGN_QUERY_RULE_INTERVAL', 'COLUMN', N'SIT_TONE_DETECT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, the agents spent talking on the phone during the reporting interval. This maps to TalkTimeToHalf or TalkTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CAMPAIGN_QUERY_RULE_INTERVAL', 'COLUMN', N'TALK_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total time, in seconds, the agents spent in wrap-up mode during the reporting interval. This maps to WrapupTimeToHalf or WrapupTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CAMPAIGN_QUERY_RULE_INTERVAL', 'COLUMN', N'WRAPUP_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a date time stamp corresponding to when the data was written into the source database. The data in this column maps to DbDateTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CAMPAIGN_QUERY_RULE_INTERVAL', 'COLUMN', N'DB_DATETIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number for the current partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CAMPAIGN_QUERY_RULE_INTERVAL', 'COLUMN', N'PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the surrogate key identifier for the record from the source data. The data in this column maps to RecoveryKey column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CAMPAIGN_QUERY_RULE_INTERVAL', 'COLUMN', N'RECOVERY_KEY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the datetime stamp associated with the record. This corresponds to the start of the reporting interval. This maps to the DateTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CAMPAIGN_QUERY_RULE_INTERVAL', 'COLUMN', N'DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to the CampaignOutOfNumbersToHalf or CampaignOutOfNumbers column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CAMPAIGN_QUERY_RULE_INTERVAL', 'COLUMN', N'CAMPAIGN_OUT_OF_NUMBERS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of calls where the voice was not significant enough to count. This maps to the LowNoiseVolumeToHalf or LowNoiseVolume column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CAMPAIGN_QUERY_RULE_INTERVAL', 'COLUMN', N'LOW_NOISE_VOLUME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This indicates how long the campaign was active during the reporting interval. This maps to the QueryRuleActiveTimeToHalf or QueryRuleActiveTime column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CAMPAIGN_QUERY_RULE_INTERVAL', 'COLUMN', N'QUERY_RULE_ACTIVE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to the ReportingHalfHour column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CAMPAIGN_QUERY_RULE_INTERVAL', 'COLUMN', N'REPORTING_HALF_HOUR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This maps to the ReportingInterval column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CAMPAIGN_QUERY_RULE_INTERVAL', 'COLUMN', N'REPORTING_INTERVAL'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the offset in minutes from UTC for the date and time. This maps to the TimeZone column in the source table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CAMPAIGN_QUERY_RULE_INTERVAL', 'COLUMN', N'TIME_ZONE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column gives information regarding the source of the data. This corresponds to the RESOURCE_URN from TB_CLU_RESOURCE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SUM_CAMPAIGN_QUERY_RULE_INTERVAL', 'COLUMN', N'CLUSTER_RESOURCE_URN'
GO
GRANT SELECT
	ON [dbo].[TB_SUM_CAMPAIGN_QUERY_RULE_INTERVAL]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_SUM_CAMPAIGN_QUERY_RULE_INTERVAL]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_SUM_CAMPAIGN_QUERY_RULE_INTERVAL]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_SUM_CAMPAIGN_QUERY_RULE_INTERVAL] SET (LOCK_ESCALATION = TABLE)
GO
