SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_dim01_soft_purge_dimension_pkey]
    (
      @PkeyMapsUrns [dbo].[IntegerTableType] READONLY,
      @ItemTypeUrn [INTEGER]
    )
AS
    SET NOCOUNT ON;

    DECLARE @v_Items TABLE
        (
          [ITEM_URN] INT NOT NULL,
          [ITEM_BIZ_URN] INT NOT NULL,
          [PKEY_MAP_URN] INT NOT NULL,
          [CLUSTER_RESOURCE_ID] UNIQUEIDENTIFIER NOT NULL,
          [TOTAL_PKEYS_NOT_TO_DELETE] INT NOT NULL
        );

    DECLARE @v_MemberPkeyMapTable TABLE
        (
          [MEMBER_URN] INT NOT NULL,
          [PKEY_MAP_URN] INT NOT NULL,
          [MEMBER_TYPE_ID] UNIQUEIDENTIFIER NOT NULL,
          [TOTAL_PKEY] INT NOT NULL
        );

    DECLARE @v_TypeTableName AS NVARCHAR(255);
                
    SELECT  @v_TypeTableName = [TABLE_NAME]
    FROM    [dbo].[TE_DIM_ITEM_TYPE]
    WHERE   [ITEM_TYPE_URN] = @ItemTypeUrn;

    INSERT  INTO @v_Items
            ( [ITEM_URN],
              [ITEM_BIZ_URN],
              [PKEY_MAP_URN],
              [CLUSTER_RESOURCE_ID],
              [TOTAL_PKEYS_NOT_TO_DELETE]
            )
    SELECT  [toDeleteItems].[ITEM_URN],
            [toDeleteItems].[ITEM_BIZ_URN],
            [toDeleteItems].[PKEY_MAP_URN],
            [toDeleteItems].[CLUSTER_RESOURCE_ID],
            COALESCE([notToDeletePkeyMaps].[TOTAL_PKEYS_NOT_TO_DELETE], 0) AS [TOTAL_PKEYS_NOT_TO_DELETE]
    FROM    ( SELECT    [ITEM_URN],
                        [ITEM_BIZ_URN],
                        [PKEY_MAP_URN],
                        [CLUSTER_RESOURCE_ID]
              FROM      [dbo].[VW_DIM_ITEM_PKEY]
              WHERE     [PKEY_MAP_URN] IN ( SELECT  [INTEGER_1]
                                            FROM    @PkeyMapsUrns )
                        AND [ITEM_TYPE_URN] = @ItemTypeUrn
            ) AS [toDeleteItems]
    LEFT OUTER JOIN ( SELECT    [ITEM_BIZ_URN],
                                COUNT(*) AS [TOTAL_PKEYS_NOT_TO_DELETE]
                      FROM      [dbo].[VW_DIM_ITEM_PKEY_MAP]
                      WHERE     [PKEY_MAP_URN] NOT IN ( SELECT  [INTEGER_1]
                                                        FROM    @PkeyMapsUrns )
                                AND [ITEM_TYPE_URN] = @ItemTypeUrn
                                AND [STATUS] <> 'D'
                      GROUP BY  [ITEM_BIZ_URN]
                    ) AS [notToDeletePkeyMaps] ON [notToDeletePkeyMaps].[ITEM_BIZ_URN] = [toDeleteItems].[ITEM_BIZ_URN]
    OPTION  ( RECOMPILE );
    
    INSERT  INTO @v_MemberPkeyMapTable
            ( [MEMBER_URN],
              [PKEY_MAP_URN],
              [MEMBER_TYPE_ID],
              [TOTAL_PKEY]
            )
    SELECT  [pkeyMain].[MEMBER_URN],
            [pkeyMain].[PKEY_MAP_URN],
            [pkeyMain].[MEMBER_TYPE_ID],
            COALESCE([multi].[TOTAL_PKEY], 1) AS [TOTAL_PKEY]
    FROM    ( SELECT    [memPkey].[MEMBER_URN],
                        [memPkey].[MEMBER_BIZ_URN],
                        [memPkey].[MEMBER_TYPE_ID],
                        [memPkey].[PKEY_MAP_URN],
                        [memPkey].[CLUSTER_RESOURCE_ID],
                        [p].[ITEM_URN]
              FROM      [dbo].[VW_DIM_MEMBER_PKEY] [memPkey]
              INNER JOIN @v_Items [p] ON ( [p].[ITEM_BIZ_URN] = [memPkey].[PARENT_ITEM_BIZ_URN]
                                           AND [memPkey].[PARENT_ITEM_TYPE_URN] = @ItemTypeUrn
                                         )
                                         OR ( [p].[ITEM_BIZ_URN] = [memPkey].[CHILD_ITEM_BIZ_URN]
                                              AND [memPkey].[CHILD_ITEM_TYPE_URN] = @ItemTypeUrn
                                            )
              WHERE     [memPkey].[STATUS] <> 'D'
            ) AS [pkeyMain]
    INNER JOIN @v_Items AS [i2] ON [i2].[ITEM_URN] = [pkeyMain].[ITEM_URN]
                                   AND [i2].[CLUSTER_RESOURCE_ID] = [pkeyMain].[CLUSTER_RESOURCE_ID]
    LEFT OUTER JOIN ( SELECT    [MEMBER_BIZ_URN],
                                [MEMBER_TYPE_ID],
                                COUNT(*) AS [TOTAL_PKEY]
                      FROM      [dbo].[VW_DIM_MEMBER_PKEY_MAP]
                      WHERE     [STATUS] <> 'D'
                      GROUP BY  [MEMBER_BIZ_URN],
                                [MEMBER_TYPE_ID]
                      HAVING    COUNT(*) > 1
                    ) AS [multi] ON [multi].[MEMBER_BIZ_URN] = [pkeyMain].[MEMBER_BIZ_URN]
                                    AND [multi].[MEMBER_TYPE_ID] = [pkeyMain].[MEMBER_TYPE_ID]
    OPTION  ( RECOMPILE );
    
    SET QUOTED_IDENTIFIER ON;
    
    DECLARE @SQL NVARCHAR(MAX);

    -- Set associated members deleted
    SELECT  @SQL = ( SELECT [a].[sqlCode]
                     FROM   ( SELECT    'UPDATE dbo.' + [mt].[TABLE_NAME] + '_PKEY_MAP 
                                SET EFFECTIVE_TO = GETUTCDATE(), STATUS = ''D'', PURGED = 1
                                WHERE PKEY_MAP_URN = ' + CAST([t].[PKEY_MAP_URN] AS VARCHAR(10)) + ';' + CHAR(13) + CHAR(10)
                              FROM      @v_MemberPkeyMapTable [t]
                              JOIN      [dbo].[TE_DIM_MEMBER_TYPE] [mt] ON [t].[MEMBER_TYPE_ID] = [mt].[MEMBER_TYPE_ID]
                            FOR
                              XML PATH(''),
                                  TYPE
                            ) [a] ( [sqlCode] )
                     ).[value]('.', 'NVARCHAR(MAX)');
                
    EXECUTE [sys].[sp_executesql] @SQL;

    SELECT  @SQL = ( SELECT [a].[sqlCode]
                     FROM   ( SELECT    'UPDATE dbo.' + [mt].[TABLE_NAME] + '
                                SET DELETED = 1, EFFECTIVE_TO = GETUTCDATE()
                                WHERE MEMBER_URN = ' + CAST([t].[MEMBER_URN] AS VARCHAR(10)) + ';' + CHAR(13) + CHAR(10)
                              FROM      @v_MemberPkeyMapTable [t]
                              JOIN      [dbo].[TE_DIM_MEMBER_TYPE] [mt] ON [t].[MEMBER_TYPE_ID] = [mt].[MEMBER_TYPE_ID]
                              WHERE     [t].[TOTAL_PKEY] = 1
                            FOR
                              XML PATH(''),
                                  TYPE
                            ) [a] ( [sqlCode] )
                     ).[value]('.', 'NVARCHAR(MAX)');
                     
    EXECUTE [sys].[sp_executesql] @SQL;
    
    -- Set item deleted only if there is only one pkey associated with it
    SELECT  @SQL = ( SELECT [a].[sqlCode]
                     FROM   ( SELECT DISTINCT
                                        'UPDATE dbo.' + @v_TypeTableName + '
                                SET DELETED = 1, EFFECTIVE_TO = GETUTCDATE()
                                WHERE ITEM_URN = ' + CAST([ITEM_URN] AS VARCHAR(10)) + ';' + CHAR(13) + CHAR(10)
                              FROM      @v_Items
                              WHERE     [TOTAL_PKEYS_NOT_TO_DELETE] = 0
                            FOR
                              XML PATH(''),
                                  TYPE
                            ) [a] ( [sqlCode] )
                     ).[value]('.', 'NVARCHAR(MAX)');
                
    EXECUTE [sys].[sp_executesql] @SQL;
        
        
    SELECT  @SQL = ( SELECT [a].[sqlCode]
                     FROM   ( SELECT    'UPDATE dbo.' + @v_TypeTableName + '_PKEY_MAP
                                SET EFFECTIVE_TO = GETUTCDATE(), STATUS = ''D'', PURGED = 1
                                WHERE PKEY_MAP_URN = ' + CAST([PKEY_MAP_URN] AS VARCHAR(10)) + ';' + CHAR(13) + CHAR(10)
                              FROM      @v_Items
                            FOR
                              XML PATH(''),
                                  TYPE
                            ) [a] ( [sqlCode] )
                     ).[value]('.', 'NVARCHAR(MAX)');
                    
    EXECUTE [sys].[sp_executesql] @SQL;
    
    
    SET QUOTED_IDENTIFIER OFF;
GO
GRANT EXECUTE
	ON [dbo].[ap_dim01_soft_purge_dimension_pkey]
	TO [portalapp_role]
GO
