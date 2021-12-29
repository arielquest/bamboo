SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[T134T] (
		[CodEmpresa]           [int] NOT NULL,
		[MANDT]                [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[SPRAS]                [nvarchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[MTART]                [nvarchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[MTBEZ]                [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[create_timestamp]     [datetime] NULL,
		CONSTRAINT [PK_T134T]
		PRIMARY KEY
		CLUSTERED
		([MANDT], [SPRAS], [MTART])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[T134T] SET (LOCK_ESCALATION = TABLE)
GO
