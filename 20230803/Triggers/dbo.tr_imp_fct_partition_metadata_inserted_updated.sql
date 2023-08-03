SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE   TRIGGER [dbo].[tr_imp_fct_partition_metadata_inserted_updated] ON [dbo].[TB_IMP_FCT_PARTITION_METADATA]
    FOR INSERT, UPDATE
    NOT FOR REPLICATION
AS
    BEGIN 
        SET XACT_ABORT OFF;
        SET NOCOUNT ON;

        -- CHECK IF THIS IS AN UPDATE
        IF ( EXISTS ( SELECT    *
                      FROM      [Deleted] )
             AND EXISTS ( SELECT    *
                          FROM      [Inserted] )
           )
        BEGIN
            -- CHECK IF NEXT_AVAILABLE_IDENTITY WAS UPDATED
            IF ( UPDATE([NEXT_AVAILABLE_IDENTITY]) )
            BEGIN
                -- IF NEXT_AVAILABLE_IDENTITY WAS UPDATED, CHECK THAT THE ONLY A SINGLE COLUMN WAS UPDATED (SEE http://aggregate.org/MAGIC/#Is%20Power%20of%202)
                IF ( ( TRY_CAST(COLUMNS_UPDATED() AS BIGINT) & ( TRY_CAST(COLUMNS_UPDATED() AS BIGINT) - 1 ) ) = 0 )
                BEGIN
                    RETURN;
                END;
            END;
        END;

        UPDATE  [dbo].[TB_ADM_PROPERTY]
        SET     [PROPERTY_VALUE] = CONVERT(VARCHAR(24), GETUTCDATE(), 126)
        WHERE   [PROPERTY_KEY] = 'PROP_LAST_PARTITION_METADATA_CHANGE';
    END;
GO
