SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[OnsiteCourse] (
		[CourseID]     [int] NOT NULL,
		[Location]     [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Days]         [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Time]         [smalldatetime] NOT NULL
)
GO
ALTER TABLE [dbo].[OnsiteCourse]
	ADD
	CONSTRAINT [PK_OnsiteCourse]
	PRIMARY KEY
	CLUSTERED
	([CourseID])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[OnsiteCourse]
	WITH CHECK
	ADD CONSTRAINT [FK_OnsiteCourse_Course]
	FOREIGN KEY ([CourseID]) REFERENCES [dbo].[Course] ([CourseID])
ALTER TABLE [dbo].[OnsiteCourse]
	CHECK CONSTRAINT [FK_OnsiteCourse_Course]

GO
ALTER TABLE [dbo].[OnsiteCourse] SET (LOCK_ESCALATION = TABLE)
GO
