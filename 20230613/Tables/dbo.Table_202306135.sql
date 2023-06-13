SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Table_202306135] (
		[Id]        [int] IDENTITY(1, 1) NOT NULL,
		[Col1]      [nvarchar](50) COLLATE SQL_Latin1_General_CP850_BIN2 NULL,
		[Col2]      [nvarchar](50) COLLATE SQL_Latin1_General_CP850_BIN2 NULL,
		[Col3]      [nvarchar](50) COLLATE SQL_Latin1_General_CP850_BIN2 NULL,
		[Col4]      [nvarchar](50) COLLATE SQL_Latin1_General_CP850_BIN2 NULL,
		[Col5]      [nvarchar](50) COLLATE SQL_Latin1_General_CP850_BIN2 NULL,
		[Col6]      [nvarchar](50) COLLATE SQL_Latin1_General_CP850_BIN2 NULL,
		[Col7]      [nvarchar](50) COLLATE SQL_Latin1_General_CP850_BIN2 NULL,
		[Col8]      [nvarchar](50) COLLATE SQL_Latin1_General_CP850_BIN2 NULL,
		[Col9]      [nvarchar](50) COLLATE SQL_Latin1_General_CP850_BIN2 NULL,
		[Col10]     [nvarchar](50) COLLATE SQL_Latin1_General_CP850_BIN2 NULL,
		CONSTRAINT [PK__Table_20__3214EC0746384D48]
		PRIMARY KEY
		CLUSTERED
		([Id])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Table_202306135] SET (LOCK_ESCALATION = TABLE)
GO
