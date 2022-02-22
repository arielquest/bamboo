CREATE TRIGGER [dbo].[dbo_jobs_ApexSQLAudit_Update]
	ON [dbo].[jobs]
	AFTER
		UPDATE
AS
	EXTERNAL NAME [ApexSQL.Audit.BeforeAfter.pubs.dbo.jobs.Update].[ApexSQL.Audit.BeforeAfterClr.BeforeAfterTrigger].[Update]
GO
