SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_adm01_increment_table_generation_count]
(
    @TableName [NVARCHAR](255),
    @NewTableGenerationCount [BIGINT] OUTPUT,
    @TableGenerationCountUrn [INT] = -1 OUTPUT  -- optional
)
AS
    SET NOCOUNT ON;
        
    -- Increment table generation count by 1
    SELECT @NewTableGenerationCount = GENERATION_COUNT, @TableGenerationCountUrn = TABLE_GENERATION_COUNT_URN
    FROM dbo.TS_ADM_TABLE_GENERATION_COUNT WITH (UPDLOCK)
    WHERE TABLE_NAME = @TableName;

    IF @NewTableGenerationCount IS NULL
    BEGIN 
        RAISERROR('Table Generation Count for [%s] is missing from TS_ADM_TABLE_GENERATION_COUNT', 16, 1, @TableName);
    END;
    ELSE BEGIN 
        SET @NewTableGenerationCount = @NewTableGenerationCount + 1;

        UPDATE TS_ADM_TABLE_GENERATION_COUNT
        SET GENERATION_COUNT = @NewTableGenerationCount, 
        MODIFIED_DATE = GETUTCDATE() 
        WHERE TABLE_NAME = @TableName;
    END;
GO
GRANT EXECUTE
	ON [dbo].[ap_adm01_increment_table_generation_count]
	TO [portalapp_role]
GO
