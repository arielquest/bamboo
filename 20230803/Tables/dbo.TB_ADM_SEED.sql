SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TB_ADM_SEED] (
		[SEED]     [int] NOT NULL
) ON [ADMGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table holds the value of the current seed for the tables with identity columns in the database. This value is used by the for replication and should not be changed. This table is not replicated.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_SEED', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field holds the value of the current seed for the tables with identity columns in the database. This value is used by the for replication and should not be changed.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_SEED', 'COLUMN', N'SEED'
GO
ALTER TABLE [dbo].[TB_ADM_SEED] SET (LOCK_ESCALATION = TABLE)
GO
