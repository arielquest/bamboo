CREATE TYPE [dbo].[VarcharTableType]
AS TABLE (
		[VARCHAR_1]     [varchar](max) COLLATE Latin1_General_CI_AS NOT NULL
)
GO
GRANT EXECUTE
	ON TYPE::[dbo].[VarcharTableType]
	TO [portalapp_role]
GO
