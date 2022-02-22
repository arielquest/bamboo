CREATE TRIGGER [dbo].[dbo_authors_ApexSQLAudit_Insert]
	ON [dbo].[authors]
	AFTER
		INSERT
AS
	EXTERNAL NAME [ApexSQL.Audit.BeforeAfter.pubs.dbo.authors.Insert].[ApexSQL.Audit.BeforeAfterClr.BeforeAfterTrigger].[Insert]
GO
