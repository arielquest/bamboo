CREATE TRIGGER [dbo].[dbo_Customers_ApexSQLAudit_Delete]
	ON [dbo].[Customers]
	AFTER
		DELETE
AS
	EXTERNAL NAME [ApexSQL.Audit.BeforeAfter.dbo.Customers.Delete].[ApexSQL.Audit.BeforeAfterClr.BeforeAfterTrigger].[Delete]
GO
