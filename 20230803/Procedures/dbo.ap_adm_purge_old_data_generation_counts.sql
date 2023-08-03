SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_adm_purge_old_data_generation_counts] (
    @OlderThanDays                            [INTEGER],    -- Note: Only applies to records in TS_ADM_DATA_GENERATION_COUNT
    @DeletionChunkSize                        [INTEGER] = 100000
)
AS
    SET NOCOUNT ON;

    DECLARE @ReturnCode AS [INTEGER],
            @RowCount AS INTEGER,
            @OldRowThreshold AS DATETIME,
            @QuietPeriodBeforePurgeSeconds [INTEGER],
            @InitialTransactionCount INT = @@TRANCOUNT;
            
    SET @ReturnCode = 0;
    SET @OldRowThreshold = DATEADD(day, -@OlderThanDays, GETUTCDATE());   

    -- Don't run a purge on a type specific gc table if there has been activity within the last 30 seconds - this removes the need for a modified date column in the table
    SET @QuietPeriodBeforePurgeSeconds = 30;

    -- validate "older than days"
    IF @OlderThanDays < 0
    BEGIN 
        SET @ReturnCode = 50161;
        RAISERROR('[dbo].[ap_adm_purge_old_data_generation_counts]: Invalid @OlderThanDays specified [%d]', 16, 1, @OlderThanDays);
        GOTO EXIT_SPROC;
    END;     
    
    BEGIN TRY;
        -- Chunk delete the members
        SET @RowCount = 1;
        WHILE @RowCount > 0
        BEGIN 
            DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_ADM_DATA_GENERATION_COUNT]
            WHERE LAST_OPERATION = 'D' 
            AND MODIFIED_DATE < @OldRowThreshold;
                
            SELECT @RowCount = @@ROWCOUNT;        
        END;

        -- System tables with data generation count tables
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_CLU_CONNECTION_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_CLU_CONNECTION_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;         
            END;
        END;

        -- Dimension and Dimension Pkey Map tables
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_AGENT_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_AGENT_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_AGENT_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_AGENT_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_AGENT_DESKTOP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_AGENT_DESKTOP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_AGENT_DESKTOP_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_AGENT_DESKTOP_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_AGENT_TEAM_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_AGENT_TEAM_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_AGENT_TEAM_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_AGENT_TEAM_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_ALIAS_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_ALIAS_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_ALIAS_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_ALIAS_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_ANNOUNCEMENT_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_ANNOUNCEMENT_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_ANNOUNCEMENT_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_ANNOUNCEMENT_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_APPLICATION_GATEWAY_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_APPLICATION_GATEWAY_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_APPLICATION_GATEWAY_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_APPLICATION_GATEWAY_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_APPLICATION_INSTANCE_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_APPLICATION_INSTANCE_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_APPLICATION_INSTANCE_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_APPLICATION_INSTANCE_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_APPLICATION_USER_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_APPLICATION_USER_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_APPLICATION_USER_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_APPLICATION_USER_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_BUCKET_INTERVAL_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_BUCKET_INTERVAL_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_BUCKET_INTERVAL_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_BUCKET_INTERVAL_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_CALL_MANAGER_GROUP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_CALL_MANAGER_GROUP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_CALL_MANAGER_GROUP_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_CALL_MANAGER_GROUP_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_CALL_SOURCE_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_CALL_SOURCE_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_CALL_SOURCE_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_CALL_SOURCE_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_CALL_TYPE_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_CALL_TYPE_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_CALL_TYPE_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_CALL_TYPE_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_CALLING_SEARCH_SPACE_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_CALLING_SEARCH_SPACE_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_CALLING_SEARCH_SPACE_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_CALLING_SEARCH_SPACE_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_CAMPAIGN_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_CAMPAIGN_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_CAMPAIGN_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_CAMPAIGN_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_CATEGORY_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_CATEGORY_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_CATEGORY_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_CATEGORY_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_CBR_RELEASE_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_CBR_RELEASE_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_CBR_RELEASE_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_CBR_RELEASE_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_CHARGEBAND_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_CHARGEBAND_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_CHARGEBAND_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_CHARGEBAND_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_CHAT_REFERRER_NAME_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_CHAT_REFERRER_NAME_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_CHAT_REFERRER_NAME_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_CHAT_REFERRER_NAME_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_CHAT_REFERRER_URL_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_CHAT_REFERRER_URL_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_CHAT_REFERRER_URL_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_CHAT_REFERRER_URL_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_CLI_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_CLI_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_CLI_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_CLI_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_COBROWSE_PAGE_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_COBROWSE_PAGE_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_COBROWSE_PAGE_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_COBROWSE_PAGE_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_CODE_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_CODE_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_CODE_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_CODE_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_CODE_GROUP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_CODE_GROUP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_CODE_GROUP_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_CODE_GROUP_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_CONTENT_URL_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_CONTENT_URL_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_CONTENT_URL_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_CONTENT_URL_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_CUSTOM_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_CUSTOM_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_CUSTOM_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_CUSTOM_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_CUSTOM_ATTRIBUTE0_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_CUSTOM_ATTRIBUTE0_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_CUSTOM_ATTRIBUTE0_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_CUSTOM_ATTRIBUTE0_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_CUSTOM_ATTRIBUTE1_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_CUSTOM_ATTRIBUTE1_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_CUSTOM_ATTRIBUTE1_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_CUSTOM_ATTRIBUTE1_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_CUSTOM_ATTRIBUTE2_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_CUSTOM_ATTRIBUTE2_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_CUSTOM_ATTRIBUTE2_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_CUSTOM_ATTRIBUTE2_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_CUSTOM_ATTRIBUTE3_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_CUSTOM_ATTRIBUTE3_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_CUSTOM_ATTRIBUTE3_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_CUSTOM_ATTRIBUTE3_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_CUSTOM_ATTRIBUTE4_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_CUSTOM_ATTRIBUTE4_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_CUSTOM_ATTRIBUTE4_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_CUSTOM_ATTRIBUTE4_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_CUSTOM_ATTRIBUTE5_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_CUSTOM_ATTRIBUTE5_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_CUSTOM_ATTRIBUTE5_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_CUSTOM_ATTRIBUTE5_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_CUSTOM_ATTRIBUTE6_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_CUSTOM_ATTRIBUTE6_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_CUSTOM_ATTRIBUTE6_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_CUSTOM_ATTRIBUTE6_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_CUSTOM_ATTRIBUTE7_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_CUSTOM_ATTRIBUTE7_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_CUSTOM_ATTRIBUTE7_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_CUSTOM_ATTRIBUTE7_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_CUSTOM_ATTRIBUTE8_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_CUSTOM_ATTRIBUTE8_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_CUSTOM_ATTRIBUTE8_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_CUSTOM_ATTRIBUTE8_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_CUSTOM_ATTRIBUTE9_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_CUSTOM_ATTRIBUTE9_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_CUSTOM_ATTRIBUTE9_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_CUSTOM_ATTRIBUTE9_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_CUSTOM_ENTRY_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_CUSTOM_ENTRY_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_CUSTOM_ENTRY_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_CUSTOM_ENTRY_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_CUSTOM0_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_CUSTOM0_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_CUSTOM0_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_CUSTOM0_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_CUSTOM1_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_CUSTOM1_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_CUSTOM1_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_CUSTOM1_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_CUSTOM2_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_CUSTOM2_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_CUSTOM2_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_CUSTOM2_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_CUSTOM3_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_CUSTOM3_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_CUSTOM3_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_CUSTOM3_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_CUSTOM4_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_CUSTOM4_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_CUSTOM4_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_CUSTOM4_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_CUSTOM5_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_CUSTOM5_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_CUSTOM5_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_CUSTOM5_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_CUSTOM6_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_CUSTOM6_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_CUSTOM6_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_CUSTOM6_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_CUSTOM7_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_CUSTOM7_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_CUSTOM7_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_CUSTOM7_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_CUSTOM8_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_CUSTOM8_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_CUSTOM8_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_CUSTOM8_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_CUSTOM9_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_CUSTOM9_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_CUSTOM9_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_CUSTOM9_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_DATE_TIME_SETTING_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_DATE_TIME_SETTING_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_DATE_TIME_SETTING_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_DATE_TIME_SETTING_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_DEPARTMENT_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_DEPARTMENT_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_DEPARTMENT_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_DEPARTMENT_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_DEVICE_POOL_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_DEVICE_POOL_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_DEVICE_POOL_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_DEVICE_POOL_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_DEVICE_PROFILE_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_DEVICE_PROFILE_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_DEVICE_PROFILE_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_DEVICE_PROFILE_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_DEVICE_TARGET_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_DEVICE_TARGET_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_DEVICE_TARGET_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_DEVICE_TARGET_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_DIAL_NUMBER_PLAN_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_DIAL_NUMBER_PLAN_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_DIAL_NUMBER_PLAN_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_DIAL_NUMBER_PLAN_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_DIALED_NUMBER_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_DIALED_NUMBER_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_DIALED_NUMBER_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_DIALED_NUMBER_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_DIALER_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_DIALER_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_DIALER_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_DIALER_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_DIRECTORY_NUMBER_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_DIRECTORY_NUMBER_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_DIRECTORY_NUMBER_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_DIRECTORY_NUMBER_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_DOCUMENT_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_DOCUMENT_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_ECC_PAYLOAD_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_ECC_PAYLOAD_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_ECC_PAYLOAD_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_ECC_PAYLOAD_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_EMAIL_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_EMAIL_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_EMAIL_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_EMAIL_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_ENTERPRISE_ROUTE_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_ENTERPRISE_ROUTE_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_ENTERPRISE_ROUTE_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_ENTERPRISE_ROUTE_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_ENTERPRISE_SERVICE_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_ENTERPRISE_SERVICE_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_ENTERPRISE_SERVICE_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_ENTERPRISE_SERVICE_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_ENTERPRISE_SKILLGROUP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_ENTERPRISE_SKILLGROUP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_ENTERPRISE_SKILLGROUP_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_ENTERPRISE_SKILLGROUP_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_ENTRY_POINT_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_ENTRY_POINT_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_ENTRY_POINT_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_ENTRY_POINT_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_EXPANDED_CALL_VARIABLE_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_EXPANDED_CALL_VARIABLE_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_EXPANDED_CALL_VARIABLE_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_EXPANDED_CALL_VARIABLE_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_FILESHARE_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_FILESHARE_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_FILESHARE_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_FILESHARE_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_GATEWAY_FUNCTION_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_GATEWAY_FUNCTION_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_GATEWAY_FUNCTION_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_GATEWAY_FUNCTION_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_GATEWAY_RESULT_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_GATEWAY_RESULT_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_GATEWAY_RESULT_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_GATEWAY_RESULT_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_GATEWAY_SERVER_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_GATEWAY_SERVER_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_GATEWAY_SERVER_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_GATEWAY_SERVER_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_GHE_ANSWER_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_GHE_ANSWER_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_GHE_ANSWER_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_GHE_ANSWER_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_GHE_CLUSTER_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_GHE_CLUSTER_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_GHE_CLUSTER_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_GHE_CLUSTER_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_GHE_CLUSTER_GROUP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_GHE_CLUSTER_GROUP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_GHE_CLUSTER_GROUP_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_GHE_CLUSTER_GROUP_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_GHE_QUESTION_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_GHE_QUESTION_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_GHE_QUESTION_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_GHE_QUESTION_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_HIERARCHY_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_HIERARCHY_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_HIERARCHY_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_HIERARCHY_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_HIERARCHY_NODE_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_HIERARCHY_NODE_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_HIERARCHY_NODE_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_HIERARCHY_NODE_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_HUNT_PILOT_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_HUNT_PILOT_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_HUNT_PILOT_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_HUNT_PILOT_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_ICR_INSTANCE_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_ICR_INSTANCE_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_ICR_INSTANCE_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_ICR_INSTANCE_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_IMPORT_RULE_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_IMPORT_RULE_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_IMPORT_RULE_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_IMPORT_RULE_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_IP_ENDPOINT_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_IP_ENDPOINT_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_IP_ENDPOINT_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_IP_ENDPOINT_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_IP_ENDPOINT_BUTTON_TEMPLATE_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_IP_ENDPOINT_BUTTON_TEMPLATE_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_IP_ENDPOINT_BUTTON_TEMPLATE_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_IP_ENDPOINT_BUTTON_TEMPLATE_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_IVR_ENTRY_POINT_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_IVR_ENTRY_POINT_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_IVR_ENTRY_POINT_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_IVR_ENTRY_POINT_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_IVR_MODULE_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_IVR_MODULE_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_IVR_MODULE_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_IVR_MODULE_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_IVR_QUEUE_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_IVR_QUEUE_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_IVR_QUEUE_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_IVR_QUEUE_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_IVR_ROUTING_TARGET_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_IVR_ROUTING_TARGET_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_IVR_ROUTING_TARGET_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_IVR_ROUTING_TARGET_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_IVR_SCRIPT_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_IVR_SCRIPT_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_IVR_SCRIPT_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_IVR_SCRIPT_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_IVR_SCRIPT_NODE_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_IVR_SCRIPT_NODE_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_IVR_SCRIPT_NODE_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_IVR_SCRIPT_NODE_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_IVR_SCRIPT_NODE_EXIT_STATE_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_IVR_SCRIPT_NODE_EXIT_STATE_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_IVR_SCRIPT_NODE_EXIT_STATE_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_IVR_SCRIPT_NODE_EXIT_STATE_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_IVR_SERVER_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_IVR_SERVER_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_IVR_SERVER_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_IVR_SERVER_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_KB_ARTICLE_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_KB_ARTICLE_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_KB_ARTICLE_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_KB_ARTICLE_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_KB_ARTICLE_REVIEW_STAGE_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_KB_ARTICLE_REVIEW_STAGE_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_KB_ARTICLE_REVIEW_STAGE_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_KB_ARTICLE_REVIEW_STAGE_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_KB_ARTICLE_WORKFLOW_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_KB_ARTICLE_WORKFLOW_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_KB_ARTICLE_WORKFLOW_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_KB_ARTICLE_WORKFLOW_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_KB_COMPLIANCE_POLICY_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_KB_COMPLIANCE_POLICY_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_KB_COMPLIANCE_POLICY_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_KB_COMPLIANCE_POLICY_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_KB_FOLDER_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_KB_FOLDER_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_KB_FOLDER_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_KB_FOLDER_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_KB_PORTAL_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_KB_PORTAL_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_KB_PORTAL_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_KB_PORTAL_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_KB_TOPIC_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_KB_TOPIC_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_KB_TOPIC_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_KB_TOPIC_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_LABEL_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_LABEL_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_LABEL_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_LABEL_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_LOGICAL_INTERFACE_CONTROLLER_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_LOGICAL_INTERFACE_CONTROLLER_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_LOGICAL_INTERFACE_CONTROLLER_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_LOGICAL_INTERFACE_CONTROLLER_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_MACHINE_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_MACHINE_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_MACHINE_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_MACHINE_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_MACHINE_RESOURCE_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_MACHINE_RESOURCE_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_MACHINE_RESOURCE_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_MACHINE_RESOURCE_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_MEDIA_CLASS_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_MEDIA_CLASS_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_MEDIA_CLASS_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_MEDIA_CLASS_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_MEDIA_ROUTING_DOMAIN_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_MEDIA_ROUTING_DOMAIN_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_MEDIA_ROUTING_DOMAIN_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_MEDIA_ROUTING_DOMAIN_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_MEDIAFILE_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_MEDIAFILE_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_MEDIAFILE_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_MEDIAFILE_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_MEDIAFILE_SERVER_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_MEDIAFILE_SERVER_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_MEDIAFILE_SERVER_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_MEDIAFILE_SERVER_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_NETWORK_TRUNK_GROUP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_NETWORK_TRUNK_GROUP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_NETWORK_TRUNK_GROUP_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_NETWORK_TRUNK_GROUP_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_NETWORK_VRU_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_NETWORK_VRU_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_NETWORK_VRU_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_NETWORK_VRU_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_NETWORK_VRU_SCRIPT_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_NETWORK_VRU_SCRIPT_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_NETWORK_VRU_SCRIPT_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_NETWORK_VRU_SCRIPT_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_NOTIFY_CATEGORY_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_NOTIFY_CATEGORY_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_NOTIFY_CATEGORY_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_NOTIFY_CATEGORY_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_NOTIFY_CHANNEL_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_NOTIFY_CHANNEL_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_NOTIFY_CHANNEL_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_NOTIFY_CHANNEL_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_NOTIFY_MESSAGE_TYPE_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_NOTIFY_MESSAGE_TYPE_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_NOTIFY_MESSAGE_TYPE_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_NOTIFY_MESSAGE_TYPE_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_NOTIFY_ORIGIN_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_NOTIFY_ORIGIN_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_NOTIFY_ORIGIN_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_NOTIFY_ORIGIN_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_OBJECT_TYPE_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_OBJECT_TYPE_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_OBJECT_TYPE_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_OBJECT_TYPE_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_OFFER_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_OFFER_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_OFFER_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_OFFER_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_OFFER_BANNER_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_OFFER_BANNER_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_OFFER_BANNER_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_OFFER_BANNER_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_PERIPHERAL_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_PERIPHERAL_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_PERIPHERAL_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_PERIPHERAL_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_PERSON_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_PERSON_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_PERSON_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_PERSON_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_PHYSICAL_INTERFACE_CONTROLLER_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_PHYSICAL_INTERFACE_CONTROLLER_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_PHYSICAL_INTERFACE_CONTROLLER_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_PHYSICAL_INTERFACE_CONTROLLER_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_PORT_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_PORT_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_PORT_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_PORT_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_PRECISION_ATTRIBUTE_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_PRECISION_ATTRIBUTE_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_PRECISION_ATTRIBUTE_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_PRECISION_ATTRIBUTE_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_PRECISION_QUEUE_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_PRECISION_QUEUE_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_PRECISION_QUEUE_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_PRECISION_QUEUE_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_PRECISION_QUEUE_STEP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_PRECISION_QUEUE_STEP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_PRECISION_QUEUE_STEP_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_PRECISION_QUEUE_STEP_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_QUERY_RULE_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_QUERY_RULE_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_QUERY_RULE_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_QUERY_RULE_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_QUEUE_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_QUEUE_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_QUEUE_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_QUEUE_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_RATING_PERIOD_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_RATING_PERIOD_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_RATING_PERIOD_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_RATING_PERIOD_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_REASON_CODE_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_REASON_CODE_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_REASON_CODE_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_REASON_CODE_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_REGION_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_REGION_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_REGION_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_REGION_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_ROUTE_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_ROUTE_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_ROUTE_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_ROUTE_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_ROUTE_PARTITION_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_ROUTE_PARTITION_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_ROUTE_PARTITION_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_ROUTE_PARTITION_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_ROUTING_CLIENT_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_ROUTING_CLIENT_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_ROUTING_CLIENT_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_ROUTING_CLIENT_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_ROUTING_PROFILE_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_ROUTING_PROFILE_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_ROUTING_PROFILE_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_ROUTING_PROFILE_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_ROUTING_SCRIPT_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_ROUTING_SCRIPT_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_ROUTING_SCRIPT_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_ROUTING_SCRIPT_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_SCHEDULE_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_SCHEDULE_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_SCHEDULE_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_SCHEDULE_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_SCHEDULED_TARGET_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_SCHEDULED_TARGET_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_SCHEDULED_TARGET_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_SCHEDULED_TARGET_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_SCL_ADAPTER_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_SCL_ADAPTER_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_SCL_ADAPTER_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_SCL_ADAPTER_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_SCL_SEARCH_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_SCL_SEARCH_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_SCL_SEARCH_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_SCL_SEARCH_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_SCRIPT_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_SCRIPT_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_SCRIPT_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_SCRIPT_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_SCRIPT_NODE_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_SCRIPT_NODE_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_SCRIPT_NODE_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_SCRIPT_NODE_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_SERVICE_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_SERVICE_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_SERVICE_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_SERVICE_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_SKILLGROUP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_SKILLGROUP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_SKILLGROUP_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_SKILLGROUP_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_SLA_BUCKET_INTERVAL_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_SLA_BUCKET_INTERVAL_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_SLA_BUCKET_INTERVAL_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_SLA_BUCKET_INTERVAL_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_STRATEGY_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_STRATEGY_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_STRATEGY_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_STRATEGY_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_SUB_CODE_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_SUB_CODE_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_SUB_CODE_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_SUB_CODE_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_TENANT_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_TENANT_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_TENANT_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_TENANT_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_TIMEBAND_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_TIMEBAND_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_TIMEBAND_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_TIMEBAND_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_TLI_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_TLI_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_TLI_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_TLI_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_TRANSLATION_ROUTE_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_TRANSLATION_ROUTE_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_TRANSLATION_ROUTE_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_TRANSLATION_ROUTE_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_TRUNK_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_TRUNK_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_TRUNK_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_TRUNK_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_TRUNK_GROUP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_TRUNK_GROUP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_TRUNK_GROUP_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_TRUNK_GROUP_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_UC_SERVICE_PROFILE_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_UC_SERVICE_PROFILE_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_UC_SERVICE_PROFILE_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_UC_SERVICE_PROFILE_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_USER_GROUP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_USER_GROUP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_USER_GROUP_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_USER_GROUP_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_USER_VARIABLE_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_USER_VARIABLE_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_USER_VARIABLE_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_USER_VARIABLE_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_VA_ASSISTANT_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_VA_ASSISTANT_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_VA_ASSISTANT_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_VA_ASSISTANT_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_VA_ATTRIBUTE_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_VA_ATTRIBUTE_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_VA_ATTRIBUTE_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_VA_ATTRIBUTE_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_VA_CASE_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_VA_CASE_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_VA_CASE_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_VA_CASE_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_VA_CATEGORY_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_VA_CATEGORY_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_VA_CATEGORY_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_VA_CATEGORY_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_VA_CLASSIFIER_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_VA_CLASSIFIER_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_VA_CLASSIFIER_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_VA_CLASSIFIER_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_VA_CUSTOMER_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_VA_CUSTOMER_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_VA_CUSTOMER_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_VA_CUSTOMER_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_VA_DOMAIN_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_VA_DOMAIN_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_VA_DOMAIN_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_VA_DOMAIN_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_VA_INTENT_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_VA_INTENT_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_VA_INTENT_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_VA_INTENT_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_VA_KEYWORD_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_VA_KEYWORD_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_VA_KEYWORD_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_VA_KEYWORD_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_VA_SCORE_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_VA_SCORE_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_VA_SCORE_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_VA_SCORE_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_VA_URL_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_VA_URL_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_VA_URL_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_VA_URL_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_VECTOR_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_VECTOR_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_VECTOR_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_VECTOR_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_VECTOR_DIRECTORY_NUMBER_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_VECTOR_DIRECTORY_NUMBER_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_VECTOR_DIRECTORY_NUMBER_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_VECTOR_DIRECTORY_NUMBER_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_VXMLAPPLICATION_SERVER_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_VXMLAPPLICATION_SERVER_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_VXMLAPPLICATION_SERVER_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_VXMLAPPLICATION_SERVER_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_WRAPUP_CODE_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_WRAPUP_CODE_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;
      
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_WRAPUP_CODE_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_WRAPUP_CODE_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;           
            END;
        END;

        -- Member and Member Pkey Map Tables
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_AGENT_AGENT_DESKTOP_MEMBER_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN          
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_AGENT_AGENT_DESKTOP_MEMBER_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;
            END;
        END;
            
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_AGENT_AGENT_DESKTOP_MEMBER_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_AGENT_AGENT_DESKTOP_MEMBER_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;

        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_AGENT_AGENT_TEAM_MEMBER_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN          
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_AGENT_AGENT_TEAM_MEMBER_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;
            END;
        END;
            
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_AGENT_AGENT_TEAM_MEMBER_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_AGENT_AGENT_TEAM_MEMBER_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;

        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_AGENT_DESKTOP_DIALED_NUMBER_MEMBER_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN          
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_AGENT_DESKTOP_DIALED_NUMBER_MEMBER_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;
            END;
        END;
            
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_AGENT_DESKTOP_DIALED_NUMBER_MEMBER_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_AGENT_DESKTOP_DIALED_NUMBER_MEMBER_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;

        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_AGENT_PERIPHERAL_MEMBER_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN          
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_AGENT_PERIPHERAL_MEMBER_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;
            END;
        END;
            
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_AGENT_PERIPHERAL_MEMBER_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_AGENT_PERIPHERAL_MEMBER_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;

        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_AGENT_PERSON_MEMBER_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN          
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_AGENT_PERSON_MEMBER_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;
            END;
        END;
            
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_AGENT_PERSON_MEMBER_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_AGENT_PERSON_MEMBER_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;

        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_AGENT_PRECISION_ATTRIBUTE_MEMBER_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN          
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_AGENT_PRECISION_ATTRIBUTE_MEMBER_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;
            END;
        END;
            
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_AGENT_PRECISION_ATTRIBUTE_MEMBER_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_AGENT_PRECISION_ATTRIBUTE_MEMBER_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;

        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_AGENT_SKILLGROUP_MEMBER_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN          
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_AGENT_SKILLGROUP_MEMBER_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;
            END;
        END;
            
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_AGENT_SKILLGROUP_MEMBER_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_AGENT_SKILLGROUP_MEMBER_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;

        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_AGENT_TEAM_DIALED_NUMBER_MEMBER_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN          
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_AGENT_TEAM_DIALED_NUMBER_MEMBER_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;
            END;
        END;
            
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_AGENT_TEAM_DIALED_NUMBER_MEMBER_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_AGENT_TEAM_DIALED_NUMBER_MEMBER_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;

        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_AGENT_TEAM_PERIPHERAL_MEMBER_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN          
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_AGENT_TEAM_PERIPHERAL_MEMBER_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;
            END;
        END;
            
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_AGENT_TEAM_PERIPHERAL_MEMBER_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_AGENT_TEAM_PERIPHERAL_MEMBER_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;

        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_AGENT_USER_GROUP_MEMBER_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN          
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_AGENT_USER_GROUP_MEMBER_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;
            END;
        END;
            
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_AGENT_USER_GROUP_MEMBER_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_AGENT_USER_GROUP_MEMBER_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;

        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_CALL_TYPE_BUCKET_INTERVAL_MEMBER_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN          
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_CALL_TYPE_BUCKET_INTERVAL_MEMBER_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;
            END;
        END;
            
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_CALL_TYPE_BUCKET_INTERVAL_MEMBER_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_CALL_TYPE_BUCKET_INTERVAL_MEMBER_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;

        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_CALL_TYPE_ROUTING_SCRIPT_MEMBER_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN          
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_CALL_TYPE_ROUTING_SCRIPT_MEMBER_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;
            END;
        END;
            
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_CALL_TYPE_ROUTING_SCRIPT_MEMBER_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_CALL_TYPE_ROUTING_SCRIPT_MEMBER_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;

        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_CODE_CODE_GROUP_MEMBER_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN          
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_CODE_CODE_GROUP_MEMBER_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;
            END;
        END;
            
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_CODE_CODE_GROUP_MEMBER_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_CODE_CODE_GROUP_MEMBER_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;

        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_CUSTOM_ENTRY_CUSTOM_MEMBER_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN          
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_CUSTOM_ENTRY_CUSTOM_MEMBER_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;
            END;
        END;
            
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_CUSTOM_ENTRY_CUSTOM_MEMBER_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_CUSTOM_ENTRY_CUSTOM_MEMBER_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;

        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_DEVICE_POOL_CALL_MANAGER_GROUP_MEMBER_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN          
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_DEVICE_POOL_CALL_MANAGER_GROUP_MEMBER_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;
            END;
        END;
            
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_DEVICE_POOL_CALL_MANAGER_GROUP_MEMBER_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_DEVICE_POOL_CALL_MANAGER_GROUP_MEMBER_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;

        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_DEVICE_POOL_DATE_TIME_SETTING_MEMBER_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN          
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_DEVICE_POOL_DATE_TIME_SETTING_MEMBER_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;
            END;
        END;
            
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_DEVICE_POOL_DATE_TIME_SETTING_MEMBER_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_DEVICE_POOL_DATE_TIME_SETTING_MEMBER_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;

        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_DEVICE_PROFILE_DIRECTORY_NUMBER_MEMBER_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN          
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_DEVICE_PROFILE_DIRECTORY_NUMBER_MEMBER_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;
            END;
        END;
            
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_DEVICE_PROFILE_DIRECTORY_NUMBER_MEMBER_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_DEVICE_PROFILE_DIRECTORY_NUMBER_MEMBER_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;

        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_DEVICE_PROFILE_IP_ENDPOINT_BUTTON_TEMPLATE_MEMBER_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN          
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_DEVICE_PROFILE_IP_ENDPOINT_BUTTON_TEMPLATE_MEMBER_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;
            END;
        END;
            
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_DEVICE_PROFILE_IP_ENDPOINT_BUTTON_TEMPLATE_MEMBER_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_DEVICE_PROFILE_IP_ENDPOINT_BUTTON_TEMPLATE_MEMBER_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;

        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_DEVICE_PROFILE_PERSON_MEMBER_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN          
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_DEVICE_PROFILE_PERSON_MEMBER_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;
            END;
        END;
            
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_DEVICE_PROFILE_PERSON_MEMBER_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_DEVICE_PROFILE_PERSON_MEMBER_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;

        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_DIALED_NUMBER_CALL_TYPE_MEMBER_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN          
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_DIALED_NUMBER_CALL_TYPE_MEMBER_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;
            END;
        END;
            
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_DIALED_NUMBER_CALL_TYPE_MEMBER_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_DIALED_NUMBER_CALL_TYPE_MEMBER_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;

        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_DIALED_NUMBER_MEDIA_ROUTING_DOMAIN_MEMBER_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN          
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_DIALED_NUMBER_MEDIA_ROUTING_DOMAIN_MEMBER_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;
            END;
        END;
            
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_DIALED_NUMBER_MEDIA_ROUTING_DOMAIN_MEMBER_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_DIALED_NUMBER_MEDIA_ROUTING_DOMAIN_MEMBER_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;

        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_DIALED_NUMBER_ROUTING_CLIENT_MEMBER_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN          
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_DIALED_NUMBER_ROUTING_CLIENT_MEMBER_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;
            END;
        END;
            
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_DIALED_NUMBER_ROUTING_CLIENT_MEMBER_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_DIALED_NUMBER_ROUTING_CLIENT_MEMBER_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;

        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_EXPANDED_CALL_VARIABLE_ECC_PAYLOAD_MEMBER_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN          
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_EXPANDED_CALL_VARIABLE_ECC_PAYLOAD_MEMBER_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;
            END;
        END;
            
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_EXPANDED_CALL_VARIABLE_ECC_PAYLOAD_MEMBER_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_EXPANDED_CALL_VARIABLE_ECC_PAYLOAD_MEMBER_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;

        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_GHE_CLUSTER_GHE_CLUSTER_GROUP_MEMBER_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN          
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_GHE_CLUSTER_GHE_CLUSTER_GROUP_MEMBER_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;
            END;
        END;
            
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_GHE_CLUSTER_GHE_CLUSTER_GROUP_MEMBER_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_GHE_CLUSTER_GHE_CLUSTER_GROUP_MEMBER_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;

        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_GHE_QUESTION_GHE_ANSWER_MEMBER_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN          
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_GHE_QUESTION_GHE_ANSWER_MEMBER_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;
            END;
        END;
            
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_GHE_QUESTION_GHE_ANSWER_MEMBER_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_GHE_QUESTION_GHE_ANSWER_MEMBER_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;

        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_IP_ENDPOINT_CALLING_SEARCH_SPACE_MEMBER_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN          
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_IP_ENDPOINT_CALLING_SEARCH_SPACE_MEMBER_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;
            END;
        END;
            
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_IP_ENDPOINT_CALLING_SEARCH_SPACE_MEMBER_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_IP_ENDPOINT_CALLING_SEARCH_SPACE_MEMBER_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;

        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_IP_ENDPOINT_DEVICE_POOL_MEMBER_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN          
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_IP_ENDPOINT_DEVICE_POOL_MEMBER_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;
            END;
        END;
            
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_IP_ENDPOINT_DEVICE_POOL_MEMBER_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_IP_ENDPOINT_DEVICE_POOL_MEMBER_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;

        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_IP_ENDPOINT_DIRECTORY_NUMBER_MEMBER_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN          
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_IP_ENDPOINT_DIRECTORY_NUMBER_MEMBER_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;
            END;
        END;
            
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_IP_ENDPOINT_DIRECTORY_NUMBER_MEMBER_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_IP_ENDPOINT_DIRECTORY_NUMBER_MEMBER_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;

        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_IP_ENDPOINT_IP_ENDPOINT_BUTTON_TEMPLATE_MEMBER_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN          
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_IP_ENDPOINT_IP_ENDPOINT_BUTTON_TEMPLATE_MEMBER_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;
            END;
        END;
            
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_IP_ENDPOINT_IP_ENDPOINT_BUTTON_TEMPLATE_MEMBER_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_IP_ENDPOINT_IP_ENDPOINT_BUTTON_TEMPLATE_MEMBER_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;

        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_IP_ENDPOINT_PERIPHERAL_MEMBER_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN          
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_IP_ENDPOINT_PERIPHERAL_MEMBER_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;
            END;
        END;
            
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_IP_ENDPOINT_PERIPHERAL_MEMBER_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_IP_ENDPOINT_PERIPHERAL_MEMBER_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;

        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_IVR_ENTRY_POINT_DIALED_NUMBER_MEMBER_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN          
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_IVR_ENTRY_POINT_DIALED_NUMBER_MEMBER_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;
            END;
        END;
            
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_IVR_ENTRY_POINT_DIALED_NUMBER_MEMBER_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_IVR_ENTRY_POINT_DIALED_NUMBER_MEMBER_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;

        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_IVR_ENTRY_POINT_IVR_SCRIPT_MEMBER_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN          
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_IVR_ENTRY_POINT_IVR_SCRIPT_MEMBER_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;
            END;
        END;
            
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_IVR_ENTRY_POINT_IVR_SCRIPT_MEMBER_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_IVR_ENTRY_POINT_IVR_SCRIPT_MEMBER_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;

        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_IVR_ROUTING_TARGET_IVR_SCRIPT_MEMBER_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN          
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_IVR_ROUTING_TARGET_IVR_SCRIPT_MEMBER_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;
            END;
        END;
            
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_IVR_ROUTING_TARGET_IVR_SCRIPT_MEMBER_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_IVR_ROUTING_TARGET_IVR_SCRIPT_MEMBER_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;

        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_IVR_SCRIPT_NODE_IVR_MODULE_MEMBER_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN          
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_IVR_SCRIPT_NODE_IVR_MODULE_MEMBER_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;
            END;
        END;
            
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_IVR_SCRIPT_NODE_IVR_MODULE_MEMBER_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_IVR_SCRIPT_NODE_IVR_MODULE_MEMBER_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;

        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_KB_ARTICLE_KB_TOPIC_MEMBER_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN          
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_KB_ARTICLE_KB_TOPIC_MEMBER_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;
            END;
        END;
            
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_KB_ARTICLE_KB_TOPIC_MEMBER_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_KB_ARTICLE_KB_TOPIC_MEMBER_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;

        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_LABEL_DIALED_NUMBER_MEMBER_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN          
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_LABEL_DIALED_NUMBER_MEMBER_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;
            END;
        END;
            
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_LABEL_DIALED_NUMBER_MEMBER_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_LABEL_DIALED_NUMBER_MEMBER_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;

        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_LABEL_ROUTING_CLIENT_MEMBER_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN          
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_LABEL_ROUTING_CLIENT_MEMBER_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;
            END;
        END;
            
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_LABEL_ROUTING_CLIENT_MEMBER_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_LABEL_ROUTING_CLIENT_MEMBER_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;

        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_MEDIA_ROUTING_DOMAIN_MEDIA_CLASS_MEMBER_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN          
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_MEDIA_ROUTING_DOMAIN_MEDIA_CLASS_MEMBER_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;
            END;
        END;
            
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_MEDIA_ROUTING_DOMAIN_MEDIA_CLASS_MEMBER_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_MEDIA_ROUTING_DOMAIN_MEDIA_CLASS_MEMBER_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;

        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_NETWORK_VRU_SCRIPT_NETWORK_VRU_MEMBER_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN          
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_NETWORK_VRU_SCRIPT_NETWORK_VRU_MEMBER_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;
            END;
        END;
            
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_NETWORK_VRU_SCRIPT_NETWORK_VRU_MEMBER_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_NETWORK_VRU_SCRIPT_NETWORK_VRU_MEMBER_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;

        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_PERIPHERAL_LOGICAL_INTERFACE_CONTROLLER_MEMBER_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN          
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_PERIPHERAL_LOGICAL_INTERFACE_CONTROLLER_MEMBER_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;
            END;
        END;
            
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_PERIPHERAL_LOGICAL_INTERFACE_CONTROLLER_MEMBER_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_PERIPHERAL_LOGICAL_INTERFACE_CONTROLLER_MEMBER_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;

        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_PHYSICAL_CONTROLLER_LOGICAL_CONTROLLER_MEMBER_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN          
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_PHYSICAL_CONTROLLER_LOGICAL_CONTROLLER_MEMBER_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;
            END;
        END;
            
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_PHYSICAL_CONTROLLER_LOGICAL_CONTROLLER_MEMBER_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_PHYSICAL_CONTROLLER_LOGICAL_CONTROLLER_MEMBER_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;

        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_PRECISION_QUEUE_BUCKET_INTERVAL_MEMBER_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN          
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_PRECISION_QUEUE_BUCKET_INTERVAL_MEMBER_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;
            END;
        END;
            
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_PRECISION_QUEUE_BUCKET_INTERVAL_MEMBER_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_PRECISION_QUEUE_BUCKET_INTERVAL_MEMBER_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;

        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_PRECISION_QUEUE_MEDIA_ROUTING_DOMAIN_MEMBER_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN          
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_PRECISION_QUEUE_MEDIA_ROUTING_DOMAIN_MEMBER_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;
            END;
        END;
            
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_PRECISION_QUEUE_MEDIA_ROUTING_DOMAIN_MEMBER_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_PRECISION_QUEUE_MEDIA_ROUTING_DOMAIN_MEMBER_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;

        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_PRECISION_QUEUE_STEP_PRECISION_ATTRIBUTE_MEMBER_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN          
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_PRECISION_QUEUE_STEP_PRECISION_ATTRIBUTE_MEMBER_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;
            END;
        END;
            
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_PRECISION_QUEUE_STEP_PRECISION_ATTRIBUTE_MEMBER_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_PRECISION_QUEUE_STEP_PRECISION_ATTRIBUTE_MEMBER_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;

        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_PRECISION_QUEUE_STEP_PRECISION_QUEUE_MEMBER_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN          
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_PRECISION_QUEUE_STEP_PRECISION_QUEUE_MEMBER_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;
            END;
        END;
            
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_PRECISION_QUEUE_STEP_PRECISION_QUEUE_MEMBER_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_PRECISION_QUEUE_STEP_PRECISION_QUEUE_MEMBER_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;

        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_QUERY_RULE_CAMPAIGN_MEMBER_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN          
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_QUERY_RULE_CAMPAIGN_MEMBER_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;
            END;
        END;
            
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_QUERY_RULE_CAMPAIGN_MEMBER_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_QUERY_RULE_CAMPAIGN_MEMBER_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;

        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_QUERY_RULE_IMPORT_RULE_MEMBER_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN          
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_QUERY_RULE_IMPORT_RULE_MEMBER_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;
            END;
        END;
            
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_QUERY_RULE_IMPORT_RULE_MEMBER_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_QUERY_RULE_IMPORT_RULE_MEMBER_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;

        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_ROUTE_ENTERPRISE_ROUTE_MEMBER_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN          
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_ROUTE_ENTERPRISE_ROUTE_MEMBER_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;
            END;
        END;
            
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_ROUTE_ENTERPRISE_ROUTE_MEMBER_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_ROUTE_ENTERPRISE_ROUTE_MEMBER_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;

        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_ROUTE_PARTITION_CALLING_SEARCH_SPACE_MEMBER_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN          
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_ROUTE_PARTITION_CALLING_SEARCH_SPACE_MEMBER_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;
            END;
        END;
            
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_ROUTE_PARTITION_CALLING_SEARCH_SPACE_MEMBER_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_ROUTE_PARTITION_CALLING_SEARCH_SPACE_MEMBER_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;

        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_ROUTE_SKILLGROUP_MEMBER_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN          
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_ROUTE_SKILLGROUP_MEMBER_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;
            END;
        END;
            
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_ROUTE_SKILLGROUP_MEMBER_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_ROUTE_SKILLGROUP_MEMBER_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;

        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_ROUTING_CLIENT_PERIPHERAL_MEMBER_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN          
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_ROUTING_CLIENT_PERIPHERAL_MEMBER_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;
            END;
        END;
            
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_ROUTING_CLIENT_PERIPHERAL_MEMBER_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_ROUTING_CLIENT_PERIPHERAL_MEMBER_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;

        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_SCRIPT_ROUTING_SCRIPT_MEMBER_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN          
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_SCRIPT_ROUTING_SCRIPT_MEMBER_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;
            END;
        END;
            
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_SCRIPT_ROUTING_SCRIPT_MEMBER_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_SCRIPT_ROUTING_SCRIPT_MEMBER_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;

        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_SERVICE_ENTERPRISE_SERVICE_MEMBER_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN          
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_SERVICE_ENTERPRISE_SERVICE_MEMBER_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;
            END;
        END;
            
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_SERVICE_ENTERPRISE_SERVICE_MEMBER_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_SERVICE_ENTERPRISE_SERVICE_MEMBER_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;

        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_SERVICE_MEDIA_ROUTING_DOMAIN_MEMBER_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN          
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_SERVICE_MEDIA_ROUTING_DOMAIN_MEMBER_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;
            END;
        END;
            
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_SERVICE_MEDIA_ROUTING_DOMAIN_MEMBER_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_SERVICE_MEDIA_ROUTING_DOMAIN_MEMBER_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;

        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_SERVICE_PERIPHERAL_MEMBER_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN          
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_SERVICE_PERIPHERAL_MEMBER_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;
            END;
        END;
            
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_SERVICE_PERIPHERAL_MEMBER_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_SERVICE_PERIPHERAL_MEMBER_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;

        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_SKILLGROUP_CAMPAIGN_MEMBER_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN          
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_SKILLGROUP_CAMPAIGN_MEMBER_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;
            END;
        END;
            
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_SKILLGROUP_CAMPAIGN_MEMBER_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_SKILLGROUP_CAMPAIGN_MEMBER_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;

        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_SKILLGROUP_ENTERPRISE_SKILLGROUP_MEMBER_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN          
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_SKILLGROUP_ENTERPRISE_SKILLGROUP_MEMBER_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;
            END;
        END;
            
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_SKILLGROUP_ENTERPRISE_SKILLGROUP_MEMBER_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_SKILLGROUP_ENTERPRISE_SKILLGROUP_MEMBER_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;

        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_SKILLGROUP_MEDIA_ROUTING_DOMAIN_MEMBER_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN          
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_SKILLGROUP_MEDIA_ROUTING_DOMAIN_MEMBER_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;
            END;
        END;
            
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_SKILLGROUP_MEDIA_ROUTING_DOMAIN_MEMBER_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_SKILLGROUP_MEDIA_ROUTING_DOMAIN_MEMBER_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;

        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_SKILLGROUP_PERIPHERAL_MEMBER_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN          
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_SKILLGROUP_PERIPHERAL_MEMBER_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;
            END;
        END;
            
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_SKILLGROUP_PERIPHERAL_MEMBER_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_SKILLGROUP_PERIPHERAL_MEMBER_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;

        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_SKILLGROUP_SERVICE_MEMBER_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN          
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_SKILLGROUP_SERVICE_MEMBER_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;
            END;
        END;
            
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_SKILLGROUP_SERVICE_MEMBER_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_SKILLGROUP_SERVICE_MEMBER_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;

        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_TRUNK_GROUP_NETWORK_TRUNK_GROUP_MEMBER_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN          
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_TRUNK_GROUP_NETWORK_TRUNK_GROUP_MEMBER_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;
            END;
        END;
            
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_TRUNK_GROUP_NETWORK_TRUNK_GROUP_MEMBER_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_TRUNK_GROUP_NETWORK_TRUNK_GROUP_MEMBER_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;

        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_TRUNK_TRUNK_GROUP_MEMBER_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN          
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_TRUNK_TRUNK_GROUP_MEMBER_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;
            END;
        END;
            
        IF EXISTS(SELECT 1 FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID = OBJECT_ID('TS_DIM_TRUNK_TRUNK_GROUP_MEMBER_PKEY_MAP_GC') AND DATEADD(second, -@QuietPeriodBeforePurgeSeconds, GETUTCDATE()) > last_user_update)
        BEGIN 
            SET @RowCount = 1;
            WHILE @RowCount > 0
            BEGIN 
                DELETE TOP (@DeletionChunkSize) FROM [dbo].[TS_DIM_TRUNK_TRUNK_GROUP_MEMBER_PKEY_MAP_GC] WHERE LAST_OPERATION = 'D';
                
                SELECT @RowCount = @@ROWCOUNT;          
            END;
        END;

        
    END TRY
    BEGIN CATCH;
        DECLARE @ErrorMessage VARCHAR(2000) = '['+OBJECT_NAME(@@PROCID)+']'+ISNULL(':'+ERROR_MESSAGE(),'');
        IF @InitialTransactionCount = 0 AND @@TRANCOUNT > 0
        BEGIN 
            ROLLBACK TRANSACTION;
        END;
        ELSE IF @InitialTransactionCount <> 0 AND @@TRANCOUNT > @InitialTransactionCount
        BEGIN 
            IF (XACT_STATE()) = -1
            BEGIN 
                SET @ErrorMessage = @ErrorMessage +' [Uncommittable Transaction!]';
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
        RAISERROR(@ErrorMessage, 16, 1) WITH LOG;  
        --EXEC [dbo].[ap_adm_raise_error];
    END CATCH;
    
    EXIT_SPROC:    
        RETURN @ReturnCode;
GO
GRANT EXECUTE
	ON [dbo].[ap_adm_purge_old_data_generation_counts]
	TO [portalapp_role]
GO
