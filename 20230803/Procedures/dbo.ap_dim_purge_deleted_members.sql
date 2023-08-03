SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[ap_dim_purge_deleted_members]
    (
      @MemberTypeInternalName NVARCHAR(100),
      @DeleteBatchSize INT = 100000
    )
AS
    BEGIN
        SET NOCOUNT ON;

        DECLARE @ReturnCode INT = 0,
            @IsPurgeActive BIT,
            @InitialTransactionCount INT = @@TRANCOUNT,
            @insert_SQL NVARCHAR(MAX),
            @deletePkey_SQL NVARCHAR(MAX),
            @deleteBiz_SQL NVARCHAR(MAX),
            @ErrorMessage VARCHAR(2000),
            @OlderThanDays INT;

        BEGIN TRY;
        --Check if purge is active on this side
            SELECT  @IsPurgeActive = CASE WHEN CAST([ri].[XML_DATA].[query]('/Columns/Column[@Name="PURGE_ENABLED"]/text()') AS NVARCHAR(5)) = 'True' THEN 1
                                          ELSE 0
                                     END
            FROM    [dbo].[fn_clu_get_exony_db_resource_instance](NULL) AS [exDb]
            INNER JOIN [dbo].[TB_CLU_RESOURCE_INSTANCE] [ri] ON [ri].[RESOURCE_INSTANCE_ID] = [exDb].[RESOURCE_INSTANCE_ID];

            IF @IsPurgeActive = 1
            BEGIN 
                SELECT  @insert_SQL = CONCAT('SELECT MEMBER_URN, MEMBER_BIZ_URN', CHAR(13), CHAR(10), 'FROM [', OBJECT_SCHEMA_NAME(OBJECT_ID([TABLE_NAME])),
                                             '].[', [TABLE_NAME], ']', CHAR(13), CHAR(10), 'WHERE DELETED = 1', CHAR(13), CHAR(10),
                                             'AND EFFECTIVE_TO < DATEADD(day, - @sp_IN_OlderThanDays, GETUTCDATE()) AND LATEST = 1', CHAR(13), CHAR(10),
                                             'AND MEMBER_BIZ_URN NOT IN (SELECT pkey.MEMBER_BIZ_URN', CHAR(13), CHAR(10), SPACE(27), 'FROM [',
                                             OBJECT_SCHEMA_NAME(OBJECT_ID([TABLE_NAME])), '].[', [TABLE_NAME], '_PKEY_MAP] pkey', CHAR(13), CHAR(10), SPACE(27),
                                             'WHERE PURGED = 0', CHAR(13), CHAR(10), SPACE(27), ');'),
                        @deletePkey_SQL = CONCAT('DELETE FROM [', OBJECT_SCHEMA_NAME(OBJECT_ID([TABLE_NAME])), '].[', [TABLE_NAME], '_PKEY_MAP]', CHAR(13),
                                                 CHAR(10), 'WHERE PKEY_MAP_BIZ_URN IN (SELECT map.PKEY_MAP_BIZ_URN', CHAR(13), CHAR(10), SPACE(25),
                                                 'FROM #ChunkOfMembersToDelete chunk', CHAR(13), CHAR(10), SPACE(25), 'INNER JOIN [',
                                                 OBJECT_SCHEMA_NAME(OBJECT_ID([TABLE_NAME])), '].[' + [TABLE_NAME],
                                                 '_PKEY_MAP] map ON chunk.MEMBER_BUSINESS_URN = map.MEMBER_BIZ_URN', CHAR(13), CHAR(10), SPACE(25), ');'),
                        @deleteBiz_SQL = CONCAT('DELETE FROM [', OBJECT_SCHEMA_NAME(OBJECT_ID([TABLE_NAME])), '].[', [TABLE_NAME], ']', CHAR(13), CHAR(10),
                                                'WHERE MEMBER_BIZ_URN IN (SELECT MEMBER_BUSINESS_URN', CHAR(13), CHAR(10), SPACE(25),
                                                'FROM #ChunkOfMembersToDelete', CHAR(13), CHAR(10), SPACE(25), ');'),
                        @OlderThanDays = [PURGE_PERIOD]
                FROM    [dbo].[TE_DIM_MEMBER_TYPE]
                WHERE   [INTERNAL_NAME] = @MemberTypeInternalName;

                IF @insert_SQL IS NULL
                BEGIN 
                    SET @ReturnCode = 50300;
                    RAISERROR ('[dbo].[ap_dim_purge_deleted_members]: Invalid @MemberTypeInternalName specified [%s]', 16, 1, @MemberTypeInternalName);
                END;
            
                -- validate "older than days"
                IF @OlderThanDays < 0
                BEGIN 
                    SET @ReturnCode = 50161;
                    RAISERROR ('[dbo].[ap_dim_purge_deleted_members]: Invalid @OlderThanDays specified [%d]', 16, 1, @OlderThanDays);
                END;

                CREATE TABLE [#MembersToDelete]
                    (
                      [MEMBER_URN] [INTEGER],
                      [MEMBER_BUSINESS_URN] [INTEGER],
                      PRIMARY KEY ( [MEMBER_URN] )
                    );
                CREATE TABLE [#ChunkOfMembersToDelete]
                    (
                      [MEMBER_URN] [INTEGER],
                      [MEMBER_BUSINESS_URN] [INTEGER],
                      PRIMARY KEY ( [MEMBER_URN] )
                    );

                -- Get the all surrogates of business members which are deleted and not associated with any non-purged pkey maps
                INSERT  INTO [#MembersToDelete]
                        ( [MEMBER_URN],
                          [MEMBER_BUSINESS_URN]
                        )
                        EXECUTE [sys].[sp_executesql] @insert_SQL, N'@sp_IN_OlderThanDays INT', @sp_IN_OlderThanDays = @OlderThanDays;

                -- Chunk delete the members
                WHILE EXISTS ( SELECT   1
                               FROM     [#MembersToDelete] )
                BEGIN 
                    -- Get the members to delete in this chunk
                    INSERT  INTO [#ChunkOfMembersToDelete]
                            ( [MEMBER_URN],
                              [MEMBER_BUSINESS_URN]
                            )
                    SELECT TOP ( @DeleteBatchSize )
                            [MEMBER_URN],
                            [MEMBER_BUSINESS_URN]
                    FROM    [#MembersToDelete]
                    ORDER BY [MEMBER_URN] DESC;
                    
                    IF @InitialTransactionCount > 0
                    BEGIN
                        SAVE TRANSACTION [PurgeMembersTransaction];
                    END;
                    ELSE
                    BEGIN
                        BEGIN TRANSACTION;
                    END;

                    -- Delete all business pkey maps related to the members being deleted. Note: This may temporarily leave a member record
                    -- without the pkey map if on a chunk boundary, however because only LATEST members are deleted it will eventually be deleted in 
                    -- a subsequent chunk.
                    EXECUTE [sys].[sp_executesql] @deletePkey_SQL;

                    -- Delete base table rows
                    EXECUTE [sys].[sp_executesql] @deleteBiz_SQL;

                    -- Clear the successfully deleted rows
                    DELETE  FROM [#MembersToDelete]
                    WHERE   [MEMBER_URN] IN ( SELECT    [MEMBER_URN]
                                              FROM      [#ChunkOfMembersToDelete] );

                    TRUNCATE TABLE [#ChunkOfMembersToDelete];
                    
                    -- Only want to commit the transaction if we started it
                    IF @InitialTransactionCount = 0
                    BEGIN
                        COMMIT TRANSACTION;
                    END;
                END;

                DROP TABLE [#MembersToDelete];
                DROP TABLE [#ChunkOfMembersToDelete];
            END;
            SET @ReturnCode = 0;
        END TRY
        BEGIN CATCH;
            SELECT  @ReturnCode = CASE WHEN @ReturnCode NOT IN ( 50300, 50161 ) THEN @@ERROR
                                       ELSE @ReturnCode
                                  END,
                    @ErrorMessage = ERROR_MESSAGE();
    
            IF @InitialTransactionCount = 0
                AND @@TRANCOUNT > 0
            BEGIN 
                ROLLBACK TRANSACTION;
            END;
            ELSE
                IF @InitialTransactionCount <> 0
                    AND @@TRANCOUNT > @InitialTransactionCount
                BEGIN 
                    -- ROLLBACK SAVEPOINT
                    ROLLBACK TRANSACTION [PurgeMembersTransaction];
                    IF ( XACT_STATE() ) = -1
                    BEGIN 
                        -- TRANSACTION IS NOT COMMITTABLE, SO ROLLBACK IF OPEN
                        IF @@TRANCOUNT > 0
                        BEGIN
                            ROLLBACK TRANSACTION;
                        END;
                        SET @ErrorMessage = ISNULL(@ErrorMessage, OBJECT_NAME(@@PROCID)) + ' [Uncommittable Transaction!]';
                        -- THIS IS TO AVOID TRANSACTION MISMATCHES IN THE CALLING APPLICATION
                        DECLARE @transactionFake INT = @@TRANCOUNT;
                        WHILE @transactionFake < @InitialTransactionCount
                        BEGIN 
                            BEGIN TRANSACTION;
                            SET @transactionFake = @transactionFake + 1;
                        END;
                    END;
                    ELSE
                    BEGIN 
                        -- IF THE CURRENT TRANCOUNT IS HIGHER THAN THE INITIAL TRANCOUNT, COMMIT THE EXTRAS
                        -- TO AVOID TRANSACTION MISMATCHES IN THE CALLING APPLICATION
                        WHILE @@TRANCOUNT > @InitialTransactionCount
                        BEGIN 
                            COMMIT TRANSACTION;
                        END;
                    END;
                    SET @ErrorMessage = OBJECT_NAME(@@PROCID) + ISNULL(':' + @ErrorMessage, '');
                    RAISERROR(@ErrorMessage, 16, 1) WITH LOG;
                END;
        END CATCH;

        RETURN @ReturnCode;
    END;
GO
GRANT EXECUTE
	ON [dbo].[ap_dim_purge_deleted_members]
	TO [portalapp_role]
GO
