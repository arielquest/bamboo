CREATE TRIGGER [dbo].[dbo_discounts_ApexSQLAudit_Update]
	ON [dbo].[discounts]
	AFTER
		UPDATE
AS
	EXTERNAL NAME [ApexSQL.Audit.BeforeAfter.pubs.dbo.discounts.Update].[ApexSQL.Audit.BeforeAfterClr.BeforeAfterTrigger].[Update]
GO
