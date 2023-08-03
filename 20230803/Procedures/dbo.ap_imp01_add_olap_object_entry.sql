SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
--------------------------------------------------------------------------------
-- Adds a row representing an OLAP object entry
-- SELECT * FROM TB_ADM_OLAP_OBJECT
--------------------------------------------------------------------------------
CREATE PROCEDURE [dbo].[ap_imp01_add_olap_object_entry]
    (
      @I_OlapObjectUrn INT,
      @I_OlapObjectType CHAR(1),
      @I_ParentOlapObjectName NVARCHAR(50),
      @I_OlapObjectName VARCHAR(50),
      @I_PrimaryTable sysname,
      @I_PartitionMap VARCHAR(750),
      @I_CheckMeasure sysname
    )
AS
SET NOCOUNT ON;

DECLARE @olalObjectUrn INT,
    @error INT = 0;

BEGIN TRY;
    IF @I_OlapObjectUrn IS NULL
    BEGIN 
        SET @error = -2;
        RAISERROR ('ap_imp01_add_olap_object_entry: the olap object urn not provided for the olap object', 16, 1) WITH LOG;
    END;

    SELECT  @olalObjectUrn = [OLAP_OBJECT_URN]
    FROM    [dbo].[TB_ADM_OLAP_OBJECT]
    WHERE   [PARENT_OLAP_OBJECT_NAME] = @I_ParentOlapObjectName
            AND [OLAP_OBJECT_NAME] = @I_OlapObjectName
            AND [OLAP_OBJECT_TYPE] = @I_OlapObjectType;

    IF @olalObjectUrn IS NOT NULL
    BEGIN 
        IF @olalObjectUrn <> @I_OlapObjectUrn
        BEGIN 
            SET @error = -3;
            RAISERROR ('ap_imp01_add_olap_object_entry: the olap object urn is mapped to a different olap object name [[%d], [%s]]', 16, 1, 
            @olalObjectUrn, @I_OlapObjectName) WITH LOG;
        END;
    END;

    IF @olalObjectUrn IS NULL
    BEGIN 
        BEGIN TRY;
            SET IDENTITY_INSERT TB_ADM_OLAP_OBJECT ON;
            INSERT  INTO [dbo].[TB_ADM_OLAP_OBJECT]
                    (
                      [OLAP_OBJECT_URN],
                      [PARENT_OLAP_OBJECT_NAME],
                      [OLAP_OBJECT_NAME],
                      [OLAP_OBJECT_TYPE],
                      [PRIMARY_TABLE],
                      [PARTITION_MAP],
                      [CHECK_MEASURE]
                    )
            VALUES  (
                      @I_OlapObjectUrn,
                      @I_ParentOlapObjectName,
                      @I_OlapObjectName,
                      @I_OlapObjectType,
                      @I_PrimaryTable,
                      @I_PartitionMap,
                      @I_CheckMeasure
                    );
        END TRY
        BEGIN CATCH;
            SET IDENTITY_INSERT TB_ADM_OLAP_OBJECT OFF;
            SET @error = @@ERROR;
            RAISERROR ('ap_imp01_add_olap_object_entry: error adding olap table entry [%s], Error [%d', 16, 1, @I_PrimaryTable, @error) WITH LOG;
        END CATCH;
        SET IDENTITY_INSERT TB_ADM_OLAP_OBJECT OFF;
    END;
END TRY
BEGIN CATCH;
    IF @error = 0
    BEGIN 
        SET @error = @@ERROR;
    END;
END CATCH;

RETURN @error;
GO
