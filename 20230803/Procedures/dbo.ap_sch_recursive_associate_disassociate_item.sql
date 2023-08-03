SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE dbo.ap_sch_recursive_associate_disassociate_item
(
    @SessionId AS UNIQUEIDENTIFIER,
    @ParentHierarchyChangeId AS UNIQUEIDENTIFIER,
    @HierarchyChangeId AS UNIQUEIDENTIFIER,
    @RequestType AS CHAR(1),
    @HierarchyNodeId AS UNIQUEIDENTIFIER,
    @ItemBusinessUrn AS INT,
    @ItemTypeUrn AS INT,
    @HierarchyPrecedence AS INT,
    @EffectiveFrom AS DATETIME    
) AS
    SET NOCOUNT ON;
    
    DECLARE @Rowcount AS INT,
            @InitialTransactionCount AS INT,
            @HistoricalEscalationPeriod AS INT,
            @IsPastChange AS BIT,
            @UtcNow AS DATETIME,
            @ReturnCode AS INT,
            @SubsequentOtherEffectiveFrom AS DATETIME,
            @ItemTypeId AS UNIQUEIDENTIFIER,
            @ItemSurrogateUrn AS INT,
            @ItemSurrogateEffectiveFrom AS DATETIME,
            @ItemSurrogateEffectiveTo AS DATETIME,
            @ChangeStamp AS INT,
            @NewItemSurrogateUrn AS INT,
            @HierarchyNodeSurrogateUrn AS INT,
            @HierarchyNodeSurrogateEffectiveFrom AS DATETIME,
            @HierarchyNodeSurrogateEffectiveTo AS DATETIME,
            @HierarchyNodeBusinessUrn AS INT,
            @HierarchyBusinessUrn AS INT,
            @ItemSurrogateInvalidFrom AS DATETIME,
            @ItemSurrogateInvalidTo AS DATETIME,
            @IsItemInvalid BIT,
            @IgnoreConsolidationPeriod BIT,
            @SQL NVARCHAR(2000);
    
    DECLARE @SubsequentItems TABLE
    (
        ITEM_URN INT,
        EFFECTIVE_FROM DATETIME,
        EFFECTIVE_TO DATETIME,
        CHANGE_STAMP INT
    );
    
    DECLARE @ChangeResultMappingTable as TABLE
    (
        HIERARCHY_CHANGE_ID UNIQUEIDENTIFIER,
        ITEM_TYPE_ID UNIQUEIDENTIFIER,
        ITEM_BUSINESS_URN INT,
        EFFECTIVE_FROM DATETIME,
        EFFECTIVE_TO DATETIME
    );
    
    DECLARE @ChildNodesTable as TABLE
    (
        ITEM_URN INT
    );
    
        
    SET @InitialTransactionCount = @@TRANCOUNT;
    SET @UtcNow = DATEADD(ms, -(DATEPART(ms, GETUTCDATE())), GETUTCDATE());
    SET @ReturnCode = 0;
    SET @HistoricalEscalationPeriod = 1440; -- default is 1 day (1440 minutes)
    SET @IsItemInvalid = 0;
    SET @ItemSurrogateInvalidFrom = @EffectiveFrom;
    SET @ParentHierarchyChangeId = COALESCE(@ParentHierarchyChangeId, @HierarchyChangeId);
    SET @IgnoreConsolidationPeriod = 0;
    
    SELECT @HistoricalEscalationPeriod = COALESCE(CAST(PROPERTY_VALUE AS INT), 1440)
    FROM dbo.TB_ADM_PROPERTY
    WHERE PROPERTY_KEY = 'PROP_TYPE2_HISTORICAL_ESCALATION_PERIOD';
    
    IF (DATEDIFF(mi, @EffectiveFrom, GETUTCDATE())) > @HistoricalEscalationPeriod
    BEGIN 
        SET @IsPastChange = 1;
    END;
    
    -- Check Session Id
    IF @SessionId IS NULL
    BEGIN 
        SET @ReturnCode = 50157;
        RAISERROR(50157, 16, 5, 'ap_sch_recursive_associate_disassociate_item');
        RETURN @ReturnCode;
    END;
        
    -- Get the surrogate of the item that is effective during the input datetime.
    SELECT     @ItemSurrogateUrn = ITEM_URN,
            @ItemTypeId = ITEM_TYPE_ID,
            @ChangeStamp = CHANGE_STAMP,
            @ItemSurrogateEffectiveFrom = EFFECTIVE_FROM,
            @ItemSurrogateEffectiveTo = EFFECTIVE_TO,
            @ItemSurrogateInvalidTo = EFFECTIVE_TO
    FROM dbo.VW_DIM_ITEM
    WHERE ITEM_BIZ_URN = @ItemBusinessUrn
    AND ITEM_TYPE_URN = @ItemTypeUrn
    AND @EffectiveFrom BETWEEN EFFECTIVE_FROM AND EFFECTIVE_TO
    OPTION(RECOMPILE);
    
    SELECT     @HierarchyNodeSurrogateUrn = ITEM_URN,
            @HierarchyNodeBusinessUrn = ITEM_BIZ_URN,
            @HierarchyBusinessUrn = HIERARCHY_BUSINESS_URN,
            @HierarchyNodeSurrogateEffectiveFrom = EFFECTIVE_FROM,
            @HierarchyNodeSurrogateEffectiveTo = EFFECTIVE_TO
    FROM dbo.VW_DIM_HIERARCHY_NODE
    WHERE NODE_ID = @HierarchyNodeId
    AND @EffectiveFrom BETWEEN EFFECTIVE_FROM AND EFFECTIVE_TO;
    
    IF @ItemSurrogateUrn IS NULL OR @HierarchyNodeSurrogateUrn IS NULL
    BEGIN 
        RETURN;
    END;
    
    INSERT INTO @ChildNodesTable (ITEM_URN)
    SELECT ITEM_URN FROM dbo.VW_DIM_HIERARCHY_NODE WHERE HIERARCHY_PARENT_URN = @HierarchyNodeSurrogateUrn
    AND @EffectiveFrom BETWEEN EFFECTIVE_FROM AND EFFECTIVE_TO;
    
    IF @RequestType = 'D'
    BEGIN 
    -- If it is a disassociate request and the association currently does not exist then just return.
        IF NOT EXISTS (
                SELECT *
                FROM dbo.TB_DIM_ITEM_HIERARCHY_NODE_MEMBER
                WHERE ITEM_URN = @ItemSurrogateUrn
                    AND ITEM_TYPE_URN = @ItemTypeUrn
                    AND HIERARCHY_NODE_URN = @HierarchyNodeSurrogateUrn
                    AND PRECEDENCE = @HierarchyPrecedence
                )
        BEGIN 
            GOTO EXIT_SPROC;
        END;
    END;

    SET @NewItemSurrogateUrn = @ItemSurrogateUrn;
    
    BEGIN TRANSACTION AssDisItemTransaction;
        -- type 2 the item
        exec @ReturnCode = dbo.ap_dim01_do_type2_item @SessionId, @NewItemSurrogateUrn OUT, @ItemBusinessUrn OUT, @ItemTypeUrn, @ChangeStamp, @EffectiveFrom, 0, 1;
    
        IF @ReturnCode <> 0
        BEGIN 
            GOTO EXIT_WITH_ERROR;
        END;
        
        IF @RequestType = 'A'
        BEGIN 
            IF @NewItemSurrogateUrn <> @ItemSurrogateUrn
            BEGIN 
                SET @IsItemInvalid = 1;
                SET @IgnoreConsolidationPeriod = 1;
                
                -- Copy existing mappings to the new surrogate
                INSERT INTO dbo.TB_DIM_ITEM_HIERARCHY_NODE_MEMBER (ITEM_URN, ITEM_TYPE_URN, HIERARCHY_NODE_URN, PRECEDENCE)
                SELECT @NewItemSurrogateUrn, @ItemTypeUrn, HIERARCHY_NODE_URN, PRECEDENCE
                FROM dbo.TB_DIM_ITEM_HIERARCHY_NODE_MEMBER
                WHERE ITEM_URN = @ItemSurrogateUrn    
                AND ITEM_TYPE_URN = @ItemTypeUrn            
                AND NOT (PRECEDENCE = @HierarchyPrecedence AND HIERARCHY_NODE_URN IN (SELECT ITEM_URN FROM dbo.VW_DIM_HIERARCHY_NODE WHERE HIERARCHY_BUSINESS_URN = @HierarchyBusinessUrn));
                
                SELECT @ReturnCode = @@ERROR;
                IF @ReturnCode <> 0
                BEGIN 
                    RAISERROR('ap_sch_recursive_associate_disassociate_item: Error copying node mappings for the new surrogate for taxonomy item [%d,%d], Error Code: [%d]', 16, 1, @ItemSurrogateUrn, @ItemTypeUrn, @ReturnCode) WITH LOG;
                    GOTO EXIT_WITH_ERROR;
                END;
                
                -- insert the new mapping
                INSERT INTO dbo.TB_DIM_ITEM_HIERARCHY_NODE_MEMBER (ITEM_URN, ITEM_TYPE_URN, HIERARCHY_NODE_URN, PRECEDENCE)
                VALUES (@NewItemSurrogateUrn, @ItemTypeUrn, @HierarchyNodeSurrogateUrn, @HierarchyPrecedence);
                
                SELECT @ReturnCode = @@ERROR;
                IF @ReturnCode <> 0
                BEGIN 
                    RAISERROR('ap_sch_recursive_associate_disassociate_item: Error adding node mapping for the new surrogate for taxonomy item [%d,%d] mapped to node [%d], Error Code: [%d]', 16, 1, @ItemSurrogateUrn, @ItemTypeUrn, @HierarchyNodeSurrogateUrn, @ReturnCode) WITH LOG;
                    GOTO EXIT_WITH_ERROR;
                END;
                
                SELECT     @ItemSurrogateEffectiveFrom = EFFECTIVE_FROM,
                        @ItemSurrogateEffectiveTo = EFFECTIVE_TO,
                        @ChangeStamp = CHANGE_STAMP
                FROM dbo.VW_DIM_ITEM 
                WHERE ITEM_URN = @NewItemSurrogateUrn
                AND ITEM_TYPE_URN = @ItemTypeUrn    
                OPTION(RECOMPILE);
            END;
            ELSE BEGIN 
                UPDATE dbo.TB_DIM_ITEM_HIERARCHY_NODE_MEMBER SET HIERARCHY_NODE_URN = @HierarchyNodeSurrogateUrn
                WHERE ITEM_URN = @NewItemSurrogateUrn
                AND ITEM_TYPE_URN = @ItemTypeUrn
                AND PRECEDENCE = @HierarchyPrecedence
                AND HIERARCHY_NODE_URN IN (SELECT ITEM_URN FROM dbo.VW_DIM_HIERARCHY_NODE WHERE HIERARCHY_BUSINESS_URN = @HierarchyBusinessUrn);
                
                SELECT @Rowcount = @@ROWCOUNT, @ReturnCode = @@ERROR;
                IF @ReturnCode <> 0
                BEGIN 
                    RAISERROR('ap_sch_recursive_associate_disassociate_item: Error updating node mapping for the surrogate for taxonomy item [%d,%d] mapped to node [%d], Error Code: [%d]', 16, 1, @ItemSurrogateUrn, @ItemTypeUrn, @HierarchyNodeSurrogateUrn, @ReturnCode) WITH LOG;
                    GOTO EXIT_WITH_ERROR;
                END;
                
                IF @Rowcount = 0
                BEGIN 
                    -- insert the new mapping
                    INSERT INTO dbo.TB_DIM_ITEM_HIERARCHY_NODE_MEMBER (ITEM_URN, ITEM_TYPE_URN, HIERARCHY_NODE_URN, PRECEDENCE)
                    VALUES (@NewItemSurrogateUrn, @ItemTypeUrn, @HierarchyNodeSurrogateUrn, @HierarchyPrecedence);
                    
                    SELECT @ReturnCode = @@ERROR;
                    IF @ReturnCode <> 0
                    BEGIN 
                        RAISERROR('ap_sch_recursive_associate_disassociate_item: Error adding node mapping for the surrogate for taxonomy item [%d,%d] mapped to role [%d], Error Code: [%d]', 16, 1, @ItemSurrogateUrn, @ItemTypeUrn, @HierarchyNodeSurrogateUrn, @ReturnCode) WITH LOG;
                        GOTO EXIT_WITH_ERROR;
                    END;
                END;
            END;
            
            -- Adjust effective dates and associate future surrogates of item to future surrogates of node.
            IF @ItemSurrogateEffectiveTo > @HierarchyNodeSurrogateEffectiveTo
            BEGIN 
                DECLARE @OldAdjustedItemSurrogateUrn AS INT,
                        @NewAdjustedItemSurrogateUrn AS INT,
                        @AdjustmentEffectiveFrom AS DATETIME,
                        @SubsequentHierarchyNodeSurrogateUrn AS INT;
                        
                SET @OldAdjustedItemSurrogateUrn = @NewItemSurrogateUrn;
                SET @NewAdjustedItemSurrogateUrn = @NewItemSurrogateUrn;
                SET @AdjustmentEffectiveFrom = DATEADD(ss, 1, @HierarchyNodeSurrogateEffectiveTo);
                
                -- type 2 the item to create an adjustment surrogate
                exec @ReturnCode = dbo.ap_dim01_do_type2_item @SessionId, @NewAdjustedItemSurrogateUrn OUT, @ItemBusinessUrn OUT, @ItemTypeUrn, @ChangeStamp, @AdjustmentEffectiveFrom, 0, 1;
            
                IF @ReturnCode <> 0
                BEGIN 
                    GOTO EXIT_WITH_ERROR;
                END;
                IF @OldAdjustedItemSurrogateUrn <> @NewAdjustedItemSurrogateUrn
                BEGIN 
                    IF @IsItemInvalid = 0
                    BEGIN 
                        SET @ItemSurrogateInvalidFrom = @AdjustmentEffectiveFrom;
                    END;
                    SET @IsItemInvalid = 1;
                END;
                
                -- If there is a subsequent surrogate of the hierarchy node then link the adjustment item surrogate to the subsequent surrogate of the hierarchy node                
                SELECT @SubsequentHierarchyNodeSurrogateUrn = ITEM_URN 
                FROM dbo.VW_DIM_HIERARCHY_NODE
                WHERE ITEM_BIZ_URN = @HierarchyNodeBusinessUrn
                AND @AdjustmentEffectiveFrom BETWEEN EFFECTIVE_FROM AND EFFECTIVE_TO;
                
                IF @SubsequentHierarchyNodeSurrogateUrn IS NOT NULL
                BEGIN 
                    IF NOT EXISTS(SELECT * FROM dbo.TB_DIM_ITEM_HIERARCHY_NODE_MEMBER
                                WHERE ITEM_URN = @NewAdjustedItemSurrogateUrn
                                AND ITEM_TYPE_URN = @ItemTypeUrn
                                AND HIERARCHY_NODE_URN = @SubsequentHierarchyNodeSurrogateUrn
                                AND PRECEDENCE = @HierarchyPrecedence)
                    BEGIN 
                        INSERT INTO dbo.TB_DIM_ITEM_HIERARCHY_NODE_MEMBER (ITEM_URN, ITEM_TYPE_URN, HIERARCHY_NODE_URN, PRECEDENCE)
                        VALUES (@NewAdjustedItemSurrogateUrn, @ItemTypeUrn, @SubsequentHierarchyNodeSurrogateUrn, @HierarchyPrecedence)
                    
                        SELECT @ReturnCode = @@ERROR
                        IF @ReturnCode <> 0
                        BEGIN 
                            RAISERROR('ap_sch_recursive_associate_disassociate_item: Error adding node mapping for the adjustment surrogate for taxonomy item [%d] mapped to role [%d], Error Code: [%d]', 16, 1, @ItemSurrogateUrn, @HierarchyNodeSurrogateUrn, @ReturnCode) WITH LOG;
                            GOTO EXIT_WITH_ERROR;
                        END;
                    END;
                END;
            END;
            
            -- Get the effective from date of the first future surrogate of the item that is *NOT* linked to a surrogate of the current hierarchy node
            SELECT @SQL =
            'SELECT TOP 1 @SubsequentOtherEffectiveFrom = i.EFFECTIVE_FROM
            FROM dbo.TB_DIM_ITEM_HIERARCHY_NODE_MEMBER AS m
            JOIN dbo.' + TABLE_NAME + ' AS i ON i.ITEM_URN = m.ITEM_URN
            JOIN dbo.VW_DIM_HIERARCHY_NODE AS n ON n.ITEM_URN = m.HIERARCHY_NODE_URN
            WHERE m.PRECEDENCE = @HierarchyPrecedence
            AND n.HIERARCHY_BUSINESS_URN = @HierarchyBusinessUrn
            AND i.EFFECTIVE_FROM >= @EffectiveFrom
            AND i.ITEM_BIZ_URN = @ItemBusinessUrn        
            AND m.ITEM_TYPE_URN = @ItemTypeUrn
            AND n.ITEM_BIZ_URN <> @HierarchyNodeBusinessUrn
            ORDER BY i.EFFECTIVE_FROM;'
            FROM dbo.TE_DIM_ITEM_TYPE
            WHERE ITEM_TYPE_URN = @ItemTypeUrn;

            EXEC sp_executesql @SQL,
             N'@HierarchyPrecedence INT,
              @HierarchyBusinessUrn INT, 
              @EffectiveFrom DATETIME,
              @ItemBusinessUrn INT,
              @ItemTypeUrn INT, 
              @HierarchyNodeBusinessUrn INT,
              @SubsequentOtherEffectiveFrom DATETIME OUTPUT', 
             @HierarchyPrecedence = @HierarchyPrecedence,
             @HierarchyBusinessUrn = @HierarchyBusinessUrn,
             @EffectiveFrom = @EffectiveFrom,
             @ItemBusinessUrn = @ItemBusinessUrn,
             @ItemTypeUrn = @ItemTypeUrn,
             @HierarchyNodeBusinessUrn = @HierarchyNodeBusinessUrn,
             @SubsequentOtherEffectiveFrom = @SubsequentOtherEffectiveFrom OUTPUT;
            
            SET @SubsequentOtherEffectiveFrom = COALESCE(@SubsequentOtherEffectiveFrom, 2958463) -- 2958463 == 9999-12-31 00:00:00.000;
            
            -- Get all the future surrogates of the item until the subsequent change date
            DELETE @SubsequentItems;
            
            INSERT INTO @SubsequentItems (ITEM_URN, EFFECTIVE_FROM, EFFECTIVE_TO, CHANGE_STAMP)
            SELECT ITEM_URN, EFFECTIVE_FROM, EFFECTIVE_TO, CHANGE_STAMP
            FROM dbo.VW_DIM_ITEM
            WHERE ITEM_BIZ_URN = @ItemBusinessUrn
            AND ITEM_TYPE_URN = @ItemTypeUrn
            AND EFFECTIVE_FROM > @EffectiveFrom AND EFFECTIVE_TO < @SubsequentOtherEffectiveFrom
            OPTION(RECOMPILE);
            
            -- Loop through each item
            WHILE EXISTS(SELECT * FROM @SubsequentItems)
            BEGIN 
                DECLARE @loopItemUrn AS INT,
                        @loopItemEffectiveFrom AS DATETIME,
                        @loopItemEffectiveTo AS DATETIME,
                        @loopItemChangeStamp AS INT,
                        @loopHierarchyNodeSurrogateUrn AS INT,
                        @loopHierarchyNodeSurrogateEffectiveTo AS DATETIME;
                
                -- Get the item
                SELECT TOP 1 @loopItemUrn = ITEM_URN, 
                            @loopItemEffectiveFrom = EFFECTIVE_FROM, 
                            @loopItemEffectiveTo = EFFECTIVE_TO, 
                            @loopItemChangeStamp = CHANGE_STAMP 
                FROM @SubsequentItems 
                ORDER BY EFFECTIVE_FROM;
                
                -- Get the surrogate of the hierarchy node that was effective when then item became effective
                SELECT     @loopHierarchyNodeSurrogateUrn = ITEM_URN,
                        @loopHierarchyNodeSurrogateEffectiveTo = EFFECTIVE_TO
                FROM dbo.VW_DIM_HIERARCHY_NODE 
                WHERE ITEM_BIZ_URN = @HierarchyNodeBusinessUrn
                AND @loopItemEffectiveFrom BETWEEN EFFECTIVE_FROM AND EFFECTIVE_TO;
                
                IF @loopHierarchyNodeSurrogateUrn IS NOT NULL
                BEGIN 
                    -- if the item is not already mapped to the node at the precedence then add it.
                    IF NOT EXISTS(SELECT * FROM dbo.TB_DIM_ITEM_HIERARCHY_NODE_MEMBER
                                    WHERE ITEM_URN = @loopItemUrn
                                    AND ITEM_TYPE_URN = @ItemTypeUrn
                                    AND HIERARCHY_NODE_URN = @loopHierarchyNodeSurrogateUrn
                                    AND PRECEDENCE = @HierarchyPrecedence)
                    BEGIN 
                        INSERT INTO dbo.TB_DIM_ITEM_HIERARCHY_NODE_MEMBER (ITEM_URN, ITEM_TYPE_URN, HIERARCHY_NODE_URN, PRECEDENCE)
                        VALUES (@loopItemUrn, @ItemTypeUrn, @loopHierarchyNodeSurrogateUrn, @HierarchyPrecedence);
                        
                        SELECT @ReturnCode = @@ERROR;
                        IF @ReturnCode <> 0
                        BEGIN 
                            RAISERROR('ap_sch_recursive_associate_disassociate_item: Error adding node mapping for the subsequent surrogate for taxonomy item [%d] to subsequent surrogate of role [%d], Error Code: [%d]', 16, 1, @ItemSurrogateUrn, @HierarchyNodeSurrogateUrn, @ReturnCode) WITH LOG;
                            GOTO EXIT_WITH_ERROR;
                        END;
                    END;
                
                    -- if the current item surrogate's end date is after the end date of the current hierarchy node surrogate's end date
                    -- then create another adjustment surrogate.
                    IF @loopItemEffectiveTo > @loopHierarchyNodeSurrogateEffectiveTo
                    BEGIN 
                        DECLARE @loopOldAdjustedItemSurrogateUrn AS INT,
                                @loopNewAdjustedItemSurrogateUrn AS INT,
                                @loopAdjustmentEffectiveFrom AS DATETIME,
                                @loopSubsequentHierarchyNodeSurrogateUrn AS INT;
                                
                        SET @loopOldAdjustedItemSurrogateUrn = @loopItemUrn;
                        SET @loopNewAdjustedItemSurrogateUrn = @loopItemUrn;
                        SET @loopAdjustmentEffectiveFrom = DATEADD(ss, 1, @loopHierarchyNodeSurrogateEffectiveTo);
                        
                        -- type 2 the item to create an adjustment surrogate
                        exec @ReturnCode = dbo.ap_dim01_do_type2_item @SessionId, @loopNewAdjustedItemSurrogateUrn OUT, @ItemBusinessUrn OUT, @ItemTypeUrn, @loopItemChangeStamp, @loopAdjustmentEffectiveFrom, 0, 1;
                    
                        IF @ReturnCode <> 0
                        BEGIN 
                            GOTO EXIT_WITH_ERROR;
                        END;
                        
                        IF @loopOldAdjustedItemSurrogateUrn <> @loopNewAdjustedItemSurrogateUrn
                        BEGIN 
                            IF @IsItemInvalid = 0
                            BEGIN 
                                SET @ItemSurrogateInvalidFrom = @AdjustmentEffectiveFrom;
                            END;
                            IF @loopItemEffectiveTo > @ItemSurrogateInvalidTo
                            BEGIN 
                                SET @ItemSurrogateInvalidTo = @loopItemEffectiveTo;
                            END;
                            SET @IsItemInvalid = 1;
                        END;
                        
                        -- If there is a subsequent surrogate of the hierarchy node then link the adjustment item surrogate to the subsequent surrogate of the hierarchy node                
                        SELECT @loopSubsequentHierarchyNodeSurrogateUrn = ITEM_URN 
                        FROM dbo.VW_DIM_HIERARCHY_NODE
                        WHERE ITEM_BIZ_URN = @HierarchyNodeBusinessUrn
                        AND @loopAdjustmentEffectiveFrom BETWEEN EFFECTIVE_FROM AND EFFECTIVE_TO;
                        
                        IF @loopSubsequentHierarchyNodeSurrogateUrn IS NOT NULL
                        BEGIN 
                            IF NOT EXISTS(SELECT * FROM dbo.TB_DIM_ITEM_HIERARCHY_NODE_MEMBER
                                    WHERE ITEM_URN = @loopNewAdjustedItemSurrogateUrn
                                    AND ITEM_TYPE_URN = @ItemTypeUrn
                                    AND HIERARCHY_NODE_URN = @loopSubsequentHierarchyNodeSurrogateUrn
                                    AND PRECEDENCE = @HierarchyPrecedence)
                            BEGIN 
                                INSERT INTO dbo.TB_DIM_ITEM_HIERARCHY_NODE_MEMBER (ITEM_URN, ITEM_TYPE_URN, HIERARCHY_NODE_URN, PRECEDENCE)
                                VALUES (@loopNewAdjustedItemSurrogateUrn, @ItemTypeUrn, @loopSubsequentHierarchyNodeSurrogateUrn, @HierarchyPrecedence);
                            
                                SELECT @ReturnCode = @@ERROR;
                                IF @ReturnCode <> 0
                                BEGIN 
                                    RAISERROR('ap_sch_recursive_associate_disassociate_item: Error adding node mapping for the adjustment surrogate for taxonomy item [%d] mapped to role [%d], Error Code: [%d]', 16, 1, @ItemSurrogateUrn, @HierarchyNodeSurrogateUrn, @ReturnCode) WITH LOG;
                                    GOTO EXIT_WITH_ERROR;
                                END;
                            END;
                        END;
                    END;
                END;
                
                DELETE @SubsequentItems WHERE ITEM_URN = @loopItemUrn;
            END;
            
            IF @IsItemInvalid = 1
            BEGIN 
                INSERT INTO @ChangeResultMappingTable (HIERARCHY_CHANGE_ID, ITEM_TYPE_ID, ITEM_BUSINESS_URN, EFFECTIVE_FROM, EFFECTIVE_TO)
                VALUES (@ParentHierarchyChangeId, @ItemTypeId, @ItemBusinessUrn, @ItemSurrogateInvalidFrom, @ItemSurrogateInvalidTo);
            END;
        END;
        
        IF @RequestType = 'D'
        BEGIN 
            IF @NewItemSurrogateUrn <> @ItemSurrogateUrn
            BEGIN 
                INSERT INTO dbo.TB_DIM_ITEM_HIERARCHY_NODE_MEMBER (ITEM_URN, ITEM_TYPE_URN, HIERARCHY_NODE_URN, PRECEDENCE)
                SELECT @NewItemSurrogateUrn, @ItemTypeUrn, HIERARCHY_NODE_URN, PRECEDENCE
                FROM dbo.TB_DIM_ITEM_HIERARCHY_NODE_MEMBER
                WHERE ITEM_URN = @ItemSurrogateUrn
                AND ITEM_TYPE_URN = @ItemTypeUrn
                AND NOT (PRECEDENCE = @HierarchyPrecedence AND HIERARCHY_NODE_URN = @HierarchyNodeSurrogateUrn);
                                
                SELECT @ReturnCode = @@ERROR;
                IF @ReturnCode <> 0
                BEGIN 
                    RAISERROR('ap_sch_recursive_associate_disassociate_item: Error deleting node mapping for taxonomy item [%d] to node [%d], Error Code: [%d]', 16, 1, @NewItemSurrogateUrn, @HierarchyNodeSurrogateUrn, @ReturnCode) WITH LOG;
                    GOTO EXIT_WITH_ERROR;
                END;
                
                SELECT     @ItemSurrogateInvalidFrom = EFFECTIVE_FROM,
                        @ItemSurrogateInvalidTo = EFFECTIVE_TO
                FROM dbo.VW_DIM_ITEM 
                WHERE ITEM_URN = @NewItemSurrogateUrn
                AND ITEM_TYPE_URN = @ItemTypeUrn
                OPTION(RECOMPILE);
                            
                INSERT INTO @ChangeResultMappingTable (HIERARCHY_CHANGE_ID, ITEM_TYPE_ID, ITEM_BUSINESS_URN, EFFECTIVE_FROM, EFFECTIVE_TO)
                VALUES (@ParentHierarchyChangeId, @ItemTypeId, @ItemBusinessUrn, @ItemSurrogateInvalidFrom, @ItemSurrogateInvalidTo);
            END;
            ELSE
            BEGIN 
                DELETE dbo.TB_DIM_ITEM_HIERARCHY_NODE_MEMBER
                WHERE PRECEDENCE = @HierarchyPrecedence
                AND HIERARCHY_NODE_URN = @HierarchyNodeSurrogateUrn
                AND ITEM_URN = @NewItemSurrogateUrn    
                AND ITEM_TYPE_URN = @ItemTypeUrn;
                
                SELECT @ReturnCode = @@ERROR;
                IF @ReturnCode <> 0
                BEGIN 
                    RAISERROR('ap_sch_recursive_associate_disassociate_item: Error deleting node mapping for taxonomy item [%d] to node [%d], Error Code: [%d]', 16, 1, @NewItemSurrogateUrn, @HierarchyNodeSurrogateUrn, @ReturnCode) WITH LOG;
                    GOTO EXIT_WITH_ERROR;
                END;
            END;
            
            -- Get the effective from date of the first future surrogate of the item that is *NOT* linked to a surrogate of the current hierarchy node                        
            SELECT @SQL =
            'SELECT TOP 1 @SubsequentOtherEffectiveFrom = i.EFFECTIVE_FROM
            FROM dbo.TB_DIM_ITEM_HIERARCHY_NODE_MEMBER AS m
            JOIN dbo.' + TABLE_NAME + ' AS i ON i.ITEM_URN = m.ITEM_URN
            JOIN dbo.VW_DIM_HIERARCHY_NODE AS n ON n.ITEM_URN = m.HIERARCHY_NODE_URN
            WHERE m.PRECEDENCE = @HierarchyPrecedence
            AND n.HIERARCHY_BUSINESS_URN = @HierarchyBusinessUrn
            AND i.EFFECTIVE_FROM >= @EffectiveFrom
            AND i.ITEM_BIZ_URN = @ItemBusinessUrn        
            AND m.ITEM_TYPE_URN = @ItemTypeUrn
            AND n.ITEM_BIZ_URN <> @HierarchyNodeBusinessUrn
            ORDER BY i.EFFECTIVE_FROM'
            FROM dbo.TE_DIM_ITEM_TYPE
            WHERE ITEM_TYPE_URN = @ItemTypeUrn;

            EXEC sp_executesql @SQL,
             N'@HierarchyPrecedence INT,
              @HierarchyBusinessUrn INT, 
              @EffectiveFrom DATETIME,
              @ItemBusinessUrn INT,
              @ItemTypeUrn INT, 
              @HierarchyNodeBusinessUrn INT,
              @SubsequentOtherEffectiveFrom DATETIME OUTPUT', 
             @HierarchyPrecedence = @HierarchyPrecedence,
             @HierarchyBusinessUrn = @HierarchyBusinessUrn,
             @EffectiveFrom = @EffectiveFrom,
             @ItemBusinessUrn = @ItemBusinessUrn,
             @ItemTypeUrn = @ItemTypeUrn,
             @HierarchyNodeBusinessUrn = @HierarchyNodeBusinessUrn,
             @SubsequentOtherEffectiveFrom = @SubsequentOtherEffectiveFrom OUTPUT;
                 
            SET @SubsequentOtherEffectiveFrom = COALESCE(@SubsequentOtherEffectiveFrom, 2958463); -- 2958463 == 9999-12-31 00:00:00.000
            
            -- delete membership between any surrogate of the item to all surrogates of the node that were effective on or after
            -- the effective date of the change.
            DELETE dbo.TB_DIM_ITEM_HIERARCHY_NODE_MEMBER
            WHERE ITEM_URN IN (SELECT ITEM_URN FROM dbo.VW_DIM_ITEM WHERE ITEM_BIZ_URN = @ItemBusinessUrn
                            AND ITEM_TYPE_URN = @ItemTypeUrn
                            AND EFFECTIVE_FROM >= @EffectiveFrom AND EFFECTIVE_TO < @SubsequentOtherEffectiveFrom)
            AND ITEM_TYPE_URN = @ItemTypeUrn
            AND HIERARCHY_NODE_URN IN (SELECT ITEM_URN FROM dbo.VW_DIM_HIERARCHY_NODE WHERE ITEM_BIZ_URN = @HierarchyNodeBusinessUrn)
            AND PRECEDENCE = @HierarchyPrecedence
            OPTION(RECOMPILE);
            
            SELECT @ReturnCode = @@ERROR;
            IF @ReturnCode <> 0
            BEGIN 
                RAISERROR('ap_sch_recursive_associate_disassociate_item: Error removing association for item business key [%d] to hierarchy node [%d], Error [%d] ', 16, 1, @ItemBusinessUrn, @HierarchyNodeSurrogateUrn, @ReturnCode) WITH LOG;
                GOTO EXIT_WITH_ERROR;
            END;
        END;
        
        IF @IsPastChange = 1
        BEGIN 
            INSERT INTO dbo.TB_SCH_HIERARCHY_CHANGE_RESULT (HIERARCHY_CHANGE_ID, ITEM_TYPE_ID, ITEM_BUSINESS_URN, EFFECTIVE_FROM, EFFECTIVE_TO)
            SELECT a.HIERARCHY_CHANGE_ID, a.ITEM_TYPE_ID, a.ITEM_BUSINESS_URN, a.EFFECTIVE_FROM, a.EFFECTIVE_TO
            FROM @ChangeResultMappingTable AS a
            WHERE NOT EXISTS(SELECT * FROM dbo.TB_SCH_HIERARCHY_CHANGE_RESULT AS b
                            WHERE a.HIERARCHY_CHANGE_ID = b.HIERARCHY_CHANGE_ID
                            AND a.ITEM_TYPE_ID = b.ITEM_TYPE_ID
                            AND a.ITEM_BUSINESS_URN = b.ITEM_BUSINESS_URN
                            AND a.EFFECTIVE_FROM = b.EFFECTIVE_FROM
                            AND a.EFFECTIVE_TO = b.EFFECTIVE_TO                            
                            );
                    
            SELECT @ReturnCode = @@ERROR;
            IF @ReturnCode <> 0
            BEGIN 
                RAISERROR('ap_sch_recursive_associate_disassociate_item: Error inserting hierarchy change result data. Error[%d]', 16, 1, @ReturnCode) WITH LOG;
                GOTO EXIT_WITH_ERROR;
            END;
        END;
        
        -- Type 2 all the items of the same item type assocated with all the child nodes
        WHILE EXISTS(SELECT * FROM @ChildNodesTable)
        BEGIN 
            DECLARE @ChildNodeUrn INT;
            SELECT TOP 1 @ChildNodeUrn = ITEM_URN FROM @ChildNodesTable ORDER BY [ITEM_URN];
            
            exec @ReturnCode = dbo.ap_sch_recursive_associate_disassociate_item_children @SessionId, @ParentHierarchyChangeId, @ChildNodeUrn, @ItemTypeUrn, @EffectiveFrom, @IgnoreConsolidationPeriod;
            
            IF @ReturnCode <> 0
            BEGIN 
                GOTO EXIT_WITH_ERROR;
            END;
            
            DELETE @ChildNodesTable WHERE ITEM_URN = @ChildNodeUrn;
        END;
    IF @InitialTransactionCount = 0 
    BEGIN 
           COMMIT TRANSACTION AssDisItemTransaction;
    END;
    ELSE BEGIN 
        WHILE @@TRANCOUNT > @InitialTransactionCount
        BEGIN 
           COMMIT TRANSACTION;
        END;
    END;
    
    
    GOTO EXIT_SPROC;
    
    EXIT_WITH_ERROR:
        DECLARE @ErrorMessage VARCHAR(200);
        IF @InitialTransactionCount = 0 AND @@TRANCOUNT > 0
        BEGIN 
            ROLLBACK TRANSACTION;
        END;
        ELSE IF @InitialTransactionCount <> 0 AND @@TRANCOUNT > @InitialTransactionCount
        BEGIN 
            IF (XACT_STATE()) = -1
            BEGIN 
                SET @ErrorMessage = ISNULL(@ErrorMessage,OBJECT_NAME(@@PROCID))+' [Uncommittable Transaction!]';
                ROLLBACK TRANSACTION;
                -- THIS IS TO AVOID TRANSACTION MISMATCHES IN THE CALLING APPLICATION
                DECLARE @transactionFake INT = @@TRANCOUNT;
                WHILE @transactionFake < @InitialTransactionCount
                BEGIN 
                    BEGIN TRANSACTION;
                    SET @transactionFake = @transactionFake + 1;
                END;
            END;
            ELSE BEGIN 
                WHILE @@TRANCOUNT > @InitialTransactionCount
                BEGIN 
                    COMMIT TRANSACTION;
                END;
            END;
            SET @ErrorMessage = ISNULL(@ErrorMessage,OBJECT_NAME(@@PROCID));
            RAISERROR(@ErrorMessage, 16, 1) WITH LOG;
        END;
    
    EXIT_SPROC:    
        RETURN @ReturnCode;
GO
