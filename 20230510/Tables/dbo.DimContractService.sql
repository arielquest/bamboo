SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DimContractService] (
		[Id]                                        [int] IDENTITY(1, 1) NOT NULL,
		[ContractServiceSourceId]                   [int] NOT NULL,
		[EntitySourceId]                            [int] NOT NULL,
		[Entity]                                    [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[AgencySourceId]                            [int] NULL,
		[Agency]                                    [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[BranchSourceId]                            [int] NULL,
		[Branch]                                    [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DepartmentSourceId]                        [int] NULL,
		[Department]                                [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ProfitCenterSourceId]                      [int] NULL,
		[ProfitCenter]                              [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ServicingCode]                             [nchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ServicingCodeDescription]                  [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ServiceNumber]                             [int] NULL,
		[ContractNumber]                            [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Description]                               [nvarchar](125) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Term]                                      [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ServiceType]                               [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ContractedFee]                             [numeric](19, 4) NULL,
		[ContractedHours]                           [numeric](7, 2) NULL,
		[HoursWorked]                               [numeric](7, 2) NULL,
		[HoursRemaining]                            [numeric](7, 2) NULL,
		[ServiceTotal]                              [numeric](19, 4) NULL,
		[ServicingAccountManagerEntitySourceId]     [int] NULL,
		[ServicingAccountManagerLookupCode]         [nchar](6) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ServicingAccountManager]                   [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[InceptionDate]                             [datetime] NULL,
		[ExpirationDate]                            [datetime] NULL,
		[SourceInsertDate]                          [datetime] NOT NULL,
		[SourceUpdateDate]                          [datetime] NULL,
		[InsertDate]                                [datetime] NOT NULL,
		[UpdateDate]                                [datetime] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DimContractService] SET (LOCK_ESCALATION = TABLE)
GO
