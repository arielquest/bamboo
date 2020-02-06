SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Shippers] (
		[ShipperID]       [int] IDENTITY(1, 1) NOT NULL,
		[CompanyName]     [nvarchar](40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Phone]           [nvarchar](24) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [dbo].[Shippers]
	ADD
	CONSTRAINT [PK_Shippers]
	PRIMARY KEY
	CLUSTERED
	([ShipperID])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[Shippers] SET (LOCK_ESCALATION = TABLE)
GO
