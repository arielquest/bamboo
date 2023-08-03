SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER tr_sec_group_member_inserted ON [dbo].[TB_SEC_GROUP_MEMBER]
FOR INSERT
NOT FOR REPLICATION
AS
    SET NOCOUNT ON;

    DECLARE @error INT;
    
    EXEC @error = [dbo].[ap_sec_calc_group_members] 'Trigger';
    
    IF @error <> 0
        ROLLBACK TRANSACTION;
GO
