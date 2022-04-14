SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [metadata].[ChildConfiguration1] (
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
		[ValidFrom]                 [datetime2](7) GENERATED ALWAYS AS ROW START NOT NULL,
		[ValidTo]                   [datetime2](7) GENERATED ALWAYS AS ROW END NOT NULL,
		PERIOD FOR SYSTEM_TIME ([ValidFrom], [ValidTo]),
		CONSTRAINT [pk_metadata_ChildConfiguration1]
		PRIMARY KEY
		CLUSTERED
		([ObjectId], [VersionId], [_WorkspaceId])
	ON [ps_workspace] ([_WorkspaceId])
) ON [ps_workspace] ([_WorkspaceId])
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE=[metadata].[ChildConfiguration1History]))
GO
ALTER TABLE [metadata].[ChildConfiguration1]
	WITH CHECK
	ADD CONSTRAINT [FK_ChildConfiguration1_ConfigurationObjects]
	FOREIGN KEY ([ConfigurationId], [VersionId], [_WorkspaceId]) REFERENCES [metadata].[ConfigurationObjects] ([ConfigurationId], [VersionId], [_WorkspaceId])
	ON DELETE CASCADE
ALTER TABLE [metadata].[ChildConfiguration1]
	CHECK CONSTRAINT [FK_ChildConfiguration1_ConfigurationObjects]

GO
ALTER TABLE [metadata].[ChildConfiguration1] SET (LOCK_ESCALATION = TABLE)
GO
