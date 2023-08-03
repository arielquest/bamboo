SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_imp01_set_olap_partition_map_status]
(
    @FactResourceInstanceID     AS UNIQUEIDENTIFIER,
    @OlapResourceInstanceID     AS UNIQUEIDENTIFIER,
    @FactTableName              AS NVARCHAR(100),
    @ParentOlapObjectName       AS NVARCHAR(50),
    @OlapObjectName             AS NVARCHAR(128),
    @OlapPartitionName          AS NVARCHAR(250),
    @Status                     AS INT
) AS
BEGIN 
    SET NOCOUNT ON;
    
    DECLARE @error                   INT = 0,
            @InitialTransactionCount INT = @@TRANCOUNT,
            @olapObjectURN           INT,
            @OlapPartitionID         UNIQUEIDENTIFIER,
            @ErrorMessage            VARCHAR(200);

   
    SELECT @olapObjectURN = OLAP_OBJECT_URN FROM dbo.TB_ADM_OLAP_OBJECT 
    WHERE PARENT_OLAP_OBJECT_NAME = @ParentOlapObjectName 
    AND OLAP_OBJECT_NAME = @OlapObjectName
    AND OLAP_OBJECT_TYPE = 'C';
    
    IF @olapObjectURN IS NOT NULL
    BEGIN   
        SELECT @OlapPartitionID = om.OLAP_PARTITION_ID
        FROM dbo.TB_IMP_FCT_OLAP_PARTITION_MAP AS om
        JOIN dbo.TB_IMP_FCT_PARTITION as fp ON om.FACT_PARTITION_ID = fp.FACT_PARTITION_ID
        JOIN dbo.TB_IMP_FCT_PARTITION_METADATA as fpm ON fpm.FACT_PARTITION_METADATA_ID = fp.FACT_PARTITION_METADATA_ID
        JOIN dbo.TB_IMP_FCT_OLAP_PARTITION p ON p.OLAP_PARTITION_ID = om.OLAP_PARTITION_ID
        WHERE p.OLAP_OBJECT_URN = @olapObjectURN
            AND p.OLAP_PARTITION_NAME = @OlapPartitionName
            AND fpm.CUBE_VIEW_NAME = @FactTableName
            AND fp.RESOURCE_INSTANCE_ID = @FactResourceInstanceID
            AND p.RESOURCE_INSTANCE_ID = @OlapResourceInstanceID;
        
        BEGIN TRY;                                
            BEGIN TRANSACTION SetPartMapTransaction;
    
            IF @OlapPartitionID IS NOT NULL
            BEGIN 
                UPDATE dbo.TB_IMP_FCT_OLAP_PARTITION
                SET STATUS = @Status
                WHERE OLAP_PARTITION_ID = @OlapPartitionID
                AND STATUS <> 3; -- can't overwrite reset state - when a partition is reset the row is deleted
            END;
         
            IF @InitialTransactionCount = 0 
            BEGIN 
               COMMIT TRANSACTION SetPartMapTransaction;
            END;
            ELSE BEGIN 
                WHILE @@TRANCOUNT > @InitialTransactionCount
                BEGIN 
                    COMMIT TRANSACTION;
                END;
            END;
        END TRY
        BEGIN CATCH;
            SELECT @ErrorMessage = '['+OBJECT_NAME(@@PROCID)+']' + ISNULL(': ' + ERROR_MESSAGE(),''),
                   @error = @@ERROR;
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
    END;
    ELSE BEGIN 
        SET @error = -1;
    END;
    RETURN @error;
END;
GO
GRANT EXECUTE
	ON [dbo].[ap_imp01_set_olap_partition_map_status]
	TO [portalapp_role]
GO
