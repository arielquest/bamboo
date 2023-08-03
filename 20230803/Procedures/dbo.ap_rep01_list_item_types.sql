SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------
--
-------------------------------------------------------------------------------
CREATE PROCEDURE [dbo].[ap_rep01_list_item_types] AS
SET NOCOUNT ON;

DECLARE @error AS INT;

SET @error = 0;

SELECT '00000000-0000-0000-0000-000000000010' AS [ID_FIELD], 'All' AS [NAME], 0 AS [Order_By]
UNION
SELECT ITEM_TYPE_ID AS [ID_FIELD], NAME AS [NAME], 1 AS [Order_By]
FROM TE_DIM_ITEM_TYPE
WHERE HIDDEN = 0
ORDER BY ORDER_BY, NAME;

SELECT @error = @@ERROR;

IF @error <> 0
BEGIN 
    RAISERROR (50100, 16, 2, @error, 'ap_rep01_list_item_types', '');
    GOTO EXIT_SPROC;
END;

EXIT_SPROC:

RETURN @error;
GO
GRANT EXECUTE
	ON [dbo].[ap_rep01_list_item_types]
	TO [portalapp_role]
GO
