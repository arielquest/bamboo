SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[tr_dim_category_inserted_updated]  ON [dbo].[TB_DIM_CATEGORY] FOR INSERT, UPDATE NOT FOR REPLICATION AS
BEGIN 
    SET XACT_ABORT OFF;
    SET NOCOUNT ON;
    
    DECLARE @ErrorMessage NVARCHAR(500) = N'', 
            @ErrorCode INT = 0,
            @InitialTransactionCount INT = @@TRANCOUNT,
            @NewTableGenerationCount BIGINT,
            @deadlockRetry TINYINT = 0,
            @WaitDelay CHAR(9),
            @IsUpdate AS [BIT],
            @CurrentScope VARBINARY(128);

    SELECT @CurrentScope = CONTEXT_INFO();
            
    SELECT @IsUpdate = CASE WHEN EXISTS(SELECT 1 FROM deleted) THEN 1 ELSE 0 END;

    -- Return early if no rows or if it is an update is by replication on the msrepl_tran_version column
    IF NOT EXISTS(SELECT 1 FROM inserted) OR (@IsUpdate = 1 AND UPDATE(msrepl_tran_version) AND SESSIONPROPERTY('REPLICATION_AGENT') = 0)
    /*
    -- Test
    OR (NOT UPDATE(ITEM_BIZ_URN) = 0 AND COLUMNS_UPDATED() ^ 2 <> 0)
    */
    -- Context_Info set to 0x0 means disable triggers in this scope
    OR @CurrentScope = 0x0
    BEGIN 
        RETURN;
    END;
    
    BEGIN TRANSACTION TR_categTran;
    WHILE @deadlockRetry < 3
    BEGIN 
        SAVE TRANSACTION deadlockSavePoint;
        BEGIN TRY; 
            DECLARE @PARENT_PATH NVARCHAR(4000), @RowCount INT = 0;
            
            SELECT @PARENT_PATH = [parent].[PATH]
            FROM dbo.TB_DIM_CATEGORY [parent]
            INNER JOIN inserted [child] ON [child].[HIERARCHY_PARENT_URN] = [parent].[ITEM_URN]
            WHERE [child].[ROOT_CATEGORY_BIZ_URN] IS NOT NULL AND [child].[ROOT_CATEGORY_BIZ_URN] > 0;

            -- DISABLE TRIGGERS FOR CURRENT scope
            SET CONTEXT_INFO 0x0;

            -- Set Biz Urn on inserts
            IF @IsUpdate = 0
            BEGIN 
                UPDATE dbo.TB_DIM_CATEGORY
                SET ITEM_BIZ_URN = ISNULL(NULLIF(ITEM_BIZ_URN,-2),ITEM_URN), [PATH] = ISNULL(@PARENT_PATH, '/') + REPLACE(ISNULL([NAME], '<NULL>'), '/', '|') + '/'
                WHERE ITEM_URN IN (SELECT ITEM_URN FROM inserted);
            END; 
            ELSE BEGIN
                -- On update, set path to the new path
                IF object_id('tempdb..#categoryPaths') IS NOT NULL
                BEGIN
                    DROP TABLE #categoryPaths;
                END;
                
                SELECT  a.ITEM_URN,
                        ISNULL(@PARENT_PATH, '/') + REPLACE(ISNULL([b].[NAME], '<NULL>'), '/', '|') + '/' AS [NEW_PATH],
                        b.[PATH] AS [OLD_PATH]
                INTO    #categoryPaths
                FROM    [Inserted] a
                INNER JOIN [dbo].[TB_DIM_CATEGORY] b ON [b].[ITEM_URN] = [a].[ITEM_URN];

                IF EXISTS ( SELECT  1
                            FROM    #categoryPaths )
                BEGIN
                    UPDATE  dbo.TB_DIM_CATEGORY
                    SET     [PATH] = ISNULL(@PARENT_PATH, '/') + REPLACE(ISNULL([NAME], '<NULL>'), '/', '|') + '/'
                    WHERE   ITEM_URN IN ( SELECT    ITEM_URN
                                          FROM      inserted )
                            AND ISNULL([PATH],'') <> ISNULL(@PARENT_PATH, '/') + REPLACE(ISNULL([NAME], '<NULL>'), '/', '|') + '/';

                    SET @RowCount = @@ROWCOUNT;
                
                    IF @RowCount > 0
                    BEGIN
                        -- A path has been updated, so ensure any children are correctly set
                        WITH    category
                                  AS ( SELECT   [dim].[PATH],
                                                [paths].[NEW_PATH],
                                                [paths].[OLD_PATH]
                                       FROM     [dbo].[TB_DIM_CATEGORY] [dim]
                                       INNER JOIN #categoryPaths [paths] ON dim.[PATH] LIKE paths.[OLD_PATH] + '%'
                                       WHERE    [dim].[ROOT_CATEGORY_BIZ_URN] IS NOT NULL
                                                AND [dim].[ROOT_CATEGORY_BIZ_URN] > 0
                                     )
                            UPDATE  category
                            SET     [PATH] = STUFF([PATH], 1, LEN([OLD_PATH]), [NEW_PATH]);
                    END;
                END;
            END;
            
            IF @InitialTransactionCount = 0 
            BEGIN 
                COMMIT TRANSACTION TR_categTran;
            END;
            ELSE BEGIN 
                WHILE @@TRANCOUNT > @InitialTransactionCount
                BEGIN 
                    COMMIT TRANSACTION;
                END;
            END;
            SET @deadlockRetry = 3;
            BREAK;
        END TRY 
        BEGIN CATCH;
            SET @ErrorCode = ERROR_NUMBER();
            IF @ErrorCode <> 0
            BEGIN 
                IF @ErrorCode = 1205 
                BEGIN 
                    IF XACT_STATE() = -1
                    BEGIN 
                        SET @ErrorMessage = OBJECT_NAME(@@PROCID)+': A deadlock occured and this transaction was the deadlock-victim. Error = [%d]';
                        SET @deadlockRetry = 3;
                        BREAK;
                    END;
                    ELSE BEGIN 
                        ROLLBACK TRANSACTION deadlockSavePoint;

                        SET @ErrorMessage = OBJECT_NAME(@@PROCID)+': A deadlock occured and this transaction was the deadlock-victim. Error = [%d]';
                        SET @deadlockRetry = @deadlockRetry + 1;
                        
                        --Random wait between 50ms and 999ms
                        SELECT @WaitDelay = '0:0:0.' + RIGHT('0'+CAST(CASE WHEN seed > 949 THEN 949 ELSE seed END +50 AS VARCHAR(3)),3)
                        FROM (SELECT ABS(CHECKSUM(NEWID()) % 999)) a(seed);                        
                        WAITFOR DELAY @WaitDelay;

                        CONTINUE;
                    END;
                END;
                ELSE BEGIN 
                    ROLLBACK TRANSACTION;
                    SET @ErrorMessage = OBJECT_NAME(@@PROCID)+': An error occured while attempting to insert item. Error = [%d]';
                    
                    SET @deadlockRetry = 3;
                    BREAK;
                END;
            END;
        END CATCH;
    END;
    
    IF @InitialTransactionCount = 0 AND @@TRANCOUNT > 0
    BEGIN 
        ROLLBACK;
    END; 

    -- RE-ENABLE TRIGGERS FOR CURRENT SCOPE
    SET CONTEXT_INFO 0x1; 
  
    
    IF @ErrorMessage = ''
    BEGIN 
        RETURN;
    END;
    ELSE BEGIN 
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
        RAISERROR(@ErrorMessage, 16, 1, @ErrorCode) WITH LOG;
    END;
END;
GO
