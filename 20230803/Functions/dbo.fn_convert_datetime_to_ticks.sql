SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION dbo.fn_convert_datetime_to_ticks ( @DateTime DATETIME )
RETURNS BIGINT
AS
    BEGIN 
        IF @DateTime < 0
            RETURN NULL;

        DECLARE @DateToTicks BIGINT;
        DECLARE @TimeToTicks BIGINT;
        DECLARE @Year INT ,
            @Month INT ,
            @Day INT ,
            @Hour INT ,
            @Minute INT ,
            @Seconds INT ,
            @MonthToDays INT;
    
        SET @Year = DATEPART(yyyy, @DateTime);
        SET @Month = DATEPART(mm, @DateTime);
        SET @Day = DATEPART(dd, @DateTime);
        SET @Hour = DATEPART(hh, @DateTime);
        SET @Minute = DATEPART(mi, @DateTime);
        SET @Seconds = DATEPART(ss, @DateTime);
    
    -- convert the given month (0-12) to the corresponding number of days into the year (by end of month)
        IF ( @Year % 4 = 0 )
            AND ( ( @Year % 100 != 0 )
                  OR ( ( @Year % 100 = 0 )
                       AND ( @Year % 400 = 0 )
                     )
                )
            BEGIN 
         -- If leap year
                SET @MonthToDays = CASE ( @Month - 1 ) -- do not remove -1
                                     WHEN 0 THEN 0
                                     WHEN 1 THEN 31
                                     WHEN 2 THEN 60
                                     WHEN 3 THEN 91
                                     WHEN 4 THEN 121
                                     WHEN 5 THEN 152
                                     WHEN 6 THEN 182
                                     WHEN 7 THEN 213
                                     WHEN 8 THEN 244
                                     WHEN 9 THEN 274
                                     WHEN 10 THEN 305
                                     WHEN 11 THEN 335
                                     WHEN 12 THEN 366
                                     ELSE 0
                                   END;
            END;
        ELSE
            BEGIN 
        -- If not leap year
                SET @MonthToDays = CASE ( @Month - 1 ) -- do not remove -1
                                     WHEN 0 THEN 0
                                     WHEN 1 THEN 31
                                     WHEN 2 THEN 59
                                     WHEN 3 THEN 90
                                     WHEN 4 THEN 120
                                     WHEN 5 THEN 151
                                     WHEN 6 THEN 181
                                     WHEN 7 THEN 212
                                     WHEN 8 THEN 243
                                     WHEN 9 THEN 273
                                     WHEN 10 THEN 304
                                     WHEN 11 THEN 334
                                     WHEN 12 THEN 365
                                     ELSE 0
                                   END;
            END;

    
        SET @DateToTicks = CONVERT(BIGINT, ( ( ( ( ( ( ( @Year
                                            - 1 ) * 365 )
                                            + ( ( @Year - 1 )
                                            / 4 ) )
                                            - ( ( @Year - 1 )
                                            / 100 ) )
                                            + ( ( @Year - 1 )
                                            / 400 ) )
                                            + @MonthToDays )
                                            + @Day ) - 1)
            * 864000000000;
        SET @TimeToTicks = ( ( ( @Hour * 3600 )
                               + CONVERT(BIGINT, @Minute)
                               * 60 )
                             + CONVERT(BIGINT, @Seconds) )
            * 10000000;
    
        RETURN @DateToTicks + @TimeToTicks + (CONVERT(BIGINT, DATEPART(ms, @DateTime)) * CONVERT(BIGINT,10000));

    END;
GO
