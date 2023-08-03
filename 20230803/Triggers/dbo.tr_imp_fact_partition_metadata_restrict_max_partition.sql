SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE   TRIGGER [dbo].[tr_imp_fact_partition_metadata_restrict_max_partition] ON [dbo].[TB_IMP_FCT_PARTITION_METADATA]
    FOR UPDATE
    NOT FOR REPLICATION
AS
    BEGIN
        IF UPDATE([MAXIMUM_PARTITIONS])
        BEGIN 
            RAISERROR ('Maximum partitions is read-only and can''t be changed.', 16, 1);
        END;
    END;
GO
