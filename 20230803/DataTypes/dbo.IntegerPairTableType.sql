CREATE TYPE [dbo].[IntegerPairTableType]
AS TABLE (
		[INTEGER_1]     [int] NOT NULL,
		[INTEGER_2]     [int] NULL
)
GO
GRANT EXECUTE
	ON TYPE::[dbo].[IntegerPairTableType]
	TO [portalapp_role]
GO
