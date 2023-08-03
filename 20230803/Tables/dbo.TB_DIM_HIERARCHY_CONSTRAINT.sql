SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_DIM_HIERARCHY_CONSTRAINT] (
		[HIERARCHY_CONSTRAINT_URN]     [int] IDENTITY(1, 4) NOT FOR REPLICATION NOT NULL,
		[HIERARCHY_BUSINESS_URN]       [int] NULL,
		[CONSTRAINT_TYPE]              [char](1) COLLATE Latin1_General_CI_AS NOT NULL,
		[CONSTRAINT_DATA]              [xml] NOT NULL,
		[msrepl_tran_version]          [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TB_DIM_HIERARCHY_CONSTRAINT]
		PRIMARY KEY
		CLUSTERED
		([HIERARCHY_CONSTRAINT_URN])
	ON [DIMGROUP]
) ON [DIMGROUP] TEXTIMAGE_ON [DIMGROUP]
GO
ALTER TABLE [dbo].[TB_DIM_HIERARCHY_CONSTRAINT]
	WITH NOCHECK
	ADD
	CONSTRAINT [CK_TB_DIM_HIERARCHY_CONSTRAINT_CONSTRAINT_TYPE]
	CHECK
	NOT FOR REPLICATION
	([CONSTRAINT_TYPE]='U' OR [CONSTRAINT_TYPE]='R' OR [CONSTRAINT_TYPE]='T')
GO
ALTER TABLE [dbo].[TB_DIM_HIERARCHY_CONSTRAINT]
CHECK CONSTRAINT [CK_TB_DIM_HIERARCHY_CONSTRAINT_CONSTRAINT_TYPE]
GO
ALTER TABLE [dbo].[TB_DIM_HIERARCHY_CONSTRAINT]
	ADD
	CONSTRAINT [DF_TB_DIM_HIERARCHY_CONSTRAINT_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table holds constraints used by the hierarchy schema.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_HIERARCHY_CONSTRAINT', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_HIERARCHY_CONSTRAINT', 'COLUMN', N'HIERARCHY_CONSTRAINT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Identity of the hierarchy (TB_DIM_HIERARCHY) that this constraint maps to (optional).', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_HIERARCHY_CONSTRAINT', 'COLUMN', N'HIERARCHY_BUSINESS_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The type of constraint - U: Unique Constraint, R: Range Constraint, T: Item Type Constraint.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_HIERARCHY_CONSTRAINT', 'COLUMN', N'CONSTRAINT_TYPE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Serialized constraint data.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_HIERARCHY_CONSTRAINT', 'COLUMN', N'CONSTRAINT_DATA'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_HIERARCHY_CONSTRAINT', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_DIM_HIERARCHY_CONSTRAINT]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_DIM_HIERARCHY_CONSTRAINT]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_DIM_HIERARCHY_CONSTRAINT]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_DIM_HIERARCHY_CONSTRAINT]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_DIM_HIERARCHY_CONSTRAINT] SET (LOCK_ESCALATION = TABLE)
GO
