SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_SCH_HIERARCHY_CHANGE_FACT_UPDATE_PROGRESS] (
		[HIERARCHY_CHANGE_FACT_UPDATE_PROGRESS_ID]     [uniqueidentifier] NOT NULL,
		[HIERARCHY_CHANGE_FACT_UPDATE_RESULT_ID]       [uniqueidentifier] NOT NULL,
		[FACT_PARTITION_ID]                            [uniqueidentifier] NOT NULL,
		[EXECUTION_UTC_DATE_TIME]                      [datetime] NOT NULL,
		[FACT_UPDATE_STATUS]                           [char](1) COLLATE Latin1_General_CI_AS NOT NULL,
		[ROW_COUNT]                                    [bigint] NULL,
		[EXCEPTION_MESSAGE]                            [nvarchar](500) COLLATE Latin1_General_CI_AS NULL,
		[msrepl_tran_version]                          [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TB_SCH_HIERARCHY_CHANGE_FACT_UPDATE_PROGRESS]
		PRIMARY KEY
		CLUSTERED
		([HIERARCHY_CHANGE_FACT_UPDATE_PROGRESS_ID])
	ON [ADMGROUP]
) ON [ADMGROUP]
GO
ALTER TABLE [dbo].[TB_SCH_HIERARCHY_CHANGE_FACT_UPDATE_PROGRESS]
	ADD
	CONSTRAINT [CK_TB_SCH_HIERARCHY_CHANGE_FACT_UPDATE_PROGRESS_FACT_UPDATE_STATUS]
	CHECK
	([FACT_UPDATE_STATUS]='P' OR [FACT_UPDATE_STATUS]='E' OR [FACT_UPDATE_STATUS]='C')
GO
ALTER TABLE [dbo].[TB_SCH_HIERARCHY_CHANGE_FACT_UPDATE_PROGRESS]
CHECK CONSTRAINT [CK_TB_SCH_HIERARCHY_CHANGE_FACT_UPDATE_PROGRESS_FACT_UPDATE_STATUS]
GO
ALTER TABLE [dbo].[TB_SCH_HIERARCHY_CHANGE_FACT_UPDATE_PROGRESS]
	ADD
	CONSTRAINT [DF_TB_SCH_HIERARCHY_CHANGE_FACT_UPDATE_PROGRESS_PROGRESS_ID]
	DEFAULT (newid()) FOR [HIERARCHY_CHANGE_FACT_UPDATE_PROGRESS_ID]
GO
ALTER TABLE [dbo].[TB_SCH_HIERARCHY_CHANGE_FACT_UPDATE_PROGRESS]
	ADD
	CONSTRAINT [DF_TB_SCH_HIERARCHY_CHANGE_FACT_UPDATE_PROGRESS_FACT_UPDATE_STATUS]
	DEFAULT ('P') FOR [FACT_UPDATE_STATUS]
GO
ALTER TABLE [dbo].[TB_SCH_HIERARCHY_CHANGE_FACT_UPDATE_PROGRESS]
	ADD
	CONSTRAINT [DF_TB_SCH_HIERARCHY_CHANGE_FACT_UPDATE_PROGRESS_EXECUTION_UTC_DATE_TIME]
	DEFAULT (getutcdate()) FOR [EXECUTION_UTC_DATE_TIME]
GO
ALTER TABLE [dbo].[TB_SCH_HIERARCHY_CHANGE_FACT_UPDATE_PROGRESS]
	ADD
	CONSTRAINT [DF_TB_SCH_HIERARCHY_CHANGE_FACT_UPDATE_PROGRESS_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_SCH_HIERARCHY_CHANGE_FACT_UPDATE_PROGRESS]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_SCH_HIERARCHY_CHANGE_FACT_UPDATE_PROGRESS_TB_SCH_HIERARCHY_CHANGE_FACT_UPDATE_RESULT]
	FOREIGN KEY ([HIERARCHY_CHANGE_FACT_UPDATE_RESULT_ID]) REFERENCES [dbo].[TB_SCH_HIERARCHY_CHANGE_FACT_UPDATE_RESULT] ([HIERARCHY_CHANGE_FACT_UPDATE_RESULT_ID])
	ON DELETE CASCADE
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_SCH_HIERARCHY_CHANGE_FACT_UPDATE_PROGRESS]
	CHECK CONSTRAINT [FK_TB_SCH_HIERARCHY_CHANGE_FACT_UPDATE_PROGRESS_TB_SCH_HIERARCHY_CHANGE_FACT_UPDATE_RESULT]

GO
CREATE NONCLUSTERED INDEX [IX_TB_SCH_HIERARCHY_CHANGE_FACT_UPDATE_PROGRESS_HIERARCHY_CHANGE_FACT_UPDATE_RESULT_ID]
	ON [dbo].[TB_SCH_HIERARCHY_CHANGE_FACT_UPDATE_PROGRESS] ([HIERARCHY_CHANGE_FACT_UPDATE_RESULT_ID])
	INCLUDE ([FACT_UPDATE_STATUS], [FACT_PARTITION_ID])
	ON [ADMINDEXGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table holds information about the fact data update progress as a result of a historical dimension hierarchy change (Type 2 changes). The progress information is inserted, updated or delete by the OLAP processor during its historical fact update cycle.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SCH_HIERARCHY_CHANGE_FACT_UPDATE_PROGRESS', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SCH_HIERARCHY_CHANGE_FACT_UPDATE_PROGRESS', 'COLUMN', N'HIERARCHY_CHANGE_FACT_UPDATE_PROGRESS_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the ID as in the table dbo.TB_SCH_HIERARCHY_CHANGE_FACT_UPDATE_RESULT indicating the hierarchy change result that requires the update of historical fact data.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SCH_HIERARCHY_CHANGE_FACT_UPDATE_PROGRESS', 'COLUMN', N'HIERARCHY_CHANGE_FACT_UPDATE_RESULT_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the ID as in the table dbo.TB_IMP_FACT_PARTITION indicating the histical partition table being updated.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SCH_HIERARCHY_CHANGE_FACT_UPDATE_PROGRESS', 'COLUMN', N'FACT_PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the UTC date time when the updates were executed.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SCH_HIERARCHY_CHANGE_FACT_UPDATE_PROGRESS', 'COLUMN', N'EXECUTION_UTC_DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This a charactor flag indicating the status of the update. This can have the following possible values C-Complete, E-Error, P-Pending', 'SCHEMA', N'dbo', 'TABLE', N'TB_SCH_HIERARCHY_CHANGE_FACT_UPDATE_PROGRESS', 'COLUMN', N'FACT_UPDATE_STATUS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the count of rows that were updated.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SCH_HIERARCHY_CHANGE_FACT_UPDATE_PROGRESS', 'COLUMN', N'ROW_COUNT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a string representing an error message for the error encountered (if any) during update of the fact data.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SCH_HIERARCHY_CHANGE_FACT_UPDATE_PROGRESS', 'COLUMN', N'EXCEPTION_MESSAGE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SCH_HIERARCHY_CHANGE_FACT_UPDATE_PROGRESS', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_SCH_HIERARCHY_CHANGE_FACT_UPDATE_PROGRESS]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_SCH_HIERARCHY_CHANGE_FACT_UPDATE_PROGRESS]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_SCH_HIERARCHY_CHANGE_FACT_UPDATE_PROGRESS]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_SCH_HIERARCHY_CHANGE_FACT_UPDATE_PROGRESS]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_SCH_HIERARCHY_CHANGE_FACT_UPDATE_PROGRESS] SET (LOCK_ESCALATION = TABLE)
GO