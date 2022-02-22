CREATE TRIGGER [dbo].[dbo_discounts_ApexSQLAudit_Insert]
	ON [dbo].[discounts]
	AFTER
		INSERT
AS
	EXTERNAL NAME [ApexSQL.Audit.BeforeAfter.pubs.dbo.discounts.Insert].[ApexSQL.Audit.BeforeAfterClr.BeforeAfterTrigger].[Insert]
GO
