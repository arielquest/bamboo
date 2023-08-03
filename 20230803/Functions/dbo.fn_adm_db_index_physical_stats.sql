SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_adm_db_index_physical_stats] 
    ( 
      @db_id INT, 
      @object_id INT, 
      @index_id INT, 
      @partition_number INT, 
      @mode NVARCHAR(20) 
-- This function is a workaround a limitation of dynamic management functions in SQL Server.
-- There has been a connect issue raised, but a fix has not been announced.  In the meantime, we
-- can use this as a wrapper: -
-- USAGE: e.g.
--SELECT  [indexes].[table_name], 
--        [indexes].[index_name], 
--        [dm_db_index_physical_stats].*
--FROM    ( SELECT    [indx].[index_id], 
--                    [indx].[name] AS [index_name], 
--                    [obj].[name] AS [table_name], 
--                    [obj].[object_id] AS [table_id] 
--          FROM      ( SELECT    [a].[Tables], 
--                                OBJECT_ID([a].[Tables]) AS [Table_ID] 
--                      FROM      ( VALUES ( 'dbo.TB_SEC_ROLE'), ( 'dbo.TB_SEC_POLICY_USER_ROLE'), ( 'dbo.TB_SEC_POLICY'), ( 'dbo.TB_SEC_USER'),
--                                ( 'dbo.TB_SEC_GROUP_MEMBER') ) [a] ( [Tables] ) 
--                    ) [vw_sec_user_roles] 
--          INNER JOIN [sys].[objects] [obj] ON [obj].[object_id] = [vw_sec_user_roles].[Table_ID] 
--          INNER JOIN [sys].[indexes] [indx] ON [indx].[object_id] = [obj].[object_id] 
--        ) [indexes] 
--CROSS APPLY [dbo].[fn_adm_db_index_physical_stats](DB_ID(), [indexes].[table_id], [indexes].[index_id], NULL, N'SAMPLED') [dm_db_index_physical_stats];
    ) 
RETURNS @results TABLE 
    ( 
      [database_id] [SMALLINT] NULL, 
      [object_id] [INT] NULL, 
      [index_id] [INT] NULL, 
      [partition_number] [INT] NULL, 
      [index_type_desc] [NVARCHAR](60) NULL, 
      [alloc_unit_type_desc] [NVARCHAR](60) NULL, 
      [index_depth] [TINYINT] NULL, 
      [index_level] [TINYINT] NULL, 
      [avg_fragmentation_in_percent] [FLOAT] NULL, 
      [fragment_count] [BIGINT] NULL, 
      [avg_fragment_size_in_pages] [FLOAT] NULL, 
      [page_count] [BIGINT] NULL, 
      [avg_page_space_used_in_percent] [FLOAT] NULL, 
      [record_count] [BIGINT] NULL, 
      [ghost_record_count] [BIGINT] NULL, 
      [version_ghost_record_count] [BIGINT] NULL, 
      [min_record_size_in_bytes] [INT] NULL, 
      [max_record_size_in_bytes] [INT] NULL, 
      [avg_record_size_in_bytes] [FLOAT] NULL, 
      [forwarded_record_count] [BIGINT] NULL 
    ) 
    BEGIN 
        INSERT  INTO @results 
        SELECT  [database_id], 
                [object_id], 
                [index_id], 
                [partition_number], 
                [index_type_desc], 
                [alloc_unit_type_desc], 
                [index_depth], 
                [index_level], 
                [avg_fragmentation_in_percent], 
                [fragment_count], 
                [avg_fragment_size_in_pages], 
                [page_count], 
                [avg_page_space_used_in_percent], 
                [record_count], 
                [ghost_record_count], 
                [version_ghost_record_count], 
                [min_record_size_in_bytes], 
                [max_record_size_in_bytes], 
                [avg_record_size_in_bytes], 
                [forwarded_record_count] 
        FROM    [sys].[dm_db_index_physical_stats](@db_id, @object_id, @index_id, @partition_number, @mode); 

        RETURN; 
    END;
GO
