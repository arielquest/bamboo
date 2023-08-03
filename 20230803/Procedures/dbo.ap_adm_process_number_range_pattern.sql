SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE dbo.ap_adm_process_number_range_pattern (@I_CurrentMax AS NVARCHAR(50), @I_Pattern AS NVARCHAR(50), @O_NewLineNumber AS NVARCHAR(50) = NULL OUTPUT) AS

DECLARE @v_Character AS NCHAR(1), @v_Index AS INT, @v_RangeEnd AS INT, @v_NumberRangeStart AS NVARCHAR(50), @v_PatternSlice AS NVARCHAR(50);

SET @v_Index = 1;
-- If a range pattern has been supplied then it must be the first character
SET @v_Character = SUBSTRING(@I_Pattern, @v_Index, 1);

IF @v_Character <> '['
BEGIN 
    EXEC dbo.ap_adm_process_pattern @I_CurrentMax, @I_Pattern, '', @O_NewLineNumber OUTPUT;
END;
ELSE BEGIN 
    -- XX Perform sanity checks against pattern.
    SET @v_RangeEnd = CHARINDEX(']', @I_Pattern, @v_Index + 1);
    SET @v_PatternSlice = RIGHT(@I_Pattern, LEN(@I_Pattern) - @v_RangeEnd);
    SET @v_NumberRangeStart = '';
    SET @v_Index = 2;

    -- FOR EACH Range Slice call sproc with range slice + pattern slice
    WHILE @v_Index <= @v_RangeEnd
        AND @O_NewLineNumber IS NULL
    BEGIN 
        SET @v_Character = SUBSTRING(@I_Pattern, @v_Index, 1);
        SET @v_Index = @v_Index + 1;

        -- If at the end of the current range or range slice 
        IF @v_Character = ']'
            OR @v_Character = ','
        BEGIN 
            EXEC dbo.ap_adm_process_pattern @I_CurrentMax, @v_PatternSlice, @v_NumberRangeStart, @O_NewLineNumber OUTPUT;

            SET @v_NumberRangeStart = '';
        END;
        ELSE BEGIN 
            SET @v_NumberRangeStart = @v_NumberRangeStart + @v_Character;
        END;
    END;
END;
GO
GRANT EXECUTE
	ON [dbo].[ap_adm_process_number_range_pattern]
	TO [portalapp_role]
GO
