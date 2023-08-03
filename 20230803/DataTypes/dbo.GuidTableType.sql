CREATE TYPE [dbo].[GuidTableType]
AS TABLE (
		[GUID]     [uniqueidentifier] NOT NULL
)
GO
GRANT EXECUTE
	ON TYPE::[dbo].[GuidTableType]
	TO [portalapp_role]
GO
