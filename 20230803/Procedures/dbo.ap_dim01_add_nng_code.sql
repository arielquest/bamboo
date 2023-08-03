SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_dim01_add_nng_code] (@I_URN INT, @I_ParentURN INT, @I_SkipLevel TINYINT, 
@I_Member VARCHAR(20), @I_MemberLength INT, @I_Description VARCHAR(100), @I_OSGRID VARCHAR(6), 
@I_LatLong VARCHAR(15)) AS
BEGIN 
    SET NOCOUNT ON;

    DECLARE @v_Error AS INT;

    SET IDENTITY_INSERT [dbo].[TB_DIM_NNG] ON;

    INSERT [dbo].[TB_DIM_NNG] ([NNG_URN], [PARENT_URN], [SKIP_LEVEL], [MEMBER], [MEMBER_LENGTH], [DESCRIPTION], [OSGRID], [LAT_LONG])
    VALUES (@I_URN, @I_ParentURN, @I_SkipLevel, @I_Member, @I_MemberLength, @I_Description, @I_OSGRID, @I_LatLong);

    SELECT @v_Error = @@ERROR;

    SET IDENTITY_INSERT [dbo].[TB_DIM_NNG] OFF;

    IF @v_Error <> 0
    BEGIN 
        RAISERROR ('ap_dim01_add_nng_code: Error adding new NNG code string [%s], error [%d] ', 16, 1, @I_Member, @v_Error) WITH LOG;
        RETURN - 1;
    END;

    RETURN 0;
END;
GO
