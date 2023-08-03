SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_dim_reserve_next_number_in_range]
    (
      @I_ItemTypeID UNIQUEIDENTIFIER,
      @I_ItemColumnName NVARCHAR(50),
      @I_NumberRangeStart INT,
      @I_NumberRangeEnd INT,
      @I_ParentURN INT = NULL,
      @I_ClusterResourceID UNIQUEIDENTIFIER = NULL,
      @I_FolderID UNIQUEIDENTIFIER = NULL,
      @I_OwnerID UNIQUEIDENTIFIER = NULL,
      @O_NextValue NVARCHAR(50) OUTPUT
    )
AS
    BEGIN 

        SET NOCOUNT ON;

        BEGIN TRY;
        -- Fix up default parameters
            IF @I_ParentURN IS NULL
            BEGIN 
                SET @I_ParentURN = -2;
            END;

            IF @I_FolderID IS NULL
            BEGIN 
                SET @I_FolderID = '00000002-0000-0000-0000-000000000005';
            END;

            DECLARE @v_Error INT = 0,
                @v_RowCount INT,
                @v_NextAvailableNumber INT,
                @v_IsPublisher INT,
                @InitialTransactionCount INT = @@TRANCOUNT,
                @deadlockRetry TINYINT = 0,
                @waitDelay CHAR(9),
                @deadlockRetryBegin BIT = 0,
                @ErrorMessage NVARCHAR(500) = N'';

        -- Perform a test and set operation to obtain the next number. 
            SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

            BEGIN TRANSACTION [ReverseNextTransaction];
    
            WHILE @deadlockRetry < 3
            BEGIN 
                SAVE TRANSACTION [deadlockSavePoint];
                BEGIN TRY;
                -- Check if the database on which to create the next DIRECTORY_NUMBER_OR_PATTERN or PERIPHERAL_NUMBER is a PUBLISHER or a SUBSCRIBER.
                -- This is necessary to avoid the clash of DIRECTORY_NUMBER_OR_PATTERN or PERIPERAL_NUMBER if same resources are being created from both sides at the same time.
                    SELECT  @v_IsPublisher = [IS_PUBLISHER]
                    FROM    [dbo].[fn_clu_get_exony_db_resource_instance](NULL);

                    SET @O_NextValue = NULL;

                    IF @I_ItemTypeID = '00011100-1000-0000-0000-000000000010'
                        AND @I_ItemColumnName = 'DIRECTORY_NUMBER_OR_PATTERN'
                -- Directory Number type id
                    BEGIN 
                        IF @v_IsPublisher = 1
                        BEGIN 
                            SELECT TOP 1
                                    @O_NextValue = [a].[RESERVED_NUMBER] + 2
                            FROM    ( SELECT    [a].[RESERVED_NUMBER],
                                                ISNULL(LEAD([a].[RESERVED_NUMBER], 1) OVER ( ORDER BY [a].[RESERVED_NUMBER] ), 0) AS [LEAD]
                                      FROM      ( SELECT DISTINCT
                                                            [a].[RESERVED_NUMBER]
                                                  FROM      ( SELECT    TRY_CAST([RESERVED_NUMBER] AS BIGINT) AS [RESERVED_NUMBER]
                                                              FROM      [dbo].[TB_DIM_DIRECTORY_NUMBER_PKEY_MAP]
                                                              WHERE     [LATEST] = 1
                                                                        AND [RESERVED_NUMBER] IS NOT NULL
                                                              UNION ALL
                                                              SELECT    TRY_CAST([RESERVED_NAME] AS BIGINT) AS [RESERVED_NUMBER]
                                                              FROM      [dbo].[TB_DIM_RESERVED_NAME] WITH ( XLOCK )
                                                              WHERE     [COLUMN_NAME] = 'DIRECTORY_NUMBER_OR_PATTERN'
                                                                        AND [ITEM_TYPE_ID] = '00011100-1000-0000-0000-000000000010'
                                                              UNION ALL
                                                              SELECT    @I_NumberRangeStart - CASE WHEN @I_NumberRangeStart = 0 THEN 0
                                                                                                   WHEN @I_NumberRangeStart % 2 = 1 THEN 1
                                                                                                   ELSE 2
                                                                                              END
                                                            ) [a]
                                                  WHERE     [a].[RESERVED_NUMBER] % 2 = 0
                                                ) [a]
                                      WHERE     [a].[RESERVED_NUMBER] >= @I_NumberRangeStart - ( CASE WHEN @I_NumberRangeStart = 0 THEN 0
                                                                                                      ELSE 2
                                                                                                 END )
                                    ) [a]
                            WHERE   [a].[RESERVED_NUMBER] + 2 <> [a].[LEAD]
                            ORDER BY [a].[RESERVED_NUMBER];
                        END;
                        ELSE
                        BEGIN 
                            SELECT TOP 1
                                    @O_NextValue = [a].[RESERVED_NUMBER] + 2
                            FROM    ( SELECT    [a].[RESERVED_NUMBER],
                                                ISNULL(LEAD([a].[RESERVED_NUMBER], 1) OVER ( ORDER BY [a].[RESERVED_NUMBER] ), 0) AS [LEAD]
                                      FROM      ( SELECT DISTINCT
                                                            [a].[RESERVED_NUMBER]
                                                  FROM      ( SELECT    TRY_CAST([RESERVED_NUMBER] AS BIGINT) AS [RESERVED_NUMBER]
                                                              FROM      [dbo].[TB_DIM_DIRECTORY_NUMBER_PKEY_MAP]
                                                              WHERE     [LATEST] = 1
                                                                        AND [RESERVED_NUMBER] IS NOT NULL
                                                              UNION ALL
                                                              SELECT    TRY_CAST([RESERVED_NAME] AS BIGINT) AS [RESERVED_NUMBER]
                                                              FROM      [dbo].[TB_DIM_RESERVED_NAME] WITH ( XLOCK )
                                                              WHERE     [COLUMN_NAME] = 'DIRECTORY_NUMBER_OR_PATTERN'
                                                                        AND [ITEM_TYPE_ID] = '00011100-1000-0000-0000-000000000010'
                                                              UNION ALL
                                                              SELECT    @I_NumberRangeStart - CASE WHEN @I_NumberRangeStart % 2 = 1 THEN 2
                                                                                                   ELSE 1
                                                                                              END
                                                            ) [a]
                                                  WHERE     [a].[RESERVED_NUMBER] % 2 = 1
                                                ) [a]
                                      WHERE     [a].[RESERVED_NUMBER] >= @I_NumberRangeStart - ( CASE WHEN @I_NumberRangeStart = 0 THEN 0
                                                                                                      ELSE 2
                                                                                                 END )
                                    ) [a]
                            WHERE   [a].[RESERVED_NUMBER] + 2 <> [a].[LEAD]
                            ORDER BY [a].[RESERVED_NUMBER];
                        END;
                        SET @v_RowCount = @@ROWCOUNT;

                        IF @v_RowCount <> 1
                        BEGIN 
                            SET @v_Error = -1;
                            RAISERROR ('Numbers Found [%d]', @v_RowCount, 16, 1);
                        END;
                    END;
                    ELSE
                        IF @I_ItemTypeID = '00007600-1000-0000-0000-000000000010'
                            AND @I_ItemColumnName = 'PERIPHERAL_NUMBER'
                -- Skill group type id
                        BEGIN 
                            IF @v_IsPublisher = 1
                            BEGIN 
                                SELECT TOP 1
                                        @O_NextValue = [a].[RESERVED_NUMBER] + 2
                                FROM    ( SELECT    [a].[RESERVED_NUMBER],
                                                    ISNULL(LEAD([a].[RESERVED_NUMBER], 1) OVER ( ORDER BY [a].[RESERVED_NUMBER] ), 0) AS [LEAD]
                                          FROM      ( SELECT DISTINCT
                                                                [a].[RESERVED_NUMBER]
                                                      FROM      ( SELECT    TRY_CAST([RESERVED_NUMBER] AS BIGINT) AS [RESERVED_NUMBER]
                                                                  FROM      [dbo].[TB_DIM_SKILLGROUP_PKEY_MAP]
                                                                  WHERE     [LATEST] = 1
                                                                            AND [RESERVED_NUMBER] IS NOT NULL
                                                                  UNION ALL
                                                                  SELECT    TRY_CAST([RESERVED_NAME] AS BIGINT) AS [RESERVED_NUMBER]
                                                                  FROM      [dbo].[TB_DIM_RESERVED_NAME] WITH ( XLOCK )
                                                                  WHERE     [COLUMN_NAME] = 'PERIPHERAL_NUMBER'
                                                                            AND [ITEM_TYPE_ID] = '00007600-1000-0000-0000-000000000010'
                                                                  UNION ALL
                                                                  SELECT    @I_NumberRangeStart - CASE WHEN @I_NumberRangeStart = 0 THEN 0
                                                                                                       WHEN @I_NumberRangeStart % 2 = 1 THEN 1
                                                                                                       ELSE 2
                                                                                                  END
                                                                ) [a]
                                                      WHERE     [a].[RESERVED_NUMBER] % 2 = 0
                                                    ) [a]
                                          WHERE     [a].[RESERVED_NUMBER] >= @I_NumberRangeStart - ( CASE WHEN @I_NumberRangeStart = 0 THEN 0
                                                                                                          ELSE 2
                                                                                                     END )
                                        ) [a]
                                WHERE   [a].[RESERVED_NUMBER] + 2 <> [a].[LEAD]
                                ORDER BY [a].[RESERVED_NUMBER];
                            END;
                            ELSE
                            BEGIN 
                                SELECT TOP 1
                                        @O_NextValue = [a].[RESERVED_NUMBER] + 2
                                FROM    ( SELECT    [a].[RESERVED_NUMBER],
                                                    ISNULL(LEAD([a].[RESERVED_NUMBER], 1) OVER ( ORDER BY [a].[RESERVED_NUMBER] ), 0) AS [LEAD]
                                          FROM      ( SELECT DISTINCT
                                                                [a].[RESERVED_NUMBER]
                                                      FROM      ( SELECT    TRY_CAST([RESERVED_NUMBER] AS BIGINT) AS [RESERVED_NUMBER]
                                                                  FROM      [dbo].[TB_DIM_SKILLGROUP_PKEY_MAP]
                                                                  WHERE     [LATEST] = 1
                                                                            AND [RESERVED_NUMBER] IS NOT NULL
                                                                  UNION ALL
                                                                  SELECT    TRY_CAST([RESERVED_NAME] AS BIGINT) AS [RESERVED_NUMBER]
                                                                  FROM      [dbo].[TB_DIM_RESERVED_NAME] WITH ( XLOCK )
                                                                  WHERE     [COLUMN_NAME] = 'PERIPHERAL_NUMBER'
                                                                            AND [ITEM_TYPE_ID] = '00007600-1000-0000-0000-000000000010'
                                                                  UNION ALL
                                                                  SELECT    @I_NumberRangeStart - CASE WHEN @I_NumberRangeStart % 2 = 1 THEN 2
                                                                                                       ELSE 1
                                                                                                  END
                                                                ) [a]
                                                      WHERE     [a].[RESERVED_NUMBER] % 2 = 1
                                                    ) [a]
                                          WHERE     [a].[RESERVED_NUMBER] >= @I_NumberRangeStart - ( CASE WHEN @I_NumberRangeStart = 0 THEN 0
                                                                                                          ELSE 2
                                                                                                     END )
                                        ) [a]
                                WHERE   [a].[RESERVED_NUMBER] + 2 <> [a].[LEAD]
                                ORDER BY [a].[RESERVED_NUMBER];
                            END;
                            SET @v_RowCount = @@ROWCOUNT;

                            IF @v_RowCount <> 1
                            BEGIN 
                                SET @v_Error = -1;
                                RAISERROR ('Numbers Found [%d]', @v_RowCount, 16, 1);
                            END;
                        END;
                        ELSE
                            IF @I_ItemTypeID = '00007500-1000-0000-0000-000000000010'
                                AND @I_ItemColumnName = 'PERIPHERAL_NUMBER'
                -- Service type id
                            BEGIN 
                                IF @v_IsPublisher = 1
                                BEGIN 
                                    SELECT TOP 1
                                            @O_NextValue = [a].[RESERVED_NUMBER] + 2
                                    FROM    ( SELECT    [a].[RESERVED_NUMBER],
                                                        ISNULL(LEAD([a].[RESERVED_NUMBER], 1) OVER ( ORDER BY [a].[RESERVED_NUMBER] ), 0) AS [LEAD]
                                              FROM      ( SELECT DISTINCT
                                                                    [a].[RESERVED_NUMBER]
                                                          FROM      ( SELECT    TRY_CAST([RESERVED_NUMBER] AS BIGINT) AS [RESERVED_NUMBER]
                                                                      FROM      [dbo].[TB_DIM_SERVICE_PKEY_MAP]
                                                                      WHERE     [LATEST] = 1
                                                                                AND [RESERVED_NUMBER] IS NOT NULL
                                                                      UNION ALL
                                                                      SELECT    TRY_CAST([RESERVED_NAME] AS BIGINT) AS [RESERVED_NUMBER]
                                                                      FROM      [dbo].[TB_DIM_RESERVED_NAME] WITH ( XLOCK )
                                                                      WHERE     [COLUMN_NAME] = 'PERIPHERAL_NUMBER'
                                                                                AND [ITEM_TYPE_ID] = '00007500-1000-0000-0000-000000000010'
                                                                      UNION ALL
                                                                      SELECT    @I_NumberRangeStart - CASE WHEN @I_NumberRangeStart = 0 THEN 0
                                                                                                           WHEN @I_NumberRangeStart % 2 = 1 THEN 1
                                                                                                           ELSE 2
                                                                                                      END
                                                                    ) [a]
                                                          WHERE     [a].[RESERVED_NUMBER] % 2 = 0
                                                        ) [a]
                                              WHERE     [a].[RESERVED_NUMBER] >= @I_NumberRangeStart - ( CASE WHEN @I_NumberRangeStart = 0 THEN 0
                                                                                                              ELSE 2
                                                                                                         END )
                                            ) [a]
                                    WHERE   [a].[RESERVED_NUMBER] + 2 <> [a].[LEAD]
                                    ORDER BY [a].[RESERVED_NUMBER];
                                END;
                                ELSE
                                BEGIN 
                                    SELECT TOP 1
                                            @O_NextValue = [a].[RESERVED_NUMBER] + 2
                                    FROM    ( SELECT    [a].[RESERVED_NUMBER],
                                                        ISNULL(LEAD([a].[RESERVED_NUMBER], 1) OVER ( ORDER BY [a].[RESERVED_NUMBER] ), 0) AS [LEAD]
                                              FROM      ( SELECT DISTINCT
                                                                    [a].[RESERVED_NUMBER]
                                                          FROM      ( SELECT    TRY_CAST([RESERVED_NUMBER] AS BIGINT) AS [RESERVED_NUMBER]
                                                                      FROM      [dbo].[TB_DIM_SERVICE_PKEY_MAP]
                                                                      WHERE     [LATEST] = 1
                                                                                AND [RESERVED_NUMBER] IS NOT NULL
                                                                      UNION ALL
                                                                      SELECT    TRY_CAST([RESERVED_NAME] AS BIGINT) AS [RESERVED_NUMBER]
                                                                      FROM      [dbo].[TB_DIM_RESERVED_NAME] WITH ( XLOCK )
                                                                      WHERE     [COLUMN_NAME] = 'PERIPHERAL_NUMBER'
                                                                                AND [ITEM_TYPE_ID] = '00007500-1000-0000-0000-000000000010'
                                                                      UNION ALL
                                                                      SELECT    @I_NumberRangeStart - CASE WHEN @I_NumberRangeStart % 2 = 1 THEN 2
                                                                                                           ELSE 1
                                                                                                      END
                                                                    ) [a]
                                                          WHERE     [a].[RESERVED_NUMBER] % 2 = 1
                                                        ) [a]
                                              WHERE     [a].[RESERVED_NUMBER] >= @I_NumberRangeStart - ( CASE WHEN @I_NumberRangeStart = 0 THEN 0
                                                                                                              ELSE 2
                                                                                                         END )
                                            ) [a]
                                    WHERE   [a].[RESERVED_NUMBER] + 2 <> [a].[LEAD]
                                    ORDER BY [a].[RESERVED_NUMBER];
                                END;
                                SET @v_RowCount = @@ROWCOUNT;

                                IF @v_RowCount <> 1
                                BEGIN 
                                    SET @v_Error = -1;
                                    RAISERROR ('Numbers Found [%d]', @v_RowCount, 16, 1);
                                END;
                            END;
                            ELSE
                                IF @I_ItemTypeID = '00001100-1000-0000-0000-000000000010'
                                    AND @I_ItemColumnName = 'PERIPHERAL_NUMBER'
                -- Agent type id
                                BEGIN 
                                    IF @v_IsPublisher = 1
                                    BEGIN 
                                        SELECT TOP 1
                                                @O_NextValue = [a].[RESERVED_NUMBER] + 2
                                        FROM    ( SELECT    [a].[RESERVED_NUMBER],
                                                            ISNULL(LEAD([a].[RESERVED_NUMBER], 1) OVER ( ORDER BY [a].[RESERVED_NUMBER] ), 0) AS [LEAD]
                                                  FROM      ( SELECT DISTINCT
                                                                        [a].[RESERVED_NUMBER]
                                                              FROM      ( SELECT    TRY_CAST([RESERVED_NUMBER] AS BIGINT) AS [RESERVED_NUMBER]
                                                                          FROM      [dbo].[TB_DIM_AGENT_PKEY_MAP]
                                                                          WHERE     [LATEST] = 1
                                                                                    AND [RESERVED_NUMBER] IS NOT NULL
                                                                          UNION ALL
                                                                          SELECT    TRY_CAST([RESERVED_NAME] AS BIGINT) AS [RESERVED_NUMBER]
                                                                          FROM      [dbo].[TB_DIM_RESERVED_NAME] WITH ( XLOCK )
                                                                          WHERE     [COLUMN_NAME] = 'PERIPHERAL_NUMBER'
                                                                                    AND [ITEM_TYPE_ID] = '00001100-1000-0000-0000-000000000010'
                                                                          UNION ALL
                                                                          SELECT    @I_NumberRangeStart - CASE WHEN @I_NumberRangeStart = 0 THEN 0
                                                                                                               WHEN @I_NumberRangeStart % 2 = 1 THEN 1
                                                                                                               ELSE 2
                                                                                                          END
                                                                        ) [a]
                                                              WHERE     [a].[RESERVED_NUMBER] % 2 = 0
                                                            ) [a]
                                                  WHERE     [a].[RESERVED_NUMBER] >= @I_NumberRangeStart - ( CASE WHEN @I_NumberRangeStart = 0 THEN 0
                                                                                                                  ELSE 2
                                                                                                             END )
                                                ) [a]
                                        WHERE   [a].[RESERVED_NUMBER] + 2 <> [a].[LEAD]
                                        ORDER BY [a].[RESERVED_NUMBER];
                                    END;
                                    ELSE
                                    BEGIN 
                                        SELECT TOP 1
                                                @O_NextValue = [a].[RESERVED_NUMBER] + 2
                                        FROM    ( SELECT    [a].[RESERVED_NUMBER],
                                                            ISNULL(LEAD([a].[RESERVED_NUMBER], 1) OVER ( ORDER BY [a].[RESERVED_NUMBER] ), 0) AS [LEAD]
                                                  FROM      ( SELECT DISTINCT
                                                                        [a].[RESERVED_NUMBER]
                                                              FROM      ( SELECT    TRY_CAST([RESERVED_NUMBER] AS BIGINT) AS [RESERVED_NUMBER]
                                                                          FROM      [dbo].[TB_DIM_AGENT_PKEY_MAP]
                                                                          WHERE     [LATEST] = 1
                                                                                    AND [RESERVED_NUMBER] IS NOT NULL
                                                                          UNION ALL
                                                                          SELECT    TRY_CAST([RESERVED_NAME] AS BIGINT) AS [RESERVED_NUMBER]
                                                                          FROM      [dbo].[TB_DIM_RESERVED_NAME] WITH ( XLOCK )
                                                                          WHERE     [COLUMN_NAME] = 'PERIPHERAL_NUMBER'
                                                                                    AND [ITEM_TYPE_ID] = '00001100-1000-0000-0000-000000000010'
                                                                          UNION ALL
                                                                          SELECT    @I_NumberRangeStart - CASE WHEN @I_NumberRangeStart % 2 = 1 THEN 2
                                                                                                               ELSE 1
                                                                                                          END
                                                                        ) [a]
                                                              WHERE     [a].[RESERVED_NUMBER] % 2 = 1
                                                            ) [a]
                                                  WHERE     [a].[RESERVED_NUMBER] >= @I_NumberRangeStart - ( CASE WHEN @I_NumberRangeStart = 0 THEN 0
                                                                                                                  ELSE 2
                                                                                                             END )
                                                ) [a]
                                        WHERE   [a].[RESERVED_NUMBER] + 2 <> [a].[LEAD]
                                        ORDER BY [a].[RESERVED_NUMBER];
                                    END;
                                    SET @v_RowCount = @@ROWCOUNT;

                                    IF @v_RowCount <> 1
                                    BEGIN 
                                        SET @v_Error = -1;
                                        RAISERROR ('Numbers Found [%d]', @v_RowCount, 16, 1);
                                    END;
                                END;
                                ELSE
                                BEGIN 
                                    SET @v_Error = -1;
                                    SET @ErrorMessage = OBJECT_NAME(@@PROCID) + ': invalid type parameters, error [%d]';
                                    RAISERROR (@ErrorMessage, 16, 1, @v_Error) WITH LOG;
                                END;

                    IF @O_NextValue <= @I_NumberRangeEnd
                    BEGIN 
                        BEGIN TRY;
                            INSERT  INTO [dbo].[TB_DIM_RESERVED_NAME]
                                    ( [ITEM_TYPE_ID],
                                      [COLUMN_NAME],
                                      [RESERVED_NAME],
                                      [PARENT_URN],
                                      [CLUSTER_RESOURCE_ID],
                                      [FOLDER_ID],
                                      [OWNER_ID]
                                    )
                            VALUES  ( @I_ItemTypeID,
                                      @I_ItemColumnName,
                                      @O_NextValue,
                                      @I_ParentURN,
                                      @I_ClusterResourceID,
                                      @I_FolderID,
                                      @I_OwnerID
                                    );

                            SET @v_RowCount = @@ROWCOUNT;
            
                            IF @v_RowCount <> 1
                            BEGIN 
                                RAISERROR ('Failed to insert into to TB_DIM_RESERVED_NAME - Rowcount[%d]', @v_RowCount, 16, 1);
                            END;
                        END TRY
                        BEGIN CATCH;
                            SET @v_Error = -1;
                            SET @ErrorMessage = OBJECT_NAME(@@PROCID) + ': error reserving number, error [%d]';
                            RAISERROR (@ErrorMessage, 16, 1, @v_Error);
                        END CATCH;
                    END;
                    ELSE
                    BEGIN 
                        SET @O_NextValue = NULL;
                        SET @v_Error = 1;
                        SET @ErrorMessage = OBJECT_NAME(@@PROCID) + ': No numbers left in this range';
                        RAISERROR (@ErrorMessage, 16, 1, @v_Error);
                    END;
                    IF ( XACT_STATE() ) = -1
                    BEGIN 
                        SET @ErrorMessage = OBJECT_NAME(@@PROCID) + ': Uncommittable Transaction!';
                        RAISERROR (@ErrorMessage, 16, 1);
                    END;
                    ELSE
                    BEGIN 
                        IF @InitialTransactionCount = 0
                        BEGIN 
                            COMMIT TRANSACTION [ReverseNextTransaction];
                        END;
                        ELSE
                        BEGIN 
                            WHILE @@TRANCOUNT > @InitialTransactionCount
                            BEGIN 
                                COMMIT TRANSACTION;
                            END;
                        END;
                    END;
                    SET @deadlockRetry = 3;
                    SET @v_Error = 0;
                    BREAK;
                END TRY
                BEGIN CATCH;
                    SELECT  @v_Error = CASE WHEN @v_Error NOT IN ( -1, 1 ) THEN @@ERROR
                                            ELSE @v_Error
                                       END,
                            @ErrorMessage = CASE WHEN @ErrorMessage = ''
                                                      OR @ErrorMessage IS NULL THEN '[' + OBJECT_NAME(@@PROCID) + ']' + ISNULL(': ' + ERROR_MESSAGE(), '')
                                                 ELSE @ErrorMessage
                                            END;

                    IF @v_Error <> 0
                    BEGIN 
                        IF @v_Error = 1205
                        BEGIN 
                            ROLLBACK TRANSACTION [deadlockSavePoint];
                            SET @ErrorMessage = OBJECT_NAME(@@PROCID) + ': ' + 'A deadlock occured and this transaction was the deadlock-victim. Error = [%d]';
                            SET @deadlockRetry = @deadlockRetry + 1;
                
                        --Random wait between 50ms and 999ms
                            SELECT  @waitDelay = '0:0:0.' + RIGHT('0' + CAST(CASE WHEN [a].[seed] > 949 THEN 949
                                                                                  ELSE [a].[seed]
                                                                             END + 50 AS VARCHAR(3)), 3)
                            FROM    ( SELECT    ABS(CHECKSUM(NEWID()) % 999)
                                    ) [a] ( [seed] );
                        
                            WAITFOR DELAY @waitDelay;
                            CONTINUE;
                        END;
                        ELSE
                        BEGIN 
                            ROLLBACK TRANSACTION [deadlockSavePoint];
                            SELECT  @ErrorMessage = CASE WHEN @ErrorMessage <> '' THEN @ErrorMessage
                                                         ELSE OBJECT_NAME(@@PROCID) + ': An error occured while attempting to update item. Error = [%d]'
                                                    END;
                            SET @deadlockRetry = 3;
                            BREAK;
                        END;
                    END;
                    ELSE
                    BEGIN 
                        ROLLBACK TRANSACTION [deadlockSavePoint];
                        SELECT  @ErrorMessage = CASE WHEN @ErrorMessage <> '' THEN @ErrorMessage
                                                     ELSE OBJECT_NAME(@@PROCID) + ': An error occured while attempting to update item. Error = [%d]'
                                                END;
                        SET @deadlockRetry = 3;
                        BREAK;
                    END;
                END CATCH;
            END;
        END TRY
        BEGIN CATCH;
            SELECT  @v_Error = CASE WHEN @v_Error NOT IN ( -1, 1 ) THEN @@ERROR
                                    ELSE @v_Error
                               END,
                    @ErrorMessage = CASE WHEN @ErrorMessage <> '' THEN @ErrorMessage
                                         ELSE OBJECT_NAME(@@PROCID) + ': error reserving number, error [%d]'
                                    END;
        END CATCH;
        
        IF @InitialTransactionCount = 0
            AND @@TRANCOUNT > 0
        BEGIN 
            ROLLBACK;
        END;    
    
        IF @ErrorMessage = ''
            AND @v_Error = 0
        BEGIN 
            RETURN @v_Error;
        END;
        ELSE
        BEGIN 
            IF @InitialTransactionCount = 0
                AND @@TRANCOUNT > 0
            BEGIN 
                ROLLBACK TRANSACTION;
            END;
            ELSE
                IF @InitialTransactionCount <> 0
                    AND @@TRANCOUNT > @InitialTransactionCount
                BEGIN 
                    IF ( XACT_STATE() ) = -1
                    BEGIN 
                        SET @ErrorMessage = ISNULL(@ErrorMessage, OBJECT_NAME(@@PROCID)) + ' [Uncommittable Transaction!]';
                        ROLLBACK TRANSACTION;
                -- THIS IS TO AVOID TRANSACTION MISMATCHES IN THE CALLING APPLICATION
                        DECLARE @transactionFake INT = @@TRANCOUNT;
                        WHILE @transactionFake < @InitialTransactionCount
                        BEGIN 
                            BEGIN TRANSACTION;
                            SET @transactionFake = @transactionFake + 1;
                        END;
                    END;
                    ELSE
                    BEGIN 
                        WHILE @@TRANCOUNT > @InitialTransactionCount
                        BEGIN 
                            COMMIT TRANSACTION;
                        END;
                    END;
                END;
            RAISERROR(@ErrorMessage, 16, 1, @v_Error) WITH LOG;
        END;
    
        RETURN @v_Error;
    END;
GO
GRANT EXECUTE
	ON [dbo].[ap_dim_reserve_next_number_in_range]
	TO [portalapp_role]
GO
