SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_ETL_COMPONENT_PROPERTY] (
		[COMPONENT_PROPERTY_ID]     [uniqueidentifier] NOT NULL ROWGUIDCOL,
		[COMPONENT_ID]              [uniqueidentifier] NOT NULL,
		[PROPERTY_NAME]             [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[PROPERTY_VALUE]            [nvarchar](max) COLLATE Latin1_General_CI_AS NULL,
		[msrepl_tran_version]       [uniqueidentifier] NOT NULL,
		CONSTRAINT [UN_TB_ETL_COMPONENT_PROPERTY_COMPONENT_ID_PROPERTY_NAME]
		UNIQUE
		NONCLUSTERED
		([COMPONENT_ID], [PROPERTY_NAME])
		ON [ADMINDEXGROUP],
		CONSTRAINT [PK_TB_ETL_COMPONENT_PROPERTY]
		PRIMARY KEY
		CLUSTERED
		([COMPONENT_PROPERTY_ID])
	ON [ADMINDEXGROUP]
) ON [ADMINDEXGROUP] TEXTIMAGE_ON [ADMGROUP]
GO
ALTER TABLE [dbo].[TB_ETL_COMPONENT_PROPERTY]
	ADD
	CONSTRAINT [DF_TB_ETL_COMPONENT_PROPERTY_COMPONENT_PROPERTY_ID]
	DEFAULT (newid()) FOR [COMPONENT_PROPERTY_ID]
GO
ALTER TABLE [dbo].[TB_ETL_COMPONENT_PROPERTY]
	ADD
	CONSTRAINT [DF_TB_ETL_COMPONENT_PROPERTY_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_ETL_COMPONENT_PROPERTY]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_ETL_COMPONENT_PROPERTY_TB_ETL_COMPONENT]
	FOREIGN KEY ([COMPONENT_ID]) REFERENCES [dbo].[TB_ETL_COMPONENT] ([COMPONENT_ID])
	ON DELETE CASCADE
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_ETL_COMPONENT_PROPERTY]
	CHECK CONSTRAINT [FK_TB_ETL_COMPONENT_PROPERTY_TB_ETL_COMPONENT]

GO
EXEC sp_addextendedproperty N'MS_Description', N'This table holds information about the various properties defined for each ETL component. These properties are made available to the ETL component at runtime. These properties are stored as name value pairs.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ETL_COMPONENT_PROPERTY', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ETL_COMPONENT_PROPERTY', 'COLUMN', N'COMPONENT_PROPERTY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the ID as in TB_ETL_COMPONENT indicating the ETL component for which the current property applies to.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ETL_COMPONENT_PROPERTY', 'COLUMN', N'COMPONENT_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the name of the ETL component property.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ETL_COMPONENT_PROPERTY', 'COLUMN', N'PROPERTY_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the value for the current property.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ETL_COMPONENT_PROPERTY', 'COLUMN', N'PROPERTY_VALUE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ETL_COMPONENT_PROPERTY', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_ETL_COMPONENT_PROPERTY]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_ETL_COMPONENT_PROPERTY]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_ETL_COMPONENT_PROPERTY]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_ETL_COMPONENT_PROPERTY]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_ETL_COMPONENT_PROPERTY] SET (LOCK_ESCALATION = TABLE)
GO
