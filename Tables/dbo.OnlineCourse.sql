SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[OnlineCourse] (
		[CourseID]     [int] NOT NULL,
		[URL]          [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
ALTER TABLE [dbo].[OnlineCourse]
	ADD
	CONSTRAINT [PK_OnlineCourse]
	PRIMARY KEY
	CLUSTERED
	([CourseID])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[OnlineCourse]
	WITH CHECK
	ADD CONSTRAINT [FK_OnlineCourse_Course]
	FOREIGN KEY ([CourseID]) REFERENCES [dbo].[Course] ([CourseID])
ALTER TABLE [dbo].[OnlineCourse]
	CHECK CONSTRAINT [FK_OnlineCourse_Course]

GO
ALTER TABLE [dbo].[OnlineCourse] SET (LOCK_ESCALATION = TABLE)
GO
