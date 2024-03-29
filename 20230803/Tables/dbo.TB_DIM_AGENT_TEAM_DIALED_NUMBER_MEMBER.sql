SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TB_DIM_AGENT_TEAM_DIALED_NUMBER_MEMBER] (
		[MEMBER_URN]              [int] IDENTITY(1, 4) NOT FOR REPLICATION NOT NULL,
		[MEMBER_BIZ_URN]          [int] NOT NULL,
		[PARENT_ITEM_BIZ_URN]     [int] NOT NULL,
		[CHILD_ITEM_BIZ_URN]      [int] NOT NULL,
		[EFFECTIVE_FROM]          [datetime] NOT NULL,
		[EFFECTIVE_TO]            [datetime] NOT NULL,
		[DELETED]                 [bit] NOT NULL,
		[HIDDEN]                  [bit] NOT NULL,
		[SYSTEM]                  [bit] NOT NULL,
		[LATEST]                  [bit] NOT NULL,
		[CREATED_BY_ID]           [uniqueidentifier] NOT NULL,
		[MODIFIED_BY_ID]          [uniqueidentifier] NOT NULL,
		[CREATION_DATE]           [datetime] NOT NULL,
		[MODIFIED_DATE]           [datetime] NOT NULL,
		[CHANGE_STAMP]            [int] NOT NULL,
		[XML_DATA]                [xml](DOCUMENT [dbo].[ColumnCollection]) NULL,
		[CUSTOM_XML_DATA]         [xml](DOCUMENT [dbo].[ColumnCollection]) NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TB_DIM_AGENT_TEAM_DIALED_NUMBER_MEMBER]
		PRIMARY KEY
		CLUSTERED
		([MEMBER_URN])
	ON [DIMGROUP]
) ON [DIMGROUP] TEXTIMAGE_ON [DIMGROUP]
GO
ALTER TABLE [dbo].[TB_DIM_AGENT_TEAM_DIALED_NUMBER_MEMBER]
	ADD
	CONSTRAINT [DF_TB_DIM_AGENT_TEAM_DIALED_NUMBER_MEMBER_MEMBER_BIZ_URN]
	DEFAULT ((-2)) FOR [MEMBER_BIZ_URN]
GO
ALTER TABLE [dbo].[TB_DIM_AGENT_TEAM_DIALED_NUMBER_MEMBER]
	ADD
	CONSTRAINT [DF_TB_DIM_AGENT_TEAM_DIALED_NUMBER_MEMBER_MODIFIED_DATE]
	DEFAULT (getutcdate()) FOR [MODIFIED_DATE]
GO
ALTER TABLE [dbo].[TB_DIM_AGENT_TEAM_DIALED_NUMBER_MEMBER]
	ADD
	CONSTRAINT [DF_TB_DIM_AGENT_TEAM_DIALED_NUMBER_MEMBER_CREATION_DATE]
	DEFAULT (getutcdate()) FOR [CREATION_DATE]
GO
ALTER TABLE [dbo].[TB_DIM_AGENT_TEAM_DIALED_NUMBER_MEMBER]
	ADD
	CONSTRAINT [DF_TB_DIM_AGENT_TEAM_DIALED_NUMBER_MEMBER_EFFECTIVE_FROM]
	DEFAULT (getutcdate()) FOR [EFFECTIVE_FROM]
GO
ALTER TABLE [dbo].[TB_DIM_AGENT_TEAM_DIALED_NUMBER_MEMBER]
	ADD
	CONSTRAINT [DF_TB_DIM_AGENT_TEAM_DIALED_NUMBER_MEMBER_EFFECTIVE_TO]
	DEFAULT ('2079-06-06 00:00:00') FOR [EFFECTIVE_TO]
GO
ALTER TABLE [dbo].[TB_DIM_AGENT_TEAM_DIALED_NUMBER_MEMBER]
	ADD
	CONSTRAINT [DF_TB_DIM_AGENT_TEAM_DIALED_NUMBER_MEMBER_DELETED]
	DEFAULT ((0)) FOR [DELETED]
GO
ALTER TABLE [dbo].[TB_DIM_AGENT_TEAM_DIALED_NUMBER_MEMBER]
	ADD
	CONSTRAINT [DF_TB_DIM_AGENT_TEAM_DIALED_NUMBER_MEMBER_SYSTEM]
	DEFAULT ((0)) FOR [SYSTEM]
GO
ALTER TABLE [dbo].[TB_DIM_AGENT_TEAM_DIALED_NUMBER_MEMBER]
	ADD
	CONSTRAINT [DF_TB_DIM_AGENT_TEAM_DIALED_NUMBER_MEMBER_HIDDEN]
	DEFAULT ((0)) FOR [HIDDEN]
GO
ALTER TABLE [dbo].[TB_DIM_AGENT_TEAM_DIALED_NUMBER_MEMBER]
	ADD
	CONSTRAINT [DF_TB_DIM_AGENT_TEAM_DIALED_NUMBER_MEMBER_LATEST]
	DEFAULT ((1)) FOR [LATEST]
GO
ALTER TABLE [dbo].[TB_DIM_AGENT_TEAM_DIALED_NUMBER_MEMBER]
	ADD
	CONSTRAINT [DF_TB_DIM_AGENT_TEAM_DIALED_NUMBER_MEMBER_CHANGE_STAMP]
	DEFAULT ((0)) FOR [CHANGE_STAMP]
GO
ALTER TABLE [dbo].[TB_DIM_AGENT_TEAM_DIALED_NUMBER_MEMBER]
	ADD
	CONSTRAINT [DF_TB_DIM_AGENT_TEAM_DIALED_NUMBER_MEMBER_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_DIM_AGENT_TEAM_DIALED_NUMBER_MEMBER]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_DIM_AGENT_TEAM_DIALED_NUMBER_MEMBER_MEMBER_BIZ_URN]
	FOREIGN KEY ([MEMBER_BIZ_URN]) REFERENCES [dbo].[TB_DIM_AGENT_TEAM_DIALED_NUMBER_MEMBER] ([MEMBER_URN])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_DIM_AGENT_TEAM_DIALED_NUMBER_MEMBER]
	CHECK CONSTRAINT [FK_TB_DIM_AGENT_TEAM_DIALED_NUMBER_MEMBER_MEMBER_BIZ_URN]

GO
ALTER TABLE [dbo].[TB_DIM_AGENT_TEAM_DIALED_NUMBER_MEMBER]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_DIM_AGENT_TEAM_DIALED_NUMBER_MEMBER_TB_DIM_AGENT_TEAM_CHILD_ITEM_BIZ_URN]
	FOREIGN KEY ([CHILD_ITEM_BIZ_URN]) REFERENCES [dbo].[TB_DIM_AGENT_TEAM] ([ITEM_URN])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_DIM_AGENT_TEAM_DIALED_NUMBER_MEMBER]
	CHECK CONSTRAINT [FK_TB_DIM_AGENT_TEAM_DIALED_NUMBER_MEMBER_TB_DIM_AGENT_TEAM_CHILD_ITEM_BIZ_URN]

GO
ALTER TABLE [dbo].[TB_DIM_AGENT_TEAM_DIALED_NUMBER_MEMBER]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_DIM_AGENT_TEAM_DIALED_NUMBER_MEMBER_TB_DIM_DIALED_NUMBER_PARENT_ITEM_BIZ_URN]
	FOREIGN KEY ([PARENT_ITEM_BIZ_URN]) REFERENCES [dbo].[TB_DIM_DIALED_NUMBER] ([ITEM_URN])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_DIM_AGENT_TEAM_DIALED_NUMBER_MEMBER]
	CHECK CONSTRAINT [FK_TB_DIM_AGENT_TEAM_DIALED_NUMBER_MEMBER_TB_DIM_DIALED_NUMBER_PARENT_ITEM_BIZ_URN]

GO
CREATE NONCLUSTERED INDEX [IX_TB_DIM_AGENT_TEAM_DIALED_NUMBER_MEMBER_PARENT_CHILD]
	ON [dbo].[TB_DIM_AGENT_TEAM_DIALED_NUMBER_MEMBER] ([PARENT_ITEM_BIZ_URN], [CHILD_ITEM_BIZ_URN], [LATEST])
	INCLUDE ([DELETED], [MEMBER_BIZ_URN])
	ON [DIMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_DIM_AGENT_TEAM_DIALED_NUMBER_MEMBER_CHILD_PARENT]
	ON [dbo].[TB_DIM_AGENT_TEAM_DIALED_NUMBER_MEMBER] ([CHILD_ITEM_BIZ_URN], [PARENT_ITEM_BIZ_URN], [LATEST])
	INCLUDE ([DELETED], [MEMBER_BIZ_URN])
	ON [DIMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_DIM_AGENT_TEAM_DIALED_NUMBER_MEMBER_EFFECTIVE_FROM_EFFECTIVE_TO]
	ON [dbo].[TB_DIM_AGENT_TEAM_DIALED_NUMBER_MEMBER] ([EFFECTIVE_FROM], [EFFECTIVE_TO], [LATEST])
	INCLUDE ([DELETED], [MEMBER_BIZ_URN])
	ON [DIMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_DIM_AGENT_TEAM_DIALED_NUMBER_MEMBER_BIZ]
	ON [dbo].[TB_DIM_AGENT_TEAM_DIALED_NUMBER_MEMBER] ([MEMBER_BIZ_URN], [LATEST])
	ON [DIMINDEXGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table holds base information about all the memberships between Dialed Number items and Agent Team items in the application.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_AGENT_TEAM_DIALED_NUMBER_MEMBER', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_AGENT_TEAM_DIALED_NUMBER_MEMBER', 'COLUMN', N'MEMBER_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the business key for this entity. This key references the parent row.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_AGENT_TEAM_DIALED_NUMBER_MEMBER', 'COLUMN', N'MEMBER_BIZ_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DIALED_NUMBER corresponding to the item which is the parent for the membership. The item type for this item corresponds to the parent item type specified to the current member type.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_AGENT_TEAM_DIALED_NUMBER_MEMBER', 'COLUMN', N'PARENT_ITEM_BIZ_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_AGENT_TEAM corresponding to the item which is the child for the membership. The item type for this item corresponds to the child item type specified to the current member type.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_AGENT_TEAM_DIALED_NUMBER_MEMBER', 'COLUMN', N'CHILD_ITEM_BIZ_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the UTC date time indicating when the memberhship between the parent and child items will be active.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_AGENT_TEAM_DIALED_NUMBER_MEMBER', 'COLUMN', N'EFFECTIVE_FROM'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the UTC date time indicating when the memberhship between the parent and child items will be cease to exist.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_AGENT_TEAM_DIALED_NUMBER_MEMBER', 'COLUMN', N'EFFECTIVE_TO'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the membership is deleted or not. Value 1 indicates deleted.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_AGENT_TEAM_DIALED_NUMBER_MEMBER', 'COLUMN', N'DELETED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the membership is hidden or not. Value 1 indicates hidden.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_AGENT_TEAM_DIALED_NUMBER_MEMBER', 'COLUMN', N'HIDDEN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Not used.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_AGENT_TEAM_DIALED_NUMBER_MEMBER', 'COLUMN', N'SYSTEM'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the membership is latest or not. Value 1 indicates latest.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_AGENT_TEAM_DIALED_NUMBER_MEMBER', 'COLUMN', N'LATEST'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TB_SEC_USER corresponding to the user who created the membership.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_AGENT_TEAM_DIALED_NUMBER_MEMBER', 'COLUMN', N'CREATED_BY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TB_SEC_USER corresponding to the user who last modified the membership.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_AGENT_TEAM_DIALED_NUMBER_MEMBER', 'COLUMN', N'MODIFIED_BY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a UTC date time stamp indicating when the membership was created.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_AGENT_TEAM_DIALED_NUMBER_MEMBER', 'COLUMN', N'CREATION_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a UTC date time stamp indicating when the membership was last modified.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_AGENT_TEAM_DIALED_NUMBER_MEMBER', 'COLUMN', N'MODIFIED_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is an incremental number indicating the change stamp for the specific membership.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_AGENT_TEAM_DIALED_NUMBER_MEMBER', 'COLUMN', N'CHANGE_STAMP'
GO
EXEC sp_addextendedproperty N'MS_Description', N'XML data block for this member', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_AGENT_TEAM_DIALED_NUMBER_MEMBER', 'COLUMN', N'XML_DATA'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Custom XML data block for this member', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_AGENT_TEAM_DIALED_NUMBER_MEMBER', 'COLUMN', N'CUSTOM_XML_DATA'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_AGENT_TEAM_DIALED_NUMBER_MEMBER', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_DIM_AGENT_TEAM_DIALED_NUMBER_MEMBER]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_DIM_AGENT_TEAM_DIALED_NUMBER_MEMBER]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_DIM_AGENT_TEAM_DIALED_NUMBER_MEMBER]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_DIM_AGENT_TEAM_DIALED_NUMBER_MEMBER]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_DIM_AGENT_TEAM_DIALED_NUMBER_MEMBER]
	TO [portalrs_role]
GO
ALTER TABLE [dbo].[TB_DIM_AGENT_TEAM_DIALED_NUMBER_MEMBER] SET (LOCK_ESCALATION = TABLE)
GO
