SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE dbo.ap_sch_revert_hierarchy_change_item
(
    @SessionId AS UNIQUEIDENTIFIER,
    @ParentHierarchyChangeId AS UNIQUEIDENTIFIER,
    @HierarchyChangeItemId AS UNIQUEIDENTIFIER
)
AS
    SET NOCOUNT ON;
    
    DECLARE @InitialTransactionCount AS INT,
            @ReturnCode AS INT,
            @HierarchyBusinessUrn AS INT,
            @HierarchyChangeId AS UNIQUEIDENTIFIER,
            @EffectiveFrom AS DATETIME,
            @SubsequentOtherEffectiveFrom AS DATETIME,
            @Status AS CHAR(1),
            @RequestType AS CHAR(1),
            @PrimaryNodeId AS UNIQUEIDENTIFIER,
            @RequestData AS XML,
            @AssociationPrecedence AS INT,            
            @NodeSurrogateItemUrn AS INT,
            @NodeSurrogateBusinessUrn AS INT,
            @NodeSurrogateHierarchyParentBusinessUrn AS INT,
            @NodeSurrogateDescription AS NVARCHAR(500),
            @NodeSurrogateCustomXmlData AS XML,
            @PreviousNodeSurrogateItemUrn AS INT,
            @PreviousNodeSurrogateDescription AS NVARCHAR(500),
            @PreviousNodeSurrogateHierarchyParentUrn AS INT,
            @PreviousNodeSurrogateHierarchyParentBusinessUrn AS INT,
            @ItemSurrogateBusinessUrn AS INT,
            @ItemSurrogateTypeUrn AS INT;
            
    SET @InitialTransactionCount = @@TRANCOUNT;
    SET @ReturnCode = 0;
    
    IF @HierarchyChangeItemId IS NULL
    BEGIN 
        GOTO EXIT_SPROC;
    END;
    
    SELECT     @HierarchyChangeId = hc.HIERARCHY_CHANGE_ID,
            @HierarchyBusinessUrn = hc.HIERARCHY_BUSINESS_URN,
            @EffectiveFrom = hc.EFFECTIVE_FROM,
            @Status = hc.STATUS,
            @RequestType = hci.REQUEST_TYPE,
            @PrimaryNodeId = hci.HIERARCHY_NODE_ID,
            @RequestData = hci.REQUEST_DATA
    FROM dbo.TB_SCH_HIERARCHY_CHANGE AS hc
    JOIN dbo.TB_SCH_HIERARCHY_CHANGE_ITEM AS hci ON hc.HIERARCHY_CHANGE_ID = hci.HIERARCHY_CHANGE_ID
    WHERE hci.HIERARCHY_CHANGE_ITEM_ID = @HierarchyChangeItemId;
    
    -- if the change item is not present in the database then just return
    IF @@ROWCOUNT = 0
    BEGIN 
        GOTO EXIT_SPROC;
    END;
    
    BEGIN TRANSACTION SchRevTransaction;
        IF @Status = 'C'
        BEGIN 
            -- Get the affected surrogate
            SELECT     @NodeSurrogateItemUrn = n.ITEM_URN, 
                    @NodeSurrogateBusinessUrn = n.ITEM_BIZ_URN,
                    @NodeSurrogateDescription = n.DESCRIPTION,
                    @NodeSurrogateCustomXmlData = n.CUSTOM_XML_DATA,
                    @NodeSurrogateHierarchyParentBusinessUrn = p.ITEM_BIZ_URN 
            FROM dbo.TB_DIM_HIERARCHY_NODE AS n
            JOIN dbo.TB_DIM_HIERARCHY_NODE AS p ON p.ITEM_URN = n.HIERARCHY_PARENT_URN
            WHERE n.NODE_ID = @PrimaryNodeId AND @EffectiveFrom BETWEEN n.EFFECTIVE_FROM AND n.EFFECTIVE_TO;
            
            -- Get the previous surrogate of the node based on its PrimaryNodeId
            SELECT TOP 1 @PreviousNodeSurrogateItemUrn = n.ITEM_URN, 
                    @PreviousNodeSurrogateDescription = n.DESCRIPTION,
                    @PreviousNodeSurrogateHierarchyParentBusinessUrn = p.ITEM_BIZ_URN,
                    @PreviousNodeSurrogateHierarchyParentUrn = p.ITEM_URN
            FROM dbo.TB_DIM_HIERARCHY_NODE AS n
            JOIN dbo.TB_DIM_HIERARCHY_NODE AS p ON p.ITEM_URN = n.HIERARCHY_PARENT_URN
            WHERE n.NODE_ID = @PrimaryNodeId AND n.EFFECTIVE_TO < @EffectiveFrom
            ORDER BY n.EFFECTIVE_TO DESC;
            
            -- If the request was a MOVE REQUEST
            IF @RequestType = 'M'
            BEGIN 
                -- Update the affected surrogates hierarchy parent urn to that of the previous surrogate of the affected surrogate
                UPDATE dbo.TB_DIM_HIERARCHY_NODE SET HIERARCHY_PARENT_URN = @PreviousNodeSurrogateHierarchyParentUrn
                WHERE ITEM_URN = @NodeSurrogateItemUrn;
                
                SELECT @ReturnCode = @@ERROR;
                IF @ReturnCode <> 0
                BEGIN 
                    RAISERROR('ap_sch_revert_hierarchy_change_item: Error update surrogate hierarchy node [%d], Request Type [%s], Error [%d] ', 16, 1, @NodeSurrogateItemUrn, @RequestType, @ReturnCode) WITH LOG;
                    GOTO EXIT_WITH_ERROR;
                END;
                
                -- Find the first surrogate of the affected surrogate in future where the hierarchy parent surrogate is different to that of
                -- the affected surrogates previous surrogate
                SELECT TOP 1 @SubsequentOtherEffectiveFrom = fsur.EFFECTIVE_FROM
                FROM dbo.VW_DIM_HIERARCHY_NODE AS fsur
                JOIN dbo.VW_DIM_HIERARCHY_NODE AS csur ON fsur.ITEM_BIZ_URN = csur.ITEM_BIZ_URN
                WHERE csur.ITEM_URN = @NodeSurrogateItemUrn
                and fsur.EFFECTIVE_FROM >  @EffectiveFrom
                AND fsur.HIERARCHY_PARENT_URN NOT IN (SELECT ITEM_URN FROM dbo.VW_DIM_HIERARCHY_NODE WHERE ITEM_BIZ_URN = @NodeSurrogateHierarchyParentBusinessUrn)
                ORDER BY fsur.EFFECTIVE_FROM;
                
                SET @SubsequentOtherEffectiveFrom = COALESCE(@SubsequentOtherEffectiveFrom, 2958463); -- 2958463 == 9999-12-31 00:00:00.000
                
                -- Update the hierarchy parent of any future surrogates of the affected surrogate
                -- to the correct surrogate of the hierarchy parent business urn  of the previous surrogate of the affected surrogate.
                
                UPDATE dbo.VW_DIM_HIERARCHY_NODE SET HIERARCHY_PARENT_URN = cust.NEW_PARENT_URN
                FROM dbo.VW_DIM_HIERARCHY_NODE AS nodes
                JOIN (SELECT n1.ITEM_URN, n1.HIERARCHY_PARENT_URN, n1.EFFECTIVE_FROM, n1.EFFECTIVE_TO, (SELECT TOP 1 a.ITEM_URN
                                                                                FROM dbo.VW_DIM_HIERARCHY_NODE AS n
                                                                                JOIN dbo.VW_DIM_HIERARCHY_NODE AS a ON a.ITEM_BIZ_URN = n.ITEM_BIZ_URN
                                                                                WHERE n.ITEM_URN = @PreviousNodeSurrogateHierarchyParentUrn
                                                                                AND n1.EFFECTIVE_FROM BETWEEN a.EFFECTIVE_FROM AND a.EFFECTIVE_TO
                                                                                ORDER BY a.ITEM_URN) AS NEW_PARENT_URN
                    FROM dbo.VW_DIM_HIERARCHY_NODE AS n1
                    JOIN dbo.VW_DIM_HIERARCHY_NODE AS n2 ON n2.ITEM_BIZ_URN = n1.ITEM_BIZ_URN
                    WHERE n2.ITEM_URN = @NodeSurrogateItemUrn
                    AND n1.EFFECTIVE_FROM > @EffectiveFrom AND n1.EFFECTIVE_TO < @SubsequentOtherEffectiveFrom
                    AND n1.HIERARCHY_PARENT_URN IN (SELECT ITEM_URN FROM dbo.VW_DIM_HIERARCHY_NODE WHERE ITEM_BIZ_URN = @NodeSurrogateHierarchyParentBusinessUrn)
                ) AS cust ON cust.ITEM_URN = nodes.ITEM_URN;
                
                SELECT @ReturnCode = @@ERROR;
                IF @ReturnCode <> 0
                BEGIN 
                    RAISERROR('ap_sch_revert_hierarchy_change_item: Error update future surrogates of node [%d], Request Type [%s], Error [%d] ', 16, 1, @NodeSurrogateItemUrn, @RequestType, @ReturnCode) WITH LOG;
                    GOTO EXIT_WITH_ERROR;
                END;
            END;
            
            -- If the request was a SET ATTRIBUTE REQUEST
            IF @RequestType = 'C'
            BEGIN 
                DECLARE @HierarchyNodeAttributeName AS NVARCHAR(100),
                        @HierarchyNodeAttributeValue AS NVARCHAR(100),
                        @HierarchyNodeAttributeOldValue AS NVARCHAR(100),
                        @IsHierarchyNodeAttributeCustom AS BIT;
                        
                SELECT     @HierarchyNodeAttributeName = @RequestData.value('(/SetHierarchyNodeAttributeRequest/AttributeName)[1]', 'nvarchar(100)'),
                        @HierarchyNodeAttributeValue = @RequestData.value('(/SetHierarchyNodeAttributeRequest/AttributeValue)[1]', 'nvarchar(100)'),
                        @HierarchyNodeAttributeOldValue = @RequestData.value('(/SetHierarchyNodeAttributeRequest/OldValue[@xsi:nil!="true" or not(@xsi:nil)])[1]', 'nvarchar(100)'),
                        @IsHierarchyNodeAttributeCustom = @RequestData.value('(/SetHierarchyNodeAttributeRequest/IsCustom)[1]', 'bit');
                
                -- If it is not a custom attribute
                IF @IsHierarchyNodeAttributeCustom = 0
                BEGIN 
                    IF UPPER(@HierarchyNodeAttributeName) = 'NAME'                
                    BEGIN 
                        -- Update the name and internal name to that of the previous surrogate.
                        UPDATE dbo.TB_DIM_HIERARCHY_NODE SET NAME = @HierarchyNodeAttributeOldValue
                        WHERE NODE_ID = @PrimaryNodeId;
                        
                        SELECT @ReturnCode = @@ERROR;
                        IF @ReturnCode <> 0
                        BEGIN 
                            RAISERROR('ap_sch_revert_hierarchy_change_item: Error update hierarchy node [%d], Request Type [%s], Error [%d] ', 16, 1, @NodeSurrogateBusinessUrn, @RequestType, @ReturnCode) WITH LOG;
                            GOTO EXIT_WITH_ERROR;
                        END;
                    END;
                                            
                    IF UPPER(@HierarchyNodeAttributeName) = 'DESCRIPTION'                                            
                    BEGIN 
                        -- Update the description to that of the previous surrogate.
                        UPDATE dbo.TB_DIM_HIERARCHY_NODE SET DESCRIPTION = COALESCE(@HierarchyNodeAttributeOldValue, '')
                        WHERE NODE_ID = @PrimaryNodeId;
                        
                        SELECT @ReturnCode = @@ERROR;
                        IF @ReturnCode <> 0
                        BEGIN 
                            RAISERROR('ap_sch_revert_hierarchy_change_item: Error update hierarchy node [%d], Request Type [%s], Error [%d] ', 16, 1, @NodeSurrogateBusinessUrn, @RequestType, @ReturnCode) WITH LOG;
                            GOTO EXIT_WITH_ERROR;
                        END;
                    END;        
                END;
                ELSE
                BEGIN 
                    -- If the attribute value was updated then update it to its old value. This will also handle revert of a request to remove custom attribute.
                    IF @HierarchyNodeAttributeOldValue IS NULL OR (@HierarchyNodeAttributeOldValue IS NOT NULL AND UPPER(@HierarchyNodeAttributeOldValue) <> '##ADD##')
                    BEGIN 
                        -- Reset the attribute value to the old value
                        IF @NodeSurrogateCustomXmlData IS NULL
                        BEGIN 
                            IF @HierarchyNodeAttributeOldValue IS NULL
                            BEGIN 
                                SET @NodeSurrogateCustomXmlData = '<Columns><Column Name="'+@HierarchyNodeAttributeName+'" DataType="String" IsNull="true"></Column></Columns>';
                            END;
                            ELSE BEGIN 
                                SET @NodeSurrogateCustomXmlData = '<Columns><Column Name="'+@HierarchyNodeAttributeName+'" DataType="String">'+@HierarchyNodeAttributeOldValue+'</Column></Columns>';
                            END;
                        END;
                        ELSE
                        BEGIN 
                            -- If the attribute exists then remove it
                            IF @NodeSurrogateCustomXmlData.exist('/Columns/Column[@Name=sql:variable("@HierarchyNodeAttributeName")]') = 1
                            BEGIN 
                                SET @NodeSurrogateCustomXmlData.modify('delete /Columns/Column[@Name= sql:variable("@HierarchyNodeAttributeName")]');
                            END;
                                
                            IF @HierarchyNodeAttributeOldValue IS NOT NULL
                            BEGIN 
                                SET @NodeSurrogateCustomXmlData.modify('insert <Column Name="{sql:variable("@HierarchyNodeAttributeName")}" DataType="String">{sql:variable("@HierarchyNodeAttributeOldValue")}</Column> as last into (/Columns)[1]');
                            END;
                            ELSE BEGIN 
                                SET @NodeSurrogateCustomXmlData.modify('insert <Column Name="{sql:variable("@HierarchyNodeAttributeName")}" DataType="String" IsNull="true"></Column> as last into (/Columns)[1]');
                            END;
                        END;
                    END;
                    
                    -- If the attribute was added then remove it
                    IF @HierarchyNodeAttributeOldValue IS NOT NULL AND UPPER(@HierarchyNodeAttributeOldValue) = '##ADD##'
                    BEGIN 
                        -- If the attribute exists in the custom xml data then remove it.
                        IF @NodeSurrogateCustomXmlData.exist('/Columns/Column[@Name=sql:variable("@HierarchyNodeAttributeName")]') = 1
                        BEGIN 
                            SET @NodeSurrogateCustomXmlData.modify('delete /Columns/Column[@Name= sql:variable("@HierarchyNodeAttributeName")]');
                        END;
                    END;
                    
                    -- If the custom xml does not contain any columns then set it back to null.
                    IF @NodeSurrogateCustomXmlData.exist('//Column') = 0
                    BEGIN 
                        SET @NodeSurrogateCustomXmlData = NULL;
                    END;
                    
                    UPDATE dbo.TB_DIM_HIERARCHY_NODE 
                    SET CUSTOM_XML_DATA = @NodeSurrogateCustomXmlData
                    WHERE NODE_ID = @PrimaryNodeId;
                END;
            END;
            
            -- If the request was an ADD NODE request
            IF @RequestType = 'N'
            BEGIN 
                exec @ReturnCode = dbo.ap_sch_recursive_purge_hierarchy_node @SessionId, @NodeSurrogateItemUrn;
                IF @ReturnCode <> 0
                BEGIN 
                    GOTO EXIT_WITH_ERROR;
                END;
            END;
            
            -- If it was a REMOVE NODE request
            IF @RequestType = 'R'
            BEGIN 
                SELECT     @NodeSurrogateItemUrn = n.ITEM_URN, 
                        @NodeSurrogateBusinessUrn = n.ITEM_BIZ_URN,
                        @NodeSurrogateDescription = n.DESCRIPTION,
                        @NodeSurrogateHierarchyParentBusinessUrn = p.ITEM_BIZ_URN 
                FROM dbo.VW_DIM_HIERARCHY_NODE AS n
                JOIN dbo.VW_DIM_HIERARCHY_NODE AS p ON p.ITEM_URN = n.HIERARCHY_PARENT_URN
                WHERE n.NODE_ID = @PrimaryNodeId AND DATEADD(ss, -1, @EffectiveFrom) BETWEEN n.EFFECTIVE_FROM AND n.EFFECTIVE_TO;
                
                exec @ReturnCode = dbo.ap_sch_recursive_undelete_hierarchy_node @SessionId, @NodeSurrogateItemUrn;
                IF @ReturnCode <> 0
                BEGIN 
                    GOTO EXIT_WITH_ERROR;
                END;
            END;
            
            -- If the request was an ASSOCIATION request
            IF @RequestType = 'A'
            BEGIN 
                SELECT     @ItemSurrogateBusinessUrn = @RequestData.value('(/AssociateHierarchyItemRequest/ItemBusinessUrn)[1]', 'int'),
                        @ItemSurrogateTypeUrn = (SELECT ITEM_TYPE_URN FROM dbo.TE_DIM_ITEM_TYPE WHERE INTERNAL_NAME = @RequestData.value('(/AssociateHierarchyItemRequest/ItemType)[1]', 'nvarchar(100)')),
                        @AssociationPrecedence = @RequestData.value('(/AssociateHierarchyItemRequest/Precedence)[1]', 'int');
                                
                DECLARE @SQL NVARCHAR(2000);

                SELECT @SQL =
                'SELECT TOP 1 @SubsequentOtherEffectiveFrom = i.EFFECTIVE_FROM
                FROM dbo.TB_DIM_ITEM_HIERARCHY_NODE_MEMBER AS m
                JOIN dbo.' + TABLE_NAME + ' AS i ON i.ITEM_URN = m.ITEM_URN
                JOIN dbo.VW_DIM_HIERARCHY_NODE AS n ON n.ITEM_URN = m.HIERARCHY_NODE_URN
                WHERE m.PRECEDENCE = @AssociationPrecedence
                AND n.HIERARCHY_BUSINESS_URN = @HierarchyBusinessUrn
                AND i.EFFECTIVE_FROM >= @EffectiveFrom
                AND i.ITEM_BIZ_URN = @ItemSurrogateBusinessUrn        
                AND m.ITEM_TYPE_URN = @ItemSurrogateTypeUrn
                AND n.ITEM_BIZ_URN <> @NodeSurrogateBusinessUrn
                ORDER BY i.EFFECTIVE_FROM;'
                FROM dbo.TE_DIM_ITEM_TYPE
                WHERE ITEM_TYPE_URN = @ItemSurrogateTypeUrn;

                EXEC sp_executesql @SQL,
                 N'@AssociationPrecedence INT,
                  @HierarchyBusinessUrn INT, 
                  @EffectiveFrom DATETIME,
                  @ItemSurrogateBusinessUrn INT,
                  @ItemSurrogateTypeUrn INT, 
                  @NodeSurrogateBusinessUrn INT,
                  @SubsequentOtherEffectiveFrom DATETIME OUTPUT', 
                 @AssociationPrecedence = @AssociationPrecedence,
                 @HierarchyBusinessUrn = @HierarchyBusinessUrn,
                 @EffectiveFrom = @EffectiveFrom,
                 @ItemSurrogateBusinessUrn = @ItemSurrogateBusinessUrn,
                 @ItemSurrogateTypeUrn = @ItemSurrogateTypeUrn,
                 @NodeSurrogateBusinessUrn = @NodeSurrogateBusinessUrn,
                 @SubsequentOtherEffectiveFrom = @SubsequentOtherEffectiveFrom OUTPUT;
                
                SET @SubsequentOtherEffectiveFrom = COALESCE(@SubsequentOtherEffectiveFrom, 2958463); -- 2958463 == 9999-12-31 00:00:00.000
                
                -- delete membership between any surrogate of the item to all surrogates of the node that were effective on or after
                -- the effective date of the change.
                DELETE dbo.TB_DIM_ITEM_HIERARCHY_NODE_MEMBER
                WHERE ITEM_URN IN (SELECT ITEM_URN FROM dbo.VW_DIM_ITEM WHERE ITEM_BIZ_URN = @ItemSurrogateBusinessUrn AND ITEM_TYPE_URN = @ItemSurrogateTypeUrn
                                AND EFFECTIVE_FROM >= @EffectiveFrom AND EFFECTIVE_TO < @SubsequentOtherEffectiveFrom)
                AND ITEM_TYPE_URN = @ItemSurrogateTypeUrn
                AND HIERARCHY_NODE_URN IN (SELECT ITEM_URN FROM dbo.VW_DIM_HIERARCHY_NODE WHERE ITEM_BIZ_URN = @NodeSurrogateBusinessUrn)
                AND PRECEDENCE = @AssociationPrecedence
                OPTION (RECOMPILE);
                    
                SELECT @ReturnCode = @@ERROR;
                IF @ReturnCode <> 0
                BEGIN 
                    RAISERROR('ap_sch_revert_hierarchy_change_item: Error reverting association request for item business key [%d] to hierarchy node [%d], Request Type [%s], Error [%d] ', 16, 1, @ItemSurrogateBusinessUrn, @NodeSurrogateItemUrn, @RequestType, @ReturnCode) WITH LOG;
                    GOTO EXIT_WITH_ERROR;
                END;
            END;
            
            -- If the request was a DISASSOCIATION request
            IF @RequestType = 'D'
            BEGIN 
                SELECT     @ItemSurrogateBusinessUrn = @RequestData.value('(/DisassociateHierarchyItemRequest/ItemBusinessUrn)[1]', 'int'),
                        @ItemSurrogateTypeUrn = (SELECT ITEM_TYPE_URN FROM dbo.TE_DIM_ITEM_TYPE WHERE INTERNAL_NAME = @RequestData.value('(/DisassociateHierarchyItemRequest/ItemType)[1]', 'nvarchar(100)')),
                        @AssociationPrecedence = @RequestData.value('(/DisassociateHierarchyItemRequest/Precedence)[1]', 'int');
                
                exec @ReturnCode = dbo.ap_sch_recursive_associate_disassociate_item @SessionId, @ParentHierarchyChangeId, @HierarchyChangeId, 'A', @PrimaryNodeId, @ItemSurrogateBusinessUrn, @ItemSurrogateTypeUrn, @AssociationPrecedence, @EffectiveFrom;
                
                IF @ReturnCode <> 0
                BEGIN 
                    GOTO EXIT_WITH_ERROR;
                END;
            END;    
        END;
        
        -- Deleted the reverted request
        DELETE dbo.TB_SCH_HIERARCHY_CHANGE_ITEM WHERE HIERARCHY_CHANGE_ITEM_ID = @HierarchyChangeItemId;
    IF @InitialTransactionCount = 0 
    BEGIN 
           COMMIT TRANSACTION SchRevTransaction;
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
