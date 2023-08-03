SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------
-- Returns the dimension item type primary key from the supplied internal name
-------------------------------------------------------------------------------
CREATE FUNCTION [dbo].[fn_dim_type_id_from_internal_name]
(
     @InternalName AS NVARCHAR(50)
)
RETURNS UNIQUEIDENTIFIER
AS
BEGIN
    DECLARE @item_type_id AS UNIQUEIDENTIFIER;

    SELECT @item_type_id = [it].[ITEM_TYPE_ID] 
    FROM [dbo].[TE_DIM_ITEM_TYPE] AS it
    WHERE [it].[INTERNAL_NAME] = @InternalName;    
    
    RETURN @item_type_id;
END;
GO
