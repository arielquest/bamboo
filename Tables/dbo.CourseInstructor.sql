SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[CourseInstructor] (
		[CourseID]     [int] NOT NULL,
		[PersonID]     [int] NOT NULL
)
GO
ALTER TABLE [dbo].[CourseInstructor]
	ADD
	CONSTRAINT [PK_CourseInstructor]
	PRIMARY KEY
	CLUSTERED
	([CourseID], [PersonID])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[CourseInstructor]
	WITH CHECK
	ADD CONSTRAINT [FK_CourseInstructor_Course]
	FOREIGN KEY ([CourseID]) REFERENCES [dbo].[Course] ([CourseID])
ALTER TABLE [dbo].[CourseInstructor]
	CHECK CONSTRAINT [FK_CourseInstructor_Course]

GO
ALTER TABLE [dbo].[CourseInstructor]
	WITH CHECK
	ADD CONSTRAINT [FK_CourseInstructor_Person]
	FOREIGN KEY ([PersonID]) REFERENCES [dbo].[Person] ([PersonID])
ALTER TABLE [dbo].[CourseInstructor]
	CHECK CONSTRAINT [FK_CourseInstructor_Person]

GO
ALTER TABLE [dbo].[CourseInstructor] SET (LOCK_ESCALATION = TABLE)
GO
