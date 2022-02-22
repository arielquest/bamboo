CREATE TRIGGER [dbo].[dbo_jobs_ApexSQLAudit_Insert]
	ON [dbo].[jobs]
	AFTER
		INSERT
AS
	EXTERNAL NAME [ApexSQL.Audit.BeforeAfter.pubs.dbo.jobs.Insert].[ApexSQL.Audit.BeforeAfterClr.BeforeAfterTrigger].[Insert]
GO
