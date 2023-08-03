SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_sec_delete_calc_group_members]
    (
      @AuditUser NVARCHAR(50) = ''
    )
AS
    BEGIN 
        SET NOCOUNT ON;

        DECLARE @error INT,
            @rowcount INT;

        SET @error = 0;
        SET @rowcount = 1;

        WHILE @error = 0
            AND @rowcount > 0
        BEGIN 
            DELETE  [mem]
            FROM    [dbo].[TB_SEC_GROUP_MEMBER] [mem]
            WHERE   [mem].[MEMBER_ID] IN ( SELECT   [c1].[MEMBER_ID]
                                           FROM     [dbo].[TB_SEC_GROUP_MEMBER] [cm]
                                           INNER JOIN ( SELECT  [MEMBER_ID],
                                                                [PARENT_ID],
                                                                [CALCULATED_PARENT_ID],
                                                                [CHILD_ID]
                                                        FROM    [dbo].[TB_SEC_GROUP_MEMBER]
                                                        WHERE   [CALCULATED] = 1
                                                      ) [c1] ON [cm].[CHILD_ID] = [c1].[CHILD_ID]
                                                                AND [cm].[PARENT_ID] = [c1].[CALCULATED_PARENT_ID]
                                           WHERE    NOT EXISTS ( SELECT 1
                                                                 FROM   [dbo].[TB_SEC_GROUP_MEMBER] [s]
                                                                 WHERE  [s].[PARENT_ID] = [c1].[PARENT_ID]
                                                                        AND [s].[CHILD_ID] = [cm].[PARENT_ID] )
                                           UNION
                                           SELECT   [c2].[MEMBER_ID]
                                           FROM     [dbo].[TB_SEC_GROUP_MEMBER] [pm]
                                           INNER JOIN ( SELECT  [MEMBER_ID],
                                                                [PARENT_ID],
                                                                [CHILD_ID],
                                                                [CALCULATED_PARENT_ID]
                                                        FROM    [dbo].[TB_SEC_GROUP_MEMBER]
                                                        WHERE   [CALCULATED] = 1
                                                      ) [c2] ON [pm].[PARENT_ID] = [c2].[PARENT_ID]
                                                                AND [pm].[CHILD_ID] = [c2].[CALCULATED_PARENT_ID]
                                           WHERE    NOT EXISTS ( SELECT 1
                                                                 FROM   [dbo].[TB_SEC_GROUP_MEMBER] [s]
                                                                 WHERE  [s].[PARENT_ID] = [pm].[CHILD_ID]
                                                                        AND [s].[CHILD_ID] = [c2].[CHILD_ID] ) );

            SELECT  @error = @@ERROR,
                    @rowcount = @@ROWCOUNT;

            IF @error <> 0
            BEGIN 
                RAISERROR (50101, 16, 5, @error, 'ap_sec_delete_calc_group_members', @AuditUser);
            END;
        END;

        RETURN @error;
    END;
GO
