SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_SCH_HIERARCHY_CHANGE_ITEM] (
		[HIERARCHY_CHANGE_ITEM_ID]     [uniqueidentifier] NOT NULL,
		[HIERARCHY_CHANGE_ID]          [uniqueidentifier] NOT NULL,
		[REQUEST_TYPE]                 [char](1) COLLATE Latin1_General_CI_AS NOT NULL,
		[REQUEST_DATETIME]             [datetime] NOT NULL,
		[HIERARCHY_NODE_ID]            [uniqueidentifier] NOT NULL,
		[REQUEST_DATA]                 [xml] NOT NULL,
		[msrepl_tran_version]          [uniqueidentifier] NOT NULL,
		CONSTRAINT [UN_TB_SCH_HIERARCHY_CHANGE_ITEM_REQUEST_DATETIME]
		UNIQUE
		NONCLUSTERED
		([HIERARCHY_CHANGE_ID], [REQUEST_DATETIME])
		ON [ADMINDEXGROUP],
		CONSTRAINT [PK_TB_SCH_HIERARCHY_CHANGE_ITEM]
		PRIMARY KEY
		CLUSTERED
		([HIERARCHY_CHANGE_ITEM_ID])
	ON [ADMGROUP]
) ON [ADMGROUP] TEXTIMAGE_ON [ADMGROUP]
GO
ALTER TABLE [dbo].[TB_SCH_HIERARCHY_CHANGE_ITEM]
	WITH NOCHECK
	ADD
	CONSTRAINT [CK_TB_SCH_HIERARCHY_CHANGE_ITEM_REQUEST_TYPE]
	CHECK
	NOT FOR REPLICATION
	([REQUEST_TYPE]='A' OR ([REQUEST_TYPE]='D' OR [REQUEST_TYPE]='M' OR [REQUEST_TYPE]='R' OR [REQUEST_TYPE]='N' OR [REQUEST_TYPE]='C' OR [REQUEST_TYPE]='Z'))
GO
ALTER TABLE [dbo].[TB_SCH_HIERARCHY_CHANGE_ITEM]
CHECK CONSTRAINT [CK_TB_SCH_HIERARCHY_CHANGE_ITEM_REQUEST_TYPE]
GO
ALTER TABLE [dbo].[TB_SCH_HIERARCHY_CHANGE_ITEM]
	ADD
	CONSTRAINT [DF_TB_SCH_HIERARCHY_CHANGE_ITEM_HIERARCHY_CHANGE_ITEM_ID]
	DEFAULT (newid()) FOR [HIERARCHY_CHANGE_ITEM_ID]
GO
ALTER TABLE [dbo].[TB_SCH_HIERARCHY_CHANGE_ITEM]
	ADD
	CONSTRAINT [DF_TB_SCH_HIERARCHY_CHANGE_ITEM_REQUEST_DATETIME]
	DEFAULT (getutcdate()) FOR [REQUEST_DATETIME]
GO
ALTER TABLE [dbo].[TB_SCH_HIERARCHY_CHANGE_ITEM]
	ADD
	CONSTRAINT [DF_TB_SCH_HIERARCHY_CHANGE_ITEM_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_SCH_HIERARCHY_CHANGE_ITEM]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_SCH_HIERARCHY_CHANGE_ITEM_TB_SCH_HIERARCHY_CHANGE]
	FOREIGN KEY ([HIERARCHY_CHANGE_ID]) REFERENCES [dbo].[TB_SCH_HIERARCHY_CHANGE] ([HIERARCHY_CHANGE_ID])
	ON DELETE CASCADE
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_SCH_HIERARCHY_CHANGE_ITEM]
	CHECK CONSTRAINT [FK_TB_SCH_HIERARCHY_CHANGE_ITEM_TB_SCH_HIERARCHY_CHANGE]

GO
EXEC sp_addextendedproperty N'MS_Description', N'This table holds all the individual request for a specific hierarchy change. One hierarchy change is made up of one or more change requests.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SCH_HIERARCHY_CHANGE_ITEM', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SCH_HIERARCHY_CHANGE_ITEM', 'COLUMN', N'HIERARCHY_CHANGE_ITEM_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key referencing the HIERARCHY_CHANGE_ID in TB_SCH_HIERARCHY_CHANGE. This indicates the hierarchy change associated with the request.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SCH_HIERARCHY_CHANGE_ITEM', 'COLUMN', N'HIERARCHY_CHANGE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a charactor flag indicating the type of hierarchy change request. Possible values are: A: Associate Item, D: Disassociate Item, M: Move Node, R: Delete Node, N: New Node, C: Change Node, Z: Revert change.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SCH_HIERARCHY_CHANGE_ITEM', 'COLUMN', N'REQUEST_TYPE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a datetime value indicating when the request was created. This field is used to order the execution of the individual requests for a hierarchy change.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SCH_HIERARCHY_CHANGE_ITEM', 'COLUMN', N'REQUEST_DATETIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This value coresponds to the NODE_ID in TB_DIM_HIERARCHY_NODE indicating the hierarchy node associated with the current request.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SCH_HIERARCHY_CHANGE_ITEM', 'COLUMN', N'HIERARCHY_NODE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the data specific to the request type. This information is stored as XML.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SCH_HIERARCHY_CHANGE_ITEM', 'COLUMN', N'REQUEST_DATA'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SCH_HIERARCHY_CHANGE_ITEM', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_SCH_HIERARCHY_CHANGE_ITEM]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_SCH_HIERARCHY_CHANGE_ITEM]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_SCH_HIERARCHY_CHANGE_ITEM]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_SCH_HIERARCHY_CHANGE_ITEM]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_SCH_HIERARCHY_CHANGE_ITEM] SET (LOCK_ESCALATION = TABLE)
GO
