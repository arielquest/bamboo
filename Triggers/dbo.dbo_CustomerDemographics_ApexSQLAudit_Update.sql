CREATE TRIGGER [dbo].[dbo_CustomerDemographics_ApexSQLAudit_Update]
	ON [dbo].[CustomerDemographics]
	AFTER
		UPDATE
AS
	EXTERNAL NAME [ApexSQL.Audit.BeforeAfter.dbo.CustomerDemographics.Update].[ApexSQL.Audit.BeforeAfterClr.BeforeAfterTrigger].[Update]
GO
