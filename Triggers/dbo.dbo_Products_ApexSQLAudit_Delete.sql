CREATE TRIGGER [dbo].[dbo_Products_ApexSQLAudit_Delete]
	ON [dbo].[Products]
	AFTER
		DELETE
AS
	EXTERNAL NAME [ApexSQL.Audit.BeforeAfter.dbo.Products.Delete].[ApexSQL.Audit.BeforeAfterClr.BeforeAfterTrigger].[Delete]
GO
