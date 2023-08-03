SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[ap_rep01_replication_configured_property]
    (
      @Input UNIQUEIDENTIFIER,
      @start BIT
    )
AS
    BEGIN 
        IF @start = 1
        BEGIN 
            IF EXISTS ( SELECT  1
                        FROM    [dbo].[TB_ADM_PROPERTY]
                        WHERE   [PROPERTY_KEY] = 'PROP_REPLICATION_CONFIGURED' )
            BEGIN
                UPDATE  [dbo].[TB_ADM_PROPERTY]
                SET     [PROPERTY_VALUE] = CAST(@Input AS VARCHAR(36)),
                        [MODIFIED_DATE] = GETUTCDATE(),
                        [SYSTEM] = 1
                WHERE   [PROPERTY_KEY] = 'PROP_REPLICATION_CONFIGURED';
            END;
            ELSE
            BEGIN
                INSERT  [dbo].[TB_ADM_PROPERTY]
                        ( [PROPERTY_KEY],
                          [PROPERTY_VALUE],
                          [MODIFIED_DATE],
                          [SYSTEM]
                        )
                VALUES  ( 'PROP_REPLICATION_CONFIGURED',
                          CAST(@Input AS VARCHAR(36)),
                          GETUTCDATE(),
                          1
                        );
            END;
        END;
        ELSE
        BEGIN 
            DELETE  FROM [dbo].[TB_ADM_PROPERTY]
            WHERE   [PROPERTY_KEY] = 'PROP_REPLICATION_CONFIGURED';
        END;
    END;
GO
