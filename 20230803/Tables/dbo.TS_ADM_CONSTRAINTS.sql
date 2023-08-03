SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TS_ADM_CONSTRAINTS] (
		[SOURCE_SCHEMA_NAME]        [nvarchar](128) COLLATE Latin1_General_CI_AS NOT NULL,
		[SOURCE_TABLE_NAME]         [nvarchar](128) COLLATE Latin1_General_CI_AS NOT NULL,
		[CONSTRAINT_NAME]           [nvarchar](128) COLLATE Latin1_General_CI_AS NOT NULL,
		[CONSTRAINT_KEY]            [nvarchar](max) COLLATE Latin1_General_CI_AS NOT NULL,
		[REFERENCE_SCHEMA_NAME]     [nvarchar](128) COLLATE Latin1_General_CI_AS NOT NULL,
		[REFERENCE_TABLE_NAME]      [nvarchar](128) COLLATE Latin1_General_CI_AS NOT NULL,
		[REFERENCE_KEY]             [nvarchar](max) COLLATE Latin1_General_CI_AS NOT NULL,
		[REPLICATION_OPTION]        [bit] NOT NULL,
		[DELETE_ACTION]             [bit] NOT NULL,
		[UPDATE_ACTION]             [bit] NOT NULL
) ON [ADMGROUP] TEXTIMAGE_ON [ADMGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table holds all the foreign key constraints that exists within the database. This is used during replication by the pre-snapshot and post-snapshot scripts to drop and create the constraints.', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_CONSTRAINTS', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field indicates the table schema that the constraint exists on.', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_CONSTRAINTS', 'COLUMN', N'SOURCE_SCHEMA_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field indicates the table to which has the foreign key constraint.', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_CONSTRAINTS', 'COLUMN', N'SOURCE_TABLE_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field indicates the actual name of the constraint.', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_CONSTRAINTS', 'COLUMN', N'CONSTRAINT_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field indicates the column that is the part of the constraint.', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_CONSTRAINTS', 'COLUMN', N'CONSTRAINT_KEY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field indicates the parent table schema that the constraint refers to.', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_CONSTRAINTS', 'COLUMN', N'REFERENCE_SCHEMA_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field indicates the parent table that the constraint refers to.', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_CONSTRAINTS', 'COLUMN', N'REFERENCE_TABLE_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field indicates the column in the parent table that the constraint refers to.', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_CONSTRAINTS', 'COLUMN', N'REFERENCE_KEY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field defines the replication option for the constraint.  This can be 0 (NOT for replication) or 1 (FOR replication)', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_CONSTRAINTS', 'COLUMN', N'REPLICATION_OPTION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field indicates the action on delete of records from the parent table. This can be 0 (NO ACTION) or 1 (CASCADE).', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_CONSTRAINTS', 'COLUMN', N'DELETE_ACTION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field indicates the action on update of records from the parent table. This can be 0 (NO ACTION) or 1 (CASCADE).', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_CONSTRAINTS', 'COLUMN', N'UPDATE_ACTION'
GO
ALTER TABLE [dbo].[TS_ADM_CONSTRAINTS] SET (LOCK_ESCALATION = TABLE)
GO
