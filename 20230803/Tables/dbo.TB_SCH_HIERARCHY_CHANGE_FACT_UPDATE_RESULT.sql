SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_SCH_HIERARCHY_CHANGE_FACT_UPDATE_RESULT] (
		[HIERARCHY_CHANGE_FACT_UPDATE_RESULT_ID]     [uniqueidentifier] NOT NULL,
		[HIERARCHY_CHANGE_RESULT_ID]                 [uniqueidentifier] NOT NULL,
		[RESOURCE_INSTANCE_ID]                       [uniqueidentifier] NOT NULL,
		[FACT_UPDATE_STATUS]                         [char](1) COLLATE Latin1_General_CI_AS NOT NULL,
		[msrepl_tran_version]                        [uniqueidentifier] NOT NULL,
		CONSTRAINT [UN_TB_SCH_HIERARCHY_CHANGE_FACT_UPDATE_RESULT]
		UNIQUE
		NONCLUSTERED
		([HIERARCHY_CHANGE_RESULT_ID], [RESOURCE_INSTANCE_ID])
		ON [ADMINDEXGROUP],
		CONSTRAINT [PK_TB_SCH_HIERARCHY_CHANGE_FACT_UPDATE_RESULT]
		PRIMARY KEY
		CLUSTERED
		([HIERARCHY_CHANGE_FACT_UPDATE_RESULT_ID])
	ON [ADMGROUP]
) ON [ADMGROUP]
GO
ALTER TABLE [dbo].[TB_SCH_HIERARCHY_CHANGE_FACT_UPDATE_RESULT]
	WITH NOCHECK
	ADD
	CONSTRAINT [CK_TB_SCH_HIERARCHY_CHANGE_FACT_UPDATE_RESULT_FACT_UPDATE_STATUS]
	CHECK
	NOT FOR REPLICATION
	([FACT_UPDATE_STATUS]='P' OR [FACT_UPDATE_STATUS]='H' OR [FACT_UPDATE_STATUS]='C')
GO
ALTER TABLE [dbo].[TB_SCH_HIERARCHY_CHANGE_FACT_UPDATE_RESULT]
CHECK CONSTRAINT [CK_TB_SCH_HIERARCHY_CHANGE_FACT_UPDATE_RESULT_FACT_UPDATE_STATUS]
GO
ALTER TABLE [dbo].[TB_SCH_HIERARCHY_CHANGE_FACT_UPDATE_RESULT]
	ADD
	CONSTRAINT [DF_TB_SCH_HIERARCHY_CHANGE_FACT_UPDATE_RESULT_HIERARCHY_CHANGE_FACT_UPDATE_RESULT_ID]
	DEFAULT (newid()) FOR [HIERARCHY_CHANGE_FACT_UPDATE_RESULT_ID]
GO
ALTER TABLE [dbo].[TB_SCH_HIERARCHY_CHANGE_FACT_UPDATE_RESULT]
	ADD
	CONSTRAINT [DF_TB_SCH_HIERARCHY_CHANGE_FACT_UPDATE_RESULT_FACT_UPDATE_STATUS]
	DEFAULT ('P') FOR [FACT_UPDATE_STATUS]
GO
ALTER TABLE [dbo].[TB_SCH_HIERARCHY_CHANGE_FACT_UPDATE_RESULT]
	ADD
	CONSTRAINT [DF_TB_SCH_HIERARCHY_CHANGE_FACT_UPDATE_RESULT_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_SCH_HIERARCHY_CHANGE_FACT_UPDATE_RESULT]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_SCH_HIERARCHY_CHANGE_FACT_UPDATE_RESULT_TB_SCH_HIERARCHY_CHANGE_RESULT]
	FOREIGN KEY ([HIERARCHY_CHANGE_RESULT_ID]) REFERENCES [dbo].[TB_SCH_HIERARCHY_CHANGE_RESULT] ([HIERARCHY_CHANGE_RESULT_ID])
	ON DELETE CASCADE
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_SCH_HIERARCHY_CHANGE_FACT_UPDATE_RESULT]
	CHECK CONSTRAINT [FK_TB_SCH_HIERARCHY_CHANGE_FACT_UPDATE_RESULT_TB_SCH_HIERARCHY_CHANGE_RESULT]

GO
ALTER TABLE [dbo].[TB_SCH_HIERARCHY_CHANGE_FACT_UPDATE_RESULT]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_SCH_HIERARCHY_CHANGE_FACT_UPDATE_RESULT_TB_CLU_RESOURCE_INSTANCE]
	FOREIGN KEY ([RESOURCE_INSTANCE_ID]) REFERENCES [dbo].[TB_CLU_RESOURCE_INSTANCE] ([RESOURCE_INSTANCE_ID])
	ON DELETE CASCADE
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_SCH_HIERARCHY_CHANGE_FACT_UPDATE_RESULT]
	CHECK CONSTRAINT [FK_TB_SCH_HIERARCHY_CHANGE_FACT_UPDATE_RESULT_TB_CLU_RESOURCE_INSTANCE]

GO
CREATE NONCLUSTERED INDEX [IX_TB_SCH_HIERARCHY_CHANGE_FACT_UPDATE_RESULT_RESOURCE_INSTANCE_ID]
	ON [dbo].[TB_SCH_HIERARCHY_CHANGE_FACT_UPDATE_RESULT] ([RESOURCE_INSTANCE_ID])
	ON [ADMGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table stores the information about the successful dimension updates on fact and summary data done for the results of past hierarchy changes.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SCH_HIERARCHY_CHANGE_FACT_UPDATE_RESULT', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SCH_HIERARCHY_CHANGE_FACT_UPDATE_RESULT', 'COLUMN', N'HIERARCHY_CHANGE_FACT_UPDATE_RESULT_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key referencing HIERARCHY_CHANGE_RESULT_ID in TB_SCH_HIERARCHY_CHANGE_RESULT. This indicates the specific hierarchy change result for which the historical data updates have been or pending to be executed.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SCH_HIERARCHY_CHANGE_FACT_UPDATE_RESULT', 'COLUMN', N'HIERARCHY_CHANGE_RESULT_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key referencing RESOURCE_INSTANCE_ID in TB_CLU_RESOURCE_INSTANCE. This indicates the primary or the secondary database instance where the historical data updates have been or pending to be executed.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SCH_HIERARCHY_CHANGE_FACT_UPDATE_RESULT', 'COLUMN', N'RESOURCE_INSTANCE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Charactor flag indicating the historical data update status. Possible values are P: Pending, C: Complete', 'SCHEMA', N'dbo', 'TABLE', N'TB_SCH_HIERARCHY_CHANGE_FACT_UPDATE_RESULT', 'COLUMN', N'FACT_UPDATE_STATUS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SCH_HIERARCHY_CHANGE_FACT_UPDATE_RESULT', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_SCH_HIERARCHY_CHANGE_FACT_UPDATE_RESULT]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_SCH_HIERARCHY_CHANGE_FACT_UPDATE_RESULT]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_SCH_HIERARCHY_CHANGE_FACT_UPDATE_RESULT]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_SCH_HIERARCHY_CHANGE_FACT_UPDATE_RESULT]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_SCH_HIERARCHY_CHANGE_FACT_UPDATE_RESULT] SET (LOCK_ESCALATION = TABLE)
GO
