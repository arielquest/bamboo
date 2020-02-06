SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CustomerDemographics] (
		[CustomerTypeID]     [nchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CustomerDesc]       [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [dbo].[CustomerDemographics]
	ADD
	CONSTRAINT [PK_CustomerDemographics]
	PRIMARY KEY
	NONCLUSTERED
	([CustomerTypeID])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[CustomerDemographics] SET (LOCK_ESCALATION = TABLE)
GO
