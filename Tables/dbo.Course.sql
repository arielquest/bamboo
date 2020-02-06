SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Course] (
		[CourseID]         [int] NOT NULL,
		[Title]            [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Credits]          [int] NOT NULL,
		[DepartmentID]     [int] NOT NULL
)
GO
ALTER TABLE [dbo].[Course]
	ADD
	CONSTRAINT [PK_School.Course]
	PRIMARY KEY
	CLUSTERED
	([CourseID])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[Course]
	WITH CHECK
	ADD CONSTRAINT [FK_Course_Department]
	FOREIGN KEY ([DepartmentID]) REFERENCES [dbo].[Department] ([DepartmentID])
ALTER TABLE [dbo].[Course]
	CHECK CONSTRAINT [FK_Course_Department]

GO
ALTER TABLE [dbo].[Course] SET (LOCK_ESCALATION = TABLE)
GO
