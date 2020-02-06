CREATE TRIGGER [dbo].[dbo_CustomerCustomerDemo_ApexSQLAudit_Insert]
	ON [dbo].[CustomerCustomerDemo]
	AFTER
		INSERT
AS
	EXTERNAL NAME [ApexSQL.Audit.BeforeAfter.dbo.CustomerCustomerDemo.Insert].[ApexSQL.Audit.BeforeAfterClr.BeforeAfterTrigger].[Insert]
GO
