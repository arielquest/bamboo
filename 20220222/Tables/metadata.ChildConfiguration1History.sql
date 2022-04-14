SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [metadata].[ChildConfiguration1History] (
		[ObjectId]                  [uniqueidentifier] NOT NULL,
		[ObjectName]                [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ConfigurationId]           [uniqueidentifier] NOT NULL,
		[VersionId]                 [uniqueidentifier] NOT NULL,
		[_ModifiedDate]             [datetimeoffset](7) NOT NULL,
		[_ModifiedBy]               [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_ModifiedByAppVersion]     [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[_IsDeleted]                [bit] NOT NULL,
		[_RowVersion]               [timestamp] NOT NULL,
		[_WorkspaceId]              [int] NOT NULL,
		[ValidFrom]                 [datetime2](7) NOT NULL,
		[ValidTo]                   [datetime2](7) NOT NULL
) ON [PRIMARY]
GO
CREATE CLUSTERED INDEX [ix_ChildConfiguration1History]
	ON [metadata].[ChildConfiguration1History] ([ValidTo], [ValidFrom])
	WITH ( 	DATA_COMPRESSION = PAGE)
	ON [PRIMARY]
GO
ALTER TABLE [metadata].[ChildConfiguration1History] SET (LOCK_ESCALATION = TABLE)
GO
