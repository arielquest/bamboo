SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TS_IMP_OLAP_DIMENSION_IN_ERROR] (
		[OLAP_DIMENSION_IN_ERROR_URN]     [int] IDENTITY(1, 1) NOT FOR REPLICATION NOT NULL,
		[TABLE_NAME]                      [nvarchar](500) COLLATE Latin1_General_CI_AS NOT NULL,
		[COLUMN_NAME]                     [nvarchar](500) COLLATE Latin1_General_CI_AS NOT NULL,
		[ITEM_TYPE_ID]                    [uniqueidentifier] NOT NULL,
		[ITEM_TYPE_URN]                   [int] NOT NULL,
		[ITEM_BIZ_URN]                    [int] NOT NULL,
		[CUBE_NAME]                       [nvarchar](100) COLLATE Latin1_General_CI_AS NULL,
		[MEASURE_GROUP_NAME]              [nvarchar](200) COLLATE Latin1_General_CI_AS NULL,
		[PARTITION_NAME]                  [nvarchar](300) COLLATE Latin1_General_CI_AS NULL
) ON [STGGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a staging table used to hold details of dimensions that encountered an error during OLAP processing.', 'SCHEMA', N'dbo', 'TABLE', N'TS_IMP_OLAP_DIMENSION_IN_ERROR', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field is the primary key for this table.', 'SCHEMA', N'dbo', 'TABLE', N'TS_IMP_OLAP_DIMENSION_IN_ERROR', 'COLUMN', N'OLAP_DIMENSION_IN_ERROR_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column holds the source view name that encountered an error during OLAP processing.', 'SCHEMA', N'dbo', 'TABLE', N'TS_IMP_OLAP_DIMENSION_IN_ERROR', 'COLUMN', N'TABLE_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column holds the field name of the source view that encountered an error during OLAP processing.', 'SCHEMA', N'dbo', 'TABLE', N'TS_IMP_OLAP_DIMENSION_IN_ERROR', 'COLUMN', N'COLUMN_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column holds the Item Type ID that encountered an error during OLAP processing.', 'SCHEMA', N'dbo', 'TABLE', N'TS_IMP_OLAP_DIMENSION_IN_ERROR', 'COLUMN', N'ITEM_TYPE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column holds the Item Type URN that encountered an error during OLAP processing.', 'SCHEMA', N'dbo', 'TABLE', N'TS_IMP_OLAP_DIMENSION_IN_ERROR', 'COLUMN', N'ITEM_TYPE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column holds the Item URN that encountered an error during OLAP processing.', 'SCHEMA', N'dbo', 'TABLE', N'TS_IMP_OLAP_DIMENSION_IN_ERROR', 'COLUMN', N'ITEM_BIZ_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column holds the name of the Cube that encountered an error during OLAP processing.', 'SCHEMA', N'dbo', 'TABLE', N'TS_IMP_OLAP_DIMENSION_IN_ERROR', 'COLUMN', N'CUBE_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column holds the name of the Measure Group that encountered an error during OLAP processing.', 'SCHEMA', N'dbo', 'TABLE', N'TS_IMP_OLAP_DIMENSION_IN_ERROR', 'COLUMN', N'MEASURE_GROUP_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column holds the OLAP Partition Name that encountered an error during OLAP processing.', 'SCHEMA', N'dbo', 'TABLE', N'TS_IMP_OLAP_DIMENSION_IN_ERROR', 'COLUMN', N'PARTITION_NAME'
GO
GRANT DELETE
	ON [dbo].[TS_IMP_OLAP_DIMENSION_IN_ERROR]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TS_IMP_OLAP_DIMENSION_IN_ERROR]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TS_IMP_OLAP_DIMENSION_IN_ERROR]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TS_IMP_OLAP_DIMENSION_IN_ERROR]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TS_IMP_OLAP_DIMENSION_IN_ERROR] SET (LOCK_ESCALATION = TABLE)
GO
