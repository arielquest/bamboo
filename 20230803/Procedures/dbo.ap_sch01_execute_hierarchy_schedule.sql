SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE dbo.ap_sch01_execute_hierarchy_schedule
    (
      @SessionId AS UNIQUEIDENTIFIER,
      @HierarchyChangeId AS UNIQUEIDENTIFIER
    )
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @InitialTransactionCount AS INT = @@TRANCOUNT,
        @ErrorMessage AS NVARCHAR(255),
        @ReturnCode AS INT = 0,
        @ItemBusinessUrn AS INT,
        @ItemTypeUrn AS INT,
        @EffectiveFrom AS DATETIME,
        @Status AS CHAR(1),
        @HierarchyBusinessUrn INT,
        @HierarchyNodeUrn INT,
        @DefaultFolderId AS UNIQUEIDENTIFIER,
        @DefaultOwnerId AS UNIQUEIDENTIFIER,
        @HierarchyChangeItemId AS UNIQUEIDENTIFIER,
        @HierarchyNodeName AS NVARCHAR(100),
        @HierarchyNodeDescription AS NVARCHAR(500),
        @HierarchyNodeId AS UNIQUEIDENTIFIER,
        @HierarchyNodeParentId AS UNIQUEIDENTIFIER,
        @HierarchyNodeToParentId AS UNIQUEIDENTIFIER,
        @HierarchyParentUrn AS INT,
        @RequestData AS XML,
        @HierarchyPrecedence AS INT,
        @NodeUrn AS INT,
        @ToParentUrn AS INT,
        @IsPastChange AS BIT = 0,
        @HistoricalEscalationPeriod AS INT = 1440 /*default is 1 day (1440 minutes)*/,
        @RequestType AS CHAR(1),
        @HierarchyNodeAttributeName NVARCHAR(100),
        @HierarchyNodeAttributeValue NVARCHAR(100),
        @IsHierarchyNodeAttributeCustom BIT,
        @HierarchyNodeCustomXmlData XML,
        @SubsequentOtherEffectiveFrom AS DATETIME;
            
    BEGIN TRY   
        -- Check Session Id
        IF @SessionId IS NULL
        BEGIN 
            SET @ReturnCode = 50157;
            RAISERROR(50157, 16, 5, 'ap_sch01_execute_hierarchy_schedule');
        END;
    
        -- Check Hierarchy Change Id
        IF @HierarchyChangeId IS NULL
        BEGIN 
            SET @ErrorMessage = N'ap_sch01_execute_hierarchy_schedule: Hierarchy change ID not specified';
            SET @ReturnCode = -1;
            RAISERROR(@ErrorMessage, 16, 1);
        END;
    
        SELECT TOP 1
                @EffectiveFrom = [hc].[EFFECTIVE_FROM],
                @Status = [hc].[STATUS],
                @DefaultFolderId = [h].[FOLDER_ID],
                @DefaultOwnerId = [h].[OWNER_ID],
                @HierarchyBusinessUrn = [hc].[HIERARCHY_BUSINESS_URN]
        FROM    [dbo].[TB_SCH_HIERARCHY_CHANGE] AS hc
        JOIN    [dbo].[VW_DIM_HIERARCHY] AS h ON [hc].[HIERARCHY_BUSINESS_URN] = [h].[ITEM_BIZ_URN]
                                                 AND [hc].[EFFECTIVE_FROM] BETWEEN [h].[EFFECTIVE_FROM]
                                                              AND
                                                              [h].[EFFECTIVE_TO]
        WHERE   [hc].[HIERARCHY_CHANGE_ID] = @HierarchyChangeId
        ORDER BY [hc].[HIERARCHY_CHANGE_ID];
    
        IF @@ROWCOUNT <> 1
        BEGIN 
            SET @ErrorMessage = N'ap_sch01_execute_hierarchy_schedule: Could not retrieve data for hierarchy change schedule ID ['
                + CAST(@HierarchyChangeId AS NVARCHAR(50)) + ']';
            SET @ReturnCode = -1;
            RAISERROR(@ErrorMessage, 16, 1);
        END;
    
        -- If the schedule has been executed successfully earlier then just return
        IF @Status <> 'C'
        BEGIN 
            -- Check if there are any hierarchy changes for the current hierarchy business urn pending that were created before the current change
            DECLARE @EarliestChangeRequest AS UNIQUEIDENTIFIER;
    
            SELECT TOP 1
                    @EarliestChangeRequest = [hc].[HIERARCHY_CHANGE_ID]
            FROM    [dbo].[TB_SCH_HIERARCHY_CHANGE] hc
            JOIN    [dbo].[TB_SCH_HIERARCHY_CHANGE_ITEM] item ON [hc].[HIERARCHY_CHANGE_ID] = [item].[HIERARCHY_CHANGE_ID]
            WHERE   [hc].[STATUS] <> 'C'
                    AND [hc].[HIERARCHY_BUSINESS_URN] = @HierarchyBusinessUrn
                    AND [hc].[EFFECTIVE_FROM] <= GETUTCDATE()
            ORDER BY [hc].[EFFECTIVE_FROM],
                    [item].[REQUEST_DATETIME];
    
            IF ( @HierarchyChangeId <> @EarliestChangeRequest )
            BEGIN 
                SET @ErrorMessage = N'ap_sch01_execute_hierarchy_schedule: There are hierarchy changes pending completion that were created before current change ['
                    + CAST(@HierarchyChangeId AS NVARCHAR(50)) + ']';
                SET @ReturnCode = -1;
                RAISERROR(@ErrorMessage, 16, 1);
            END;

            -- default is 1 day (1440 minutes)
            SELECT  @HistoricalEscalationPeriod = COALESCE(CAST(PROPERTY_VALUE AS INT),
                                                           1440)
            FROM    [dbo].[TB_ADM_PROPERTY]
            WHERE   PROPERTY_KEY = 'PROP_TYPE2_HISTORICAL_ESCALATION_PERIOD';
        
            DECLARE @HierarchyChangeItem AS TABLE
                (
                  EXECUTION_SEQUENCE INT IDENTITY(1, 1),
                  HIERARCHY_CHANGE_ITEM_ID UNIQUEIDENTIFIER,
                  REQUEST_TYPE CHAR(1),
                  REQUEST_DATETIME DATETIME,
                  HIERARCHY_NODE_ID UNIQUEIDENTIFIER,
                  REQUEST_DATA XML
                );
    
            BEGIN TRANSACTION SchXecTransaction;
    
            DECLARE @StartSequence INT,
                @EndSequence INT,
                @CurrentSequence INT,
                @TotalChanges INT;
        
            SET @StartSequence = -1;
            SET @EndSequence = -1;
            -- Do the reverts first
            INSERT  INTO @HierarchyChangeItem
                    (
                      HIERARCHY_CHANGE_ITEM_ID,
                      REQUEST_TYPE,
                      REQUEST_DATETIME,
                      HIERARCHY_NODE_ID,
                      REQUEST_DATA
                    )
            SELECT  HIERARCHY_CHANGE_ITEM_ID,
                    REQUEST_TYPE,
                    REQUEST_DATETIME,
                    HIERARCHY_NODE_ID,
                    REQUEST_DATA
            FROM    [dbo].[TB_SCH_HIERARCHY_CHANGE_ITEM]
            WHERE   HIERARCHY_CHANGE_ID = @HierarchyChangeId
                    AND REQUEST_TYPE = 'Z'
            ORDER BY REQUEST_DATETIME;
        
            SELECT  @StartSequence = COALESCE(MIN(EXECUTION_SEQUENCE), -1),
                    @EndSequence = COALESCE(MAX(EXECUTION_SEQUENCE), -1)
            FROM    @HierarchyChangeItem;
        
            IF @StartSequence <> -1
            BEGIN 
                DECLARE @HierarchyChangeItemIdToRevert AS UNIQUEIDENTIFIER;
            
                SET @CurrentSequence = @StartSequence;
                WHILE @CurrentSequence <= @EndSequence
                BEGIN 
                    SELECT  @HierarchyChangeItemId = HIERARCHY_CHANGE_ITEM_ID,
                            @RequestType = REQUEST_TYPE,
                            @HierarchyNodeId = HIERARCHY_NODE_ID,
                            @RequestData = REQUEST_DATA
                    FROM    @HierarchyChangeItem
                    WHERE   EXECUTION_SEQUENCE = @CurrentSequence;
                
                    IF @@ROWCOUNT <> 0
                    BEGIN 
                        SELECT  @HierarchyChangeItemIdToRevert = @RequestData.value('(/RevertHierarchyChangeRequest/RequestIdToRevert)[1]',
                                                              'uniqueidentifier');
                
                        EXEC @ReturnCode = [dbo].[ap_sch_revert_hierarchy_change_item] @SessionId,
                            @HierarchyChangeId, @HierarchyChangeItemIdToRevert;
                
                        IF @ReturnCode <> 0
                        BEGIN 
                            SET @ErrorMessage = 'ap_sch_revert_hierarchy_change_item returned ['
                                + CAST(@ReturnCode AS VARCHAR(20))+']';
                            RAISERROR(@ErrorMessage, 16, 1);
                        END;
                
                        -- Delete the revert request when the change associated with it has been reverted.
                        DELETE  [dbo].[TB_SCH_HIERARCHY_CHANGE_ITEM]
                        WHERE   HIERARCHY_CHANGE_ITEM_ID = @HierarchyChangeItemId;

                    END;
                                                
                    SET @HierarchyChangeItemIdToRevert = NULL;
                    SET @CurrentSequence = @CurrentSequence + 1;
                END;
            END;
        
            DELETE  @HierarchyChangeItem;
        
            SET @StartSequence = -1;
            SET @EndSequence = -1;
    
            INSERT  INTO @HierarchyChangeItem
                    (
                      HIERARCHY_CHANGE_ITEM_ID,
                      REQUEST_TYPE,
                      REQUEST_DATETIME,
                      HIERARCHY_NODE_ID,
                      REQUEST_DATA
                    )
            SELECT  HIERARCHY_CHANGE_ITEM_ID,
                    REQUEST_TYPE,
                    REQUEST_DATETIME,
                    HIERARCHY_NODE_ID,
                    REQUEST_DATA
            FROM    [dbo].[TB_SCH_HIERARCHY_CHANGE_ITEM]
            WHERE   HIERARCHY_CHANGE_ID = @HierarchyChangeId
                    AND REQUEST_TYPE <> 'Z'
            ORDER BY REQUEST_DATETIME;
        
            SELECT  @StartSequence = COALESCE(MIN(EXECUTION_SEQUENCE), -1),
                    @EndSequence = COALESCE(MAX(EXECUTION_SEQUENCE), -1),
                    @TotalChanges = COUNT(EXECUTION_SEQUENCE)
            FROM    @HierarchyChangeItem;
        
            IF @StartSequence <> -1
            BEGIN 
                SET @CurrentSequence = @StartSequence;
        
                IF ( DATEDIFF(mi, @EffectiveFrom, GETUTCDATE()) ) > @HistoricalEscalationPeriod
                BEGIN 
                    SET @IsPastChange = 1;
                END;
            
                WHILE @CurrentSequence <= @EndSequence
                BEGIN 
                    SELECT  @HierarchyChangeItemId = HIERARCHY_CHANGE_ITEM_ID,
                            @RequestType = REQUEST_TYPE,
                            @HierarchyNodeId = HIERARCHY_NODE_ID,
                            @RequestData = REQUEST_DATA
                    FROM    @HierarchyChangeItem
                    WHERE   EXECUTION_SEQUENCE = @CurrentSequence;
            
                    IF @@ROWCOUNT <> 0
                    BEGIN 
                        -- New Node Request
                        IF @RequestType = 'N'
                        BEGIN 
                            SET @HierarchyNodeName = NULL;
                            SET @HierarchyNodeParentId = NULL;
                            SET @HierarchyParentUrn = NULL;
                            SET @HierarchyNodeUrn = NULL;
                
                            SELECT  @HierarchyNodeName = @RequestData.value('(/AddHierarchyNodeRequest/Name)[1]',
                                                              'nvarchar(100)');
                            IF @RequestData.exist('/AddHierarchyNodeRequest/ParentInternalId[text()]') = 1
                            BEGIN 
                                SELECT  @HierarchyNodeParentId = @RequestData.value('(/AddHierarchyNodeRequest/ParentInternalId)[1]',
                                                              'uniqueidentifier');
                                -- Get the version of the parent node valid
                                SELECT  @HierarchyParentUrn = ITEM_URN
                                FROM    [dbo].[VW_DIM_HIERARCHY_NODE]
                                WHERE   NODE_ID = @HierarchyNodeParentId
                                        AND @EffectiveFrom BETWEEN EFFECTIVE_FROM
                                                           AND
                                                              EFFECTIVE_TO;
                                IF @HierarchyParentUrn IS NULL
                                BEGIN 
                                    SET @ErrorMessage = N'ap_sch01_execute_hierarchy_schedule: Effective parent node with id ['
                                        + CAST(@HierarchyChangeId AS NVARCHAR(50))
                                        + '] not found for node ['
                                        + @HierarchyNodeName + '].';
                                    SET @ReturnCode = -1;
                                    RAISERROR(@ErrorMessage, 16, 1);
                                END;
                            END;
                            ELSE
                            BEGIN 
                                SET @HierarchyNodeParentId = NULL;
                                SET @HierarchyParentUrn = NULL;
                            END;
                
                            EXEC @ReturnCode = [dbo].[ap_dim01_add_hierarchy_node] @SessionId = @SessionId,
                                @Name = @HierarchyNodeName,
                                @FolderId = @DefaultFolderId,
                                @OwnerId = @DefaultOwnerId,
                                @ItemSubTypeId = NULL, @Description = '',
                                @EffectiveFrom = @EffectiveFrom,
                                @EffectiveTo = NULL, @XmlData = NULL,
                                @HierarchyParentUrn = @HierarchyParentUrn,
                                @HierarchyBusinessUrn = @HierarchyBusinessUrn,
                                @Editable = 1, @NodeId = @HierarchyNodeId,
                                @ItemUrn = @HierarchyNodeUrn OUTPUT;
                        
                            SET @HierarchyNodeName = NULL;
                            SET @HierarchyNodeParentId = NULL;
                            SET @HierarchyParentUrn = NULL;
                            SET @HierarchyNodeUrn = NULL;
                        END;
            
                        -- Change node Request
                        IF @RequestType = 'C'
                        BEGIN 
                            DECLARE @CustomAttributeOldValue NVARCHAR(MAX);
                            SET @HierarchyNodeAttributeName = NULL;
                            SET @HierarchyNodeAttributeValue = NULL;
                            SET @IsHierarchyNodeAttributeCustom = NULL;
                            SET @HierarchyNodeUrn = NULL;
                            SET @HierarchyNodeName = NULL;
                            SET @HierarchyNodeDescription = NULL;
                
                            SELECT  @HierarchyNodeAttributeName = @RequestData.value('(/SetHierarchyNodeAttributeRequest/AttributeName)[1]',
                                                              'nvarchar(100)'),
                                    @HierarchyNodeAttributeValue = @RequestData.value('(/SetHierarchyNodeAttributeRequest/AttributeValue[@xsi:nil!="true" or not(@xsi:nil)])[1]',
                                                              'nvarchar(100)'),
                                    @IsHierarchyNodeAttributeCustom = @RequestData.value('(/SetHierarchyNodeAttributeRequest/IsCustom)[1]',
                                                              'bit');
                
                            SELECT  @HierarchyNodeName = [n].[NAME],
                                    @HierarchyNodeDescription = [n].[DESCRIPTION],
                                    @HierarchyNodeUrn = [n].[ITEM_URN],
                                    @HierarchyNodeCustomXmlData = [n].[CUSTOM_XML_DATA]
                            FROM    [dbo].[TB_DIM_HIERARCHY_NODE] AS n
                            WHERE   [n].[NODE_ID] = @HierarchyNodeId
                                    AND @EffectiveFrom BETWEEN [n].[EFFECTIVE_FROM]
                                                       AND    [n].[EFFECTIVE_TO];

                            -- remove the old value element
                            IF @RequestData.exist('//OldValue') = 1
                            BEGIN 
                                SET @RequestData.modify('delete /SetHierarchyNodeAttributeRequest/OldValue');
                            END;
                
                            -- If the attribute is not a custom attribute
                            IF @IsHierarchyNodeAttributeCustom = 0
                            BEGIN 
                                -- The attribute names should be the supported types.
                                IF UPPER(@HierarchyNodeAttributeName) = 'NAME'
                                BEGIN 
                                    -- Update all the surrogates of the nodes.
                                    UPDATE  [dbo].[TB_DIM_HIERARCHY_NODE]
                                    SET     NAME = @HierarchyNodeAttributeValue
                                    WHERE   NODE_ID = @HierarchyNodeId;
                                                
                                    IF @HierarchyNodeName IS NOT NULL
                                    BEGIN 
                                        SET @RequestData.modify('insert <OldValue>{sql:variable("@HierarchyNodeName")}</OldValue> as last into (/SetHierarchyNodeAttributeRequest)[1]');
                                    END;
                                    ELSE
                                    BEGIN 
                                        SET @RequestData.modify('insert <OldValue xsi:nil="true"></OldValue> as last into (/SetHierarchyNodeAttributeRequest)[1]');
                                    END;
                                END;
                                            
                                IF UPPER(@HierarchyNodeAttributeName) = 'DESCRIPTION'
                                BEGIN 
                                    -- Update all the surrogates of the nodes.
                                    UPDATE  [dbo].[TB_DIM_HIERARCHY_NODE]
                                    SET     DESCRIPTION = COALESCE(@HierarchyNodeAttributeValue,
                                                              '')
                                    WHERE   NODE_ID = @HierarchyNodeId;
                        
                                    IF @HierarchyNodeDescription IS NOT NULL
                                    BEGIN 
                                        SET @RequestData.modify('insert <OldValue>{sql:variable("@HierarchyNodeDescription")}</OldValue> as last into (/SetHierarchyNodeAttributeRequest)[1]');
                                    END;
                                    ELSE
                                    BEGIN 
                                        SET @RequestData.modify('insert <OldValue xsi:nil="true"></OldValue> as last into (/SetHierarchyNodeAttributeRequest)[1]');
                                    END;
                                END;
                            END;
                            ELSE
                            BEGIN 
                                -- If this the first time that the custom xml is being set.
                                IF @HierarchyNodeCustomXmlData IS NULL
                                    AND (
                                          @HierarchyNodeAttributeValue IS NULL
                                          OR (
                                               @HierarchyNodeAttributeValue IS NOT NULL
                                               AND UPPER(@HierarchyNodeAttributeValue) <> '##REMOVE##'
                                             )
                                        )
                                BEGIN 
                                    IF @HierarchyNodeAttributeValue IS NULL
                                    BEGIN 
                                        SET @HierarchyNodeCustomXmlData = '<Columns><Column Name="'
                                            + @HierarchyNodeAttributeName
                                            + '" DataType="String" IsNull="true"></Column></Columns>';
                                    END;
                                    ELSE
                                    BEGIN 
                                        SET @HierarchyNodeCustomXmlData = '<Columns><Column Name="'
                                            + @HierarchyNodeAttributeName
                                            + '" DataType="String">'
                                            + @HierarchyNodeAttributeValue
                                            + '</Column></Columns>';
                                    END;
                                                
                                    SET @RequestData.modify('insert <OldValue>##ADD##</OldValue> as last into (/SetHierarchyNodeAttributeRequest)[1]');
                                END;
                                ELSE
                                BEGIN 
                                    IF @HierarchyNodeAttributeValue IS NULL
                                        OR (
                                             @HierarchyNodeAttributeValue IS NOT NULL
                                             AND UPPER(@HierarchyNodeAttributeValue) <> '##REMOVE##'
                                           )
                                    BEGIN 
                                        -- Check if the attribute exists. If not create a new one. If it does then update the value.
                                        IF @HierarchyNodeCustomXmlData.exist('/Columns/Column[@Name=sql:variable("@HierarchyNodeAttributeName")]') = 1
                                        BEGIN 
                                            -- Get the current value of the attribute
                                            IF @HierarchyNodeCustomXmlData.query('/Columns/Column[@Name=sql:variable("@HierarchyNodeAttributeName")]').exist('/Column[@IsNull="true"]') = 1
                                            BEGIN 
                                                SET @CustomAttributeOldValue = NULL;
                                            END;
                                            ELSE
                                            BEGIN  
                                                SET @CustomAttributeOldValue = @HierarchyNodeCustomXmlData.value('((/Columns/Column[@Name=sql:variable("@HierarchyNodeAttributeName")])/text())[1]',
                                                              'nvarchar(max)');
                                            END;
                                
                                            IF @CustomAttributeOldValue IS NULL
                                            BEGIN 
                                                SET @RequestData.modify('insert <OldValue xsi:nil="true"></OldValue> as last into (/SetHierarchyNodeAttributeRequest)[1]');
                                            END;
                                            ELSE
                                            BEGIN 
                                                SET @RequestData.modify('insert <OldValue>{sql:variable("@CustomAttributeOldValue")}</OldValue> as last into (/SetHierarchyNodeAttributeRequest)[1]');
                                            END;
                                
                                            -- Delete the attribute and then add it back
                                            SET @HierarchyNodeCustomXmlData.modify('delete /Columns/Column[@Name= sql:variable("@HierarchyNodeAttributeName")]');
                                            --SET @HierarchyNodeCustomXmlData.modify('replace value of (/Columns/Column[@Name=sql:variable("@HierarchyNodeAttributeName")]/text())[1] with sql:variable("@HierarchyNodeAttributeValue")')
                                        END;
                                        ELSE
                                        BEGIN 
                                            SET @RequestData.modify('insert <OldValue>##ADD##</OldValue> as last into (/SetHierarchyNodeAttributeRequest)[1]');
                                        END;
                            
                                        IF @HierarchyNodeAttributeValue IS NOT NULL
                                        BEGIN 
                                            SET @HierarchyNodeCustomXmlData.modify('insert <Column Name="{sql:variable("@HierarchyNodeAttributeName")}" DataType="String">{sql:variable("@HierarchyNodeAttributeValue")}</Column> as last into (/Columns)[1]');
                                        END;
                                        ELSE
                                        BEGIN 
                                            SET @HierarchyNodeCustomXmlData.modify('insert <Column Name="{sql:variable("@HierarchyNodeAttributeName")}" DataType="String" IsNull="true"></Column> as last into (/Columns)[1]');
                                        END;
                                    END;
                                    ELSE
                                    BEGIN 
                                        -- If the attribute exists in the custom xml data then remove it.
                                        IF @HierarchyNodeCustomXmlData.exist('/Columns/Column[@Name=sql:variable("@HierarchyNodeAttributeName")]') = 1
                                        BEGIN 
                                            -- Get the current value of the attribute
                                            IF @HierarchyNodeCustomXmlData.query('/Columns/Column[@Name=sql:variable("@HierarchyNodeAttributeName")]').exist('/Column[@IsNull="true"]') = 1
                                            BEGIN 
                                                SET @CustomAttributeOldValue = NULL;
                                            END;
                                            ELSE
                                            BEGIN  
                                                SET @CustomAttributeOldValue = @HierarchyNodeCustomXmlData.value('((/Columns/Column[@Name=sql:variable("@HierarchyNodeAttributeName")])/text())[1]',
                                                              'nvarchar(max)');
                                            END;
                                
                                            IF @CustomAttributeOldValue IS NULL
                                            BEGIN 
                                                SET @RequestData.modify('insert <OldValue xsi:nil="true"></OldValue> as last into (/SetHierarchyNodeAttributeRequest)[1]');
                                            END;
                                            ELSE
                                            BEGIN 
                                                SET @RequestData.modify('insert <OldValue>{sql:variable("@CustomAttributeOldValue")}</OldValue> as last into (/SetHierarchyNodeAttributeRequest)[1]');
                                            END;
                                
                                            SET @HierarchyNodeCustomXmlData.modify('delete /Columns/Column[@Name= sql:variable("@HierarchyNodeAttributeName")]');
                                        END;
                                    END;
                        
                                    -- If the custom xml does not contain any columns then set it back to null.
                                    IF @HierarchyNodeCustomXmlData IS NOT NULL
                                        AND @HierarchyNodeCustomXmlData.exist('//Column') = 0
                                    BEGIN 
                                        SET @HierarchyNodeCustomXmlData = NULL;
                                    END;
                                END;
                    
                                -- Update the request object
                                UPDATE  [dbo].[TB_SCH_HIERARCHY_CHANGE_ITEM]
                                SET     REQUEST_DATA = @RequestData
                                WHERE   HIERARCHY_CHANGE_ITEM_ID = @HierarchyChangeItemId;
                    
                                UPDATE  [dbo].[TB_DIM_HIERARCHY_NODE]
                                SET     CUSTOM_XML_DATA = @HierarchyNodeCustomXmlData
                                WHERE   NODE_ID = @HierarchyNodeId;
                            END;
                
                            SET @HierarchyNodeAttributeName = NULL;
                            SET @HierarchyNodeAttributeValue = NULL;
                            SET @IsHierarchyNodeAttributeCustom = NULL;
                            SET @HierarchyNodeUrn = NULL;
                            SET @HierarchyNodeName = NULL;
                            SET @HierarchyNodeDescription = NULL;
                        END;
                        
                        -- Move Node Request or Delete node request
                        IF @RequestType = 'M'
                            OR @RequestType = 'R'
                        BEGIN 
                            SET @HierarchyNodeToParentId = NULL;
                            SET @NodeUrn = NULL;
                            SET @ToParentUrn = NULL;
                
                            IF @RequestType = 'M'
                            BEGIN 
                                SELECT  @HierarchyNodeToParentId = @RequestData.value('(/MoveHierarchyNodeRequest/NewParentInternalId)[1]',
                                                              'uniqueidentifier');
                            END;
                                
                            -- Get the latest surrogates of the changing node and the from and to parent nodes.
                            SELECT TOP 1
                                    @NodeUrn = ITEM_URN
                            FROM    [dbo].[VW_DIM_HIERARCHY_NODE]
                            WHERE   NODE_ID = @HierarchyNodeId
                                    AND @EffectiveFrom BETWEEN EFFECTIVE_FROM
                                                       AND    EFFECTIVE_TO
                            ORDER BY EFFECTIVE_FROM DESC;
                                
                            SELECT TOP 1
                                    @ToParentUrn = ITEM_URN
                            FROM    [dbo].[VW_DIM_HIERARCHY_NODE]
                            WHERE   NODE_ID = @HierarchyNodeToParentId
                                    AND @EffectiveFrom BETWEEN EFFECTIVE_FROM
                                                       AND    EFFECTIVE_TO
                            ORDER BY EFFECTIVE_FROM DESC;
                
                            EXEC @ReturnCode = [dbo].[ap_sch_recursive_update_hierachy_node] @SessionId,
                                @HierarchyChangeId, @RequestType, @NodeUrn,
                                @ToParentUrn, @EffectiveFrom, @IsPastChange;
                            IF @ReturnCode <> 0
                            BEGIN 
                                SET @ErrorMessage = 'ap_sch_recursive_update_hierachy_node returned ['
                                    + CAST(@ReturnCode AS VARCHAR(20))+']';
                                RAISERROR(@ErrorMessage, 16, 1);
                            END;
                
                            SET @HierarchyNodeToParentId = NULL;
                            SET @NodeUrn = NULL;
                            SET @ToParentUrn = NULL;
                        END;
            
                        -- Association or Dissassociation Requests
                        IF @RequestType = 'A'
                            OR @RequestType = 'D'
                        BEGIN 
                            SET @ItemBusinessUrn = NULL;
                            SET @HierarchyPrecedence = NULL;
                
                            DECLARE @RequestItemType NVARCHAR(100),
                                @RequestBusinessUrn INT,
                                @RequestPrecedence INT;               

                            IF @RequestType = 'A'
                            BEGIN 
                                SELECT  @RequestItemType = @RequestData.value('(/AssociateHierarchyItemRequest/ItemType)[1]',
                                                              'nvarchar(100)'),
                                        @RequestBusinessUrn = @RequestData.value('(/AssociateHierarchyItemRequest/ItemBusinessUrn)[1]',
                                                              'int'),
                                        @RequestPrecedence = @RequestData.value('(/AssociateHierarchyItemRequest/Precedence)[1]',
                                                              'int');
                            END;
                            ELSE
                            BEGIN 
                                SELECT  @RequestItemType = @RequestData.value('(/DisassociateHierarchyItemRequest/ItemType)[1]',
                                                              'nvarchar(100)'),
                                        @RequestBusinessUrn = @RequestData.value('(/DisassociateHierarchyItemRequest/ItemBusinessUrn)[1]',
                                                              'int'),
                                        @RequestPrecedence = @RequestData.value('(/DisassociateHierarchyItemRequest/Precedence)[1]',
                                                              'int');
                            END;

                            DECLARE @TYPE TINYINT;

                            SELECT  @TYPE = CASE WHEN @RequestItemType LIKE REPLACE('00000000-0000-0000-0000-000000000000',
                                                              '0',
                                                              '[0-9a-fA-F]')
                                                 THEN 1
                                                 WHEN @RequestItemType LIKE 'IT\_%'
                                                      ESCAPE '\' THEN 2
                                                 ELSE 3
                                            END;
                            IF @TYPE = 1
                            BEGIN
                                SELECT  @ItemTypeUrn = ITEM_TYPE_URN
                                FROM    [dbo].[TE_DIM_ITEM_TYPE]
                                WHERE   [ITEM_TYPE_ID] = @RequestItemType;
                            END;
                            IF @TYPE = 2
                            BEGIN
                                SELECT  @ItemTypeUrn = ITEM_TYPE_URN
                                FROM    [dbo].[TE_DIM_ITEM_TYPE]
                                WHERE   [INTERNAL_NAME] = @RequestItemType;
                            END;
                            IF @TYPE = 3
                            BEGIN
                                SELECT  @ItemTypeUrn = ITEM_TYPE_URN
                                FROM    [dbo].[TE_DIM_ITEM_TYPE]
                                WHERE   [NAME] = @RequestItemType;
                            END;


                            SELECT  @ItemBusinessUrn = @RequestBusinessUrn,
                                    @HierarchyPrecedence = @RequestPrecedence;
                
                            EXEC @ReturnCode = [dbo].[ap_sch_recursive_associate_disassociate_item] @SessionId,
                                @HierarchyChangeId, @HierarchyChangeId,
                                @RequestType, @HierarchyNodeId,
                                @ItemBusinessUrn, @ItemTypeUrn,
                                @HierarchyPrecedence, @EffectiveFrom;
                
                            IF @ReturnCode <> 0
                            BEGIN 
                                SET @ErrorMessage = 'ap_sch_recursive_associate_disassociate_item returned ['
                                    + CAST(@ReturnCode AS VARCHAR(20))+']';
                                RAISERROR(@ErrorMessage, 16, 1);
                            END;
                        END;
            
                    END;
                    SET @CurrentSequence = @CurrentSequence + 1;
                END;

                -- Finally set the status of the schedule to completed.
                UPDATE  [dbo].[TB_SCH_HIERARCHY_CHANGE]
                SET     STATUS = 'C'
                WHERE   HIERARCHY_CHANGE_ID = @HierarchyChangeId;
        
                IF @InitialTransactionCount = 0
                BEGIN 
                    COMMIT TRANSACTION SchXecTransaction;
                END;
                ELSE
                BEGIN 
                    WHILE @@TRANCOUNT > @InitialTransactionCount
                    BEGIN 
                        COMMIT TRANSACTION;
                    END;
                END;
            END;
        END;
        ELSE
        BEGIN
            -- No change items detected
            UPDATE  [dbo].[TB_SCH_HIERARCHY_CHANGE]
            SET     STATUS = 'C'
            WHERE   HIERARCHY_CHANGE_ID = @HierarchyChangeId;
            IF @InitialTransactionCount = 0
            BEGIN 
                COMMIT TRANSACTION SchXecTransaction;
            END;
            ELSE
            BEGIN 
                WHILE @@TRANCOUNT > @InitialTransactionCount
                BEGIN 
                    COMMIT TRANSACTION;
                END;
            END;
        END;

        IF @InitialTransactionCount = 0
            AND @@TRANCOUNT > 0
        BEGIN 
            ROLLBACK TRANSACTION;
        END;

        IF (
             (
               @ErrorMessage <> ''
               AND @ErrorMessage IS NOT NULL
             )
             OR @ReturnCode <> 0
           )
        BEGIN
            SET @ErrorMessage = ISNULL(@ErrorMessage, 'Error')
                + ': ReturnCode [' + CAST(@ReturnCode AS VARCHAR(20))+']';
            RAISERROR(@ErrorMessage, 16, 1);
        END;
    END TRY
    BEGIN CATCH   
        IF (@ErrorMessage <> '' OR @ReturnCode <> 0)
        BEGIN 
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
            END;
            RAISERROR(@ErrorMessage, 16, 1, @ReturnCode) WITH LOG;
        END;

        RETURN @ReturnCode;
    END CATCH;
    RETURN @ReturnCode;
END;
GO
GRANT EXECUTE
	ON [dbo].[ap_sch01_execute_hierarchy_schedule]
	TO [portalapp_role]
GO
