CREATE TRIGGER [dbo].[dbo_Products_ApexSQLAudit_Update]
	ON [dbo].[Products]
	AFTER
		UPDATE
AS
	EXTERNAL NAME [ApexSQL.Audit.BeforeAfter.dbo.Products.Update].[ApexSQL.Audit.BeforeAfterClr.BeforeAfterTrigger].[Update]
GO
