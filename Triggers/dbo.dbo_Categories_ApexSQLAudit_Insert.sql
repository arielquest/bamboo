CREATE TRIGGER [dbo].[dbo_Categories_ApexSQLAudit_Insert]
	ON [dbo].[Categories]
	AFTER
		INSERT
AS
	EXTERNAL NAME [ApexSQL.Audit.BeforeAfter.dbo.Categories.Insert].[ApexSQL.Audit.BeforeAfterClr.BeforeAfterTrigger].[Insert]
GO
