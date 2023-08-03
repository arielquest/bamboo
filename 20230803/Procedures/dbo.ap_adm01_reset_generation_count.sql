SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_adm01_reset_generation_count]
    (
      @SchemaName NVARCHAR(50),
      @TargetTableName NVARCHAR(255),
      @GenerationCountTableName NVARCHAR(255) = NULL,
      @TableGenerationCountUrn INT = NULL, -- Allows a table generation count to be specified - needed to specify the hard coded Urns in VW_ADM_DATA_GENERATION_COUNT
      @CustomDataSql NVARCHAR(MAX) = NULL, -- Custom query to retrieve values for data gc table
      @DataGcColumnName NVARCHAR(10) = NULL, -- Optional: If not specified, retrieved from meta using @TargetTableName
      @PrimaryKeyColumnName NVARCHAR(255) = NULL -- Optional: If not specified, retrieved from meta using @TargetTableName
    )
AS
BEGIN 
    SET NOCOUNT ON;

    DECLARE @Sql NVARCHAR(MAX),
        @ExistingTableGenerationCountUrn INT,
        @ErrorMessage NVARCHAR(4000),
        @ErrorSeverity INT,
        @ErrorState INT,
        @InitialTransactionCount INT = @@TRANCOUNT;

    -- Reserved urn range for fixed urns is < 10000
    IF @TableGenerationCountUrn IS NOT NULL
        AND @TableGenerationCountUrn >= 10000
    BEGIN 
        RAISERROR ('Fixed table generation count urns must be less than 10,000', 16, 1);
        RETURN - 1;
    END;

    -- Validate that if a gen count table is specified, then a hard coded table gen count urn is also specified
    IF (
         @GenerationCountTableName IS NULL
         AND @TableGenerationCountUrn IS NOT NULL
       )
        OR (
             @GenerationCountTableName IS NOT NULL
             AND @TableGenerationCountUrn IS NULL
           )
    BEGIN 
        RAISERROR ('If custom table generation count table is specified, then a fixed table generation count urn must also be specified', 16, 1);
        RETURN - 1;
    END;

    -- Get primary key name and type if not specified
    IF @DataGcColumnName IS NULL
        OR @PrimaryKeyColumnName IS NULL
    BEGIN 

        SELECT  @PrimaryKeyColumnName = c.COLUMN_NAME,
                @DataGcColumnName = CASE DATA_TYPE
                                      WHEN 'uniqueidentifier' THEN 'GUID_KEY'
                                      ELSE 'INT_KEY'
                                    END
        FROM    INFORMATION_SCHEMA.KEY_COLUMN_USAGE cu
        INNER JOIN INFORMATION_SCHEMA.COLUMNS c ON c.COLUMN_NAME = cu.COLUMN_NAME
                                                   AND c.TABLE_NAME = cu.TABLE_NAME
                                                   AND c.TABLE_SCHEMA = cu.TABLE_SCHEMA
                                                   AND c.TABLE_CATALOG = cu.TABLE_CATALOG
        WHERE   cu.TABLE_SCHEMA = @SchemaName
                AND cu.TABLE_NAME = @TargetTableName
                AND OBJECTPROPERTY(OBJECT_ID(constraint_name), 'IsPrimaryKey') = 1;
    END;

    IF (
         @GenerationCountTableName IS NULL
         AND @DataGcColumnName IS NULL
       )
        OR (
             @GenerationCountTableName IS NOT NULL
             AND @PrimaryKeyColumnName IS NULL
           )
    BEGIN 
        RAISERROR ('Unable to continue. Missing information about column names.', 16, 1);
        RETURN - 1;
    END;

    -- Get existing table generation count of table
    SELECT  @ExistingTableGenerationCountUrn = TABLE_GENERATION_COUNT_URN
    FROM    dbo.TS_ADM_TABLE_GENERATION_COUNT
    WHERE   TABLE_NAME = @TargetTableName;

    IF @TableGenerationCountUrn IS NOT NULL
        AND @ExistingTableGenerationCountUrn IS NOT NULL
        AND @ExistingTableGenerationCountUrn <> @TableGenerationCountUrn
    BEGIN 
        RAISERROR ('Different generation count urn specified to the current value.', 16, 1);
        RETURN - 1;
    END;

    BEGIN TRY
        BEGIN TRANSACTION ResetGCCountTransaction;

        -- Clear old data
        IF @ExistingTableGenerationCountUrn IS NOT NULL
        BEGIN 
            -- Clear Olap Dimension State row
            DELETE  FROM [dbo].[TS_IMP_OLAP_DIMENSION_STATE]
            WHERE   TABLE_GENERATION_COUNT_URN = @ExistingTableGenerationCountUrn;

            -- Clear Data GC rows
            DELETE  FROM [dbo].[TS_ADM_DATA_GENERATION_COUNT]
            WHERE   TABLE_GENERATION_COUNT_URN = @ExistingTableGenerationCountUrn;
        END;

        -- Clear old data from specific data GC table e.g. TS_DIM_AGENT
        IF @GenerationCountTableName IS NOT NULL
        BEGIN 
            -- Clear Data GC rows
            SET @Sql = 'TRUNCATE TABLE ' + @SchemaName + '.'
                + @GenerationCountTableName + ';';
            EXEC sp_executesql @Sql;
        END;

        -- Ensure Table GC row
        IF @ExistingTableGenerationCountUrn IS NULL
        BEGIN 
            IF @TableGenerationCountUrn IS NULL
            BEGIN 
                INSERT  INTO dbo.TS_ADM_TABLE_GENERATION_COUNT WITH(TABLOCK)
                        ( TABLE_NAME, GENERATION_COUNT )
                VALUES  ( @TargetTableName, 0 );
                SELECT  @TableGenerationCountUrn = SCOPE_IDENTITY();
            END;
            ELSE
            BEGIN 
                SET IDENTITY_INSERT dbo.TS_ADM_TABLE_GENERATION_COUNT ON;
                INSERT  INTO dbo.TS_ADM_TABLE_GENERATION_COUNT WITH(TABLOCK)
                        (
                          TABLE_GENERATION_COUNT_URN,
                          TABLE_NAME,
                          GENERATION_COUNT
                        )
                VALUES  (
                          @TableGenerationCountUrn,
                          @TargetTableName,
                          0
                        );
                SET IDENTITY_INSERT dbo.TS_ADM_TABLE_GENERATION_COUNT OFF;
            END;
        END;
        ELSE
        BEGIN 
            UPDATE  dbo.TS_ADM_TABLE_GENERATION_COUNT
            SET     GENERATION_COUNT = 0,
                    MODIFIED_DATE = GETUTCDATE()
            WHERE   TABLE_GENERATION_COUNT_URN = @ExistingTableGenerationCountUrn;
            SELECT  @TableGenerationCountUrn = @ExistingTableGenerationCountUrn;
        END;

        -- Insert Data Generation Count Records            
        IF @GenerationCountTableName IS NULL
        BEGIN 
            -- Uses TS_ADM_DATA_GENERATION_COUNT
            SET @Sql = 'INSERT INTO dbo.TS_ADM_DATA_GENERATION_COUNT WITH(TABLOCK) (TABLE_GENERATION_COUNT_URN, '
                + @DataGcColumnName
                + ', GENERATION_COUNT, CREATE_GENERATION_COUNT, LAST_OPERATION) ';
            IF @CustomDataSql IS NULL
            BEGIN 
                SET @Sql = @Sql + 'SELECT @TableGenerationCountUrn, '
                    + @PrimaryKeyColumnName + ', 0, 0, ''I'' FROM '
                    + @SchemaName + '.' + @TargetTableName + ';';
            END;
            ELSE
            BEGIN 
                SET @Sql = @Sql + @CustomDataSql;
            END;
            EXEC sp_executesql @Sql, N'@TableGenerationCountUrn INT',
                @TableGenerationCountUrn = @TableGenerationCountUrn;
        END;
        ELSE
        BEGIN 
            -- Has a specific generation count table
            SET @Sql = 'INSERT INTO ' + @SchemaName + '.'
                + @GenerationCountTableName + ' WITH(TABLOCK) (' + @PrimaryKeyColumnName
                + ', GENERATION_COUNT, CREATE_GENERATION_COUNT, LAST_OPERATION) ';

            IF @CustomDataSql IS NULL
            BEGIN 
                SET @Sql = @Sql + 'SELECT ' + @PrimaryKeyColumnName
                    + ', 0, 0, ''I'' FROM ' + @SchemaName + '.'
                    + @TargetTableName + ';';
            END;
            ELSE
            BEGIN 
                SET @Sql = @Sql + @CustomDataSql;
            END;
            EXEC sp_executesql @Sql;
        END;

        -- Initialise olap dimension state data
        INSERT  INTO [dbo].[TS_IMP_OLAP_DIMENSION_STATE] WITH(TABLOCK)
                (
                  OLAP_OBJECT_CLUSTER_MAP_URN,
                  TABLE_GENERATION_COUNT_URN,
                  LAST_GENERATION_COUNT
                )
        SELECT  cm.[OLAP_OBJECT_CLUSTER_MAP_URN],
                @TableGenerationCountUrn,
                -1
        FROM    [dbo].[TB_ADM_OLAP_OBJECT_CLUSTER_MAP] cm
        INNER JOIN [dbo].[TB_ADM_OLAP_OBJECT] o ON o.[OLAP_OBJECT_URN] = cm.[OLAP_OBJECT_URN]
        INNER JOIN [dbo].[TB_ADM_OLAP_OBJECT_TABLE_MAP] tm ON tm.[OLAP_OBJECT_URN] = o.[OLAP_OBJECT_URN]
        WHERE   tm.[TABLE_NAME] = @TargetTableName;

        IF @InitialTransactionCount = 0
        BEGIN 
            COMMIT TRANSACTION ResetGCCountTransaction;
        END;
        ELSE
        BEGIN 
            WHILE @@TRANCOUNT > @InitialTransactionCount
            BEGIN 
                COMMIT TRANSACTION;
            END;
        END;
    END TRY
    BEGIN CATCH
        SELECT  @ErrorMessage = OBJECT_NAME(@@PROCID) + ISNULL(': '
                                                              + ERROR_MESSAGE(),
                                                              ''),
                @ErrorSeverity = ERROR_SEVERITY(),
                @ErrorState = ERROR_STATE();
        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
        ROLLBACK TRANSACTION;
    END CATCH;
END;
GO
