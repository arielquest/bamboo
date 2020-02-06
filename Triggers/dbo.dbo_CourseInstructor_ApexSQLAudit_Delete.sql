CREATE TRIGGER [dbo].[dbo_CourseInstructor_ApexSQLAudit_Delete]
	ON [dbo].[CourseInstructor]
	AFTER
		DELETE
AS
	EXTERNAL NAME [ApexSQL.Audit.BeforeAfter.dbo.CourseInstructor.Delete].[ApexSQL.Audit.BeforeAfterClr.BeforeAfterTrigger].[Delete]
GO
