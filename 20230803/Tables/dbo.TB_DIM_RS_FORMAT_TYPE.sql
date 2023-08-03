SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_DIM_RS_FORMAT_TYPE] (
		[FORMAT_TYPE_URN]         [int] IDENTITY(1, 4) NOT FOR REPLICATION NOT NULL,
		[NAME]                    [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[INTERNAL_NAME]           [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TB_DIM_RS_FORMAT_TYPE]
		PRIMARY KEY
		CLUSTERED
		([FORMAT_TYPE_URN])
	ON [DIMGROUP]
) ON [DIMGROUP]
GO
ALTER TABLE [dbo].[TB_DIM_RS_FORMAT_TYPE]
	ADD
	CONSTRAINT [DF_TB_DIM_RS_FORMAT_TYPE_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table stores all the rendering formats associated with execution of any report in SQL server reporting services. The data in this table is populated during the import of report execution logs.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_RS_FORMAT_TYPE', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_RS_FORMAT_TYPE', 'COLUMN', N'FORMAT_TYPE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a display name for the rendering format.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_RS_FORMAT_TYPE', 'COLUMN', N'NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the systems internal name for the report rendering format.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_RS_FORMAT_TYPE', 'COLUMN', N'INTERNAL_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_RS_FORMAT_TYPE', 'COLUMN', N'msrepl_tran_version'
GO
ALTER TABLE [dbo].[TB_DIM_RS_FORMAT_TYPE] SET (LOCK_ESCALATION = TABLE)
GO
