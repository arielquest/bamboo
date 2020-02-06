CREATE TRIGGER [dbo].[dbo_CustomerCustomerDemo_ApexSQLAudit_Delete]
	ON [dbo].[CustomerCustomerDemo]
	AFTER
		DELETE
AS
	EXTERNAL NAME [ApexSQL.Audit.BeforeAfter.dbo.CustomerCustomerDemo.Delete].[ApexSQL.Audit.BeforeAfterClr.BeforeAfterTrigger].[Delete]
GO
