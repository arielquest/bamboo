SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------
-- Many items must have globally unique column/field names. This procedure 
-- assembles the name based on the rules for that type and column and the 
-- supplied seed values. The assmebled named is reserved within the dictionary
-------------------------------------------------------------------------------
CREATE PROCEDURE [dbo].[ap_dim01_generate_internal_name]
    (
      @I_ItemTypeID UNIQUEIDENTIFIER,
      @I_ParentURN INT = -2,
      @I_Parent_Type_ID UNIQUEIDENTIFIER = NULL,
      @I_OwnerID UNIQUEIDENTIFIER = NULL,
      @I_Seed1 NVARCHAR(50) = N'',
      @I_Seed2 NVARCHAR(50) = N'',
      @I_Seed3 NVARCHAR(50) = N'',
      @O_EquipmentName NVARCHAR(50) OUTPUT
    )
AS
    BEGIN 
        SET NOCOUNT ON;
        BEGIN TRY
            DECLARE @v_Error INT,
                @errorMessage VARCHAR(200),
                @v_RowCount INT,
                @v_TenantLength INT,
                @v_TenantAdjunct NVARCHAR(2),
                @v_ParentLength INT,
                @v_ParentAdjunct NVARCHAR(2),
                @v_Seed1Length INT,
                @v_Seed1Adjunct NVARCHAR(2),
                @v_Seed2Length INT,
                @v_Seed2Adjunct NVARCHAR(2),
                @v_Seed3Length INT,
                @v_Seed3Adjunct NVARCHAR(2),
                @v_PostFix NVARCHAR(5),
                @SQL NVARCHAR(MAX),
                @exists BIT = 0;
    
            IF @I_ParentURN > 0
                AND @I_Parent_Type_ID IS NULL
            BEGIN 
                SET @v_Error = -1;
                SET @errorMessage = 'ap_dim01_generate_internal_name: must include a parent type id if you specify a parent urn; error [%d]';
                RAISERROR(@errorMessage, 16, 1, @v_Error) WITH LOG;
            END;
         
            SELECT  @v_TenantLength = [TENANT_LENGTH],
                    @v_TenantAdjunct = [TENANT_ADJUNCT],
                    @v_ParentLength = [PARENT_LENGTH],
                    @v_ParentAdjunct = [PARENT_ADJUNCT],
                    @v_Seed1Length = [SEED1_LENGTH],
                    @v_Seed1Adjunct = [SEED1_ADJUNCT],
                    @v_Seed2Length = [SEED2_LENGTH],
                    @v_Seed2Adjunct = [SEED2_ADJUNCT],
                    @v_Seed3Length = [SEED3_LENGTH],
                    @v_Seed3Adjunct = [SEED3_ADJUNCT],
                    @v_PostFix = [POSTFIX]
            FROM    [dbo].[TB_DIM_RESERVED_NAME_FORMAT]
            WHERE   [ITEM_TYPE_ID] = @I_ItemTypeID;
              
            SELECT  @v_Error = @@ERROR,
                    @v_RowCount = @@ROWCOUNT;
        
            IF @v_Error <> 0
                OR @v_RowCount <> 1
            BEGIN 
                SET @v_Error = -1;
                SET @errorMessage = 'ap_dim01_generate_internal_name: no format row; error [%d]';
                RAISERROR(@errorMessage, 16, 1, @v_Error) WITH LOG;
            END;
        
            DECLARE @EquipmentNameNoPostFix NVARCHAR(50);
    
            IF OBJECT_ID('tempdb..#items') IS NOT NULL
            BEGIN 
                DROP TABLE [#items];
            END;
    
            CREATE TABLE [#items]
                (
                  [FOLDER_ID] UNIQUEIDENTIFIER NULL,
                  [FOLDER_NAME] NVARCHAR(50),
                  [ITEM_NAME] NVARCHAR(50)
                );
    
            SET @SQL = 'SELECT TOP 1 ISNULL(a.OWNER_ID, @SP_IN_I_OwnerID) AS FOLDER_ID, b.NAME AS FOLDER_NAME, a.NAME AS ITEM_NAME' + CHAR(13) + CHAR(10)
                + 'FROM (SELECT OWNER_ID, NAME, 1 AS rn' + CHAR(13) + CHAR(10) + 'FROM dbo.VW_DIM_ITEM' + CHAR(13) + CHAR(10)
                + 'WHERE ITEM_TYPE_ID = @SP_IN_I_Parent_Type_ID' + CHAR(13) + CHAR(10) + 'AND ITEM_URN = @SP_IN_I_ParentURN' + CHAR(13) + CHAR(10)
                + 'UNION ALL SELECT NULL, NULL, 2) a' + CHAR(13) + CHAR(10) + 'OUTER APPLY (SELECT FOLDER_ID, NAME' + CHAR(13) + CHAR(10)
                + 'FROM dbo.TB_SEC_FOLDER' + CHAR(13) + CHAR(10) + 'WHERE FOLDER_ID = @SP_IN_I_OwnerID) b' + CHAR(13) + CHAR(10) + 'ORDER BY rn' + CHAR(13)
                + CHAR(10) + 'OPTION(RECOMPILE);';
    
            INSERT  INTO [#items]
            EXECUTE [sp_executesql] @SQL, N'@SP_IN_I_Parent_Type_ID UNIQUEIDENTIFIER, @SP_IN_I_ParentURN INT, @SP_IN_I_OwnerID UNIQUEIDENTIFIER',
                                    @SP_IN_I_Parent_Type_ID = @I_Parent_Type_ID, @SP_IN_I_ParentURN = @I_ParentURN, @SP_IN_I_OwnerID = @I_OwnerID;
    
            SET @SQL = NULL;
    
            WITH    [CTE] ( [FOLDER_ID], [FOLDER_NAME], [ITEM_NAME], [INTERNAL_NAME] )
                      AS ( SELECT   [FOLDER_ID],
                                    [FOLDER_NAME],
                                    [ITEM_NAME],
                                    CASE WHEN @v_TenantLength > 0
                                              AND [FOLDER_ID] IS NOT NULL
                                              AND LEN([FOLDER_NAME]) > 0 THEN UPPER(LEFT(REPLACE([FOLDER_NAME], '-', '_'), @v_TenantLength)) + @v_TenantAdjunct
                                         ELSE ''
                                    END + CASE WHEN @v_ParentLength > 0
                                                    AND LEN([ITEM_NAME]) > 0 THEN UPPER(LEFT([ITEM_NAME], @v_ParentLength)) + @v_ParentAdjunct
                                               ELSE ''
                                          END
                           FROM     [#items]
                         ),
                    [CTE2] ( [FOLDER_ID], [FOLDER_NAME], [ITEM_NAME], [INTERNAL_NAME] )
                      AS ( SELECT   [CTE].[FOLDER_ID],
                                    [CTE].[FOLDER_NAME],
                                    [CTE].[ITEM_NAME],
                                    CASE WHEN [CTE].[INTERNAL_NAME] LIKE '\_%' ESCAPE '\'
                                              OR [CTE].[INTERNAL_NAME] LIKE CHAR(1) + '%'
                                              OR [CTE].[INTERNAL_NAME] LIKE CHAR(9) + '%'
                                              OR [CTE].[INTERNAL_NAME] LIKE CHAR(10) + '%'
                                              OR [CTE].[INTERNAL_NAME] LIKE CHAR(11) + '%'
                                              OR [CTE].[INTERNAL_NAME] LIKE CHAR(12) + '%'
                                              OR [CTE].[INTERNAL_NAME] LIKE CHAR(13) + '%'
                                              OR [CTE].[INTERNAL_NAME] LIKE CHAR(28) + '%'
                                              OR [CTE].[INTERNAL_NAME] LIKE CHAR(29) + '%'
                                              OR [CTE].[INTERNAL_NAME] LIKE CHAR(30) + '%'
                                              OR [CTE].[INTERNAL_NAME] LIKE CHAR(31) + '%'
                                              OR [CTE].[INTERNAL_NAME] LIKE CHAR(32) + '%' THEN STUFF([CTE].[INTERNAL_NAME], 1, 1, '')
                                         ELSE [CTE].[INTERNAL_NAME]
                                    END
                           FROM     [CTE]
                         ),
                    [CTE3] ( [INTERNAL_NAME_NOPOSTFIX], [INTERNAL_NAME] )
                      AS ( SELECT   CASE WHEN LEN(@I_Seed3) > 0
                                              AND @v_Seed3Length > 0 THEN [CTE2].[INTERNAL_NAME] + UPPER(LEFT(@I_Seed3, ABS(@v_Seed3Length - 3))) + @v_Seed3Adjunct
                                         WHEN LEN(@I_Seed2) > 0
                                              AND @v_Seed2Length > 0 THEN [CTE2].[INTERNAL_NAME] + UPPER(LEFT(@I_Seed2, ABS(@v_Seed2Length - 3))) + @v_Seed2Adjunct
                                         WHEN LEN(@I_Seed1) > 0
                                              AND @v_Seed1Length > 0 THEN [CTE2].[INTERNAL_NAME] + UPPER(LEFT(@I_Seed1, ABS(@v_Seed1Length - 3))) + @v_Seed1Adjunct
                                         ELSE [CTE2].[INTERNAL_NAME]
                                    END,
                                    [CTE2].[INTERNAL_NAME] + CASE WHEN LEN(@I_Seed1) > 0
                                                              AND @v_Seed1Length > 0 THEN UPPER(LEFT(@I_Seed1, @v_Seed1Length)) + @v_Seed1Adjunct
                                                         ELSE ''
                                                    END + CASE WHEN LEN(@I_Seed2) > 0
                                                                    AND @v_Seed2Length > 0 THEN UPPER(LEFT(@I_Seed2, @v_Seed2Length)) + @v_Seed2Adjunct
                                                               ELSE ''
                                                          END + CASE WHEN LEN(@I_Seed3) > 0
                                                                          AND @v_Seed3Length > 0 THEN UPPER(LEFT(@I_Seed3, @v_Seed3Length)) + @v_Seed3Adjunct
                                                                     ELSE ''
                                                                END + CASE WHEN LEN(@v_PostFix) > 0 THEN @v_PostFix
                                                                           ELSE ''
                                                                      END
                           FROM     [CTE2]
                         )
                SELECT  @O_EquipmentName = [cteAlias].[INTERNAL_NAME],
                        @EquipmentNameNoPostFix = [cteAlias].[INTERNAL_NAME_NOPOSTFIX]
                FROM    [CTE3] [cteAlias];

            -- CLEAN STRINGS
            DECLARE @Temp_EquipmentName NVARCHAR(50) = @O_EquipmentName,
                @Temp_EquipmentNameNoPostFix NVARCHAR(50) = @EquipmentNameNoPostFix;
            SELECT  @O_EquipmentName = '',
                    @EquipmentNameNoPostFix = '';
        
            SELECT  @O_EquipmentName = @O_EquipmentName + CASE WHEN SUBSTRING(@Temp_EquipmentName, [n], 1) LIKE '[0-9a-zA-Z_.]'
                                                               THEN SUBSTRING(@Temp_EquipmentName, [n], 1)
                                                               ELSE '_'
                                                          END
            FROM    [dbo].[fn_adm_numbers](0, LEN(@Temp_EquipmentName));

            SELECT  @EquipmentNameNoPostFix = @EquipmentNameNoPostFix
                    + CASE WHEN SUBSTRING(@Temp_EquipmentNameNoPostFix, [n], 1) LIKE '[0-9a-zA-Z_.]' THEN SUBSTRING(@Temp_EquipmentNameNoPostFix, [n], 1)
                           ELSE '_'
                      END
            FROM    [dbo].[fn_adm_numbers](0, LEN(@Temp_EquipmentNameNoPostFix));
    
            IF OBJECT_ID('tempdb..#existingItems') IS NOT NULL
            BEGIN 
                DROP TABLE [#existingItems];
            END;
    
            DECLARE @seq INT,
                @EquipmentNameNoPostFixCompare NVARCHAR(100);
    
            IF RIGHT(@EquipmentNameNoPostFix, 1) <> '.'
            BEGIN 
                SET @EquipmentNameNoPostFix = @EquipmentNameNoPostFix + '.';
            END;
    
            SET @EquipmentNameNoPostFixCompare = REPLACE(REPLACE(REPLACE(@EquipmentNameNoPostFix, '[', '[[]'), '%', '[%]'), '_', '[_]');
    
            SELECT  [INTERNAL_NAME],
                    [ITEM_TYPE_ID]
            INTO    [#existingItems]
            FROM    ( SELECT    [INTERNAL_NAME],
                                [ITEM_TYPE_ID]
                      FROM      [dbo].[VW_DIM_ITEM_PKEY_MAP]
                      UNION ALL
                      SELECT    [RESERVED_NAME],
                                [ITEM_TYPE_ID]
                      FROM      [dbo].[TB_DIM_RESERVED_NAME]
                      WHERE     [COLUMN_NAME] = 'INTERNAL_NAME'
                    ) [a]
            WHERE   [ITEM_TYPE_ID] = @I_ItemTypeID
                    AND ( [INTERNAL_NAME] = @O_EquipmentName
                          OR [INTERNAL_NAME] LIKE @EquipmentNameNoPostFixCompare + '[0-9A-Z][0-9A-Z][0-9A-Z]' + COALESCE(@v_PostFix, '')
                        )
            ORDER BY SUBSTRING([INTERNAL_NAME], LEN(@EquipmentNameNoPostFix) + 1, 3) DESC
            OPTION  ( RECOMPILE );
    
            IF EXISTS ( SELECT  1
                        FROM    [#existingItems]
                        WHERE   [INTERNAL_NAME] = @O_EquipmentName )
            BEGIN 
                SELECT TOP 1
                        @seq = [dbo].[fn_adm_from_base_thirtysix](SUBSTRING([INTERNAL_NAME], LEN(@EquipmentNameNoPostFix) + 1, 3)) + 1
                FROM    [#existingItems]
                WHERE   [INTERNAL_NAME] LIKE @EquipmentNameNoPostFixCompare + '[0-9A-Z][0-9A-Z][0-9A-Z]' + COALESCE(@v_PostFix, '')
                ORDER BY SUBSTRING([INTERNAL_NAME], LEN(@EquipmentNameNoPostFix) + 1, 3) DESC;
    
                SET @O_EquipmentName = @EquipmentNameNoPostFix + [dbo].[fn_adm_to_base_thirtysix](COALESCE(@seq, 1), 3) + COALESCE(REPLACE(@v_PostFix, ' ', '_'), '');
            END;
        END TRY
        BEGIN CATCH;
            SELECT  @v_Error = ISNULL(@v_Error, @@ERROR),
                    @errorMessage = ERROR_MESSAGE();
            RAISERROR(@errorMessage, 16, 1) WITH LOG;
        END CATCH;

        RETURN @v_Error;
    END;
GO
GRANT EXECUTE
	ON [dbo].[ap_dim01_generate_internal_name]
	TO [portalapp_role]
GO
