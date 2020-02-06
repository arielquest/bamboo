CREATE TRIGGER [dbo].[dbo_CustomerDemographics_ApexSQLAudit_Delete]
	ON [dbo].[CustomerDemographics]
	AFTER
		DELETE
AS
	EXTERNAL NAME [ApexSQL.Audit.BeforeAfter.dbo.CustomerDemographics.Delete].[ApexSQL.Audit.BeforeAfterClr.BeforeAfterTrigger].[Delete]
GO
