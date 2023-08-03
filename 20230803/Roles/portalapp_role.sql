CREATE ROLE [portalapp_role] AUTHORIZATION [dbo]
GO

ALTER ROLE [portalapp_role] ADD MEMBER [EADEVUSSUHV0147\portal_user]

GO
ALTER ROLE [portalapp_role] ADD MEMBER [NT Service\MSSQLServerOLAPService]

GO
ALTER ROLE [portalapp_role] ADD MEMBER [portal_default_mediator_role]

GO
ALTER ROLE [portalapp_role] ADD MEMBER [portal_default_partitioning_role]

GO
