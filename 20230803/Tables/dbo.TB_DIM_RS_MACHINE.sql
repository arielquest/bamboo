SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_DIM_RS_MACHINE] (
		[MACHINE_URN]             [int] IDENTITY(1, 4) NOT FOR REPLICATION NOT NULL,
		[INSTANCE_NAME]           [nvarchar](260) COLLATE Latin1_General_CI_AS NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TB_DIM_RS_MACHINE]
		PRIMARY KEY
		CLUSTERED
		([MACHINE_URN])
	ON [DIMGROUP]
) ON [DIMGROUP]
GO
ALTER TABLE [dbo].[TB_DIM_RS_MACHINE]
	ADD
	CONSTRAINT [DF_TB_DIM_RS_MACHINE_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table stores all the server instance associated with execution of any report in SQL server reporting services. The data in this table is populated during the import of report execution logs.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_RS_MACHINE', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_RS_MACHINE', 'COLUMN', N'MACHINE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the instance name of the report server associated with the report execution.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_RS_MACHINE', 'COLUMN', N'INSTANCE_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_RS_MACHINE', 'COLUMN', N'msrepl_tran_version'
GO
ALTER TABLE [dbo].[TB_DIM_RS_MACHINE] SET (LOCK_ESCALATION = TABLE)
GO
