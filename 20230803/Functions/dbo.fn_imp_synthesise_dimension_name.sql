SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
------------------------------------------------------------------------------- 
-- This function is invoked to ALTER  a dimension name in the case when a 
-- dimension is added from a fact table. 
------------------------------------------------------------------------------ 
CREATE FUNCTION [dbo].[fn_imp_synthesise_dimension_name] 
( 
    @I_ClusterResourceID     AS [UNIQUEIDENTIFIER], 
    @I_StagingTablePrefix    AS [VARCHAR](30), 
    @I_DimensionURN          AS [INTEGER] 
) 
RETURNS [VARCHAR](45) 
--WITH ENCRYPTION 
AS 
BEGIN 
    DECLARE @v_DimensionName [NVARCHAR](45); 
 
--    SET @v_DimensionName = RTRIM(@I_StagingTablePrefix) + '_' + RTRIM(CAST(@I_ClusterResourceID AS [VARCHAR](10))) + '_' + RTRIM(CAST(@I_DimensionURN AS [VARCHAR](10))) 
      SET @v_DimensionName = RTRIM(@I_StagingTablePrefix) + '_' + RTRIM(CAST(@I_DimensionURN AS [VARCHAR](10))) + '_' + RTRIM(LEFT(@I_ClusterResourceID, 10));

    RETURN @v_DimensionName; 
 
END;
GO
