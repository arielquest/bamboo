SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TB_RT_CASE_AGE] (
		[CASE_AGE_URN]             [bigint] IDENTITY(1, 2) NOT FOR REPLICATION NOT NULL,
		[CLUSTER_RESOURCE_URN]     [int] NOT NULL,
		[TENANT_URN]               [int] NOT NULL,
		[OPEN_CASES]               [bigint] NOT NULL,
		[TOTAL_AGE]                [bigint] NOT NULL,
		[AVERAGE_AGE]              [bigint] NOT NULL,
		[MAX_AGE]                  [bigint] NOT NULL,
		[HRS_0_4]                  [bigint] NOT NULL,
		[HRS_4_8]                  [bigint] NOT NULL,
		[HRS_8_12]                 [bigint] NOT NULL,
		[HRS_12_16]                [bigint] NOT NULL,
		[HRS_16_20]                [bigint] NOT NULL,
		[HRS_20_24]                [bigint] NOT NULL,
		[HRS_24_32]                [bigint] NOT NULL,
		[HRS_32_40]                [bigint] NOT NULL,
		[HRS_40_48]                [bigint] NOT NULL,
		[HRS_24_36]                [bigint] NOT NULL,
		[HRS_36_48]                [bigint] NOT NULL,
		[HRS_48_60]                [bigint] NOT NULL,
		[HRS_60_72]                [bigint] NOT NULL,
		[DAY_3_4]                  [bigint] NOT NULL,
		[DAY_4_5]                  [bigint] NOT NULL,
		[DAY_5_6]                  [bigint] NOT NULL,
		[DAY_6_7]                  [bigint] NOT NULL,
		[WEEK_1_2]                 [bigint] NOT NULL,
		[WEEK_2_3]                 [bigint] NOT NULL,
		[WEEK_3_4]                 [bigint] NOT NULL,
		[SNAPSHOT_DATE]            [datetime] NOT NULL,
		[SUMMARIZATION_DATE]       [datetime] NOT NULL,
		[TOTAL_AGE_BIZCAL]         [bigint] NOT NULL,
		[AVERAGE_AGE_BIZCAL]       [bigint] NOT NULL,
		[MAX_AGE_BIZCAL]           [bigint] NOT NULL,
		[HRS_0_4_BIZCAL]           [bigint] NOT NULL,
		[HRS_4_8_BIZCAL]           [bigint] NOT NULL,
		[HRS_8_12_BIZCAL]          [bigint] NOT NULL,
		[HRS_12_16_BIZCAL]         [bigint] NOT NULL,
		[HRS_16_20_BIZCAL]         [bigint] NOT NULL,
		[HRS_20_24_BIZCAL]         [bigint] NOT NULL,
		[HRS_24_32_BIZCAL]         [bigint] NOT NULL,
		[HRS_32_40_BIZCAL]         [bigint] NOT NULL,
		[HRS_40_48_BIZCAL]         [bigint] NOT NULL,
		[HRS_24_36_BIZCAL]         [bigint] NOT NULL,
		[HRS_36_48_BIZCAL]         [bigint] NOT NULL,
		[HRS_48_60_BIZCAL]         [bigint] NOT NULL,
		[HRS_60_72_BIZCAL]         [bigint] NOT NULL,
		[DAY_3_4_BIZCAL]           [bigint] NOT NULL,
		[DAY_4_5_BIZCAL]           [bigint] NOT NULL,
		[DAY_5_6_BIZCAL]           [bigint] NOT NULL,
		[DAY_6_7_BIZCAL]           [bigint] NOT NULL,
		[WEEK_1_2_BIZCAL]          [bigint] NOT NULL,
		[WEEK_2_3_BIZCAL]          [bigint] NOT NULL,
		[WEEK_3_4_BIZCAL]          [bigint] NOT NULL,
		[DAY_0_1_BIZCAL]           [bigint] NOT NULL,
		[DAY_1_2_BIZCAL]           [bigint] NOT NULL,
		[DAY_2_3_BIZCAL]           [bigint] NOT NULL,
		[WEEK_0_1_BIZCAL]          [bigint] NOT NULL,
		[msrepl_tran_version]      [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TB_RT_CASE_AGE]
		PRIMARY KEY
		CLUSTERED
		([CLUSTER_RESOURCE_URN], [CASE_AGE_URN])
	ON [FCTEGNGROUP]
) ON [FCTEGNGROUP]
GO
ALTER TABLE [dbo].[TB_RT_CASE_AGE]
	ADD
	CONSTRAINT [DF_TB_RT_CASE_AGE_SUMMARIZATION_DATE]
	DEFAULT (getutcdate()) FOR [SUMMARIZATION_DATE]
GO
ALTER TABLE [dbo].[TB_RT_CASE_AGE]
	ADD
	CONSTRAINT [DF_TB_RT_CASE_AGE_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
CREATE NONCLUSTERED INDEX [IX_TB_RT_CASE_AGE_TENANT_URN]
	ON [dbo].[TB_RT_CASE_AGE] ([TENANT_URN])
	ON [FCTEGNGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table contains information allowing for case monitoring', 'SCHEMA', N'dbo', 'TABLE', N'TB_RT_CASE_AGE', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_RT_CASE_AGE', 'COLUMN', N'CASE_AGE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from the table dbo.TB_CLU_RESOURCE indicating the source of the data.', 'SCHEMA', N'dbo', 'TABLE', N'TB_RT_CASE_AGE', 'COLUMN', N'CLUSTER_RESOURCE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key to TB_DIM_TENANT.ITEM_URN and refers to the eGain department.', 'SCHEMA', N'dbo', 'TABLE', N'TB_RT_CASE_AGE', 'COLUMN', N'TENANT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total count of open cases since the cut-off.', 'SCHEMA', N'dbo', 'TABLE', N'TB_RT_CASE_AGE', 'COLUMN', N'OPEN_CASES'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total duration of all open cases since the cut-off.', 'SCHEMA', N'dbo', 'TABLE', N'TB_RT_CASE_AGE', 'COLUMN', N'TOTAL_AGE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the average duration of all open cases since the cut-off.', 'SCHEMA', N'dbo', 'TABLE', N'TB_RT_CASE_AGE', 'COLUMN', N'AVERAGE_AGE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the duration of the oldest among all open cases since the cut-off.', 'SCHEMA', N'dbo', 'TABLE', N'TB_RT_CASE_AGE', 'COLUMN', N'MAX_AGE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number of cases that have been open between 0 and 4 hours.', 'SCHEMA', N'dbo', 'TABLE', N'TB_RT_CASE_AGE', 'COLUMN', N'HRS_0_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number of cases that have been open between 4 and 8 hours.', 'SCHEMA', N'dbo', 'TABLE', N'TB_RT_CASE_AGE', 'COLUMN', N'HRS_4_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number of cases that have been open between 8 and 12 hours.', 'SCHEMA', N'dbo', 'TABLE', N'TB_RT_CASE_AGE', 'COLUMN', N'HRS_8_12'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number of cases that have been open between 12 and 16 hours.', 'SCHEMA', N'dbo', 'TABLE', N'TB_RT_CASE_AGE', 'COLUMN', N'HRS_12_16'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number of cases that have been open between 16 and 20 hours.', 'SCHEMA', N'dbo', 'TABLE', N'TB_RT_CASE_AGE', 'COLUMN', N'HRS_16_20'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number of cases that have been open between 20 and 24 hours.', 'SCHEMA', N'dbo', 'TABLE', N'TB_RT_CASE_AGE', 'COLUMN', N'HRS_20_24'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number of cases that have been open between 24 and 32 hours.', 'SCHEMA', N'dbo', 'TABLE', N'TB_RT_CASE_AGE', 'COLUMN', N'HRS_24_32'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number of cases that have been open between 32 and 40 hours.', 'SCHEMA', N'dbo', 'TABLE', N'TB_RT_CASE_AGE', 'COLUMN', N'HRS_32_40'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number of cases that have been open between 40 and 48 hours.', 'SCHEMA', N'dbo', 'TABLE', N'TB_RT_CASE_AGE', 'COLUMN', N'HRS_40_48'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number of cases that have been open between 24 and 36 hours.', 'SCHEMA', N'dbo', 'TABLE', N'TB_RT_CASE_AGE', 'COLUMN', N'HRS_24_36'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number of cases that have been open between 36 and 48 hours.', 'SCHEMA', N'dbo', 'TABLE', N'TB_RT_CASE_AGE', 'COLUMN', N'HRS_36_48'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number of cases that have been open between 48 and 60 hours.', 'SCHEMA', N'dbo', 'TABLE', N'TB_RT_CASE_AGE', 'COLUMN', N'HRS_48_60'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number of cases that have been open between 60 and 72 hours.', 'SCHEMA', N'dbo', 'TABLE', N'TB_RT_CASE_AGE', 'COLUMN', N'HRS_60_72'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number of cases that have been open between 3 and 4 days.', 'SCHEMA', N'dbo', 'TABLE', N'TB_RT_CASE_AGE', 'COLUMN', N'DAY_3_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number of cases that have been open between 4 and 5 days.', 'SCHEMA', N'dbo', 'TABLE', N'TB_RT_CASE_AGE', 'COLUMN', N'DAY_4_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number of cases that have been open between 5 and 6 days.', 'SCHEMA', N'dbo', 'TABLE', N'TB_RT_CASE_AGE', 'COLUMN', N'DAY_5_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number of cases that have been open between 6 and 7 days.', 'SCHEMA', N'dbo', 'TABLE', N'TB_RT_CASE_AGE', 'COLUMN', N'DAY_6_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number of cases that have been open between 1 and 2 weeks.', 'SCHEMA', N'dbo', 'TABLE', N'TB_RT_CASE_AGE', 'COLUMN', N'WEEK_1_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number of cases that have been open between 2 and 3 weeks.', 'SCHEMA', N'dbo', 'TABLE', N'TB_RT_CASE_AGE', 'COLUMN', N'WEEK_2_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number of cases that have been open between 3 and 4 weeks.', 'SCHEMA', N'dbo', 'TABLE', N'TB_RT_CASE_AGE', 'COLUMN', N'WEEK_3_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the DateTimeStamp in UTC of the last event processed in the most recent summarization cycle ran against the cluster resource. The case age is calculated considering this date as current date-time.', 'SCHEMA', N'dbo', 'TABLE', N'TB_RT_CASE_AGE', 'COLUMN', N'SNAPSHOT_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the DateTimeStamp in UTC when the fact data is summarized.', 'SCHEMA', N'dbo', 'TABLE', N'TB_RT_CASE_AGE', 'COLUMN', N'SUMMARIZATION_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_RT_CASE_AGE', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_RT_CASE_AGE]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_RT_CASE_AGE]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_RT_CASE_AGE]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_RT_CASE_AGE]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_RT_CASE_AGE]
	TO [portalrs_role]
GO
ALTER TABLE [dbo].[TB_RT_CASE_AGE] SET (LOCK_ESCALATION = TABLE)
GO
