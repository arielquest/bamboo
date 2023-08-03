SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_ETL_QUEUE] (
		[QUEUE_ID]                [uniqueidentifier] NOT NULL ROWGUIDCOL,
		[NAME]                    [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[DESCRIPTION]             [nvarchar](100) COLLATE Latin1_General_CI_AS NULL,
		[VIRTUAL]                 [bit] NOT NULL,
		[PARENT_QUEUE_ID]         [uniqueidentifier] NULL,
		[REPLICATED]              [bit] NOT NULL,
		[MESSAGE_COUNT]           [int] NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [UN_TB_ETL_QUEUE_NAME]
		UNIQUE
		NONCLUSTERED
		([NAME])
		ON [ADMINDEXGROUP],
		CONSTRAINT [PK_TB_ETL_QUEUE]
		PRIMARY KEY
		CLUSTERED
		([QUEUE_ID])
	ON [ADMGROUP]
) ON [ADMGROUP]
GO
ALTER TABLE [dbo].[TB_ETL_QUEUE]
	ADD
	CONSTRAINT [DF_TB_ETL_QUEUE_QUEUE_ID]
	DEFAULT (newid()) FOR [QUEUE_ID]
GO
ALTER TABLE [dbo].[TB_ETL_QUEUE]
	ADD
	CONSTRAINT [DF_TB_ETL_QUEUE_VIRTUAL]
	DEFAULT ((0)) FOR [VIRTUAL]
GO
ALTER TABLE [dbo].[TB_ETL_QUEUE]
	ADD
	CONSTRAINT [DF_TB_ETL_QUEUE_REPLICATED]
	DEFAULT ((0)) FOR [REPLICATED]
GO
ALTER TABLE [dbo].[TB_ETL_QUEUE]
	ADD
	CONSTRAINT [DF_TB_ETL_QUEUE_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_ETL_QUEUE]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_ETL_QUEUE_TB_ETL_QUEUE_PARENT_QUEUE_ID]
	FOREIGN KEY ([PARENT_QUEUE_ID]) REFERENCES [dbo].[TB_ETL_QUEUE] ([QUEUE_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_ETL_QUEUE]
	CHECK CONSTRAINT [FK_TB_ETL_QUEUE_TB_ETL_QUEUE_PARENT_QUEUE_ID]

GO
CREATE NONCLUSTERED INDEX [IX_TB_ETL_QUEUE_PARENT_QUEUE_ID]
	ON [dbo].[TB_ETL_QUEUE] ([PARENT_QUEUE_ID])
	ON [ADMGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table holds information about every ETL queue configured in the system.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ETL_QUEUE', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ETL_QUEUE', 'COLUMN', N'QUEUE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The name of the queue.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ETL_QUEUE', 'COLUMN', N'NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a brief description for the queue.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ETL_QUEUE', 'COLUMN', N'DESCRIPTION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the queue is a virtual queue or not. Default is 0.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ETL_QUEUE', 'COLUMN', N'VIRTUAL'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the QUEUE_ID from the same table indicating the parent queue if any.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ETL_QUEUE', 'COLUMN', N'PARENT_QUEUE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the queue is a replicated queue or not. Default is 0. Only virtual queues should be set as replicated if needed.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ETL_QUEUE', 'COLUMN', N'REPLICATED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the expected steady state message count for the queue - used to provide component weightings for the system.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ETL_QUEUE', 'COLUMN', N'MESSAGE_COUNT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ETL_QUEUE', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_ETL_QUEUE]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_ETL_QUEUE]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_ETL_QUEUE]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_ETL_QUEUE]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_ETL_QUEUE] SET (LOCK_ESCALATION = TABLE)
GO
