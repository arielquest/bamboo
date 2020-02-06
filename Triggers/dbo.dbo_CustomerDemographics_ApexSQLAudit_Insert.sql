CREATE TRIGGER [dbo].[dbo_CustomerDemographics_ApexSQLAudit_Insert]
	ON [dbo].[CustomerDemographics]
	AFTER
		INSERT
AS
	EXTERNAL NAME [ApexSQL.Audit.BeforeAfter.dbo.CustomerDemographics.Insert].[ApexSQL.Audit.BeforeAfterClr.BeforeAfterTrigger].[Insert]
GO
