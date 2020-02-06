CREATE TRIGGER [dbo].[dbo_Categories_ApexSQLAudit_Update]
	ON [dbo].[Categories]
	AFTER
		UPDATE
AS
	EXTERNAL NAME [ApexSQL.Audit.BeforeAfter.dbo.Categories.Update].[ApexSQL.Audit.BeforeAfterClr.BeforeAfterTrigger].[Update]
GO
