SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [metadata].[ChildConfiguration1](
	[ObjectId] [uniqueidentifier] NOT NULL,
	[ObjectName] [nvarchar](255) NOT NULL,
	[ConfigurationId] [uniqueidentifier] NOT NULL,
	[VersionId] [uniqueidentifier] NOT NULL,
	[_ModifiedDate] [datetimeoffset](7) NOT NULL,
	[_ModifiedBy] [nvarchar](100) NOT NULL,
	[_ModifiedByAppVersion] [nvarchar](50) NOT NULL,
	[_IsDeleted] [bit] NOT NULL,
	[_RowVersion] [timestamp] NOT NULL,
	[_WorkspaceId] [int] NOT NULL,
	[ValidFrom] [datetime2](7) GENERATED ALWAYS AS ROW START NOT NULL,
	[ValidTo] [datetime2](7) GENERATED ALWAYS AS ROW END NOT NULL,
 CONSTRAINT [pk_metadata_ChildConfiguration1] PRIMARY KEY CLUSTERED 
(
	[ObjectId] ASC,
	[VersionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([ValidFrom], [ValidTo])
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [metadata].[ChildConfiguration1History] )
)
GO
