SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TS_DIM_LOGICAL_INTERFACE_CONTROLLER_GC] (
		[ITEM_URN]                    [int] NOT NULL,
		[GENERATION_COUNT]            [bigint] NOT NULL,
		[CREATE_GENERATION_COUNT]     [bigint] NOT NULL,
		[LAST_OPERATION]              [char](1) COLLATE Latin1_General_CI_AS NOT NULL,
		CONSTRAINT [PK_TS_DIM_LOGICAL_INTERFACE_CONTROLLER_GC]
		PRIMARY KEY
		CLUSTERED
		([ITEM_URN])
	ON [DIMGROUP]
) ON [DIMGROUP]
GO
ALTER TABLE [dbo].[TS_DIM_LOGICAL_INTERFACE_CONTROLLER_GC]
	ADD
	CONSTRAINT [CK_TS_DIM_LOGICAL_INTERFACE_CONTROLLER_GC]
	CHECK
	([LAST_OPERATION]='D' OR [LAST_OPERATION]='U' OR [LAST_OPERATION]='I')
GO
ALTER TABLE [dbo].[TS_DIM_LOGICAL_INTERFACE_CONTROLLER_GC]
CHECK CONSTRAINT [CK_TS_DIM_LOGICAL_INTERFACE_CONTROLLER_GC]
GO
ALTER TABLE [dbo].[TS_DIM_LOGICAL_INTERFACE_CONTROLLER_GC]
	ADD
	CONSTRAINT [DF_TS_DIM_LOGICAL_INTERFACE_CONTROLLER_GC_GENERATION_COUNT]
	DEFAULT ((0)) FOR [GENERATION_COUNT]
GO
ALTER TABLE [dbo].[TS_DIM_LOGICAL_INTERFACE_CONTROLLER_GC]
	ADD
	CONSTRAINT [DF_TS_DIM_LOGICAL_INTERFACE_CONTROLLER_GC_CREATE_GENERATION_COUNT]
	DEFAULT ((0)) FOR [CREATE_GENERATION_COUNT]
GO
ALTER TABLE [dbo].[TS_DIM_LOGICAL_INTERFACE_CONTROLLER_GC]
	ADD
	CONSTRAINT [DF_TS_DIM_LOGICAL_INTERFACE_CONTROLLER_GC_LAST_OPERATION]
	DEFAULT ('I') FOR [LAST_OPERATION]
GO
CREATE NONCLUSTERED INDEX [IX_TS_DIM_LOGICAL_INTERFACE_CONTROLLER_GC_GENERATION_COUNT]
	ON [dbo].[TS_DIM_LOGICAL_INTERFACE_CONTROLLER_GC] ([GENERATION_COUNT])
	INCLUDE ([LAST_OPERATION], [ITEM_URN])
	ON [DIMGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table holds all the generation count data for the records in  TB_DIM_LOGICAL_INTERFACE_CONTROLLER. This is used by the application search service to decide what records have changed. This table is not replicated. The data in this tables are inserted, updated or deleted by triggers.', 'SCHEMA', N'dbo', 'TABLE', N'TS_DIM_LOGICAL_INTERFACE_CONTROLLER_GC', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the primary key value of the record in the corresponding table that has changed.', 'SCHEMA', N'dbo', 'TABLE', N'TS_DIM_LOGICAL_INTERFACE_CONTROLLER_GC', 'COLUMN', N'ITEM_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is an auto incrementing number corresponding to the number of times the specific record in the corresponding table has changed.', 'SCHEMA', N'dbo', 'TABLE', N'TS_DIM_LOGICAL_INTERFACE_CONTROLLER_GC', 'COLUMN', N'GENERATION_COUNT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is an auto incrementing number corresponding to the generation count the specific record in the corresponding table had when it was created.', 'SCHEMA', N'dbo', 'TABLE', N'TS_DIM_LOGICAL_INTERFACE_CONTROLLER_GC', 'COLUMN', N'CREATE_GENERATION_COUNT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a character flag indicating the last operation that was executed against the specific record in the corresponding table. Possible values are I: Insert, U: Update; D: Delete.', 'SCHEMA', N'dbo', 'TABLE', N'TS_DIM_LOGICAL_INTERFACE_CONTROLLER_GC', 'COLUMN', N'LAST_OPERATION'
GO
GRANT SELECT
	ON [dbo].[TS_DIM_LOGICAL_INTERFACE_CONTROLLER_GC]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TS_DIM_LOGICAL_INTERFACE_CONTROLLER_GC] SET (LOCK_ESCALATION = TABLE)
GO
