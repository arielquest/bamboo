CREATE TRIGGER [dbo].[dbo_CustomerCustomerDemo_ApexSQLAudit_Update]
	ON [dbo].[CustomerCustomerDemo]
	AFTER
		UPDATE
AS
	EXTERNAL NAME [ApexSQL.Audit.BeforeAfter.dbo.CustomerCustomerDemo.Update].[ApexSQL.Audit.BeforeAfterClr.BeforeAfterTrigger].[Update]
GO
