SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_IMP_CDR_SESSION] (
		[CDR_SESSION_URN]           [int] IDENTITY(1, 4) NOT FOR REPLICATION NOT NULL,
		[SEQUENCE]                  [int] NOT NULL,
		[SWITCH_CODE]               [int] NOT NULL,
		[SWITCH_TYPE]               [char](4) COLLATE Latin1_General_CI_AS NOT NULL,
		[RECORD_COUNT]              [int] NOT NULL,
		[EXPECTED_RECORD_COUNT]     [int] NOT NULL,
		[CREATED]                   [datetime] NOT NULL,
		[RECEIVED]                  [datetime] NOT NULL,
		[LATEST]                    [datetime] NULL,
		[COMPLETED]                 [datetime] NULL,
		[LOADED]                    [datetime] NULL,
		[STATUS]                    [char](1) COLLATE Latin1_General_CI_AS NOT NULL,
		[msrepl_tran_version]       [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TB_IMP_CDR_SESSION]
		PRIMARY KEY
		CLUSTERED
		([CDR_SESSION_URN])
	WITH FILLFACTOR=80
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TB_IMP_CDR_SESSION]
	WITH NOCHECK
	ADD
	CONSTRAINT [CK_TB_IMP_CDR_SESSION_STATUS]
	CHECK
	NOT FOR REPLICATION
	([STATUS]='R' OR ([STATUS]='C' OR [STATUS]='N'))
GO
ALTER TABLE [dbo].[TB_IMP_CDR_SESSION]
CHECK CONSTRAINT [CK_TB_IMP_CDR_SESSION_STATUS]
GO
ALTER TABLE [dbo].[TB_IMP_CDR_SESSION]
	ADD
	CONSTRAINT [DF_TB_IMP_CDR_SESSION_RECORD_COUNT]
	DEFAULT ((0)) FOR [RECORD_COUNT]
GO
ALTER TABLE [dbo].[TB_IMP_CDR_SESSION]
	ADD
	CONSTRAINT [DF_TB_IMP_CDR_SESSION_RECEIVED]
	DEFAULT (getutcdate()) FOR [RECEIVED]
GO
ALTER TABLE [dbo].[TB_IMP_CDR_SESSION]
	ADD
	CONSTRAINT [DF_TB_IMP_CDR_SESSION_STATUS]
	DEFAULT ('N') FOR [STATUS]
GO
ALTER TABLE [dbo].[TB_IMP_CDR_SESSION]
	ADD
	CONSTRAINT [DF_TB_IMP_CDR_SESSION_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table holds all the IN CDR sessions. Each session is equivalant to a CDR file that is read.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_CDR_SESSION', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_CDR_SESSION', 'COLUMN', N'CDR_SESSION_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the sequence number associated with the CDR file. The sequence, switch code and the switch type together make up a session.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_CDR_SESSION', 'COLUMN', N'SEQUENCE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the switch code associated with the CDR.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_CDR_SESSION', 'COLUMN', N'SWITCH_CODE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the switch type associated with the CDR.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_CDR_SESSION', 'COLUMN', N'SWITCH_TYPE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of CDRs processed in the session.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_CDR_SESSION', 'COLUMN', N'RECORD_COUNT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the total number of CDRs that were supposed to be processed in the session.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_CDR_SESSION', 'COLUMN', N'EXPECTED_RECORD_COUNT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a UTC date time stamp indicating when the session record was created.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_CDR_SESSION', 'COLUMN', N'CREATED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a UTC date time stamp indicating when the session record was recieved.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_CDR_SESSION', 'COLUMN', N'RECEIVED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column is deprecated and will me removed from future versions.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_CDR_SESSION', 'COLUMN', N'LATEST'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a UTC date time stamp indicating when the CDR session was completed. This indicates when the CDR summary data was processed.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_CDR_SESSION', 'COLUMN', N'COMPLETED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column is deprecated and will me removed from future versions.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_CDR_SESSION', 'COLUMN', N'LOADED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a charactor flag indicating the status of the CDR session. Possible values are N: New; C: Completed; R: Rolled Back', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_CDR_SESSION', 'COLUMN', N'STATUS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_IMP_CDR_SESSION', 'COLUMN', N'msrepl_tran_version'
GO
GRANT SELECT
	ON [dbo].[TB_IMP_CDR_SESSION]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_IMP_CDR_SESSION] SET (LOCK_ESCALATION = TABLE)
GO
