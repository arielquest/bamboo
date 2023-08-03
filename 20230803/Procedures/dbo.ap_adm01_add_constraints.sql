SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_adm01_add_constraints]
AS
    BEGIN 
        SET NOCOUNT ON;

        DECLARE @sql NVARCHAR(MAX),
            @error INT;

        SELECT  @sql = COALESCE(@sql + ';', N'') + N'
    IF NOT EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(''' + [CONSTRAINT_NAME] + ''') AND OBJECTPROPERTY(id, ''IsForeignKey'') = 1) 
    ALTER TABLE [' + [SOURCE_SCHEMA_NAME] + N'].[' + [SOURCE_TABLE_NAME] + N'] 
    ADD CONSTRAINT [' + [CONSTRAINT_NAME] + N'] FOREIGN KEY (' + [CONSTRAINT_KEY] + N') REFERENCES [' + [REFERENCE_SCHEMA_NAME] + '].[' + [REFERENCE_TABLE_NAME]
                + N'] (' + [REFERENCE_KEY] + N') ON DELETE ' + CASE WHEN [DELETE_ACTION] = 0 THEN N'NO ACTION'
                                                                    ELSE N'CASCADE'
                                                               END + N' ' + CASE WHEN [REPLICATION_OPTION] = 0 THEN 'NOT FOR REPLICATION'
                                                                                 ELSE ''
                                                                            END
        FROM    [dbo].[TS_ADM_CONSTRAINTS];

        EXEC @error = [sys].[sp_executesql] @sql;

        IF @error <> 0
        BEGIN 
            RAISERROR (50100, 16, 1, @error, 'ap_adm01_add_constraints', NULL);
        END;

        RETURN @error;
    END;
GO
