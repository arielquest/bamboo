SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_prg_audit_cleanup]
    (
      @isPurgeActive BIT = NULL
    )
AS
    BEGIN
        SET NOCOUNT ON;

        DECLARE @error INT = 0,
            @rowcount INT = 1,
            @currentUtcDateTime DATETIME = GETUTCDATE(),
            @retainDays INT;

        BEGIN TRY;
            IF @isPurgeActive IS NULL
            BEGIN
                --Check if purge is active
                SELECT  @isPurgeActive = CASE WHEN CAST([ri].[XML_DATA].[query]('/Columns/Column[@Name="PURGE_ENABLED"]/text()') AS NVARCHAR(5)) = 'True' THEN 1
                                              ELSE 0
                                         END
                FROM    [dbo].[fn_clu_get_exony_db_resource_instance](NULL) AS [exDb]
                INNER JOIN [dbo].[TB_CLU_RESOURCE_INSTANCE] [ri] ON [ri].[RESOURCE_INSTANCE_ID] = [exDb].[RESOURCE_INSTANCE_ID];
            END;

            IF @isPurgeActive = 1
            BEGIN 
                IF EXISTS ( SELECT  1
                            FROM    [dbo].[sysobjects]
                            WHERE   [id] = OBJECT_ID(N'[dbo].[VW_ADM_EXPIRED_SESSIONS]')
                                    AND OBJECTPROPERTY([id], N'IsView') = 1 )
                BEGIN
                    DELETE  [sess]
                    FROM    [dbo].[TB_ADM_SESSION] [sess]
                    WHERE   EXISTS ( SELECT 1
                                     FROM   [dbo].[VW_ADM_EXPIRED_SESSIONS] [exp]
                                     WHERE  [sess].[SESSION_ID] = [exp].[SESSION_ID] );
                END;
            END;
        END TRY
        BEGIN CATCH;
            SET @error = @@ERROR;
            RAISERROR (50100, 16, 1, @error, 'ap_prg_audit_cleanup', '');
        END CATCH;

        RETURN @error;
    END;
GO
