CREATE TRIGGER [dbo].[dbo_Course_ApexSQLAudit_Update]
	ON [dbo].[Course]
	AFTER
		UPDATE
AS
	EXTERNAL NAME [ApexSQL.Audit.BeforeAfter.dbo.Course.Update].[ApexSQL.Audit.BeforeAfterClr.BeforeAfterTrigger].[Update]
GO
