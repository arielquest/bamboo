SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Test001] as

--CIS VALUE SETS
               declare @CISCodes table (
               [Code]                                                Varchar(50),
               [Value Set Name]             Varchar(100),
               [Code System]                   Varchar(100),
                              INDEX IX_TempCISCodes_ValueSetName ([Value Set Name], [Code])
               )
GO
