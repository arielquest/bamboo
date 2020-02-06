CREATE TRIGGER [dbo].[dbo_Customers_ApexSQLAudit_Insert]
	ON [dbo].[Customers]
	AFTER
		INSERT
AS
	EXTERNAL NAME [ApexSQL.Audit.BeforeAfter.dbo.Customers.Insert].[ApexSQL.Audit.BeforeAfterClr.BeforeAfterTrigger].[Insert]
GO
