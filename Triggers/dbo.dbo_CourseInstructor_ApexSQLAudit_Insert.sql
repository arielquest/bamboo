CREATE TRIGGER [dbo].[dbo_CourseInstructor_ApexSQLAudit_Insert]
	ON [dbo].[CourseInstructor]
	AFTER
		INSERT
AS
	EXTERNAL NAME [ApexSQL.Audit.BeforeAfter.dbo.CourseInstructor.Insert].[ApexSQL.Audit.BeforeAfterClr.BeforeAfterTrigger].[Insert]
GO
