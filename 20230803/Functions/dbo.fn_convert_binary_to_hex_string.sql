SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION dbo.fn_convert_binary_to_hex_string
    (
      @BinaryValue VARBINARY(MAX)
    )
RETURNS VARCHAR(MAX)
AS
    BEGIN 
        IF @BinaryValue IS NULL
            RETURN NULL;

        DECLARE @charValue VARCHAR(MAX) ,
            @i INT ,
            @length INT ,
            @hexString CHAR(16);

        SET @charValue = '0x';
        SET @i = 1;
        SET @length = DATALENGTH(@BinaryValue);
        SET @hexString = '0123456789abcdef';

        WHILE ( @i <= @length )
            BEGIN 
                DECLARE @tempInt INT ,
                    @firstInt INT ,
                    @secondInt INT;

                SET @tempInt = CONVERT(INT, SUBSTRING(@BinaryValue,
                                            @i, 1));
                SET @firstInt = FLOOR(@tempInt / 16);
                SET @secondInt = @tempInt - ( @firstInt * 16 );

                SET @charValue = @charValue
                    + SUBSTRING(@hexString, @firstInt + 1, 1)
                    + SUBSTRING(@hexString, @secondInt + 1,
                                1);
                SET @i = @i + 1;
            END;

        RETURN @charValue;
    END;
GO
