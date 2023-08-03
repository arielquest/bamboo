SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_dim01_generate_and_reserve_internal_name] (
@ItemTypeID UNIQUEIDENTIFIER, @I_Parent_Type_ID UNIQUEIDENTIFIER  = NULL, @ParentURN INT = -2, 
@ClusterResourceID UNIQUEIDENTIFIER = NULL, @FolderID UNIQUEIDENTIFIER = '00000002-0000-0000-0000-000000000005', 
@OwnerID UNIQUEIDENTIFIER = NULL, @Seed1 NVARCHAR(50) = N'', @Seed2 NVARCHAR(50) = N'', @Seed3 NVARCHAR(50) = N'', 
@EquipmentName NVARCHAR(50) OUTPUT) AS
BEGIN 
    DECLARE @Error INT = 0, @Stop INT = 0, @LoopCheck INT = 0, @waitDelay CHAR(9);
    
    WHILE @Stop = 0
    BEGIN 
        EXEC @Error = dbo.ap_dim01_generate_internal_name @ItemTypeID, @ParentURN, @I_Parent_Type_ID, @OwnerID, @Seed1, @Seed2, @Seed3, @EquipmentName OUT;
        
        IF @Error = 0 
        BEGIN 
            EXEC @Error = dbo.ap_dim01_reserve_internal_name @ItemTypeID, @EquipmentName, @ParentURN, @ClusterResourceID, @FolderID, @OwnerID;

            IF (@Error = 1) --1 = internal name already reserved.
            BEGIN 
                IF @LoopCheck = 3
                BEGIN 
                    SET @Stop = 1;
                    BREAK;
                END;
                --Random wait between 50ms and 999ms
                SELECT @waitDelay = '0:0:0.' + RIGHT('0'+CAST(CASE WHEN seed > 949 THEN 949 ELSE seed END +50 AS VARCHAR(3)),3)
                FROM (SELECT ABS(CHECKSUM(NEWID()) % 999)) a(seed);
                
                SET @LoopCheck = @LoopCheck + 1;
                WAITFOR DELAY @waitDelay; -- if the name is in use, then try to generate another one...
                CONTINUE;
            END;
            ELSE BEGIN 
                SET @Stop = 1;
                BREAK;
            END;
        END;
        ELSE BEGIN 
            SET @Stop = 1;
            BREAK;
        END;
    END;

    RETURN @Error;
END;
GO
GRANT EXECUTE
	ON [dbo].[ap_dim01_generate_and_reserve_internal_name]
	TO [portalapp_role]
GO
