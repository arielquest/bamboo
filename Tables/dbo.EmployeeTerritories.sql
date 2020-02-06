SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EmployeeTerritories] (
		[EmployeeID]      [int] NOT NULL,
		[TerritoryID]     [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
ALTER TABLE [dbo].[EmployeeTerritories]
	ADD
	CONSTRAINT [PK_EmployeeTerritories]
	PRIMARY KEY
	NONCLUSTERED
	([EmployeeID], [TerritoryID])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[EmployeeTerritories]
	WITH CHECK
	ADD CONSTRAINT [FK_EmployeeTerritories_Employees]
	FOREIGN KEY ([EmployeeID]) REFERENCES [dbo].[Employees] ([EmployeeID])
ALTER TABLE [dbo].[EmployeeTerritories]
	CHECK CONSTRAINT [FK_EmployeeTerritories_Employees]

GO
ALTER TABLE [dbo].[EmployeeTerritories]
	WITH CHECK
	ADD CONSTRAINT [FK_EmployeeTerritories_Territories]
	FOREIGN KEY ([TerritoryID]) REFERENCES [dbo].[Territories] ([TerritoryID])
ALTER TABLE [dbo].[EmployeeTerritories]
	CHECK CONSTRAINT [FK_EmployeeTerritories_Territories]

GO
ALTER TABLE [dbo].[EmployeeTerritories] SET (LOCK_ESCALATION = TABLE)
GO
