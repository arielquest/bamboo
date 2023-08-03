SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_ETL_COMPONENT_QUEUE_MEMBER] (
		[COMPONENT_QUEUE_MEMBER_ID]     [uniqueidentifier] NOT NULL ROWGUIDCOL,
		[COMPONENT_ID]                  [uniqueidentifier] NOT NULL,
		[QUEUE_ID]                      [uniqueidentifier] NOT NULL,
		[MEMBER_TYPE]                   [char](1) COLLATE Latin1_General_CI_AS NOT NULL,
		[msrepl_tran_version]           [uniqueidentifier] NOT NULL,
		CONSTRAINT [UN_TB_ETL_COMPONENT_QUEUE_MEMBER_COMPONENT_ID_QUEUE_ID]
		UNIQUE
		NONCLUSTERED
		([COMPONENT_ID], [QUEUE_ID])
		ON [ADMINDEXGROUP],
		CONSTRAINT [PK_TB_ETL_COMPONENT_QUEUE_MEMBER]
		PRIMARY KEY
		CLUSTERED
		([COMPONENT_QUEUE_MEMBER_ID])
	ON [ADMINDEXGROUP]
) ON [ADMINDEXGROUP]
GO
ALTER TABLE [dbo].[TB_ETL_COMPONENT_QUEUE_MEMBER]
	WITH NOCHECK
	ADD
	CONSTRAINT [CK_TB_ETL_COMPONENT_QUEUE_MEMBER_MEMBER_TYPE]
	CHECK
	NOT FOR REPLICATION
	([MEMBER_TYPE]='O' OR [MEMBER_TYPE]='I')
GO
ALTER TABLE [dbo].[TB_ETL_COMPONENT_QUEUE_MEMBER]
CHECK CONSTRAINT [CK_TB_ETL_COMPONENT_QUEUE_MEMBER_MEMBER_TYPE]
GO
ALTER TABLE [dbo].[TB_ETL_COMPONENT_QUEUE_MEMBER]
	ADD
	CONSTRAINT [DF_TB_ETL_COMPONENT_QUEUE_MEMBER_COMPONENT_QUEUE_MEMBER_ID]
	DEFAULT (newid()) FOR [COMPONENT_QUEUE_MEMBER_ID]
GO
ALTER TABLE [dbo].[TB_ETL_COMPONENT_QUEUE_MEMBER]
	ADD
	CONSTRAINT [DF_TB_ETL_COMPONENT_QUEUE_MEMBER_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_ETL_COMPONENT_QUEUE_MEMBER]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_ETL_COMPONENT_QUEUE_MEMBER_TB_ETL_COMPONENT]
	FOREIGN KEY ([COMPONENT_ID]) REFERENCES [dbo].[TB_ETL_COMPONENT] ([COMPONENT_ID])
	ON DELETE CASCADE
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_ETL_COMPONENT_QUEUE_MEMBER]
	CHECK CONSTRAINT [FK_TB_ETL_COMPONENT_QUEUE_MEMBER_TB_ETL_COMPONENT]

GO
ALTER TABLE [dbo].[TB_ETL_COMPONENT_QUEUE_MEMBER]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_ETL_COMPONENT_QUEUE_MEMBER_TB_ETL_QUEUE]
	FOREIGN KEY ([QUEUE_ID]) REFERENCES [dbo].[TB_ETL_QUEUE] ([QUEUE_ID])
	ON DELETE CASCADE
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_ETL_COMPONENT_QUEUE_MEMBER]
	CHECK CONSTRAINT [FK_TB_ETL_COMPONENT_QUEUE_MEMBER_TB_ETL_QUEUE]

GO
CREATE NONCLUSTERED INDEX [IX_TB_ETL_COMPONENT_QUEUE_MEMBER_QUEUE_ID]
	ON [dbo].[TB_ETL_COMPONENT_QUEUE_MEMBER] ([QUEUE_ID])
	ON [ADMINDEXGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table stores the links between the ETL components and the ETL queues.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ETL_COMPONENT_QUEUE_MEMBER', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ETL_COMPONENT_QUEUE_MEMBER', 'COLUMN', N'COMPONENT_QUEUE_MEMBER_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the ID as in TB_ETL_COMPONENT indicating the ETL component.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ETL_COMPONENT_QUEUE_MEMBER', 'COLUMN', N'COMPONENT_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the ID as in TB_ETL_QUEUE indicating the ETL Queue.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ETL_COMPONENT_QUEUE_MEMBER', 'COLUMN', N'QUEUE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a charactor flag indicating the type of the membership between the ETL component and the queue. Possible values are: I = Input Queue, O = Output Queue', 'SCHEMA', N'dbo', 'TABLE', N'TB_ETL_COMPONENT_QUEUE_MEMBER', 'COLUMN', N'MEMBER_TYPE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ETL_COMPONENT_QUEUE_MEMBER', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_ETL_COMPONENT_QUEUE_MEMBER]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_ETL_COMPONENT_QUEUE_MEMBER]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_ETL_COMPONENT_QUEUE_MEMBER]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_ETL_COMPONENT_QUEUE_MEMBER]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_ETL_COMPONENT_QUEUE_MEMBER] SET (LOCK_ESCALATION = TABLE)
GO
