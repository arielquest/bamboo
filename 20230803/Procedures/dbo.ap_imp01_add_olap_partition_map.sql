SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_imp01_add_olap_partition_map] (@FactResourceInstanceID UNIQUEIDENTIFIER, @OlapResourceInstanceID UNIQUEIDENTIFIER, 
@FactTableName NVARCHAR(100), @FactPartitionNumber INT, @ParentOlapObjectName NVARCHAR(50), @OlapObjectName NVARCHAR(128), 
@OlapPartitionName NVARCHAR(250)) AS

SET NOCOUNT ON;
DECLARE @ErrorMessage VARCHAR(200);
DECLARE @error INT = 0, @InitialTransactionCount INT = @@TRANCOUNT, 
@olapObjectURN INT, @factPartitionID UNIQUEIDENTIFIER, @OlapPartitionMapID UNIQUEIDENTIFIER, @highWaterMark INT, @OlapPartitionID UNIQUEIDENTIFIER;

BEGIN TRY;

    SELECT @olapObjectURN = OLAP_OBJECT_URN
    FROM dbo.TB_ADM_OLAP_OBJECT
    WHERE PARENT_OLAP_OBJECT_NAME = @ParentOlapObjectName
    AND OLAP_OBJECT_NAME = @OlapObjectName AND OLAP_OBJECT_TYPE = 'C';

    IF @olapObjectURN IS NULL
    BEGIN 
        SET @error = -1;
        RAISERROR ('ap_imp01_add_olap_partition_map: @olapObjectURN cannot be NULL', 16, 1);
    END;

    -- Check that the olap resource instance has a mpping to the specified cluster object
    IF NOT EXISTS (SELECT 1 
                   FROM [dbo].[TB_ADM_OLAP_OBJECT_CLUSTER_MAP] cm
                   WHERE OLAP_OBJECT_URN = @olapObjectURN 
                   AND OLAP_CLUSTER_RESOURCE_ID = (SELECT RESOURCE_ID
                                                   FROM TB_CLU_RESOURCE_INSTANCE
                                                   WHERE RESOURCE_INSTANCE_ID = @OlapResourceInstanceID
                                                  )
                   )
    BEGIN 
        SET @error = -1;
        RAISERROR ('ap_imp01_add_olap_partition_map: Failed to add olap partition map as the olap object [%s].[%s] is not mapped to this OLAP cluster resource.', 
                   16, 1, @ParentOlapObjectName, @OlapObjectName);
    END;

    SELECT @OlapPartitionMapID = om.OLAP_PARTITION_MAP_ID
    FROM dbo.TB_IMP_FCT_OLAP_PARTITION_MAP AS om
    INNER JOIN dbo.TB_IMP_FCT_OLAP_PARTITION AS op ON op.OLAP_PARTITION_ID = om.OLAP_PARTITION_ID
    INNER JOIN dbo.TB_IMP_FCT_PARTITION AS fp ON om.FACT_PARTITION_ID = fp.FACT_PARTITION_ID
    INNER JOIN dbo.TB_IMP_FCT_PARTITION_METADATA AS fpm ON fpm.FACT_PARTITION_METADATA_ID = fp.FACT_PARTITION_METADATA_ID
    WHERE op.OLAP_OBJECT_URN = @olapObjectURN AND op.OLAP_PARTITION_NAME = @OlapPartitionName
    AND fpm.CUBE_VIEW_NAME = @FactTableName AND fp.PARTITION_ID = @FactPartitionNumber 
    AND fp.RESOURCE_INSTANCE_ID = @FactResourceInstanceID AND op.RESOURCE_INSTANCE_ID = @OlapResourceInstanceID;

    SELECT @OlapPartitionID = OLAP_PARTITION_ID
    FROM dbo.TB_IMP_FCT_OLAP_PARTITION
    WHERE OLAP_OBJECT_URN = @olapObjectURN AND OLAP_PARTITION_NAME = @OlapPartitionName
    AND RESOURCE_INSTANCE_ID = @OlapResourceInstanceID;

    SELECT @factPartitionID = FACT_PARTITION_ID
    FROM dbo.TB_IMP_FCT_PARTITION AS fp
    INNER JOIN dbo.TB_IMP_FCT_PARTITION_METADATA AS fpm ON fpm.FACT_PARTITION_METADATA_ID = fp.FACT_PARTITION_METADATA_ID
    WHERE fpm.CUBE_VIEW_NAME = @FactTableName AND fp.PARTITION_ID = @FactPartitionNumber 
    AND fp.RESOURCE_INSTANCE_ID = @FactResourceInstanceID;

    BEGIN TRANSACTION AddOlapMpTransaction;
    

        IF @OlapPartitionID IS NULL
        BEGIN 
            SET @OlapPartitionID = NEWID();

            INSERT INTO dbo.TB_IMP_FCT_OLAP_PARTITION (OLAP_PARTITION_ID, RESOURCE_INSTANCE_ID, OLAP_OBJECT_URN, OLAP_PARTITION_NAME, STATUS, msrepl_tran_version)
            VALUES (@OlapPartitionID, @OlapResourceInstanceID, @olapObjectURN, @OlapPartitionName, 0, NEWID());
        END;

        IF @OlapPartitionMapID IS NULL
        BEGIN 
            INSERT INTO dbo.TB_IMP_FCT_OLAP_PARTITION_MAP (OLAP_PARTITION_MAP_ID, FACT_PARTITION_ID, OLAP_PARTITION_ID, LAST_HIGH_WATER, msrepl_tran_version)
            VALUES (NEWID(), @factPartitionID, @OlapPartitionID, 0, NEWID());
        END;

        IF @InitialTransactionCount = 0 
        BEGIN 
           COMMIT TRANSACTION AddOlapMpTransaction;
        END;
        ELSE BEGIN 
            WHILE @@TRANCOUNT > @InitialTransactionCount
            BEGIN 
                COMMIT TRANSACTION;
            END;
        END;
    END TRY
    
    BEGIN CATCH;
        SELECT @error = CASE WHEN @error <> -1 THEN @@ERROR ELSE @error END,
        @ErrorMessage = ERROR_MESSAGE();

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
	ON [dbo].[ap_imp01_add_olap_partition_map]
	TO [portalapp_role]
GO
