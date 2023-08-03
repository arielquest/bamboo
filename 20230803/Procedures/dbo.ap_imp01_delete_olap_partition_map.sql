SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_imp01_delete_olap_partition_map] (@FactResourceInstanceID UNIQUEIDENTIFIER, @OlapResourceInstanceID UNIQUEIDENTIFIER, 
@ParentOlapObjectName NVARCHAR(50), @OlapObjectName AS NVARCHAR(128), @OlapPartitionName AS NVARCHAR(250) = NULL) AS
SET NOCOUNT ON;

DECLARE @error INT = 0, @InitialTransactionCount INT = @@TRANCOUNT, 
@OlapPartitionID UNIQUEIDENTIFIER, @OlapObjectURN INT, @ErrorMessage VARCHAR(1000);

BEGIN TRANSACTION DelOlapMapTransaction;
    BEGIN TRY;
        BEGIN TRY;
            IF (@OlapPartitionName IS NOT NULL)
            BEGIN 
                SELECT @OlapPartitionID = op.OLAP_PARTITION_ID
                FROM dbo.TB_ADM_OLAP_OBJECT AS oo
                INNER JOIN dbo.TB_IMP_FCT_OLAP_PARTITION AS op ON oo.OLAP_OBJECT_URN = op.OLAP_OBJECT_URN
                INNER JOIN dbo.TB_IMP_FCT_OLAP_PARTITION_MAP AS m ON op.OLAP_PARTITION_ID = m.OLAP_PARTITION_ID
                INNER JOIN dbo.TB_IMP_FCT_PARTITION AS p ON p.FACT_PARTITION_ID = m.FACT_PARTITION_ID
                WHERE p.RESOURCE_INSTANCE_ID = @FactResourceInstanceID
                AND oo.PARENT_OLAP_OBJECT_NAME = @ParentOlapObjectName AND oo.OLAP_OBJECT_NAME = @OlapObjectName
                AND oo.OLAP_OBJECT_TYPE = 'C' AND op.OLAP_PARTITION_NAME = @OlapPartitionName
                AND op.RESOURCE_INSTANCE_ID = @OlapResourceInstanceID;

                DELETE dbo.TB_IMP_FCT_OLAP_PARTITION_MAP
                FROM dbo.TB_IMP_FCT_OLAP_PARTITION_MAP AS m
                INNER JOIN dbo.TB_IMP_FCT_OLAP_PARTITION AS op ON op.OLAP_PARTITION_ID = m.OLAP_PARTITION_ID
                WHERE op.OLAP_PARTITION_ID = @OlapPartitionID AND op.RESOURCE_INSTANCE_ID = @OlapResourceInstanceID;
            END;
            ELSE BEGIN 
                SELECT DISTINCT @OlapObjectURN = op.OLAP_OBJECT_URN
                FROM dbo.TB_ADM_OLAP_OBJECT AS oo
                INNER JOIN dbo.TB_IMP_FCT_OLAP_PARTITION AS op ON oo.OLAP_OBJECT_URN = op.OLAP_OBJECT_URN
                INNER JOIN dbo.TB_IMP_FCT_OLAP_PARTITION_MAP AS m ON op.OLAP_PARTITION_ID = m.OLAP_PARTITION_ID
                INNER JOIN dbo.TB_IMP_FCT_PARTITION AS p ON p.FACT_PARTITION_ID = m.FACT_PARTITION_ID
                WHERE p.RESOURCE_INSTANCE_ID = @FactResourceInstanceID
                AND oo.PARENT_OLAP_OBJECT_NAME = @ParentOlapObjectName AND oo.OLAP_OBJECT_NAME = @OlapObjectName
                AND oo.OLAP_OBJECT_TYPE = 'C' AND op.RESOURCE_INSTANCE_ID = @OlapResourceInstanceID;

                DELETE dbo.TB_IMP_FCT_OLAP_PARTITION_MAP
                FROM dbo.TB_IMP_FCT_OLAP_PARTITION_MAP AS m
                INNER JOIN dbo.TB_IMP_FCT_OLAP_PARTITION AS op ON op.OLAP_PARTITION_ID = m.OLAP_PARTITION_ID
                WHERE op.OLAP_OBJECT_URN = @OlapObjectURN AND op.RESOURCE_INSTANCE_ID = @OlapResourceInstanceID;
    
                DELETE FROM dbo.TB_IMP_FCT_OLAP_PARTITION
                WHERE OLAP_OBJECT_URN = @OlapObjectURN AND RESOURCE_INSTANCE_ID = @OlapResourceInstanceID;
            END;
        END TRY
        BEGIN CATCH;
            SET @error = @@ERROR;
            RAISERROR('ap_imp01_delete_olap_partition_map: Failed to delete olap partition map for Cube [%s]/Partition [%s]: Error [%d]', 
            16, 1, @ParentOlapObjectName, @OlapObjectName, @OlapPartitionName,@error);
        END CATCH;
        
        BEGIN TRY;       
            DELETE FROM TB_IMP_FCT_OLAP_PARTITION
            WHERE OLAP_PARTITION_ID = @OlapPartitionID;
        END TRY
        BEGIN CATCH;
            SET @error = @@ERROR;
            RAISERROR('ap_imp01_delete_olap_partition_map: Failed to delete olap partition map for Cubes [%s]: Error [%d]', 16, 1, 
            @ParentOlapObjectName, @OlapObjectName ,@error);
        END CATCH;
        
        IF @InitialTransactionCount = 0 
        BEGIN 
           COMMIT TRANSACTION DelOlapMapTransaction;
        END;
        ELSE BEGIN 
            WHILE @@TRANCOUNT > @InitialTransactionCount
            BEGIN 
                COMMIT TRANSACTION;
            END;
        END;
    END TRY
    BEGIN CATCH;
        SELECT @error = CASE WHEN @error = 0 THEN @@ERROR ELSE @error END, @ErrorMessage = ERROR_MESSAGE();

        IF @InitialTransactionCount = 0 AND @@TRANCOUNT > 0
        BEGIN 
            ROLLBACK TRANSACTION;
        END;
        ELSE IF @InitialTransactionCount <> 0 AND @@TRANCOUNT > @InitialTransactionCount
        BEGIN 
            IF (XACT_STATE()) = -1
            BEGIN 
                SET @ErrorMessage = ISNULL(@ErrorMessage,OBJECT_NAME(@@PROCID))+' [Uncommittable Transaction!]';
                ROLLBACK TRANSACTION;
                -- THIS IS TO AVOID TRANSACTION MISMATCHES IN THE CALLING APPLICATION
                DECLARE @transactionFake INT = @@TRANCOUNT;
                WHILE @transactionFake < @InitialTransactionCount
                BEGIN 
                    BEGIN TRANSACTION;
                    SET @transactionFake = @transactionFake + 1;
                END;
            END;
            ELSE BEGIN 
                WHILE @@TRANCOUNT > @InitialTransactionCount
                BEGIN 
                    COMMIT TRANSACTION;
                END;
            END;
            SET @ErrorMessage = ISNULL(@ErrorMessage,OBJECT_NAME(@@PROCID));
            RAISERROR(@ErrorMessage, 16, 1) WITH LOG;
        END;
    END CATCH;

RETURN @error;
GO
GRANT EXECUTE
	ON [dbo].[ap_imp01_delete_olap_partition_map]
	TO [portalapp_role]
GO
