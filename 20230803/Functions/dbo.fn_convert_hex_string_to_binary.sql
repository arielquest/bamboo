SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION dbo.fn_convert_hex_string_to_binary
    (
      @HexString NVARCHAR(MAX)
    )
RETURNS VARBINARY(MAX)
AS
    BEGIN 
        IF @HexString IS NULL
            RETURN NULL;

        DECLARE @binaryResult VARBINARY(MAX);
    
        SELECT  @binaryResult = CAST('' AS XML).value('xs:hexBinary( substring(sql:variable("@HexString"), sql:column("t.pos")) )',
                                            'varbinary(max)')
        FROM    ( SELECT    CASE SUBSTRING(@HexString, 1, 2)
                              WHEN '0x' THEN 3
                              ELSE 0
                            END
                ) AS t ( pos );
        RETURN @binaryResult;
    END
GO
