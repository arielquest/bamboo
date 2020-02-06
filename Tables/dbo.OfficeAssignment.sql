SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[OfficeAssignment] (
		[InstructorID]     [int] NOT NULL,
		[Location]         [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[Timestamp]        [timestamp] NOT NULL
)
GO
ALTER TABLE [dbo].[OfficeAssignment]
	ADD
	CONSTRAINT [PK_OfficeAssignment]
	PRIMARY KEY
	CLUSTERED
	([InstructorID])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[OfficeAssignment]
	WITH CHECK
	ADD CONSTRAINT [FK_OfficeAssignment_Person]
	FOREIGN KEY ([InstructorID]) REFERENCES [dbo].[Person] ([PersonID])
ALTER TABLE [dbo].[OfficeAssignment]
	CHECK CONSTRAINT [FK_OfficeAssignment_Person]

GO
ALTER TABLE [dbo].[OfficeAssignment] SET (LOCK_ESCALATION = TABLE)
GO
