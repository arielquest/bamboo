CREATE TRIGGER [dbo].[dbo_authors_ApexSQLAudit_Update]
	ON [dbo].[authors]
	AFTER
		UPDATE
AS
	EXTERNAL NAME [ApexSQL.Audit.BeforeAfter.pubs.dbo.authors.Update].[ApexSQL.Audit.BeforeAfterClr.BeforeAfterTrigger].[Update]
GO
