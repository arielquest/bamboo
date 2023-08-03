SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER tr_adm_time_zone_config_instead_of_inserted_updated ON dbo.TB_ADM_TIME_ZONE_CONFIG
    INSTEAD OF INSERT, UPDATE
    NOT FOR REPLICATION
AS
SET NOCOUNT ON;
    
    -- If there exists an IS_DEFAULT with 1 then update it to 0 (only if the new record or updated record has IS_DEFAULT of 1)
IF UPDATE(IS_DEFAULT)
BEGIN
    IF EXISTS ( SELECT  *
                FROM    inserted
                WHERE   IS_DEFAULT = 1 )
    BEGIN
        DECLARE @defaultCount AS INT;
        SELECT  @defaultCount = COUNT(*)
        FROM    inserted
        WHERE   IS_DEFAULT = 1;
            
        IF @defaultCount > 1
        BEGIN
            RAISERROR('Multiple records cannot be updated', 16, 1);
            RETURN;
        END;
            
        UPDATE  dbo.TB_ADM_TIME_ZONE_CONFIG
        SET     IS_DEFAULT = 0
        WHERE   IS_DEFAULT = 1;                    
    END;
END;
    
    -- Check if rows were updated
IF ( SELECT COUNT(*)
     FROM   inserted
   ) <> 0
    AND ( SELECT    COUNT(*)
          FROM      deleted
        ) <> 0
BEGIN
    UPDATE  dbo.TB_ADM_TIME_ZONE_CONFIG
    SET     TIME_ZONE_URN = ins.TIME_ZONE_URN,
            OLAP_CUBE_DIMENSION_NAME = ins.OLAP_CUBE_DIMENSION_NAME,
            ENABLED = ins.ENABLED,
            IS_DEFAULT = ins.IS_DEFAULT,
            CREATE_OLAP_AGGREGATION = ins.CREATE_OLAP_AGGREGATION
    FROM    dbo.TB_ADM_TIME_ZONE_CONFIG AS tz
    JOIN    inserted AS ins ON ins.TIME_ZONE_CONFIG_URN = tz.TIME_ZONE_CONFIG_URN;
END;
    
    -- Check if rows were inserted
IF ( SELECT COUNT(*)
     FROM   inserted
   ) <> 0
    AND ( SELECT    COUNT(*)
          FROM      deleted
        ) = 0
BEGIN
    INSERT  INTO dbo.TB_ADM_TIME_ZONE_CONFIG
            (
              TIME_ZONE_CONFIG_URN,
              TIME_ZONE_URN,
              OLAP_CUBE_DIMENSION_NAME,
              IS_DEFAULT,
              ENABLED,
              CREATE_OLAP_AGGREGATION,
              msrepl_tran_version
            )
    SELECT  TIME_ZONE_CONFIG_URN,
            TIME_ZONE_URN,
            OLAP_CUBE_DIMENSION_NAME,
            IS_DEFAULT,
            ENABLED,
            CREATE_OLAP_AGGREGATION,
            msrepl_tran_version
    FROM    inserted;        
END;
GO
