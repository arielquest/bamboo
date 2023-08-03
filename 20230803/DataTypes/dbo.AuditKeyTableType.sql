CREATE TYPE [dbo].[AuditKeyTableType]
AS TABLE (
		[INTEGER_1]     [int] NULL,
		[INTEGER_2]     [int] NULL,
		[INTEGER_3]     [int] NULL,
		[INTEGER_4]     [int] NULL,
		[GUID_1]        [uniqueidentifier] NULL,
		[GUID_2]        [uniqueidentifier] NULL
)
GO
GRANT EXECUTE
	ON TYPE::[dbo].[AuditKeyTableType]
	TO [portalapp_role]
GO
