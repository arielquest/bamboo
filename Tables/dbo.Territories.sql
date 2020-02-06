SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Territories] (
		[TerritoryID]              [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[TerritoryDescription]     [nchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[RegionID]                 [int] NOT NULL
)
GO
ALTER TABLE [dbo].[Territories]
	ADD
	CONSTRAINT [PK_Territories]
	PRIMARY KEY
	NONCLUSTERED
	([TerritoryID])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[Territories]
	WITH CHECK
	ADD CONSTRAINT [FK_Territories_Region]
	FOREIGN KEY ([RegionID]) REFERENCES [dbo].[Region] ([RegionID])
ALTER TABLE [dbo].[Territories]
	CHECK CONSTRAINT [FK_Territories_Region]

GO
ALTER TABLE [dbo].[Territories] SET (LOCK_ESCALATION = TABLE)
GO
