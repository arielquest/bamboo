SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TS_ADM_OLAP_OBJECT_STATUS] (
		[OLAP_OBJECT_URN]       [int] NOT NULL,
		[CURRENT_PARTITION]     [varchar](128) COLLATE Latin1_General_CI_AS NOT NULL,
		[STATUS]                [int] NOT NULL,
		CONSTRAINT [PK_TS_ADM_OLAP_OBJECT_STATUS]
		PRIMARY KEY
		CLUSTERED
		([OLAP_OBJECT_URN])
	ON [ADMGROUP]
) ON [ADMGROUP]
GO
ALTER TABLE [dbo].[TS_ADM_OLAP_OBJECT_STATUS]
	ADD
	CONSTRAINT [DF_TS_ADM_OLAP_OBJECT_STATUS_CURRENT_PARTITION]
	DEFAULT ('') FOR [CURRENT_PARTITION]
GO
ALTER TABLE [dbo].[TS_ADM_OLAP_OBJECT_STATUS]
	ADD
	CONSTRAINT [DF_TS_ADM_OLAP_OBJECT_STATUS_STATUS]
	DEFAULT ((0)) FOR [STATUS]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table holds information about the processing status of partitions within the Analysis Services cube objects (OLAP Objects).', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_OLAP_OBJECT_STATUS', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field indicates the OLAP Object that is being processed. This refers to the OLAP_OBJECT_URN in TB_ADM_OLAP_OBJECT', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_OLAP_OBJECT_STATUS', 'COLUMN', N'OLAP_OBJECT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field indicates the partition name of the OLAP Object that is being processed.', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_OLAP_OBJECT_STATUS', 'COLUMN', N'CURRENT_PARTITION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This field indicates the processing status of the partition as indicated in the CURRENT_PARTITION field of the table. 0: Ready, 1: About To Process, 2: About To Merge.', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_OLAP_OBJECT_STATUS', 'COLUMN', N'STATUS'
GO
ALTER TABLE [dbo].[TS_ADM_OLAP_OBJECT_STATUS] SET (LOCK_ESCALATION = TABLE)
GO
