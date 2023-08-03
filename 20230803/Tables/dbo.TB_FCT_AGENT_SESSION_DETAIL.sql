SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TB_FCT_AGENT_SESSION_DETAIL] (
		[PARTITION_URN]                      [int] NOT NULL,
		[PARTITION_GLOBAL_URN]               [bigint] NOT NULL,
		[PARTITION_ID]                       [int] NOT NULL,
		[DATE_TIME_UTC]                      [datetime] NOT NULL,
		[DATE_UTC_URN]                       [int] NOT NULL,
		[TIME_UTC_URN]                       [smallint] NOT NULL,
		[CLUSTER_RESOURCE_URN]               [int] NOT NULL,
		[SKEY]                               [numeric](19, 0) NOT NULL,
		[TENANT_URN]                         [int] NOT NULL,
		[AGENT_URN]                          [int] NOT NULL,
		[PERSON_URN]                         [int] NOT NULL,
		[AGENT_TEAM_URN]                     [int] NOT NULL,
		[ACTIVITY_TYPE_CODE_URN]             [int] NOT NULL,
		[ACTIVITY_SUB_TYPE_CODE_URN]         [int] NOT NULL,
		[USER_SESSION_KEY]                   [numeric](19, 0) NOT NULL,
		[LOGOUT_CNTR]                        [int] NOT NULL,
		[LOGIN_CNTR]                         [int] NOT NULL,
		[LOGIN_IDLE_TIMEOUT_CNTR]            [int] NOT NULL,
		[LOGOUT_BY_SYSTEM_TIMEOUT_CNTR]      [int] NOT NULL,
		[AVAILABILITY_CNTR]                  [int] NOT NULL,
		[UNAVAILABILITY_CNTR]                [int] NOT NULL,
		[LOGIN_DURATION_ON_LOGOUT]           [int] NOT NULL,
		[LOGIN_DURATION_ON_TIMEOUT]          [int] NOT NULL,
		[AVAILABILITY_DURATION]              [int] NOT NULL,
		[CUSTOM_DIMENSION_0]                 [int] NOT NULL,
		[CUSTOM_DIMENSION_1]                 [int] NOT NULL,
		[CUSTOM_DIMENSION_2]                 [int] NOT NULL,
		[CUSTOM_DIMENSION_3]                 [int] NOT NULL,
		[CUSTOM_DIMENSION_4]                 [int] NOT NULL,
		[CUSTOM_DIMENSION_5]                 [int] NOT NULL,
		[CUSTOM_DIMENSION_6]                 [int] NOT NULL,
		[CUSTOM_DIMENSION_7]                 [int] NOT NULL,
		[CUSTOM_DIMENSION_8]                 [int] NOT NULL,
		[CUSTOM_DIMENSION_9]                 [int] NOT NULL,
		[CUSTOM_MEASURE_0]                   [int] NULL,
		[CUSTOM_MEASURE_1]                   [int] NULL,
		[CUSTOM_MEASURE_2]                   [int] NULL,
		[CUSTOM_MEASURE_3]                   [int] NULL,
		[CUSTOM_MEASURE_4]                   [int] NULL,
		[CUSTOM_MEASURE_5]                   [int] NULL,
		[CUSTOM_MEASURE_6]                   [int] NULL,
		[CUSTOM_MEASURE_7]                   [int] NULL,
		[CUSTOM_MEASURE_8]                   [int] NULL,
		[CUSTOM_MEASURE_9]                   [int] NULL,
		[LOGIN_DURATION]                     [int] NOT NULL,
		[REASON_CODE_URN]                    [int] NOT NULL,
		[UNAVAILABLE_DURATION_CHAT]          [int] NOT NULL,
		[UNAVAILABLE_DURATION_VCHAT]         [int] NOT NULL,
		[UNAVAILABLE_DURATION_EMAIL]         [int] NOT NULL,
		[UNAVAILABLE_DURATION_TASK]          [int] NOT NULL,
		[UNAVAILABLE_DURATION_SOCIAL]        [int] NOT NULL,
		[MANAGER_AGENT_URN]                  [int] NOT NULL,
		[UNAVAILABLE_DURATION_CALLTRACK]     [int] NOT NULL,
		CONSTRAINT [PK_FCT_AGENT_SESSION_DETAIL]
		PRIMARY KEY
		CLUSTERED
		([PARTITION_URN])
	ON [FCTEGNGROUP]
) ON [FCTEGNGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_FCT_AGENT_SESSION_DETAIL_AGENT_URN]
	ON [dbo].[TB_FCT_AGENT_SESSION_DETAIL] ([AGENT_URN])
	ON [FCTEGNGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SESSION_DETAIL', 'INDEX', N'IX_FCT_AGENT_SESSION_DETAIL_AGENT_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_AGENT_SESSION_DETAIL_PERSON_URN]
	ON [dbo].[TB_FCT_AGENT_SESSION_DETAIL] ([PERSON_URN])
	ON [FCTEGNGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SESSION_DETAIL', 'INDEX', N'IX_FCT_AGENT_SESSION_DETAIL_PERSON_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_AGENT_SESSION_DETAIL_AGENT_TEAM_URN]
	ON [dbo].[TB_FCT_AGENT_SESSION_DETAIL] ([AGENT_TEAM_URN])
	ON [FCTEGNGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SESSION_DETAIL', 'INDEX', N'IX_FCT_AGENT_SESSION_DETAIL_AGENT_TEAM_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the template table for the historical metrics or facts relating to user sessions, including login and availability data. This is equivalent to EGDM_INT_FCT_USERSESSION_DET in the eGain Analytics Database.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SESSION_DETAIL', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SESSION_DETAIL', 'COLUMN', N'PARTITION_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column holds a value that uniquely identifies a row across all the partition tables for this partition type.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SESSION_DETAIL', 'COLUMN', N'PARTITION_GLOBAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number for the current partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SESSION_DETAIL', 'COLUMN', N'PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The date and time when the event occurred in UTC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SESSION_DETAIL', 'COLUMN', N'DATE_TIME_UTC'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the date of the DATE_TIME_UTC value.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SESSION_DETAIL', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DATE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SESSION_DETAIL', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the time of the DATE_TIME_UTC value.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SESSION_DETAIL', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIME', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SESSION_DETAIL', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column gives information regarding the source of the data. This corresponds to the RESOURCE_URN from TB_CLU_RESOURCE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SESSION_DETAIL', 'COLUMN', N'CLUSTER_RESOURCE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the primary key on the source and is used for debugging.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SESSION_DETAIL', 'COLUMN', N'SKEY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_TENANT.ITEM_URN and refers to the Tenant (or "Department" on the source) of the Agent.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SESSION_DETAIL', 'COLUMN', N'TENANT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TENANT', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SESSION_DETAIL', 'COLUMN', N'TENANT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_AGENT.ITEM_URN and refers to the Agent to which this session belongs.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SESSION_DETAIL', 'COLUMN', N'AGENT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_AGENT', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SESSION_DETAIL', 'COLUMN', N'AGENT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_PERSON.ITEM_URN and refers to the Person to which this session belongs.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SESSION_DETAIL', 'COLUMN', N'PERSON_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_PERSON', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SESSION_DETAIL', 'COLUMN', N'PERSON_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_AGENT_TEAM.ITEM_URN and refers to the Agent Team of the Agent.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SESSION_DETAIL', 'COLUMN', N'AGENT_TEAM_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_AGENT_TEAM', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SESSION_DETAIL', 'COLUMN', N'AGENT_TEAM_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_CODE.ITEM_URN and refers to an Activity Type in the Activity Type Code Group.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SESSION_DETAIL', 'COLUMN', N'ACTIVITY_TYPE_CODE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CODE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SESSION_DETAIL', 'COLUMN', N'ACTIVITY_TYPE_CODE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_SUB_CODE.ITEM_URN and refers to an Activity Sub Type of the Activity Type stored in ACTIVITY_TYPE_CODE_URN.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SESSION_DETAIL', 'COLUMN', N'ACTIVITY_SUB_TYPE_CODE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_SUB_CODE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SESSION_DETAIL', 'COLUMN', N'ACTIVITY_SUB_TYPE_CODE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The unique ID of the user session.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SESSION_DETAIL', 'COLUMN', N'USER_SESSION_KEY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times the user logged out during a session. Users are logged out either when they click the Log Out button or when the system times out due to inactivity. Note: If a previous session is still active when they log in, users have the option of continuing that session.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SESSION_DETAIL', 'COLUMN', N'LOGOUT_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times the user logged in during a session. Note: If a previous session is still active when they log in, users have the option of continuing that session.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SESSION_DETAIL', 'COLUMN', N'LOGIN_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times the user logged out during the session because of inactivity. This does not include the times when users explicitly log out by clicking the Log Out button.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SESSION_DETAIL', 'COLUMN', N'LOGIN_IDLE_TIMEOUT_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times the user was forcibly logged out by the system. This may happen because of network errors, browser crashes, etc.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SESSION_DETAIL', 'COLUMN', N'LOGOUT_BY_SYSTEM_TIMEOUT_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times the agent marked herself available for Chat or Video Chat during the session.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SESSION_DETAIL', 'COLUMN', N'AVAILABILITY_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of times the agent marked herself unavailable for Chat or Video Chat during the session.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SESSION_DETAIL', 'COLUMN', N'UNAVAILABILITY_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The amount of time for which the user was logged into the system during the session. Duration = Time at Logout – Time at Login where the log out is an explicit log out action.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SESSION_DETAIL', 'COLUMN', N'LOGIN_DURATION_ON_LOGOUT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The amount of time for which the user was logged into the system during the session. Duration = Time at Logout – Time at Login where the log out is a result of the session timing out.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SESSION_DETAIL', 'COLUMN', N'LOGIN_DURATION_ON_TIMEOUT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Only applicable to Chat and Video Chat, this shows the amount of time for which the user was available to handle activities during the session.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SESSION_DETAIL', 'COLUMN', N'AVAILABILITY_DURATION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SESSION_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM0', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SESSION_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SESSION_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM1', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SESSION_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SESSION_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM2', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SESSION_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SESSION_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM3', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SESSION_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SESSION_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM4', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SESSION_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SESSION_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM5', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SESSION_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SESSION_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM6', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SESSION_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SESSION_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM7', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SESSION_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SESSION_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM8', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SESSION_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SESSION_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM9', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SESSION_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SESSION_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SESSION_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SESSION_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SESSION_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SESSION_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SESSION_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SESSION_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SESSION_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SESSION_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SESSION_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The amount of time for which the user was logged into the system during the session interval. Duration = Time at Logout – Time at Login where the log out is an explicit log out action.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SESSION_DETAIL', 'COLUMN', N'LOGIN_DURATION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key to TB_DIM_REASON_CODE indicating the reason why the user went into an unavailable state for a given activity type.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SESSION_DETAIL', 'COLUMN', N'REASON_CODE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_REASON_CODE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SESSION_DETAIL', 'COLUMN', N'REASON_CODE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The amount of time in seconds where the user was unavailable for chat activities.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SESSION_DETAIL', 'COLUMN', N'UNAVAILABLE_DURATION_CHAT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The amount of time in seconds where the user was unavailable for video chats.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SESSION_DETAIL', 'COLUMN', N'UNAVAILABLE_DURATION_VCHAT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The amount of time in seconds where the user was unavailable for email activities.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SESSION_DETAIL', 'COLUMN', N'UNAVAILABLE_DURATION_EMAIL'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The amount of time in seconds where the user was unavailable for task activities.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SESSION_DETAIL', 'COLUMN', N'UNAVAILABLE_DURATION_TASK'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The amount of time in seconds where the user was unavailable for social activities.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SESSION_DETAIL', 'COLUMN', N'UNAVAILABLE_DURATION_SOCIAL'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_AGENT.ITEM_URN and refers to the Agent who is manager of the Agent specified in AGENT_URN.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SESSION_DETAIL', 'COLUMN', N'MANAGER_AGENT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The amount of time in seconds where the user was unavailable for calltrack activities.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_SESSION_DETAIL', 'COLUMN', N'UNAVAILABLE_DURATION_CALLTRACK'
GO
GRANT SELECT
	ON [dbo].[TB_FCT_AGENT_SESSION_DETAIL]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_FCT_AGENT_SESSION_DETAIL]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_FCT_AGENT_SESSION_DETAIL]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_FCT_AGENT_SESSION_DETAIL] SET (LOCK_ESCALATION = TABLE)
GO
