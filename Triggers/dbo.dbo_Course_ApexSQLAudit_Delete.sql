CREATE TRIGGER [dbo].[dbo_Course_ApexSQLAudit_Delete]
	ON [dbo].[Course]
	AFTER
		DELETE
AS
	EXTERNAL NAME [ApexSQL.Audit.BeforeAfter.dbo.Course.Delete].[ApexSQL.Audit.BeforeAfterClr.BeforeAfterTrigger].[Delete]
GO
