CREATE TRIGGER [dbo].[dbo_jobs_ApexSQLAudit_Delete]
	ON [dbo].[jobs]
	AFTER
		DELETE
AS
	EXTERNAL NAME [ApexSQL.Audit.BeforeAfter.pubs.dbo.jobs.Delete].[ApexSQL.Audit.BeforeAfterClr.BeforeAfterTrigger].[Delete]
GO
