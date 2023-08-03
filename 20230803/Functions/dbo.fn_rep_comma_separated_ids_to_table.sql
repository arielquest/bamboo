SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION fn_rep_comma_separated_ids_to_table ( @list NVARCHAR(MAX) )
RETURNS @tbl TABLE ( number INT NOT NULL )
AS
    BEGIN 
        DECLARE @pos INT ,
            @nextpos INT ,
            @valuelen INT;

        SELECT  @pos = 0 ,
                @nextpos = 1;

        WHILE @nextpos > 0
            BEGIN 
                SELECT  @nextpos = CHARINDEX(',', @list,
                                            @pos + 1);
                SELECT  @valuelen = CASE WHEN @nextpos > 0
                                         THEN @nextpos
                                         ELSE LEN(@list) + 1
                                    END - @pos - 1;
                INSERT  @tbl
                        ( number
                        )
                VALUES  ( CONVERT(INT, SUBSTRING(@list,
                                            @pos + 1,
                                            @valuelen))
                        );
                SELECT  @pos = @nextpos;
            END;
        RETURN;
    END;
GO
