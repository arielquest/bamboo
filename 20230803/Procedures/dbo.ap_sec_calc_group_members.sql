SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_sec_calc_group_members]
    (
      @AuditUser NVARCHAR(50) = ''
    )
AS
    BEGIN 
        SET NOCOUNT ON;

        DECLARE @rowcount INT;

        SET @rowcount = 1;

        BEGIN TRY;
            WHILE @rowcount > 0
            BEGIN 
                INSERT  INTO [dbo].[TB_SEC_GROUP_MEMBER]
                        ( [PARENT_ID],
                          [CHILD_ID],
                          [CALCULATED_PARENT_ID],
                          [CALCULATED]
                        )
                SELECT DISTINCT
                        [p].[USER_ID],
                        [c].[USER_ID],
                        [cm].[PARENT_ID],
                        1
                FROM    [dbo].[TB_SEC_GROUP_MEMBER] [pm]
                INNER JOIN [dbo].[TB_SEC_USER] [p] ON [p].[USER_ID] = [pm].[PARENT_ID]
                INNER JOIN [dbo].[TB_SEC_GROUP_MEMBER] [cm] ON [cm].[PARENT_ID] = [pm].[CHILD_ID]
                INNER JOIN [dbo].[TB_SEC_USER] [c] ON [c].[USER_ID] = [cm].[CHILD_ID]
                WHERE   NOT EXISTS ( SELECT 1
                                     FROM   [dbo].[TB_SEC_GROUP_MEMBER]
                                     WHERE  [PARENT_ID] = [p].[USER_ID]
                                            AND [CHILD_ID] = [c].[USER_ID]
                                            AND [CALCULATED_PARENT_ID] = [cm].[PARENT_ID] );

                SELECT  @rowcount = @@ROWCOUNT;
            END;
        END TRY
        BEGIN CATCH;
            IF @@ERROR = 547 --Check constraint violation
            BEGIN 
                RAISERROR (70029, 16, 5, @@ERROR, 'ap_sec_calc_group_members', @AuditUser);
            END;
            ELSE
            BEGIN  --Generic insertion error
                RAISERROR (50101, 16, 5, @@ERROR, 'ap_sec_calc_group_members', @AuditUser);
            END;
        END CATCH;

        RETURN @@ERROR;
    END;
GO
