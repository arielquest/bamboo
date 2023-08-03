SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_SGY_STRATEGY_PARAMETER] (
		[STRATEGY_PARAMETER_ID]            [uniqueidentifier] NOT NULL,
		[STRATEGY_SCRIPT_MEMBER_ID]        [uniqueidentifier] NOT NULL,
		[LINKED_STRATEGY_PARAMETER_ID]     [uniqueidentifier] NULL,
		[NODE_TYPE_ID]                     [uniqueidentifier] NULL,
		[SORT_ORDER]                       [int] NOT NULL,
		[ITEM_TYPE_ID]                     [uniqueidentifier] NOT NULL,
		[ITEM_COUNT]                       [int] NOT NULL,
		[ITEM_URN]                         [int] NOT NULL,
		[EXPRESSION]                       [nvarchar](500) COLLATE Latin1_General_CI_AS NOT NULL,
		[ARCHIVED]                         [bit] NOT NULL,
		[ENABLED]                          [bit] NOT NULL,
		[HIDDEN]                           [bit] NOT NULL,
		[SYSTEM]                           [bit] NOT NULL,
		[DELETED]                          [bit] NOT NULL,
		[msrepl_tran_version]              [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TB_SGY_STRATEGY_PARAMETER]
		PRIMARY KEY
		CLUSTERED
		([STRATEGY_PARAMETER_ID])
	ON [ADMGROUP]
) ON [ADMGROUP]
GO
ALTER TABLE [dbo].[TB_SGY_STRATEGY_PARAMETER]
	ADD
	CONSTRAINT [DF_TB_SGY_STRATEGY_PARAMETER_STRATEGY_PARAMETER_ID]
	DEFAULT (newid()) FOR [STRATEGY_PARAMETER_ID]
GO
ALTER TABLE [dbo].[TB_SGY_STRATEGY_PARAMETER]
	ADD
	CONSTRAINT [DF_TB_SGY_STRATEGY_PARAMETER_SORT_ORDER]
	DEFAULT ((1)) FOR [SORT_ORDER]
GO
ALTER TABLE [dbo].[TB_SGY_STRATEGY_PARAMETER]
	ADD
	CONSTRAINT [DF_TB_SGY_STRATEGY_PARAMETER_ITEM_TYPE_ID]
	DEFAULT ('00000001-0000-0000-0000-000000000010') FOR [ITEM_TYPE_ID]
GO
ALTER TABLE [dbo].[TB_SGY_STRATEGY_PARAMETER]
	ADD
	CONSTRAINT [DF_TB_SGY_STRATEGY_PARAMETER_ITEM_COUNT]
	DEFAULT ((1)) FOR [ITEM_COUNT]
GO
ALTER TABLE [dbo].[TB_SGY_STRATEGY_PARAMETER]
	ADD
	CONSTRAINT [DF_TB_SGY_STRATEGY_PARAMETER_ITEM_URN]
	DEFAULT ((-1)) FOR [ITEM_URN]
GO
ALTER TABLE [dbo].[TB_SGY_STRATEGY_PARAMETER]
	ADD
	CONSTRAINT [DF_TB_SGY_STRATEGY_PARAMETER_EXPRESSION]
	DEFAULT (N'') FOR [EXPRESSION]
GO
ALTER TABLE [dbo].[TB_SGY_STRATEGY_PARAMETER]
	ADD
	CONSTRAINT [DF_TB_SGY_STRATEGY_PARAMETER_ARCHIVED]
	DEFAULT ((0)) FOR [ARCHIVED]
GO
ALTER TABLE [dbo].[TB_SGY_STRATEGY_PARAMETER]
	ADD
	CONSTRAINT [DF_TB_SGY_STRATEGY_PARAMETER_ENABLED]
	DEFAULT ((1)) FOR [ENABLED]
GO
ALTER TABLE [dbo].[TB_SGY_STRATEGY_PARAMETER]
	ADD
	CONSTRAINT [DF_TB_SGY_STRATEGY_PARAMETER_HIDDEN]
	DEFAULT ((0)) FOR [HIDDEN]
GO
ALTER TABLE [dbo].[TB_SGY_STRATEGY_PARAMETER]
	ADD
	CONSTRAINT [DF_TB_SGY_STRATEGY_PARAMETER_SYSTEM]
	DEFAULT ((0)) FOR [SYSTEM]
GO
ALTER TABLE [dbo].[TB_SGY_STRATEGY_PARAMETER]
	ADD
	CONSTRAINT [DF_TB_SGY_STRATEGY_PARAMETER_DELETED]
	DEFAULT ((0)) FOR [DELETED]
GO
ALTER TABLE [dbo].[TB_SGY_STRATEGY_PARAMETER]
	ADD
	CONSTRAINT [DF_TB_SGY_STRATEGY_PARAMETER_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_SGY_STRATEGY_PARAMETER]
	WITH NOCHECK
	ADD CONSTRAINT [FK_SGY_STRATEGY_PARAMETER_DIM_ITEM_TYPE]
	FOREIGN KEY ([ITEM_TYPE_ID]) REFERENCES [dbo].[TE_DIM_ITEM_TYPE] ([ITEM_TYPE_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_SGY_STRATEGY_PARAMETER]
	CHECK CONSTRAINT [FK_SGY_STRATEGY_PARAMETER_DIM_ITEM_TYPE]

GO
ALTER TABLE [dbo].[TB_SGY_STRATEGY_PARAMETER]
	WITH NOCHECK
	ADD CONSTRAINT [FK_SGY_STRATEGY_PARAMETER_SGY_STRATEGY_SCRIPT_MEMBER]
	FOREIGN KEY ([STRATEGY_SCRIPT_MEMBER_ID]) REFERENCES [dbo].[TB_SGY_STRATEGY_SCRIPT_MEMBER] ([STRATEGY_SCRIPT_MEMBER_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_SGY_STRATEGY_PARAMETER]
	CHECK CONSTRAINT [FK_SGY_STRATEGY_PARAMETER_SGY_STRATEGY_SCRIPT_MEMBER]

GO
CREATE NONCLUSTERED INDEX [IX_TB_SGY_STRATEGY_PARAMETER_ITEM_TYPE_ID]
	ON [dbo].[TB_SGY_STRATEGY_PARAMETER] ([ITEM_TYPE_ID])
	ON [ADMGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_SGY_STRATEGY_PARAMETER_STRATEGY_SCRIPT_MEMBER_ID]
	ON [dbo].[TB_SGY_STRATEGY_PARAMETER] ([STRATEGY_SCRIPT_MEMBER_ID])
	ON [ADMGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'Template parameter that determines what the user should be prompted for this parameter. There is a difference between a strategy parameter for a strategy template and a strategy instance. For example a Queue To Skillgroup node type may require 10 Skillgroups. The Strategy Template Parameter would contain a single entry with an ietm count of 10. For each instantiation of that template there would be 10 Strategy Instance Parameters each of which would contain a reference to teh actual skillgroup and an item count of 1. This means that the template', 'SCHEMA', N'dbo', 'TABLE', N'TB_SGY_STRATEGY_PARAMETER', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SGY_STRATEGY_PARAMETER', 'COLUMN', N'STRATEGY_PARAMETER_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'An optional linked or supporting item which the expression or main item needs. For example a Skillgroup may need an associated label.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SGY_STRATEGY_PARAMETER', 'COLUMN', N'LINKED_STRATEGY_PARAMETER_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the order in which the parameter is displayed to the user for this strategy instance.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SGY_STRATEGY_PARAMETER', 'COLUMN', N'SORT_ORDER'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The type of item, if present, that this strategy parameter is associated with e.g. Skill Group, Agent', 'SCHEMA', N'dbo', 'TABLE', N'TB_SGY_STRATEGY_PARAMETER', 'COLUMN', N'ITEM_TYPE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Required number of items for this parameter when an strategy instance is created. ', 'SCHEMA', N'dbo', 'TABLE', N'TB_SGY_STRATEGY_PARAMETER', 'COLUMN', N'ITEM_COUNT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The item to which this parameter is associated', 'SCHEMA', N'dbo', 'TABLE', N'TB_SGY_STRATEGY_PARAMETER', 'COLUMN', N'ITEM_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'A node type specific expression that is used by the system to create template strings or instance values.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SGY_STRATEGY_PARAMETER', 'COLUMN', N'EXPRESSION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is flag indicating whether the parameter is set for archive or not. Value of 1 indicates archived.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SGY_STRATEGY_PARAMETER', 'COLUMN', N'ARCHIVED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is flag indicating whether the parameter is enabled or not. Value of 1 indicates enabled.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SGY_STRATEGY_PARAMETER', 'COLUMN', N'ENABLED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is flag indicating whether the parameter is hidden or not. Value of 1 indicates hidden.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SGY_STRATEGY_PARAMETER', 'COLUMN', N'HIDDEN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is flag indicating whether the parameter is owned by the system or not. Value of 1 indicates system owned parameter.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SGY_STRATEGY_PARAMETER', 'COLUMN', N'SYSTEM'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SGY_STRATEGY_PARAMETER', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_SGY_STRATEGY_PARAMETER]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_SGY_STRATEGY_PARAMETER]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_SGY_STRATEGY_PARAMETER]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_SGY_STRATEGY_PARAMETER]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_SGY_STRATEGY_PARAMETER] SET (LOCK_ESCALATION = TABLE)
GO
