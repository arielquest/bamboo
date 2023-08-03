SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE   FUNCTION [dbo].[fn_adm_string_split]
    (
      -- FUNCTION IS OPTIMISED FOR 8000 CHARACTERS, DO NOT CHANGE THIS
      -- UNLESS YOU KNOW WHAT YOU'RE DOING!!
      -- IF YOU NEED MORE, USE THE MS FUNCTION "STRING_SPLIT" - NOTE: IT 
      -- WON'T HAVE ORDINAL POSITION OF THE SPLIT PARTS
      @DataString VARCHAR(8000),
      @Delimeter CHAR(1)
      -- USAGE
      -- SELECT test.SomeID, test.SomeValue, Item = split.Item
      -- FROM [aTable] test
      -- CROSS APPLY dbo.fn_adm_string_split(test.SomeValue,',') split
    )
RETURNS TABLE
    WITH SCHEMABINDING
AS
 RETURN
    WITH    [1stOrderOfMagnitude] ( [N] )
              AS ( SELECT   1
                   FROM     ( VALUES ( 1), ( 1), ( 1), ( 1), ( 1), ( 1), ( 1), ( 1), ( 1), ( 1) ) [a] ( [N] )
                 ),
            [2ndOrderOfMagnitude] ( [N] )
              AS ( SELECT   1
                   FROM     [1stOrderOfMagnitude] [a]
                   CROSS JOIN [1stOrderOfMagnitude] [b]
                 ),
            [4thOrderOfMagnitude] ( [N] )
              AS ( SELECT   1
                   FROM     [2ndOrderOfMagnitude] [a]
                   CROSS JOIN [2ndOrderOfMagnitude] [b]
                 ),
            [cteTally] ( [N] )
              AS ( SELECT   0
                   UNION ALL
                   SELECT TOP ( DATALENGTH(ISNULL(@DataString, 1)) )
                            ROW_NUMBER() OVER ( ORDER BY ( SELECT   NULL
                                                         ) )
                   FROM     [4thOrderOfMagnitude]
                 ),
            [cteStart] ( [StartPositionOfString] )
              AS ( SELECT   [t].[N] + 1
                   FROM     [cteTally] [t]
                   WHERE    ( SUBSTRING(@DataString, [t].[N], 1) = @Delimeter
                              OR [t].[N] = 0
                            )
                 )
    SELECT  [ItemNumber] = ROW_NUMBER() OVER ( ORDER BY [s].[StartPositionOfString] ),
            [Item] = SUBSTRING(@DataString, [s].[StartPositionOfString],
                               ISNULL(NULLIF(LEAD([s].[StartPositionOfString], 1, 1) OVER ( ORDER BY [s].[StartPositionOfString] ) - 1, 0)
                                      - [s].[StartPositionOfString], 8000))
    FROM    [cteStart] [s];
GO
GRANT SELECT
	ON [dbo].[fn_adm_string_split]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[fn_adm_string_split]
	TO [portalrs_role]
GO
GRANT SELECT
	ON [dbo].[fn_adm_string_split]
	TO [portalreporting_role]
GO
GRANT SELECT
	ON [dbo].[fn_adm_string_split]
	TO [portal_default_mediator_role]
GO
