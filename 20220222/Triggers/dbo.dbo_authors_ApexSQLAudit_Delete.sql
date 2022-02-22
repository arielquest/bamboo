CREATE TRIGGER [dbo].[dbo_authors_ApexSQLAudit_Delete]
	ON [dbo].[authors]
	AFTER
		DELETE
AS
	EXTERNAL NAME [ApexSQL.Audit.BeforeAfter.pubs.dbo.authors.Delete].[ApexSQL.Audit.BeforeAfterClr.BeforeAfterTrigger].[Delete]
GO
