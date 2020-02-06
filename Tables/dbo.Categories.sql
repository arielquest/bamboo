SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Categories] (
		[CategoryID]       [int] IDENTITY(1, 1) NOT NULL,
		[CategoryName]     [nvarchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Description]      [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Picture]          [image] NULL
)
GO
ALTER TABLE [dbo].[Categories]
	ADD
	CONSTRAINT [PK_Categories]
	PRIMARY KEY
	CLUSTERED
	([CategoryID])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [CategoryName]
	ON [dbo].[Categories] ([CategoryName])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[Categories] SET (LOCK_ESCALATION = TABLE)
GO
