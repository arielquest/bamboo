SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION dbo.fn_convert_ticks_to_datetime ( @Ticks BIGINT )
RETURNS DATETIME
AS
    BEGIN 
        IF @Ticks < 0
            RETURN NULL;

        DECLARE @Days BIGINT;
        DECLARE @DaysBefore1753 BIGINT;
        DECLARE @TimeTicks BIGINT;
        DECLARE @Seconds BIGINT;
        DECLARE @MilliTicks BIGINT;
        DECLARE @MilliSeconds BIGINT;
    
        SET @Days = @Ticks / CONVERT(BIGINT, 864000000000);
        SET @DaysBefore1753 = CONVERT(BIGINT, 639905);
        SET @TimeTicks = @Ticks
            % CONVERT(BIGINT, 864000000000);
        SET @Seconds = @TimeTicks / CONVERT(BIGINT, 10000000);
        SET @MilliTicks = @TimeTicks
            % CONVERT(BIGINT, 10000000);
        SET @MilliSeconds = @MilliTicks
            / CONVERT(BIGINT, 10000);
    
        RETURN DATEADD(ms, @MilliSeconds, DATEADD(s,@Seconds,DATEADD(d,@Days - @DaysBefore1753,CONVERT(DATETIME,'1/1/1753'))));
    END;
GO
