SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Department] (
		[DepartmentID]      [int] NOT NULL,
		[Name]              [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Budget]            [money] NOT NULL,
		[StartDate]         [datetime] NOT NULL,
		[Administrator]     [int] NULL
)
GO
ALTER TABLE [dbo].[Department]
	ADD
	CONSTRAINT [PK_Department]
	PRIMARY KEY
	CLUSTERED
	([DepartmentID])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[Department] SET (LOCK_ESCALATION = TABLE)
GO
