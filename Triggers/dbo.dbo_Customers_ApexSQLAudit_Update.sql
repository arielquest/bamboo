CREATE TRIGGER [dbo].[dbo_Customers_ApexSQLAudit_Update]
	ON [dbo].[Customers]
	AFTER
		UPDATE
AS
	EXTERNAL NAME [ApexSQL.Audit.BeforeAfter.dbo.Customers.Update].[ApexSQL.Audit.BeforeAfterClr.BeforeAfterTrigger].[Update]
GO
