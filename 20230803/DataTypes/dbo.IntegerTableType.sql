CREATE TYPE [dbo].[IntegerTableType]
AS TABLE (
		[INTEGER_1]     [int] NOT NULL
)
GO
GRANT EXECUTE
	ON TYPE::[dbo].[IntegerTableType]
	TO [portalapp_role]
GO
