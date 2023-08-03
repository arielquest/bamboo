SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------
-- Returns the dimension member type primary key from the supplied internal name
-------------------------------------------------------------------------------
CREATE FUNCTION [dbo].[fn_dim_member_type_id_from_internal_name]
(
     @InternalName AS NVARCHAR(50)
)
RETURNS UNIQUEIDENTIFIER
AS
BEGIN
    DECLARE @member_type_id AS UNIQUEIDENTIFIER;

    SELECT @member_type_id = [it].[MEMBER_TYPE_ID]
    FROM [dbo].[TE_DIM_MEMBER_TYPE] AS it
    WHERE [it].[INTERNAL_NAME] = @InternalName;

    RETURN @member_type_id;
END;
GO
