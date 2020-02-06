CREATE TRIGGER [dbo].[dbo_Categories_ApexSQLAudit_Delete]
	ON [dbo].[Categories]
	AFTER
		DELETE
AS
	EXTERNAL NAME [ApexSQL.Audit.BeforeAfter.dbo.Categories.Delete].[ApexSQL.Audit.BeforeAfterClr.BeforeAfterTrigger].[Delete]
GO
