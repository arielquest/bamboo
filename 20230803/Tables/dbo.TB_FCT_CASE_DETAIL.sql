SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TB_FCT_CASE_DETAIL] (
		[PARTITION_URN]                [int] NOT NULL,
		[PARTITION_GLOBAL_URN]         [bigint] NOT NULL,
		[PARTITION_ID]                 [int] NOT NULL,
		[DATE_TIME_UTC]                [datetime] NOT NULL,
		[DATE_UTC_URN]                 [int] NOT NULL,
		[TIME_UTC_URN]                 [smallint] NOT NULL,
		[SKEY]                         [numeric](19, 0) NOT NULL,
		[CLUSTER_RESOURCE_URN]         [int] NOT NULL,
		[CASE_ID]                      [numeric](19, 0) NOT NULL,
		[CASE_STATE]                   [smallint] NOT NULL,
		[CASE_SEVERITY]                [int] NOT NULL,
		[TENANT_URN]                   [int] NOT NULL,
		[ACTIVITY_TYPE_CODE_URN]       [int] NOT NULL,
		[CUSTOMER_URN]                 [int] NOT NULL,
		[AGENT_URN]                    [int] NOT NULL,
		[PERSON_URN]                   [int] NOT NULL,
		[AGENT_TEAM_URN]               [int] NOT NULL,
		[NEW_CNTR]                     [int] NOT NULL,
		[CLOSE_CNTR]                   [int] NOT NULL,
		[REOPEN_CNTR]                  [int] NOT NULL,
		[ACTIVITY_ASSIGNED_CNTR]       [int] NOT NULL,
		[ACTIVITY_UNASSIGNED_CNTR]     [int] NOT NULL,
		[ASSIGNED_TO_USER_CNTR]        [int] NOT NULL,
		[RESOLUTION_TIME]              [int] NOT NULL,
		[CLOSED_METSLA_CNTR]           [int] NOT NULL,
		[CLOSED_NOTMETSLA_CNTR]        [int] NOT NULL,
		[CUSTOM_DIMENSION_0]           [int] NOT NULL,
		[CUSTOM_DIMENSION_1]           [int] NOT NULL,
		[CUSTOM_DIMENSION_2]           [int] NOT NULL,
		[CUSTOM_DIMENSION_3]           [int] NOT NULL,
		[CUSTOM_DIMENSION_4]           [int] NOT NULL,
		[CUSTOM_DIMENSION_5]           [int] NOT NULL,
		[CUSTOM_DIMENSION_6]           [int] NOT NULL,
		[CUSTOM_DIMENSION_7]           [int] NOT NULL,
		[CUSTOM_DIMENSION_8]           [int] NOT NULL,
		[CUSTOM_DIMENSION_9]           [int] NOT NULL,
		[CUSTOM_MEASURE_0]             [int] NULL,
		[CUSTOM_MEASURE_1]             [int] NULL,
		[CUSTOM_MEASURE_2]             [int] NULL,
		[CUSTOM_MEASURE_3]             [int] NULL,
		[CUSTOM_MEASURE_4]             [int] NULL,
		[CUSTOM_MEASURE_5]             [int] NULL,
		[CUSTOM_MEASURE_6]             [int] NULL,
		[CUSTOM_MEASURE_7]             [int] NULL,
		[CUSTOM_MEASURE_8]             [int] NULL,
		[CUSTOM_MEASURE_9]             [int] NULL,
		[CASE_URN]                     [int] NOT NULL,
		[MANAGER_AGENT_URN]            [int] NOT NULL,
		[ACTIVITIES_ASSIGNED_CNTR]     [int] NOT NULL,
		[RESOLUTION_TIME_BIZCAL]       [int] NOT NULL,
		[VA_SELF_SERVED_CNTR]          [int] NOT NULL,
		CONSTRAINT [PK_FCT_CASE_DETAIL]
		PRIMARY KEY
		CLUSTERED
		([PARTITION_URN])
	ON [FCTEGNGROUP]
) ON [FCTEGNGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_FCT_CASE_DETAIL_CASE_ID]
	ON [dbo].[TB_FCT_CASE_DETAIL] ([CASE_ID])
	ON [FCTEGNIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_DETAIL', 'INDEX', N'IX_FCT_CASE_DETAIL_CASE_ID'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_CASE_DETAIL_AGENT_URN]
	ON [dbo].[TB_FCT_CASE_DETAIL] ([AGENT_URN])
	ON [FCTEGNIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_DETAIL', 'INDEX', N'IX_FCT_CASE_DETAIL_AGENT_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_CASE_DETAIL_PERSON_URN]
	ON [dbo].[TB_FCT_CASE_DETAIL] ([PERSON_URN])
	ON [FCTEGNIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_DETAIL', 'INDEX', N'IX_FCT_CASE_DETAIL_PERSON_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_CASE_DETAIL_AGENT_TEAM_URN]
	ON [dbo].[TB_FCT_CASE_DETAIL] ([AGENT_TEAM_URN])
	ON [FCTEGNIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'H', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_DETAIL', 'INDEX', N'IX_FCT_CASE_DETAIL_AGENT_TEAM_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the template table for metrics or facts relating to eGain Cases. It is equivalent to EGDM_INT_FCT_CASE_DET in the eGain Analytics Database.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_DETAIL', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_DETAIL', 'COLUMN', N'PARTITION_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column holds a value that uniquely identifies a row across all the partition tables for this partition type.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_DETAIL', 'COLUMN', N'PARTITION_GLOBAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number for the current partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_DETAIL', 'COLUMN', N'PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The date and time when the event occurred in UTC.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_DETAIL', 'COLUMN', N'DATE_TIME_UTC'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the date of the DATE_TIME_UTC value.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_DETAIL', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DATE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_DETAIL', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the time of the DATE_TIME_UTC value.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_DETAIL', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIME', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_DETAIL', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the primary key on the source and is used for debugging.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_DETAIL', 'COLUMN', N'SKEY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column gives information regarding the source of the data. This corresponds to the RESOURCE_URN from TB_CLU_RESOURCE.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_DETAIL', 'COLUMN', N'CLUSTER_RESOURCE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Unique ID for the case on the source.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_DETAIL', 'COLUMN', N'CASE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The status of the case when this event occured. 1 = Open, 2 = Completed, 4 = Reopened.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_DETAIL', 'COLUMN', N'CASE_STATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'An integer value that identifies the severity of this case when this routing activity was performed.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_DETAIL', 'COLUMN', N'CASE_SEVERITY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_TENANT.ITEM_URN and refers to the Tenant (or "Department" on the source) of the Agent.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_DETAIL', 'COLUMN', N'TENANT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TENANT', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_DETAIL', 'COLUMN', N'TENANT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_CODE.ITEM_URN and refers to the type of the activity (e.g. Chat or Email) associated with this event.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_DETAIL', 'COLUMN', N'ACTIVITY_TYPE_CODE_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CODE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_DETAIL', 'COLUMN', N'ACTIVITY_TYPE_CODE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_CUSTOMER.ITEM_URN and refers to the customer of the case.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_DETAIL', 'COLUMN', N'CUSTOMER_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_AGENT.ITEM_URN and refers to the Agent to which the case is assigned.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_DETAIL', 'COLUMN', N'AGENT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_AGENT', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_DETAIL', 'COLUMN', N'AGENT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_PERSON.ITEM_URN and refers to the Person of the Agent.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_DETAIL', 'COLUMN', N'PERSON_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_PERSON', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_DETAIL', 'COLUMN', N'PERSON_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_AGENT_TEAM.ITEM_URN and refers to the Agent Team of the Agent where it is is a physical member.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_DETAIL', 'COLUMN', N'AGENT_TEAM_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_AGENT_TEAM', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_DETAIL', 'COLUMN', N'AGENT_TEAM_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Indicates if this is a new case that was created by the system.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_DETAIL', 'COLUMN', N'NEW_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Indicates if the case was closed by the system.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_DETAIL', 'COLUMN', N'CLOSE_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Indicates if the case was reopened by the system.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_DETAIL', 'COLUMN', N'REOPEN_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of incoming activities or interactions for the given case. Note: Activities created using the Compose option in the Agent Console are not included.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_DETAIL', 'COLUMN', N'ACTIVITY_ASSIGNED_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N' The number of incoming activities or interactions that were dissociated with this case and associated with another case. This number is based on events logged when a user changes the case of an incoming activity.Note: Activities created using the Compose option in the Agent Console are not included.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_DETAIL', 'COLUMN', N'ACTIVITY_UNASSIGNED_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of users to whom the case has been offered or assigned, either by the workflow or manually.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_DETAIL', 'COLUMN', N'ASSIGNED_TO_USER_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Resolution Time = Time when case is closed – Time when case was created.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_DETAIL', 'COLUMN', N'RESOLUTION_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Determined by comparing the due date set for the case (in the workflow or manually) and the date on which the case was closed. This applies only to closed cases.If no SLA is defined, the system considers the case as not having met SLA.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_DETAIL', 'COLUMN', N'CLOSED_METSLA_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Determined by comparing the due date set for the case (in the workflow or manually) and the date on which the case was closed. This applies only to closed cases.If no SLA is defined, the system considers the case as not having met SLA.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_DETAIL', 'COLUMN', N'CLOSED_NOTMETSLA_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM0', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM1', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM2', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM3', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM4', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM5', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM6', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM7', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM8', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM9', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_DETAIL', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_DETAIL', 'COLUMN', N'CUSTOM_MEASURE_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN that represents Case information, as TB_DIM_CASE.ITEM_URN.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_DETAIL', 'COLUMN', N'CASE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_AGENT.ITEM_URN and refers to the Agent who is manager of the Agent specified in AGENT_URN.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_DETAIL', 'COLUMN', N'MANAGER_AGENT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The total number of activities assigned to cases solved during the interval.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_DETAIL', 'COLUMN', N'ACTIVITIES_ASSIGNED_CNTR'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The number of Virtual Assistant interactions that were completed during the interval without requiring a transfer to a live agent.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CASE_DETAIL', 'COLUMN', N'VA_SELF_SERVED_CNTR'
GO
GRANT SELECT
	ON [dbo].[TB_FCT_CASE_DETAIL]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_FCT_CASE_DETAIL]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_FCT_CASE_DETAIL]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_FCT_CASE_DETAIL] SET (LOCK_ESCALATION = TABLE)
GO
