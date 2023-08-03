SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[tr_sec_group_member_deleted] ON [dbo].[TB_SEC_GROUP_MEMBER]
FOR DELETE
NOT FOR REPLICATION
AS
    SET NOCOUNT ON;

    DECLARE @error INT;
    
    EXEC @error = [dbo].[ap_sec_delete_calc_group_members] 'Trigger';
    
    IF @error <> 0
        ROLLBACK TRANSACTION;
GO
