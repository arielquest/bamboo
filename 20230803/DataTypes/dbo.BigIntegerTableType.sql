CREATE TYPE [dbo].[BigIntegerTableType]
AS TABLE (
		[BIGINTEGER_1]     [bigint] NOT NULL
)
GO
GRANT EXECUTE
	ON TYPE::[dbo].[BigIntegerTableType]
	TO [portalapp_role]
GO
