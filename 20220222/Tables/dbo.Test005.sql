SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Test005] (
		[FirstName]     [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[LastName]      [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Test005] SET (LOCK_ESCALATION = TABLE)
GO
