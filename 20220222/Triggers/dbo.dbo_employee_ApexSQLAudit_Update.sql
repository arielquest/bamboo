CREATE TRIGGER [dbo].[dbo_employee_ApexSQLAudit_Update]
	ON [dbo].[employee]
	AFTER
		UPDATE
AS
	EXTERNAL NAME [ApexSQL.Audit.BeforeAfter.pubs.dbo.employee.Update].[ApexSQL.Audit.BeforeAfterClr.BeforeAfterTrigger].[Update]
GO
