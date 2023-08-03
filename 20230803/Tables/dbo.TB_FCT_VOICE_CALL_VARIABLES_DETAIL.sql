SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_FCT_VOICE_CALL_VARIABLES_DETAIL] (
		[PARTITION_URN]            [int] NOT NULL,
		[PARTITION_GLOBAL_URN]     [bigint] NOT NULL,
		[PARTITION_ID]             [int] NOT NULL,
		[DATE_TIME_UTC]            [datetime] NOT NULL,
		[DATE_UTC_URN]             [int] NOT NULL,
		[TIME_UTC_URN]             [smallint] NOT NULL,
		[CLUSTER_RESOURCE_URN]     [int] NOT NULL,
		[QUEUE_URN]                [int] NOT NULL,
		[AGENT_URN]                [int] NOT NULL,
		[DIALED_NUMBER_URN]        [int] NOT NULL,
		[CONTACT_ID]               [nvarchar](256) COLLATE Latin1_General_CI_AS NOT NULL,
		[VAR_KEY]                  [nvarchar](256) COLLATE Latin1_General_CI_AS NOT NULL,
		[VAR_VALUE]                [nvarchar](max) COLLATE Latin1_General_CI_AS NOT NULL,
		CONSTRAINT [PK_FCT_VOICE_CALL_VARIABLES_DETAIL]
		PRIMARY KEY
		CLUSTERED
		([PARTITION_URN])
	ON [FCTAWSGROUP]
) ON [FCTAWSGROUP] TEXTIMAGE_ON [FCTAWSGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_FCT_VOICE_CALL_VARIABLES_DETAIL_AGENT_URN]
	ON [dbo].[TB_FCT_VOICE_CALL_VARIABLES_DETAIL] ([AGENT_URN])
	ON [FCTAWSGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VOICE_CALL_VARIABLES_DETAIL', 'INDEX', N'IX_FCT_VOICE_CALL_VARIABLES_DETAIL_AGENT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the template table for metrics relating to classification of activities.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VOICE_CALL_VARIABLES_DETAIL', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VOICE_CALL_VARIABLES_DETAIL', 'COLUMN', N'PARTITION_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column holds a value that uniquely identifies a row across all the partition tables for this partition type.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VOICE_CALL_VARIABLES_DETAIL', 'COLUMN', N'PARTITION_GLOBAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number for the current partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VOICE_CALL_VARIABLES_DETAIL', 'COLUMN', N'PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The date and time when the event occurred in UTC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VOICE_CALL_VARIABLES_DETAIL', 'COLUMN', N'DATE_TIME_UTC'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the date of the DATE_TIME_UTC value.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VOICE_CALL_VARIABLES_DETAIL', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DATE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VOICE_CALL_VARIABLES_DETAIL', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the time of the DATE_TIME_UTC value.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VOICE_CALL_VARIABLES_DETAIL', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIME', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VOICE_CALL_VARIABLES_DETAIL', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column gives information regarding the source of the data. This corresponds to the RESOURCE_URN from TB_CLU_RESOURCE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VOICE_CALL_VARIABLES_DETAIL', 'COLUMN', N'CLUSTER_RESOURCE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_QUEUE.ITEM_URN and refers to the Queue related to this activity.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VOICE_CALL_VARIABLES_DETAIL', 'COLUMN', N'QUEUE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_QUEUE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VOICE_CALL_VARIABLES_DETAIL', 'COLUMN', N'QUEUE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_AGENT.ITEM_URN and refers to the Agent to which the case is assigned.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VOICE_CALL_VARIABLES_DETAIL', 'COLUMN', N'AGENT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_AGENT', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VOICE_CALL_VARIABLES_DETAIL', 'COLUMN', N'AGENT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TN_DIM_DIALED_NUMBER.ITEM_URN and refers to the dialed number for the contact leg.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VOICE_CALL_VARIABLES_DETAIL', 'COLUMN', N'DIALED_NUMBER_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The unique identifier for the contact leg.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VOICE_CALL_VARIABLES_DETAIL', 'COLUMN', N'CONTACT_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The contact attribute name.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VOICE_CALL_VARIABLES_DETAIL', 'COLUMN', N'VAR_KEY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The contact attribute value.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_VOICE_CALL_VARIABLES_DETAIL', 'COLUMN', N'VAR_VALUE'
GO
GRANT SELECT
	ON [dbo].[TB_FCT_VOICE_CALL_VARIABLES_DETAIL]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_FCT_VOICE_CALL_VARIABLES_DETAIL]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_FCT_VOICE_CALL_VARIABLES_DETAIL]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_FCT_VOICE_CALL_VARIABLES_DETAIL] SET (LOCK_ESCALATION = TABLE)
GO
