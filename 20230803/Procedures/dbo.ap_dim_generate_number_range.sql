SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------
-- Takes the supplied number mask and returns the associated number range:
-- e.g. 4XXX will return 4000 to 4999
-- DECLARE @NumberMask AS NVARCHAR(50) = '4XXX', @NumberRangeStart AS INTEGER, @NumberRangeEnd AS INTEGER;
-- EXECUTE [ap_dim_generate_number_range] @I_NumberMask = @NumberMask, @O_NumberRangeStart = @NumberRangeStart OUTPUT, @O_NumberRangeEnd = @NumberRangeEnd OUTPUT;
-- SELECT  @NumberRangeStart, @NumberRangeEnd;
-------------------------------------------------------------------------------
CREATE PROCEDURE [dbo].[ap_dim_generate_number_range]
    (
      @I_NumberMask AS NVARCHAR(50),
      @O_NumberRangeStart AS INTEGER OUTPUT,
      @O_NumberRangeEnd AS INTEGER OUTPUT
    )
AS
    BEGIN 
        SET NOCOUNT ON;

        DECLARE @O_NumberRangeStart_vc VARCHAR(50),
            @O_NumberRangeEnd_vc VARCHAR(50);

        SET @I_NumberMask = LTRIM(RTRIM(@I_NumberMask));

        SELECT  @O_NumberRangeStart_vc = ISNULL(@O_NumberRangeStart_vc, '')
                + CASE WHEN SUBSTRING(@I_NumberMask, [t].[N], 1) LIKE '[0-9]' THEN SUBSTRING(@I_NumberMask, [t].[N], 1)
                       ELSE '0'
                  END,
                @O_NumberRangeEnd_vc = ISNULL(@O_NumberRangeEnd_vc, '') + CASE WHEN SUBSTRING(@I_NumberMask, [t].[N], 1) LIKE '[0-9]'
                                                                               THEN SUBSTRING(@I_NumberMask, [t].[N], 1)
                                                                               ELSE '9'
                                                                          END
        FROM    [dbo].[fn_adm_numbers](0, LEN(@I_NumberMask)) [t]
        ORDER BY [t].[N];

        SET @O_NumberRangeStart = CAST(@O_NumberRangeStart_vc AS INTEGER);
        SET @O_NumberRangeEnd = CAST(@O_NumberRangeEnd_vc AS INTEGER);

        RETURN 0;
    END;
GO
GRANT EXECUTE
	ON [dbo].[ap_dim_generate_number_range]
	TO [portalapp_role]
GO
