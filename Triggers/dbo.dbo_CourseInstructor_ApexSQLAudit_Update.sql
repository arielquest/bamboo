CREATE TRIGGER [dbo].[dbo_CourseInstructor_ApexSQLAudit_Update]
	ON [dbo].[CourseInstructor]
	AFTER
		UPDATE
AS
	EXTERNAL NAME [ApexSQL.Audit.BeforeAfter.dbo.CourseInstructor.Update].[ApexSQL.Audit.BeforeAfterClr.BeforeAfterTrigger].[Update]
GO
