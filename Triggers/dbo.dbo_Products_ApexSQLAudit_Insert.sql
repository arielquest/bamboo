CREATE TRIGGER [dbo].[dbo_Products_ApexSQLAudit_Insert]
	ON [dbo].[Products]
	AFTER
		INSERT
AS
	EXTERNAL NAME [ApexSQL.Audit.BeforeAfter.dbo.Products.Insert].[ApexSQL.Audit.BeforeAfterClr.BeforeAfterTrigger].[Insert]
GO
