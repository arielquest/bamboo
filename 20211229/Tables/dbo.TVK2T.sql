SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TVK2T] (
		[CodEmpresa]           [int] NOT NULL,
		[MANDT]                [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[SPRAS]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[KATR2]                [nvarchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[VTEXT]                [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[create_timestamp]     [datetime] NULL,
		CONSTRAINT [PK_TVK2T]
		PRIMARY KEY
		CLUSTERED
		([MANDT], [SPRAS], [KATR2])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TVK2T] SET (LOCK_ESCALATION = TABLE)
GO
