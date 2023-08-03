SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------
-- Called at the end of the copy user process within the same transaction.
-------------------------------------------------------------------------------
CREATE PROCEDURE [dbo].[ap_sec01_on_copy_user]
(
    @SourceUserId     uniqueidentifier,     -- The user id of the user being copied
    @NewUserId         uniqueidentifier     -- The user id of the new copy
) AS
BEGIN 
    SET NOCOUNT ON;
  
    -- **ADD CUSTOM USER COPY LOGIC HERE**
END;
GO
GRANT EXECUTE
	ON [dbo].[ap_sec01_on_copy_user]
	TO [portalapp_role]
GO
