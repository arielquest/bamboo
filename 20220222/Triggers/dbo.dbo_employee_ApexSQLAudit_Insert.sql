CREATE TRIGGER [dbo].[dbo_employee_ApexSQLAudit_Insert]
	ON [dbo].[employee]
	AFTER
		INSERT
AS
	EXTERNAL NAME [ApexSQL.Audit.BeforeAfter.pubs.dbo.employee.Insert].[ApexSQL.Audit.BeforeAfterClr.BeforeAfterTrigger].[Insert]
GO
