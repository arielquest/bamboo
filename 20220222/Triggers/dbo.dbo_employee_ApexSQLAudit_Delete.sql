CREATE TRIGGER [dbo].[dbo_employee_ApexSQLAudit_Delete]
	ON [dbo].[employee]
	AFTER
		DELETE
AS
	EXTERNAL NAME [ApexSQL.Audit.BeforeAfter.pubs.dbo.employee.Delete].[ApexSQL.Audit.BeforeAfterClr.BeforeAfterTrigger].[Delete]
GO
