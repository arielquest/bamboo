SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_FCT_COBROWSE_SESSION] (
		[PARTITION_URN]                   [int] NOT NULL,
		[PARTITION_ID]                    [int] NOT NULL,
		[PARTITION_GLOBAL_URN]            [bigint] NOT NULL,
		[START_DATE_TIME_UTC]             [datetime] NOT NULL,
		[END_DATE_TIME_UTC]               [datetime] NOT NULL,
		[START_DATE_UTC_URN]              [int] NOT NULL,
		[START_TIME_UTC_URN]              [smallint] NOT NULL,
		[END_DATE_UTC_URN]                [int] NOT NULL,
		[END_TIME_UTC_URN]                [smallint] NOT NULL,
		[CLUSTER_RESOURCE_URN]            [int] NOT NULL,
		[SESSION_ID]                      [nvarchar](255) COLLATE Latin1_General_CI_AS NOT NULL,
		[SESSION_UID]                     [nvarchar](255) COLLATE Latin1_General_CI_AS NOT NULL,
		[LAST_EVENT_TYPE]                 [nvarchar](255) COLLATE Latin1_General_CI_AS NOT NULL,
		[SESSION_INITIATION_TYPE_URN]     [tinyint] NOT NULL,
		[TENANT_URN]                      [int] NOT NULL,
		[CUSTOMER_URN]                    [int] NOT NULL,
		[AGENT_URN]                       [int] NOT NULL,
		[PERSON_URN]                      [int] NOT NULL,
		[AGENT_TEAM_URN]                  [int] NOT NULL,
		[SESSION_SUCCESSFUL]              [bit] NOT NULL,
		[SESSION_DURATION]                [int] NOT NULL,
		[TOTAL_PAGE_VISITS]               [int] NOT NULL,
		[TOTAL_PAGE_DURATION]             [int] NOT NULL,
		[MIN_PAGE_DURATION]               [int] NOT NULL,
		[MAX_PAGE_DURATION]               [int] NOT NULL,
		[CUSTOM_DIMENSION_0]              [int] NOT NULL,
		[CUSTOM_DIMENSION_1]              [int] NOT NULL,
		[CUSTOM_DIMENSION_2]              [int] NOT NULL,
		[CUSTOM_DIMENSION_3]              [int] NOT NULL,
		[CUSTOM_DIMENSION_4]              [int] NOT NULL,
		[CUSTOM_DIMENSION_5]              [int] NOT NULL,
		[CUSTOM_DIMENSION_6]              [int] NOT NULL,
		[CUSTOM_DIMENSION_7]              [int] NOT NULL,
		[CUSTOM_DIMENSION_8]              [int] NOT NULL,
		[CUSTOM_DIMENSION_9]              [int] NOT NULL,
		[CUSTOM_MEASURE_0]                [int] NULL,
		[CUSTOM_MEASURE_1]                [int] NULL,
		[CUSTOM_MEASURE_2]                [int] NULL,
		[CUSTOM_MEASURE_3]                [int] NULL,
		[CUSTOM_MEASURE_4]                [int] NULL,
		[CUSTOM_MEASURE_5]                [int] NULL,
		[CUSTOM_MEASURE_6]                [int] NULL,
		[CUSTOM_MEASURE_7]                [int] NULL,
		[CUSTOM_MEASURE_8]                [int] NULL,
		[CUSTOM_MEASURE_9]                [int] NULL,
		[MANAGER_AGENT_URN]               [int] NOT NULL,
		[START_PAGE_URN]                  [int] NOT NULL,
		[END_PAGE_URN]                    [int] NOT NULL,
		CONSTRAINT [PK_FCT_COBROWSE_SESSION]
		PRIMARY KEY
		CLUSTERED
		([PARTITION_URN], [PARTITION_ID])
	ON [FCTEGNGROUP]
) ON [FCTEGNGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_FCT_COBROWSE_SESSION_AGENT_URN]
	ON [dbo].[TB_FCT_COBROWSE_SESSION] ([AGENT_URN])
	ON [FCTEGNGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_COBROWSE_SESSION', 'INDEX', N'IX_FCT_COBROWSE_SESSION_AGENT_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_COBROWSE_SESSION_PERSON_URN]
	ON [dbo].[TB_FCT_COBROWSE_SESSION] ([PERSON_URN])
	ON [FCTEGNGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_COBROWSE_SESSION', 'INDEX', N'IX_FCT_COBROWSE_SESSION_PERSON_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_COBROWSE_SESSION_AGENT_TEAM_URN]
	ON [dbo].[TB_FCT_COBROWSE_SESSION] ([AGENT_TEAM_URN])
	ON [FCTEGNGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_COBROWSE_SESSION', 'INDEX', N'IX_FCT_COBROWSE_SESSION_AGENT_TEAM_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the template table for metrics or facts relating to cobrowse in the eGain application. The session data will be sourced from eGActiveDB.EGCB_SESSION_ETL_STAGE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_COBROWSE_SESSION', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_COBROWSE_SESSION', 'COLUMN', N'PARTITION_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number for the current partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_COBROWSE_SESSION', 'COLUMN', N'PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column holds a value that uniquely identifies a row across all the partition tables for this partition type.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_COBROWSE_SESSION', 'COLUMN', N'PARTITION_GLOBAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The date and time in UTC indicating the start of the knowledge base portal session.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_COBROWSE_SESSION', 'COLUMN', N'START_DATE_TIME_UTC'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The date and time in UTC indicating the end of the knowledge base portal session.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_COBROWSE_SESSION', 'COLUMN', N'END_DATE_TIME_UTC'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the date of the START_DATE_TIME_UTC value.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_COBROWSE_SESSION', 'COLUMN', N'START_DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the time of the START_DATE_TIME_UTC value.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_COBROWSE_SESSION', 'COLUMN', N'START_TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the date of the END_DATE_TIME_UTC value.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_COBROWSE_SESSION', 'COLUMN', N'END_DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the time of the END_DATE_TIME_UTC value.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_COBROWSE_SESSION', 'COLUMN', N'END_TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column gives information regarding the source of the data. This corresponds to the RESOURCE_URN from TB_CLU_RESOURCE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_COBROWSE_SESSION', 'COLUMN', N'CLUSTER_RESOURCE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the cobrowse base portal session identifier on the source equipment.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_COBROWSE_SESSION', 'COLUMN', N'SESSION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the cobrowse base portal session alternate identifier on the source equipment.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_COBROWSE_SESSION', 'COLUMN', N'SESSION_UID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the final event type seen by the ETL on the source equipment for the cobrowse sessions.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_COBROWSE_SESSION', 'COLUMN', N'LAST_EVENT_TYPE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This identifies whether the cobrowse session was initiated by a customer, agent or unknown.  Will contain either 0 (unknown), 1 (agent) or 2 (customer).', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_COBROWSE_SESSION', 'COLUMN', N'SESSION_INITIATION_TYPE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_TENANT.ITEM_URN and refers to the Tenant (or "Department" on the source) of the cobrowse base portal.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_COBROWSE_SESSION', 'COLUMN', N'TENANT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TENANT', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_COBROWSE_SESSION', 'COLUMN', N'TENANT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_CUSTOMER.ITEM_URN indicating the authenticated customer for the cobrowse base portal session. This will be set only for authenticated customer sessions. Default is -1 indicating no customer.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_COBROWSE_SESSION', 'COLUMN', N'CUSTOMER_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_AGENT.ITEM_URN indicating the authenticated cobrowse agent for the portal session. This will be set only for portal sessions accessed by cobrowse agents. Default is -1 indicating no agent.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_COBROWSE_SESSION', 'COLUMN', N'AGENT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_AGENT', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_COBROWSE_SESSION', 'COLUMN', N'AGENT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_PERSON.ITEM_URN indicating the Person for the Agent. This will be set for conformed agents only.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_COBROWSE_SESSION', 'COLUMN', N'PERSON_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_PERSON', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_COBROWSE_SESSION', 'COLUMN', N'PERSON_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_AGENT_TEAM.ITEM_URN indicating the Agent Team for the Agent where it is a physical member. This will be set for conformed agents only.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_COBROWSE_SESSION', 'COLUMN', N'AGENT_TEAM_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_AGENT_TEAM', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_COBROWSE_SESSION', 'COLUMN', N'AGENT_TEAM_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Indicates whether the cobrowse session was successful.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_COBROWSE_SESSION', 'COLUMN', N'SESSION_SUCCESSFUL'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Total duration of the cobrowse session.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_COBROWSE_SESSION', 'COLUMN', N'SESSION_DURATION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of unique pages visited in a cobrowse session.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_COBROWSE_SESSION', 'COLUMN', N'TOTAL_PAGE_VISITS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The total time spent across all pages visited during the cobrowse session in seconds.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_COBROWSE_SESSION', 'COLUMN', N'TOTAL_PAGE_DURATION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The minimum time spent on a pages visited during the cobrowse session in seconds.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_COBROWSE_SESSION', 'COLUMN', N'MIN_PAGE_DURATION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The maximum time spent on a pages visited during the cobrowse session in seconds.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_COBROWSE_SESSION', 'COLUMN', N'MAX_PAGE_DURATION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_COBROWSE_SESSION', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM0', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_COBROWSE_SESSION', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_COBROWSE_SESSION', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM1', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_COBROWSE_SESSION', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_COBROWSE_SESSION', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM2', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_COBROWSE_SESSION', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_COBROWSE_SESSION', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM3', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_COBROWSE_SESSION', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_COBROWSE_SESSION', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM4', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_COBROWSE_SESSION', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_COBROWSE_SESSION', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM5', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_COBROWSE_SESSION', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_COBROWSE_SESSION', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM6', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_COBROWSE_SESSION', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_COBROWSE_SESSION', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM7', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_COBROWSE_SESSION', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_COBROWSE_SESSION', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM8', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_COBROWSE_SESSION', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_COBROWSE_SESSION', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM9', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_COBROWSE_SESSION', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_COBROWSE_SESSION', 'COLUMN', N'CUSTOM_MEASURE_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_COBROWSE_SESSION', 'COLUMN', N'CUSTOM_MEASURE_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_COBROWSE_SESSION', 'COLUMN', N'CUSTOM_MEASURE_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_COBROWSE_SESSION', 'COLUMN', N'CUSTOM_MEASURE_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_COBROWSE_SESSION', 'COLUMN', N'CUSTOM_MEASURE_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_COBROWSE_SESSION', 'COLUMN', N'CUSTOM_MEASURE_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_COBROWSE_SESSION', 'COLUMN', N'CUSTOM_MEASURE_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_COBROWSE_SESSION', 'COLUMN', N'CUSTOM_MEASURE_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_COBROWSE_SESSION', 'COLUMN', N'CUSTOM_MEASURE_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_COBROWSE_SESSION', 'COLUMN', N'CUSTOM_MEASURE_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_AGENT.ITEM_URN and refers to the Agent who is manager of the Agent specified in AGENT_URN.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_COBROWSE_SESSION', 'COLUMN', N'MANAGER_AGENT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_COBROWSE_PAGE.ITEM_URN and refers to the URL of first page in a CoBrowse session.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_COBROWSE_SESSION', 'COLUMN', N'START_PAGE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_COBROWSE_PAGE.ITEM_URN and refers to the URL of last page in a CoBrowse session.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_COBROWSE_SESSION', 'COLUMN', N'END_PAGE_URN'
GO
GRANT SELECT
	ON [dbo].[TB_FCT_COBROWSE_SESSION]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_FCT_COBROWSE_SESSION]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_FCT_COBROWSE_SESSION]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_FCT_COBROWSE_SESSION] SET (LOCK_ESCALATION = TABLE)
GO
