SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_selfcare01_get_dn_label_mappings] 
(
    @DialedNumberString VARCHAR(50), 
    @Mapping1 VARCHAR(40) = '' OUTPUT, 
    @Mapping2 VARCHAR(40) = '' OUTPUT, 
    @Mapping3 VARCHAR(40) = '' OUTPUT, 
    @Mapping4 VARCHAR(40) = '' OUTPUT, 
    @Mapping5 VARCHAR(40) = '' OUTPUT, 
    @Mapping6 VARCHAR(40) = '' OUTPUT, 
    @Mapping7 VARCHAR(40) = '' OUTPUT, 
    @Mapping8 VARCHAR(40) = '' OUTPUT, 
    @Mapping9 VARCHAR(40) = '' OUTPUT, 
    @Mapping10 VARCHAR(40) = '' OUTPUT
) AS
BEGIN 
    SET NOCOUNT ON;

    DECLARE @v_Error INT, @v_RowCount INT, @v_MapTypeDescriptor CHAR(2), @v_DialedNumberUrn INT, 
    @v_GenericMapId UNIQUEIDENTIFIER;

    SELECT @Mapping1 = a.map, @Mapping2 = a.map, @Mapping3 = a.map, @Mapping4 = a.map, @Mapping5 = a.map, 
    @Mapping6 = a.map, @Mapping7 = a.map, @Mapping8 = a.map, @Mapping9 = a.map, @Mapping10 = a.map
    FROM (VALUES(''))a(map);

    BEGIN TRY;
        SELECT DISTINCT 
        @v_MapTypeDescriptor = CAST(LEFT(gmt.MAP_TYPE_DESCRIPTOR, 2) AS CHAR(2)), 
        @v_DialedNumberUrn = dn.ITEM_URN, 
        @v_GenericMapId = gm.GENERIC_MAP_ID
        FROM TB_DIM_GENERIC_MAP AS gm
        INNER JOIN TE_DIM_GENERIC_MAP_TYPE AS gmt ON gmt.GENERIC_MAP_TYPE_ID = gm.GENERIC_MAP_TYPE_ID
        INNER JOIN TE_DIM_GENERIC_MAP_CLASS AS gmc ON gmc.GENERIC_MAP_CLASS_ID = gm.GENERIC_MAP_CLASS_ID
        INNER JOIN TB_DIM_GENERIC_MAPPING AS gmap ON gmap.GENERIC_MAP_ID = gm.GENERIC_MAP_ID
        INNER JOIN VW_DIM_DIALED_NUMBER_PKEY AS dn ON dn.ITEM_BIZ_URN = gmap.FROM_ITEM_URN AND dn.LATEST = 1
        WHERE dn.DIALEDNUMBER = @DialedNumberString AND dn.SELF_CARE_ENABLED = 1 AND dn.DELETED = 0
        AND gmc.INTERNAL_NAME = 'GMC_SELF_CARE';

        SET @v_RowCount = @@ROWCOUNT;

        IF @v_RowCount <> 1
        BEGIN 
            RETURN 0;
        END;
    END TRY
    BEGIN CATCH;
        SET @v_Error = @@ERROR;
        RAISERROR('ap_selfcare01_get_dn_label_mappings: error finding the mapping type for Dialed Number [%s], Error = [%d]', 16, 1, @DialedNumberString, @v_Error ) WITH LOG;
        RETURN  @v_Error;
    END CATCH;

    BEGIN TRY;
        -- If the generic map id is null because of reasons like, dialed number being disabled for self care or have been deleted then exit the sproc.
        IF @v_GenericMapId IS NOT NULL
        BEGIN 
            DECLARE @curMapping TABLE (INTERNAL_NAME VARCHAR(50), WEIGHTING INT, pos INT);

            IF @v_MapTypeDescriptor = 'W'
            BEGIN 
                INSERT INTO @curMapping
                SELECT INTERNAL_NAME, WEIGHTING, ROW_NUMBER() OVER(ORDER BY a.[SEQUENCE] ASC) AS pos
                FROM (SELECT TOP 10 lbl.INTERNAL_NAME, (gmap.INT_VAL * 100) / (SELECT CASE SUM(INT_VAL) WHEN 0
                                                                                                        THEN 100
                                                                                                        ELSE SUM(INT_VAL) END
                                                                               FROM TB_DIM_GENERIC_MAPPING AS gm2
                                                                               INNER JOIN VW_DIM_LABEL AS lbl2 ON lbl2.ITEM_BIZ_URN = gm2.TO_ITEM_URN AND lbl2.LATEST = 1
                                                                               WHERE gm2.GENERIC_MAP_ID = gm.GENERIC_MAP_ID AND lbl2.DELETED = 0
                                                                               AND lbl2.SELF_CARE_ENABLED = 1) AS WEIGHTING,
                      gmap.[SEQUENCE]
                      FROM TB_DIM_GENERIC_MAPPING AS gmap
                      INNER JOIN TB_DIM_GENERIC_MAP AS gm ON gm.GENERIC_MAP_ID = gmap.GENERIC_MAP_ID
                      INNER JOIN VW_DIM_LABEL_PKEY AS lbl ON lbl.ITEM_BIZ_URN = gmap.TO_ITEM_URN AND lbl.LATEST = 1
                      WHERE gm.GENERIC_MAP_ID = @v_GenericMapId AND lbl.DELETED = 0 AND gmap.DELETED = 0 AND lbl.SELF_CARE_ENABLED = 1
                      ORDER BY gmap.[SEQUENCE] ASC) a;
            END;
            ELSE BEGIN 
                INSERT INTO @curMapping
                SELECT INTERNAL_NAME, WEIGHTING, ROW_NUMBER() OVER(ORDER BY a.[SEQUENCE] ASC) AS pos
                FROM (SELECT TOP 10 lbl.INTERNAL_NAME, gmap.INT_VAL AS WEIGHTING, gmap.[SEQUENCE]
                      FROM TB_DIM_GENERIC_MAPPING AS gmap
                      INNER JOIN TB_DIM_GENERIC_MAP AS gm ON gm.GENERIC_MAP_ID = gmap.GENERIC_MAP_ID
                      INNER JOIN VW_DIM_LABEL_PKEY AS lbl ON lbl.ITEM_BIZ_URN = gmap.TO_ITEM_URN AND lbl.LATEST = 1
                      WHERE gm.GENERIC_MAP_ID = @v_GenericMapId AND lbl.DELETED = 0 AND gmap.DELETED = 0 AND lbl.SELF_CARE_ENABLED = 1
                      ORDER BY gmap.[SEQUENCE] ASC) a;
            END;

            SELECT 
            @Mapping1 = MAX(CASE WHEN pos = 1 THEN INTERNAL_NAME + ';' + RTRIM(@v_MapTypeDescriptor) + CAST(WEIGHTING AS VARCHAR(20)) ELSE NULL END),
            @Mapping2 = MAX(CASE WHEN pos = 2 THEN INTERNAL_NAME + ';' + RTRIM(@v_MapTypeDescriptor) + CAST(WEIGHTING AS VARCHAR(20)) ELSE NULL END),
            @Mapping3 = MAX(CASE WHEN pos = 3 THEN INTERNAL_NAME + ';' + RTRIM(@v_MapTypeDescriptor) + CAST(WEIGHTING AS VARCHAR(20)) ELSE NULL END),
            @Mapping4 = MAX(CASE WHEN pos = 4 THEN INTERNAL_NAME + ';' + RTRIM(@v_MapTypeDescriptor) + CAST(WEIGHTING AS VARCHAR(20)) ELSE NULL END),
            @Mapping5 = MAX(CASE WHEN pos = 5 THEN INTERNAL_NAME + ';' + RTRIM(@v_MapTypeDescriptor) + CAST(WEIGHTING AS VARCHAR(20)) ELSE NULL END),
            @Mapping6 = MAX(CASE WHEN pos = 6 THEN INTERNAL_NAME + ';' + RTRIM(@v_MapTypeDescriptor) + CAST(WEIGHTING AS VARCHAR(20)) ELSE NULL END),
            @Mapping7 = MAX(CASE WHEN pos = 7 THEN INTERNAL_NAME + ';' + RTRIM(@v_MapTypeDescriptor) + CAST(WEIGHTING AS VARCHAR(20)) ELSE NULL END),
            @Mapping8 = MAX(CASE WHEN pos = 8 THEN INTERNAL_NAME + ';' + RTRIM(@v_MapTypeDescriptor) + CAST(WEIGHTING AS VARCHAR(20)) ELSE NULL END),
            @Mapping9 = MAX(CASE WHEN pos = 9 THEN INTERNAL_NAME + ';' + RTRIM(@v_MapTypeDescriptor) + CAST(WEIGHTING AS VARCHAR(20)) ELSE NULL END),
            @Mapping10 = MAX(CASE WHEN pos = 10 THEN INTERNAL_NAME + ';' + RTRIM(@v_MapTypeDescriptor) + CAST(WEIGHTING AS VARCHAR(20)) ELSE NULL END)
            FROM @curMapping;
        END;
    END TRY
    BEGIN CATCH;
        SET @v_Error = @@ERROR;
    END CATCH;

    RETURN @v_Error;
END;
GO
GRANT EXECUTE
	ON [dbo].[ap_selfcare01_get_dn_label_mappings]
	TO [portalapp_role]
GO
