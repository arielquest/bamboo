SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_dim01_delete_ip_endpoint_ip_endpoint_button_template_member]
(
    @SessionId              [UNIQUEIDENTIFIER],
    @MemberUrn              [INTEGER],
    @ChangeStamp            [INTEGER] OUTPUT
) AS
BEGIN 
    SET NOCOUNT ON;

    DECLARE     @ReturnCode              AS [INTEGER] = 0,
                @RowCount                AS [INTEGER],
                @ParentItemBusinessUrn   AS [INTEGER],
                @ChildItemBusinessUrn    AS [INTEGER],
                @AuditUrn                AS [BIGINT],
                @Deleted                 AS [BIT],
                @UtcNow                  AS [DATETIME] = DATEADD(ms, -(DATEPART(ms, GETUTCDATE())), GETUTCDATE()),
                @InitialTransactionCount AS [INTEGER] = @@TRANCOUNT,
                @SessionUserId           AS [UNIQUEIDENTIFIER],
                @ErrorMessage            AS [VARCHAR](1024);

    BEGIN TRY;
        --Check Session Id
        IF @SessionId IS NULL
        BEGIN 
            SET @ReturnCode = 50157;
            RAISERROR(50157, 16, 5, 'ap_dim01_delete_ip_endpoint_ip_endpoint_button_template_member');
        END;
    
        IF NOT EXISTS(SELECT 1 
                      FROM dbo.TB_ADM_SESSION 
                      WHERE SESSION_ID = @SessionId
                      )
        BEGIN 
            SET @ReturnCode = 50157;
            RAISERROR(50157, 16, 5, 'ap_dim01_delete_ip_endpoint_ip_endpoint_button_template_member');
        END;
          
        -- Retrieve user information
        SELECT @SessionUserId = USER_ID 
        FROM dbo.TB_SEC_USER
        WHERE DELETED = 0
        AND LOGIN_NAME = (SELECT SESSION_USER_NAME 
                          FROM dbo.TB_ADM_SESSION 
                          WHERE SESSION_ID = @SessionId
                          );

        -- If member urn is not supplied return
        IF @MemberUrn IS NOT NULL
        BEGIN    
            -- Get member information
            SELECT  @ParentItemBusinessUrn = PARENT_ITEM_BIZ_URN,
                    @ChildItemBusinessUrn = CHILD_ITEM_BIZ_URN,
                    @Deleted = DELETED
            FROM dbo.TB_DIM_IP_ENDPOINT_IP_ENDPOINT_BUTTON_TEMPLATE_MEMBER WITH (UPDLOCK)
            WHERE MEMBER_URN = @MemberUrn;
    
            -- Return if already deleted
            IF @Deleted <> 1
            BEGIN        
                BEGIN TRANSACTION PDEL_ipendpointipendTran;
                -- Mark the member as deleted
                UPDATE dbo.TB_DIM_IP_ENDPOINT_IP_ENDPOINT_BUTTON_TEMPLATE_MEMBER
                SET EFFECTIVE_FROM = CASE WHEN DATEDIFF(mi, EFFECTIVE_FROM, @UtcNow) < 0 THEN @UtcNow ELSE EFFECTIVE_FROM END,
                    EFFECTIVE_TO = @UtcNow,
                    DELETED = 1,
                    MODIFIED_DATE = @UtcNow, 
                    MODIFIED_BY_ID = @SessionUserId,
                    CHANGE_STAMP = CHANGE_STAMP + 1
                WHERE MEMBER_URN = @MemberUrn
                AND DELETED = 0
                AND CHANGE_STAMP = @ChangeStamp;
        
                SELECT @ReturnCode = @@ERROR, @RowCount = @@RowCount;
                IF @ReturnCode <> 0
                BEGIN 
                    SET @ReturnCode = -2;
                    RAISERROR('ap_dim01_delete_ip_endpoint_ip_endpoint_button_template_member: Error deleting member [%d], Error [%d] ', 16, 1, @MemberUrn, @ReturnCode) WITH LOG;
                END;
        
                -- Concurrency conflict or attempt to delete non deleted record
                IF @RowCount = 0
                BEGIN 
                    SET @ReturnCode = -2;
                    RAISERROR('ap_dim01_delete_ip_endpoint_ip_endpoint_button_template_member: Concurrency conflict occured (or attempt to delete already deleted member) whilst deleting member [%d], Error [%d]', 16, 1, @MemberUrn, @ReturnCode) WITH LOG;
                END;
        
                -- Update the passed in changestamp to match the row just incremented in the UPDATE statement
                SET @ChangeStamp = @ChangeStamp + 1;

                -- Audit success against parent and child
                EXEC dbo.ap_adm01_audit_event @SessionId, 'AT_MEMBER_DELETE_COMMITTED', DEFAULT, @ParentItemBusinessUrn, @ChildItemBusinessUrn, 54, 53,  NULL, NULL, 'S', 0, 
                'MEMBER_DELETED', NULL, NULL, NULL, @AuditUrn OUTPUT;
        
                IF @InitialTransactionCount = 0 
                BEGIN 
                    COMMIT TRANSACTION PDEL_ipendpointipendTran;
                END;
                ELSE BEGIN 
                    WHILE @@TRANCOUNT > @InitialTransactionCount
                    BEGIN 
                        COMMIT TRANSACTION;
                    END;
                END;
                SET @ReturnCode = 0;
            END;
        END;
    END TRY
    BEGIN CATCH;
        SET @ErrorMessage = ERROR_MESSAGE();
        IF @InitialTransactionCount = 0 AND @@TRANCOUNT > 0
        BEGIN 
            ROLLBACK TRANSACTION;
        END;
        ELSE IF @InitialTransactionCount <> 0 AND @@TRANCOUNT > @InitialTransactionCount
        BEGIN 
            IF (XACT_STATE()) = -1
            BEGIN 
                SET @ErrorMessage = ISNULL(NULLIF(@ErrorMessage,''),OBJECT_NAME(@@PROCID))+' [Uncommittable Transaction!]';
                ROLLBACK TRANSACTION;
                -- THIS IS TO AVOID TRANSACTION MISMATCHES IN THE CALLING APPLICATION
                DECLARE @transactionFake INT = @@TRANCOUNT;
                WHILE @transactionFake < @InitialTransactionCount
                BEGIN 
                    BEGIN TRANSACTION;
                    SET @transactionFake = @transactionFake + 1;
                END;
            END;
            ELSE BEGIN 
                WHILE @@TRANCOUNT > @InitialTransactionCount
                BEGIN 
                    COMMIT TRANSACTION;
                END;
            END;
            SET @ErrorMessage = ISNULL(@ErrorMessage,OBJECT_NAME(@@PROCID));
            RAISERROR(@ErrorMessage, 16, 1) WITH LOG;
        END;
    END CATCH;
    RETURN @ReturnCode;
END;
GO
GRANT EXECUTE
	ON [dbo].[ap_dim01_delete_ip_endpoint_ip_endpoint_button_template_member]
	TO [portalapp_role]
GO
