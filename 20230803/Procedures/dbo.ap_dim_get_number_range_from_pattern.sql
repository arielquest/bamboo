SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------
-- ALTER PROC A AS EXEC ap_dim_get_number_range_from_pattern '[23,4]XXXXX', 1
-- EXEC ap_dim_get_number_range_from_pattern '23XXX', 1
-------------------------------------------------------------------------------
CREATE PROC [dbo].[ap_dim_get_number_range_from_pattern]
    (
      @I_Pattern AS NVARCHAR(50),
      @O_NumberRangeStart AS BIGINT = NULL OUTPUT,
      @O_NumberRangeEnd AS BIGINT = NULL OUTPUT     
    )
AS
    SET NOCOUNT ON;
    SET ANSI_WARNINGS OFF;
   
    SET @O_NumberRangeStart = NULL;
    SET @O_NumberRangeEnd = NULL;
    
    /******************************************************************************\
    --=====Description=====--
    Patterns 
    [2,4,5]XXXX ==> 20000 - 59999
    [4,1,9]XXXX ==> 10000 - 99999
    [45]XXXX    ==> 45000 - 45999
    [45,2]XXXX  ==> 20000 - 45999
    \******************************************************************************/

    SELECT  @O_NumberRangeStart = [a].[Start],
            @O_NumberRangeEnd = [a].[End]
    FROM    ( SELECT    [a].[I_Pattern],
                        MIN(TRY_CAST(CAST(TRY_CAST(TRY_CAST([Item] AS BIGINT) AS BIGINT) AS VARCHAR(20)) + REPLICATE('0',
                                                                                                                     LEN([a].[I_Pattern])
                                                                                                                     - LEN(REPLACE([a].[I_Pattern], 'X', ''))
                                                                                                                     - ( LEN(TRY_CAST([Item] AS BIGINT)) - 1 )) AS BIGINT)),
                        MAX(TRY_CAST(CAST(TRY_CAST([Item] AS BIGINT) AS VARCHAR(20)) + REPLICATE('9',
                                                                                                 LEN([a].[I_Pattern]) - LEN(REPLACE([a].[I_Pattern], 'X', ''))
                                                                                                 - ( LEN(TRY_CAST([Item] AS BIGINT)) - 1 )) AS BIGINT))
              FROM      ( VALUES ( @I_Pattern ) ) [a] ( [I_Pattern] )
                        CROSS APPLY [dbo].[fn_adm_string_split](CASE WHEN CHARINDEX('[', [a].[I_Pattern], 1) > 0
                                                                          AND CHARINDEX(']', [a].[I_Pattern], 1) > 0
                                                                     THEN SUBSTRING([a].[I_Pattern], CHARINDEX('[', [a].[I_Pattern], 1) + 1,
                                                                                    CHARINDEX(']', [a].[I_Pattern], 1) - 2)
                                                                     ELSE [a].[I_Pattern]
                                                                END, ',')
              GROUP BY  [a].[I_Pattern]
            ) [a] ( [Pattern], [Start], [End] );
GO
GRANT EXECUTE
	ON [dbo].[ap_dim_get_number_range_from_pattern]
	TO [portalapp_role]
GO
