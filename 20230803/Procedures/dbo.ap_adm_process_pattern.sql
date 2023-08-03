SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE dbo.ap_adm_process_pattern (@I_CurrentMax AS NVARCHAR(50), @I_Pattern AS NVARCHAR(50), @I_LineRangeStart AS NVARCHAR(50), @O_NewLineNumber AS NVARCHAR(50) = NULL OUTPUT) AS
DECLARE @v_Char AS NCHAR(1), @v_Index AS INT, @v_NumberRangeEnd AS NVARCHAR(50);

SET @v_Index = 1;
SET @v_NumberRangeEnd = @I_LineRangeStart;

WHILE @v_Index <= LEN(@I_Pattern)
BEGIN 
    -- Get next character from pattern
    SET @v_Char = SUBSTRING(@I_Pattern, @v_Index, 1);
    SET @v_Index = @v_Index + 1;

    IF @v_Char = 'X'
    BEGIN 
        SET @I_LineRangeStart = @I_LineRangeStart + '0';
        SET @v_NumberRangeEnd = @v_NumberRangeEnd + '9';
    END;
    ELSE BEGIN 
        SET @I_LineRangeStart = @I_LineRangeStart + @v_Char;
        SET @v_NumberRangeEnd = @v_NumberRangeEnd + @v_Char;
    END;
END;

--    PRINT 'Range Start: ' + @I_LineRangeStart
--    PRINT 'Range End:   ' + @v_NumberRangeEnd
IF @I_CurrentMax IS NULL
    OR @I_CurrentMax = ''
BEGIN 
    SET @O_NewLineNumber = @I_LineRangeStart;
END;
ELSE BEGIN 
    IF @I_CurrentMax + 1 BETWEEN @I_LineRangeStart
            AND @v_NumberRangeEnd
    BEGIN 
        SET @O_NewLineNumber = @I_CurrentMax + 1;
    END;
    ELSE BEGIN 
        SET @O_NewLineNumber = '';
    END;
END;
--        PRINT 'LN: ' + COALESCE(@O_NewLineNumber, '')   
RETURN 0;
GO
GRANT EXECUTE
	ON [dbo].[ap_adm_process_pattern]
	TO [portalapp_role]
GO
