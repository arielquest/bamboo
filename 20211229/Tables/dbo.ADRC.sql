SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ADRC] (
		[CodEmpresa]           [int] NOT NULL,
		[CLIENT]               [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ADDRNUMBER]           [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DATE_FROM]            [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[NATION]               [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DATE_TO]              [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[TITLE]                [nvarchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[NAME1]                [nvarchar](40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[NAME2]                [nvarchar](40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[NAME3]                [nvarchar](40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[NAME4]                [nvarchar](40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[NAME_TEXT]            [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[NAME_CO]              [nvarchar](40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CITY1]                [nvarchar](40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CITY2]                [nvarchar](40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CITY_CODE]            [nvarchar](12) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CITYP_CODE]           [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[HOME_CITY]            [nvarchar](40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CITYH_CODE]           [nvarchar](12) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CHCKSTATUS]           [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[REGIOGROUP]           [nvarchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[POST_CODE1]           [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[POST_CODE2]           [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[POST_CODE3]           [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PCODE1_EXT]           [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PCODE2_EXT]           [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PCODE3_EXT]           [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PO_BOX]               [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DONT_USE_P]           [nvarchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PO_BOX_NUM]           [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PO_BOX_LOC]           [nvarchar](40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CITY_CODE2]           [nvarchar](12) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PO_BOX_REG]           [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PO_BOX_CTY]           [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[POSTALAREA]           [nvarchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[TRANSPZONE]           [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[STREET]               [nvarchar](60) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DONT_USE_S]           [nvarchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[STREETCODE]           [nvarchar](12) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[STREETABBR]           [nvarchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[HOUSE_NUM1]           [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[HOUSE_NUM2]           [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[HOUSE_NUM3]           [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[STR_SUPPL1]           [nvarchar](40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[STR_SUPPL2]           [nvarchar](40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[STR_SUPPL3]           [nvarchar](40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[LOCATION]             [nvarchar](40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[BUILDING]             [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[FLOOR]                [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ROOMNUMBER]           [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[COUNTRY]              [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[LANGU]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[REGION]               [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ADDR_GROUP]           [nvarchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[FLAGGROUPS]           [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PERS_ADDR]            [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[SORT1]                [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[SORT2]                [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[SORT_PHN]             [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DEFLT_COMM]           [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[TEL_NUMBER]           [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[TEL_EXTENS]           [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[FAX_NUMBER]           [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[FAX_EXTENS]           [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[FLAGCOMM2]            [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[FLAGCOMM3]            [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[FLAGCOMM4]            [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[FLAGCOMM5]            [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[FLAGCOMM6]            [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[FLAGCOMM7]            [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[FLAGCOMM8]            [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[FLAGCOMM9]            [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[FLAGCOMM10]           [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[FLAGCOMM11]           [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[FLAGCOMM12]           [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[FLAGCOMM13]           [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ADDRORIGIN]           [nvarchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[MC_NAME1]             [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[MC_CITY1]             [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[MC_STREET]            [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[EXTENSION1]           [nvarchar](40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[EXTENSION2]           [nvarchar](40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[TIME_ZONE]            [nvarchar](6) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[TAXJURCODE]           [nvarchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ADDRESS_ID]           [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[LANGU_CREA]           [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[PO_BOX_LOBBY]         [nvarchar](40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DELI_SERV_TYPE]       [nvarchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[DELI_SERV_NUMBER]     [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[create_timestamp]     [datetime] NULL,
		CONSTRAINT [PK_ADRC]
		PRIMARY KEY
		CLUSTERED
		([CLIENT], [ADDRNUMBER], [DATE_FROM], [NATION])
	ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [_dta_index_ADRC_7_642101328__K3_K2]
	ON [dbo].[ADRC] ([ADDRNUMBER], [CLIENT])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[ADRC] SET (LOCK_ESCALATION = TABLE)
GO
