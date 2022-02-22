CREATE TRIGGER [dbo].[dbo_discounts_ApexSQLAudit_Delete]
	ON [dbo].[discounts]
	AFTER
		DELETE
AS
	EXTERNAL NAME [ApexSQL.Audit.BeforeAfter.pubs.dbo.discounts.Delete].[ApexSQL.Audit.BeforeAfterClr.BeforeAfterTrigger].[Delete]
GO
