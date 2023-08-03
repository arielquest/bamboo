SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
------------------------------------------------------------------------------- 
-- Gets the last operations for the specified olap dimension since it was last processed
------------------------------------------------------------------------------- 
CREATE PROCEDURE [dbo].[ap_imp01_olap_get_dimension_last_operations]
    (
      @OlapDimensionName AS NVARCHAR(100),
      @ClusterResourceInstanceId AS UNIQUEIDENTIFIER
    )
AS
    BEGIN 
        SET NOCOUNT ON;

        DECLARE @OlapObjectUrn INT,
            @ErrorMessage NVARCHAR(4000),
            @ErrorSeverity INT,
            @ErrorState INT;

        BEGIN TRY;
            -- Get the Olap Object Urn and Cluster Map Urn
            SELECT  @OlapObjectUrn = [oo].[OLAP_OBJECT_URN]
            FROM    [dbo].[TB_ADM_OLAP_OBJECT_CLUSTER_MAP] [ocm]
            INNER JOIN [dbo].[TB_ADM_OLAP_OBJECT] [oo] ON [oo].[OLAP_OBJECT_URN] = [ocm].[OLAP_OBJECT_URN]
            WHERE   UPPER([oo].[OLAP_OBJECT_NAME]) = UPPER(@OlapDimensionName)
                    AND [ocm].[OLAP_CLUSTER_RESOURCE_ID] = @ClusterResourceInstanceId;

            -- Get the last operations for the tables involved since the olap object on this cluster was last processed
            DECLARE @Sql NVARCHAR(MAX);

            SET @Sql = 'SELECT DISTINCT' + CHAR(13) + CHAR(10) 
                     + '        [abc].[LAST_OPERATION]' + CHAR(13) + CHAR(10)
                     + 'FROM    [dbo].[VW_ADM_DATA_GENERATION_COUNT] [abc]' + CHAR(13) + CHAR(10)
                     + 'LEFT OUTER JOIN [dbo].[TS_IMP_OLAP_DIMENSION_STATE] [ods] ON [ods].[TABLE_GENERATION_COUNT_URN] = [abc].[TABLE_GENERATION_COUNT_URN]' + CHAR(13) + CHAR(10) 
                     +  '                                                             AND [ods].[OLAP_OBJECT_CLUSTER_MAP_URN] = 1' + CHAR(13) + CHAR(10) 
                     -- Using dynamic SQL to ensure that optimisation plan is sensible for query against VW_ADM_DATA_GENERATION_COUNT,
                     -- Joining with the result of this part of the predicate "properly" causes the execution analyzer to hit every 
                     -- underlying table in VW_ADM_DATA_GENERATION_COUNT.  By essentially hardcoding the CSV, as below, we short-cut
                     -- to just the specific underlying tables in VW_ADM_DATA_GENERATION_COUNT.
                     +  'WHERE   [abc].[TABLE_GENERATION_COUNT_URN] IN ( ' + 
                       -- Get the table generation counts mapped to the olap object
                       STUFF(( SELECT   ',' + CAST([tgc].[TABLE_GENERATION_COUNT_URN] AS NVARCHAR(MAX))
                               FROM     [dbo].[TB_ADM_OLAP_OBJECT_TABLE_MAP] [otm]
                               INNER JOIN [dbo].[VW_ADM_TABLE_GENERATION_COUNT] [tgc] ON [otm].[TABLE_NAME] = [tgc].[TABLE_NAME]
                               WHERE    [otm].[OLAP_OBJECT_URN] = @OlapObjectUrn
                             FOR
                               XML PATH('')
                             ), 1, 1, '') + ' )' + CHAR(13) + CHAR(10) 
                     + '        AND ( [abc].[GENERATION_COUNT] > [ods].[LAST_GENERATION_COUNT]' + CHAR(13) + CHAR(10) 
                     + '              OR [ods].[LAST_GENERATION_COUNT] IS NULL' + CHAR(13) + CHAR(10) 
                     + '            );';

            EXEC [sys].[sp_executesql] @Sql;

            RETURN 0;
        END TRY
        BEGIN CATCH;
            SELECT  @ErrorMessage = '[' + OBJECT_NAME(@@PROCID) + ']' + ISNULL(': ' + ERROR_MESSAGE(), ''),
                    @ErrorSeverity = ERROR_SEVERITY(),
                    @ErrorState = ERROR_STATE();
            RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
            RETURN - 1;
        END CATCH;
    END;
GO
GRANT EXECUTE
	ON [dbo].[ap_imp01_olap_get_dimension_last_operations]
	TO [portalapp_role]
GO
