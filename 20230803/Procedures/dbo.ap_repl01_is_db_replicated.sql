SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_repl01_is_db_replicated] (@IsReplicated AS BIT OUT) AS
BEGIN 
    DECLARE @isSubscriber BIT, @isPublisher BIT;

    SET @isPublisher = 0;
    SET @isSubscriber = 0;
    SET @IsReplicated = 0;

    IF EXISTS (
            SELECT *
            FROM dbo.sysobjects
            WHERE xtype = 'U'
                AND NAME = 'syspublications'
            )
    BEGIN 
        IF EXISTS (
                SELECT *
                FROM syspublications
                WHERE NAME IN ('BasePubWin', 'BaseSubWin', 'Fact', 'NonQueued')
                )
        BEGIN 
            SET @isPublisher = 1;
        END;
    END;

    IF EXISTS (
            SELECT *
            FROM dbo.sysobjects
            WHERE xtype = 'U'
                AND NAME = 'MSreplication_subscriptions'
            )
    BEGIN 
        IF EXISTS (
                SELECT *
                FROM MSreplication_subscriptions
                WHERE publication IN ('BasePubWin', 'BaseSubWin', 'Fact', 'NonQueued')
                )
        BEGIN 
            SET @isSubscriber = 1;
        END;
    END;

    IF @isSubscriber = 1
        OR @isPublisher = 1
    BEGIN 
        SET @IsReplicated = 1;
    END;
END;
GO
GRANT EXECUTE
	ON [dbo].[ap_repl01_is_db_replicated]
	TO [portalapp_role]
GO
