SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[StudentGrade] (
		[EnrollmentID]     [int] IDENTITY(1, 1) NOT NULL,
		[CourseID]         [int] NOT NULL,
		[StudentID]        [int] NOT NULL,
		[Grade]            [decimal](3, 2) NULL
)
GO
ALTER TABLE [dbo].[StudentGrade]
	ADD
	CONSTRAINT [PK_StudentGrade]
	PRIMARY KEY
	CLUSTERED
	([EnrollmentID])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[StudentGrade]
	WITH CHECK
	ADD CONSTRAINT [FK_StudentGrade_Course]
	FOREIGN KEY ([CourseID]) REFERENCES [dbo].[Course] ([CourseID])
ALTER TABLE [dbo].[StudentGrade]
	CHECK CONSTRAINT [FK_StudentGrade_Course]

GO
ALTER TABLE [dbo].[StudentGrade]
	WITH CHECK
	ADD CONSTRAINT [FK_StudentGrade_Student]
	FOREIGN KEY ([StudentID]) REFERENCES [dbo].[Person] ([PersonID])
ALTER TABLE [dbo].[StudentGrade]
	CHECK CONSTRAINT [FK_StudentGrade_Student]

GO
ALTER TABLE [dbo].[StudentGrade] SET (LOCK_ESCALATION = TABLE)
GO
