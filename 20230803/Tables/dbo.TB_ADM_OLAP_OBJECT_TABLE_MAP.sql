SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_ADM_OLAP_OBJECT_TABLE_MAP] (
		[OLAP_OBJECT_TABLE_MAP_URN]     [int] IDENTITY(1, 4) NOT FOR REPLICATION NOT NULL,
		[OLAP_OBJECT_URN]               [int] NOT NULL,
		[TABLE_NAME]                    [nvarchar](255) COLLATE Latin1_General_CI_AS NOT NULL,
		[msrepl_tran_version]           [uniqueidentifier] NOT NULL,
		CONSTRAINT [UN_TB_ADM_OLAP_OBJECT_TABLE_MAP_OLAP_OBJECT_URN_TABLE_NAME]
		UNIQUE
		NONCLUSTERED
		([OLAP_OBJECT_URN], [TABLE_NAME])
		ON [ADMINDEXGROUP],
		CONSTRAINT [PK_TB_ADM_OLAP_OBJECT_TABLE_MAP]
		PRIMARY KEY
		CLUSTERED
		([OLAP_OBJECT_TABLE_MAP_URN])
	ON [ADMGROUP]
) ON [ADMGROUP]
GO
ALTER TABLE [dbo].[TB_ADM_OLAP_OBJECT_TABLE_MAP]
	ADD
	CONSTRAINT [DF_TB_ADM_OLAP_OBJECT_TABLE_MAP_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_ADM_OLAP_OBJECT_TABLE_MAP]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_ADM_OLAP_OBJECT_TABLE_MAP_TB_ADM_OLAP_OBJECT]
	FOREIGN KEY ([OLAP_OBJECT_URN]) REFERENCES [dbo].[TB_ADM_OLAP_OBJECT] ([OLAP_OBJECT_URN])
	ON DELETE CASCADE
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_ADM_OLAP_OBJECT_TABLE_MAP]
	CHECK CONSTRAINT [FK_TB_ADM_OLAP_OBJECT_TABLE_MAP_TB_ADM_OLAP_OBJECT]

GO
EXEC sp_addextendedproperty N'MS_Description', N'This stores the mappings between olap objects and the tables which their source data originate from.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_OLAP_OBJECT_TABLE_MAP', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field is the primary key for this table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_OLAP_OBJECT_TABLE_MAP', 'COLUMN', N'OLAP_OBJECT_TABLE_MAP_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field indicates the OLAP Object. This is the foreign key from TB_ADM_OLAP_OBJECT.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_OLAP_OBJECT_TABLE_MAP', 'COLUMN', N'OLAP_OBJECT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field is the name of the table that the Olap Object is based on.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_OLAP_OBJECT_TABLE_MAP', 'COLUMN', N'TABLE_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_OLAP_OBJECT_TABLE_MAP', 'COLUMN', N'msrepl_tran_version'
GO
GRANT SELECT
	ON [dbo].[TB_ADM_OLAP_OBJECT_TABLE_MAP]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_ADM_OLAP_OBJECT_TABLE_MAP] SET (LOCK_ESCALATION = TABLE)
GO
