SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CustomerCustomerDemo] (
		[CustomerID]         [nchar](5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CustomerTypeID]     [nchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
ALTER TABLE [dbo].[CustomerCustomerDemo]
	ADD
	CONSTRAINT [PK_CustomerCustomerDemo]
	PRIMARY KEY
	NONCLUSTERED
	([CustomerID], [CustomerTypeID])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[CustomerCustomerDemo]
	WITH CHECK
	ADD CONSTRAINT [FK_CustomerCustomerDemo]
	FOREIGN KEY ([CustomerTypeID]) REFERENCES [dbo].[CustomerDemographics] ([CustomerTypeID])
ALTER TABLE [dbo].[CustomerCustomerDemo]
	CHECK CONSTRAINT [FK_CustomerCustomerDemo]

GO
ALTER TABLE [dbo].[CustomerCustomerDemo]
	WITH CHECK
	ADD CONSTRAINT [FK_CustomerCustomerDemo_Customers]
	FOREIGN KEY ([CustomerID]) REFERENCES [dbo].[Customers] ([CustomerID])
ALTER TABLE [dbo].[CustomerCustomerDemo]
	CHECK CONSTRAINT [FK_CustomerCustomerDemo_Customers]

GO
ALTER TABLE [dbo].[CustomerCustomerDemo] SET (LOCK_ESCALATION = TABLE)
GO
