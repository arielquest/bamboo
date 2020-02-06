SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Person] (
		[PersonID]           [int] IDENTITY(1, 1) NOT NULL,
		[LastName]           [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[FirstName]          [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[HireDate]           [datetime] NULL,
		[EnrollmentDate]     [datetime] NULL,
		[Discriminator]      [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
ALTER TABLE [dbo].[Person]
	ADD
	CONSTRAINT [PK_School.Student]
	PRIMARY KEY
	CLUSTERED
	([PersonID])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[Person] SET (LOCK_ESCALATION = TABLE)
GO
