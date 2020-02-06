CREATE TRIGGER [dbo].[dbo_Course_ApexSQLAudit_Insert]
	ON [dbo].[Course]
	AFTER
		INSERT
AS
	EXTERNAL NAME [ApexSQL.Audit.BeforeAfter.dbo.Course.Insert].[ApexSQL.Audit.BeforeAfterClr.BeforeAfterTrigger].[Insert]
GO
