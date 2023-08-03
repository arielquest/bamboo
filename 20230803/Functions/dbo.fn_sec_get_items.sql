SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_sec_get_items]
    (
      @AuditUser [NVARCHAR](50) ,
      @Path [NVARCHAR](450) ,
      @Operation [NVARCHAR](50)
    )
RETURNS @SecItems TABLE
    (
      [FOLDER_ID] [UNIQUEIDENTIFIER]
    )
--WITH ENCRYPTION
AS
    BEGIN 
    
        SET @AuditUser = LOWER(@AuditUser);
    -- The Administrator/System/Trigger user can do anything
        IF @AuditUser = 'administrator'
            OR @AuditUser = 'system'
            OR @AuditUser = 'trigger'
            BEGIN 
                INSERT  INTO @SecItems
                        SELECT  FOLDER_ID
                        FROM    dbo.TB_SEC_FOLDER
                        WHERE   TEMPLATE = 0
                                AND LEFT(PATH + '/',
                                         LEN(@Path + '/')) = @Path
                                + '/';

                RETURN;
            END;

        DECLARE @userid UNIQUEIDENTIFIER;
    
        SELECT  @userid = USER_ID
        FROM    dbo.TB_SEC_USER
        WHERE   LOWER(LOGIN_NAME) = @AuditUser;

        INSERT  INTO @SecItems
                SELECT DISTINCT
                        s.FOLDER_ID
                FROM    dbo.TE_SEC_OPERATION o
                        JOIN dbo.TE_SEC_TASK t ON t.TASK_ID = o.TASK_ID
                        JOIN dbo.TB_SEC_ROLE_MAPPING rm ON rm.TASK_ID = t.TASK_ID
                        JOIN dbo.TB_SEC_ROLE r ON r.ROLE_ID = rm.ROLE_ID
                        JOIN dbo.TB_SEC_POLICY_USER_ROLE pur ON pur.ROLE_ID = r.ROLE_ID
                        JOIN dbo.TB_SEC_FOLDER s ON s.POLICY_ID = pur.POLICY_ID
                        JOIN (
        -- The user
                               SELECT   @userid AS USER_ID
                               UNION ALL
        -- and groups
                               SELECT   PARENT_ID
                               FROM     dbo.TB_SEC_GROUP_MEMBER
                               WHERE    CHILD_ID = @userid
                             ) AS m ON m.USER_ID = pur.USER_ID
                WHERE   o.NAME = @Operation
                        AND LEFT(PATH + '/',
                                 LEN(@Path + '/')) = @Path
                        + '/';

        RETURN;
    END;
GO
