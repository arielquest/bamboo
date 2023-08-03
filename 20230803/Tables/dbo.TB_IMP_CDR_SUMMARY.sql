SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_IMP_CDR_SUMMARY] (
		[CDR_SUMMARY_URN]         [int] IDENTITY(1, 4) NOT FOR REPLICATION NOT NULL,
		[CDR_SESSION_URN]         [int] NOT NULL,
		[TYPE]                    [char](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[SEQUENCE]                [int] NOT NULL,
		[RECORD_COUNT]            [int] NOT NULL,
		[FILENAME]                [nvarchar](255) COLLATE Latin1_General_CI_AS NOT NULL,
		[CREATED]                 [datetime] NOT NULL,
		[COMPLETED]               [datetime] NULL,
		[LOADED]                  [datetime] NULL,
		[STATUS]                  [char](1) COLLATE Latin1_General_CI_AS NOT NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TB_IMP_CDR_SUMMARY]
		PRIMARY KEY
		CLUSTERED
		([CDR_SUMMARY_URN])
	WITH FILLFACTOR=80
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TB_IMP_CDR_SUMMARY]
	ADD
	CONSTRAINT [CK_TB_IMP_CDR_SUMMARY_STATUS]
	CHECK
	([STATUS]='Z' OR ([STATUS]='E' OR ([STATUS]='L' OR ([STATUS]='C' OR [STATUS]='N'))))
GO
ALTER TABLE [dbo].[TB_IMP_CDR_SUMMARY]
CHECK CONSTRAINT [CK_TB_IMP_CDR_SUMMARY_STATUS]
GO
ALTER TABLE [dbo].[TB_IMP_CDR_SUMMARY]
	ADD
	CONSTRAINT [DF_TB_IMP_CDR_SUMMARY_CREATED]
	DEFAULT (getutcdate()) FOR [CREATED]
GO
ALTER TABLE [dbo].[TB_IMP_CDR_SUMMARY]
	ADD
	CONSTRAINT [DF_TB_IMP_CDR_SUMMARY_STATUS]
	DEFAULT ('N') FOR [STATUS]
GO
ALTER TABLE [dbo].[TB_IMP_CDR_SUMMARY]
	ADD
	CONSTRAINT [DF_TB_IMP_CDR_SUMMARY_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_IMP_CDR_SUMMARY]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_IMP_CDR_SUMMARY_TB_IMP_CDR_SESSION]
	FOREIGN KEY ([CDR_SESSION_URN]) REFERENCES [dbo].[TB_IMP_CDR_SESSION] ([CDR_SESSION_URN])
	ON DELETE CASCADE
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_IMP_CDR_SUMMARY]
	CHECK CONSTRAINT [FK_TB_IMP_CDR_SUMMARY_TB_IMP_CDR_SESSION]

GO
CREATE NONCLUSTERED INDEX [IX_TB_IMP_CDR_SUMMARY_CDR_SESSION_URN]
	ON [dbo].[TB_IMP_CDR_SUMMARY] ([CDR_SESSION_URN])
	ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table is deprecated and will be removed in future versions. This table was initially used by the IN importer to record the various summary data files that have been imported into the IN summary tables.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_CDR_SUMMARY', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the recoord.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_CDR_SUMMARY', 'COLUMN', N'CDR_SUMMARY_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_IMP_CDR_SESSION corresponding to the CDR import session associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_CDR_SUMMARY', 'COLUMN', N'CDR_SESSION_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is string indicating the type of the summary data imported.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_CDR_SUMMARY', 'COLUMN', N'TYPE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the sequence number associated with the summary file.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_CDR_SUMMARY', 'COLUMN', N'SEQUENCE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of summary records imported from the file.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_CDR_SUMMARY', 'COLUMN', N'RECORD_COUNT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the path of the summary file relative to the IN importer.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_CDR_SUMMARY', 'COLUMN', N'FILENAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a UTC data time stamp indicating when record was created.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_CDR_SUMMARY', 'COLUMN', N'CREATED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a UTC data time stamp indicating when the import of the IN summary data file was completed.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_CDR_SUMMARY', 'COLUMN', N'COMPLETED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a UTC data time stamp indicating when the IN summary data file was loaded for import.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_CDR_SUMMARY', 'COLUMN', N'LOADED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a charactor flag indicating the status of the CDR summary file. Possible values are N: New; C: Completed; L: Loaded; E: Error; Z: Finalized', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_CDR_SUMMARY', 'COLUMN', N'STATUS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_CDR_SUMMARY', 'COLUMN', N'msrepl_tran_version'
GO
GRANT SELECT
	ON [dbo].[TB_IMP_CDR_SUMMARY]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_IMP_CDR_SUMMARY] SET (LOCK_ESCALATION = TABLE)
GO
