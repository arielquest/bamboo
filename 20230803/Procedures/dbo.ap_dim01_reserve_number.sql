SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------
-- Various numbers can either be allocated by Exony or can be imported from
-- the remote system. The numbers typically exist as a range which is defined
-- as: 
--     [1,2,3]XXX which gives a boundary range of 1000 to 3999
-- As each new number is required by default a sequence of numbers is allocated
-- with a sequential transaction providing the multi-user locking strategy.
-- However, because data can be manually entered on the remote system then gaps
-- may appear in the sequence.e.g. Exony adds 1000, 1001, 1002, 1003, the import 
-- then reads 2500 therefore leaving a gap between 1003 and 2500. 
-- Returns: < 0 - SQL Engine error
--            0 - Number allocated correctly 
--            1 - No free numbers
-------------------------------------------------------------------------------
CREATE PROCEDURE dbo.ap_dim01_reserve_number
    (
      @I_ItemTypeID UNIQUEIDENTIFIER,
      @I_ItemColumnName NVARCHAR(50),
      @I_ParentURN INT = NULL,
      @I_Parent_Type_ID UNIQUEIDENTIFIER = NULL,
      @I_ClusterResourceID UNIQUEIDENTIFIER = NULL,
      @I_FolderID UNIQUEIDENTIFIER = NULL,
      @I_OwnerID UNIQUEIDENTIFIER = NULL,
      @O_NextValue NVARCHAR(50) OUTPUT
    )
AS
BEGIN 
    SET NOCOUNT ON;

    -- Fix up default parameters
    IF @I_ParentURN IS NULL
    BEGIN 
        SET @I_ParentURN = -2;
    END;
    
    DECLARE @v_Error INT = -1,
            @v_RowCount INT,
            @v_NumberRange NVARCHAR(50),
            @v_Index INT,
            @v_NextAvailableNumber INT,
            @v_NumberRangeStart INT,
            @v_NumberRangeEnd INT;
   
    -- If the tenant id is not specified and parent (eg peripheral) is specified, then try fetch the owner of the peripheral
    IF (@I_ParentURN IS NOT NULL AND @I_ParentURN > 0)
        AND @I_OwnerID IS NULL
    BEGIN 
        IF @I_Parent_Type_ID IS NULL
        BEGIN 
            RAISERROR('ap_dim01_reserve_number: Parameter @I_Parent_Type_ID must be specified if @ParentURN is specified', 16, 1) WITH LOG;
            RETURN -1;
        END;
        
        DECLARE @SQL NVARCHAR(MAX);
        SELECT  @SQL = 'SELECT @sp_out_I_OwnerID = OWNER_ID' + CHAR(13) + CHAR(10) + 'FROM dbo.' + TABLE_NAME + CHAR(13) + CHAR(10) + 'WHERE [ITEM_URN] = ' + CAST(@I_ParentURN AS VARCHAR(20))
        FROM    dbo.TE_DIM_ITEM_TYPE
        WHERE   ITEM_TYPE_ID = @I_Parent_Type_ID;

        EXECUTE sp_executesql @SQL, N'@sp_out_I_OwnerID UNIQUEIDENTIFIER OUTPUT', @sp_out_I_OwnerID = @I_OwnerID OUTPUT;
    END;

    -- Find the number range or pattern that will be used to restrict the number search.
    SELECT  @v_NumberRange = [NUMBER_RANGE]
    FROM    dbo.TB_DIM_RESERVED_NUMBER
    WHERE   [COLUMN_NAME] = @I_ItemColumnName
            AND [ITEM_TYPE_ID] = @I_ItemTypeID;
   
    SELECT  @v_Error = @@ERROR,
            @v_RowCount = @@ROWCOUNT;
 
    IF @v_Error <> 0
        OR @v_RowCount <> 1
    BEGIN 
        SET @v_Error = -1;
        RAISERROR('ap_dim01_reserve_number: no number range row; error [%d], [%s]', 16, 1, @v_Error, @I_ItemColumnName) WITH LOG;
        RETURN -1;
    END;

    SET @O_NextValue = NULL;
    SET @v_Index = 1;

    -- Remove any numbers from the reserved table that have now been allocated.
    EXEC @v_Error = dbo.ap_dim_clear_used_reserved_numbers @I_ItemTypeID, @I_ItemColumnName, @I_ParentURN, @I_ClusterResourceID, @I_FolderID, @I_OwnerID, @O_NextValue OUTPUT;
    
    EXEC dbo.ap_dim_get_number_range_from_pattern @v_NumberRange, @v_NumberRangeStart OUTPUT, @v_NumberRangeEnd OUTPUT;

    EXEC @v_Error = dbo.ap_dim_reserve_next_number_in_range @I_ItemTypeID, @I_ItemColumnName, @v_NumberRangeStart, @v_NumberRangeEnd, @I_ParentURN, @I_ClusterResourceID, @I_FolderID, @I_OwnerID, @O_NextValue OUTPUT;
        
    IF @O_NextValue IS NULL
    BEGIN 
        RAISERROR('ap_dim01_reserve_number: could not generate number;', 16, 1) WITH LOG;
        RETURN 1;
    END;
   
    RETURN @v_Error;
END;
GO
GRANT EXECUTE
	ON [dbo].[ap_dim01_reserve_number]
	TO [portalapp_role]
GO
