SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_adm01_get_provisioning_audits] 
(@FolderIds dbo.GuidTableType READONLY, 
 @ItemTypeIds dbo.GuidTableType READONLY, 
 @DateFrom DATETIME, @DateTo DATETIME, 
 @Outcome CHAR(1) = NULL, 
 @Page INT, 
 @PageSize INT, 
 @SortColumn NVARCHAR(50) = 'EVENT_UTC_DATE_TIME', 
 @SortAscending BIT = 1) AS
BEGIN 
    SET NOCOUNT ON;
    DECLARE @ReturnCode INT = 0, @Sql NVARCHAR(MAX), @InitialTransactionCount INT = @@TRANCOUNT, @ErrorMessage VARCHAR(1000);
    BEGIN TRANSACTION ProvAuditTransaction;
    BEGIN TRY;
        -- validate sort column
        IF NOT EXISTS (
                SELECT 1
                FROM (VALUES ('EVENT_UTC_DATE_TIME'), ('AUDIT_TYPE_ID'), ('ITEM_URN'), 
                             ('ITEM_NAME'), ('ITEM_PATH'), ('ITEM_TYPE_ID'), ('RELATED_ITEM_URN'), 
                             ('RELATED_ITEM_NAME'), ('RELATED_ITEM_PATH'), ('RELATED_ITEM_TYPE_ID'), 
                             ('EQUIPMENT_NAME'), ('USER_NAME'), ('EVENT_OUTCOME')
                      ) a(SortColumn)
                WHERE SortColumn = @SortColumn
                )
        BEGIN 
            SET @ReturnCode = - 1;
            RAISERROR ('[dbo].[ap_adm01_get_provisioning_audits]: Invalid @SortColumn specified [%s]', 16, 1, @SortColumn);
        END;

        -- validate page number
        IF @Page <= 0
        BEGIN 
            SET @ReturnCode = - 1;
            RAISERROR ('[dbo].[ap_adm01_get_provisioning_audits]: Invalid @Page specified [%d]. Must be greater than or equal to 1.', 16, 1, @Page);
        END;

        IF @PageSize <= 0
        BEGIN 
            SET @ReturnCode = - 1;
            RAISERROR ('[dbo].[ap_adm01_get_provisioning_audits]: Invalid @PageSize specified [%d]. Must be greater than or equal to 1.', 16, 1, @PageSize);
        END;

        -- build sql (dynamic to allow sorting on any column)
        SELECT @Sql = N'' + CHAR(13) + CHAR(10) +
            'WITH ProvisioningAuditData AS ('+CHAR(13)+CHAR(10)+
            'SELECT '+CHAR(13)+CHAR(10)+
            --VW FCT_AUDIT
            'a.[EVENT_UTC_DATE_TIME], '+CHAR(13)+CHAR(10)+
            'a.[AUDIT_TYPE_ID], '+CHAR(13)+CHAR(10)+
            'a.[EVENT_OUTCOME],'+CHAR(13)+CHAR(10)+
            --TB_ADM_SESSION
            's.[SESSION_USER_NAME] AS [USER_NAME], '+CHAR(13)+CHAR(10)+
            --VW_DIM_ITEM
            'item.ITEM_URN, '+CHAR(13)+CHAR(10)+
            'item.NAME AS [ITEM_NAME], '+CHAR(13)+CHAR(10)+
            'item.ITEM_TYPE_ID, '+CHAR(13)+CHAR(10)+
            --TB_SEC_FOLDER
            'CASE itemFolder.PATH WHEN '''' THEN ''/'' ELSE itemFolder.PATH END AS [ITEM_PATH], '+CHAR(13)+CHAR(10)+
            --VW_DIM_ITEM
            'relatedItem.ITEM_URN AS [RELATED_ITEM_URN], '+CHAR(13)+CHAR(10)+
            'relatedItem.NAME AS [RELATED_ITEM_NAME], '+CHAR(13)+CHAR(10)+
            'relatedItem.ITEM_TYPE_ID AS [RELATED_ITEM_TYPE_ID], '+CHAR(13)+CHAR(10)+
            --TB_SEC_FOLDER
            'CASE relatedItemFolder.PATH WHEN '''' THEN ''/'' ELSE relatedItemFolder.PATH END AS [RELATED_ITEM_PATH], '+CHAR(13)+CHAR(10)+
            --TB_CLU_RESOURCE
            'cr.NAME AS [EQUIPMENT_NAME]'+CHAR(13)+CHAR(10)+
            'FROM dbo.VW_FCT_AUDIT a'+CHAR(13)+CHAR(10)+
            'INNER JOIN dbo.TB_ADM_SESSION s ON a.SESSION_ID = s.SESSION_ID'+CHAR(13)+CHAR(10)+
            'INNER JOIN dbo.TE_ADM_AUDIT_TYPE AS atype ON a.AUDIT_TYPE_ID = atype.AUDIT_TYPE_ID'+CHAR(13)+CHAR(10)+
            'INNER JOIN dbo.VW_DIM_ITEM item ON item.ITEM_BIZ_URN = a.INT_VAL_1 AND item.ITEM_TYPE_URN = a.INT_VAL_3 AND item.LATEST = 1'+CHAR(13)+CHAR(10)+
            'LEFT OUTER JOIN dbo.TB_CLU_RESOURCE cr ON cr.RESOURCE_ID = a.GUID_VAL_1'+CHAR(13)+CHAR(10)+
            'INNER JOIN dbo.TB_SEC_FOLDER itemFolder ON itemFolder.FOLDER_ID = item.FOLDER_ID'+CHAR(13)+CHAR(10)+
            'LEFT OUTER JOIN dbo.VW_DIM_ITEM relatedItem ON relatedItem.ITEM_BIZ_URN = a.INT_VAL_2 AND relatedItem.ITEM_TYPE_URN = a.INT_VAL_4 AND relatedItem.LATEST = 1'+CHAR(13)+CHAR(10)+
            'LEFT OUTER JOIN dbo.TB_SEC_FOLDER relatedItemFolder ON relatedItemFolder.FOLDER_ID = relatedItem.FOLDER_ID'+CHAR(13)+CHAR(10)+
            'WHERE (atype.INTERNAL_NAME LIKE ''AT\_DIMENSION\_%''  ESCAPE ''\'' OR atype.INTERNAL_NAME LIKE ''AT\_MEMBER\_%''  ESCAPE ''\'')'+CHAR(13)+CHAR(10)+
            'AND EVENT_UTC_DATE_TIME BETWEEN @DateFrom AND @DateTo'+CHAR(13)+CHAR(10)+
            CASE WHEN @Outcome IS NULL THEN '' ELSE  'AND a.[EVENT_OUTCOME] = @Outcome' +CHAR(13)+CHAR(10) END +
            'AND item.FOLDER_ID IN (SELECT [GUID] FROM @FolderIds) AND item.ITEM_TYPE_ID IN (' + STUFF((SELECT ',' + CHAR(39) + CAST([GUID] AS VARCHAR(36)) + CHAR(39)
                                                                                                        FROM @ItemTypeIds
                                                                                                        FOR XML PATH(''), TYPE
                                                                                                        ).value('.', 'NVARCHAR(MAX)'), 1, 1, ''
                                                                                                       ) + ')'+CHAR(13)+CHAR(10)+
            'UNION ALL'+CHAR(13)+CHAR(10)+
            'SELECT '+CHAR(13)+CHAR(10)+
            --VW FCT_AUDIT
            'a.[EVENT_UTC_DATE_TIME], '+CHAR(13)+CHAR(10)+
            'a.[AUDIT_TYPE_ID], '+CHAR(13)+CHAR(10)+
            'a.[EVENT_OUTCOME],'+CHAR(13)+CHAR(10)+
            --TB_ADM_SESSION
            's.[SESSION_USER_NAME] AS [USER_NAME], '+CHAR(13)+CHAR(10)+
            --VW_DIM_ITEM
            'item.ITEM_URN, '+CHAR(13)+CHAR(10)+
            'item.NAME AS [ITEM_NAME], '+CHAR(13)+CHAR(10)+
            'item.ITEM_TYPE_ID, '+CHAR(13)+CHAR(10)+
            --TB_SEC_FOLDER
            'CASE itemFolder.PATH WHEN '''' THEN ''/'' ELSE itemFolder.PATH END AS [ITEM_PATH], '+CHAR(13)+CHAR(10)+
            --VW_DIM_ITEM
            'relatedItem.ITEM_URN AS [RELATED_ITEM_URN], '+CHAR(13)+CHAR(10)+
            'relatedItem.NAME AS [RELATED_ITEM_NAME], '+CHAR(13)+CHAR(10)+
            'relatedItem.ITEM_TYPE_ID AS [RELATED_ITEM_TYPE_ID], '+CHAR(13)+CHAR(10)+
            --TB_SEC_FOLDER
            'CASE relatedItemFolder.PATH WHEN '''' THEN ''/'' ELSE relatedItemFolder.PATH END AS [RELATED_ITEM_PATH], '+CHAR(13)+CHAR(10)+
            --TB_CLU_RESOURCE
            'cr.NAME AS [EQUIPMENT_NAME]'+CHAR(13)+CHAR(10)+
            'FROM dbo.VW_FCT_AUDIT a'+CHAR(13)+CHAR(10)+
            'INNER JOIN dbo.TB_ADM_SESSION s ON a.SESSION_ID = s.SESSION_ID'+CHAR(13)+CHAR(10)+
            'INNER JOIN dbo.TE_ADM_AUDIT_TYPE AS atype ON a.AUDIT_TYPE_ID = atype.AUDIT_TYPE_ID'+CHAR(13)+CHAR(10)+
            'INNER JOIN dbo.VW_DIM_ITEM item ON item.ITEM_BIZ_URN = a.INT_VAL_2 AND item.ITEM_TYPE_URN = a.INT_VAL_4 AND item.LATEST = 1'+CHAR(13)+CHAR(10)+
            'LEFT OUTER JOIN dbo.TB_CLU_RESOURCE cr ON cr.RESOURCE_ID = a.GUID_VAL_1'+CHAR(13)+CHAR(10)+
            'INNER JOIN dbo.TB_SEC_FOLDER itemFolder ON itemFolder.FOLDER_ID = item.FOLDER_ID'+CHAR(13)+CHAR(10)+
            'LEFT OUTER JOIN dbo.VW_DIM_ITEM relatedItem ON relatedItem.ITEM_BIZ_URN = a.INT_VAL_1 AND relatedItem.ITEM_TYPE_URN = a.INT_VAL_3 AND relatedItem.LATEST = 1'+CHAR(13)+CHAR(10)+
            'LEFT OUTER JOIN dbo.TB_SEC_FOLDER relatedItemFolder ON relatedItemFolder.FOLDER_ID = relatedItem.FOLDER_ID'+CHAR(13)+CHAR(10)+
            'WHERE (atype.INTERNAL_NAME LIKE ''AT\_DIMENSION\_%'' ESCAPE ''\'' OR atype.INTERNAL_NAME LIKE ''AT\_MEMBER\_%''  ESCAPE ''\'')'+CHAR(13)+CHAR(10)+
            'AND EVENT_UTC_DATE_TIME BETWEEN @DateFrom AND @DateTo'+CHAR(13)+CHAR(10)+
            CASE WHEN @Outcome IS NULL THEN '' ELSE  'AND a.[EVENT_OUTCOME] = @Outcome' +CHAR(13)+CHAR(10) END +
            'AND item.FOLDER_ID IN (SELECT [GUID] FROM @FolderIds) AND item.ITEM_TYPE_ID IN (' + STUFF((SELECT ',' + CHAR(39) + CAST([GUID] AS VARCHAR(36)) + CHAR(39)
                                                                                                        FROM @ItemTypeIds
                                                                                                        FOR XML PATH(''), TYPE
                                                                                                        ).value('.', 'NVARCHAR(MAX)'), 1, 1, ''
                                                                                                       ) + ')'+CHAR(13)+CHAR(10)+
            ')'+CHAR(13)+CHAR(10)+
            'SELECT TOP (@PageSize)'+CHAR(13)+CHAR(10)+
            'EVENT_UTC_DATE_TIME, AUDIT_TYPE_ID, ITEM_URN, ITEM_NAME, ITEM_PATH, ITEM_TYPE_ID, '+CHAR(13)+CHAR(10)+
            'RELATED_ITEM_URN, RELATED_ITEM_NAME, RELATED_ITEM_PATH,RELATED_ITEM_TYPE_ID, '+CHAR(13)+CHAR(10)+
            'EQUIPMENT_NAME, [USER_NAME], EVENT_OUTCOME'+CHAR(13)+CHAR(10)+
            'FROM (SELECT ROW_NUMBER() OVER(ORDER BY '+@SortColumn+' ASC) AS [ROW_NUM], *'+CHAR(13)+CHAR(10)+
            '      FROM ProvisioningAuditData) q'+CHAR(13)+CHAR(10)+
            'WHERE q.ROW_NUM BETWEEN (@Page - 1) * @PageSize + 1 AND @Page * @PageSize'+CHAR(13)+CHAR(10)+
            'ORDER BY q.ROW_NUM ASC'+CHAR(13)+CHAR(10)+
            'OPTION (RECOMPILE);';
            -- OPTION (RECOMPILE) make sure parameter sniffing doesn't cause all audit partitions to be hit

        -- execute query                        
        EXEC sp_executesql @Sql, N'@FolderIds AS dbo.GuidTableType READONLY, @DateFrom AS DATETIME, @DateTo AS DATETIME, @Outcome AS CHAR(1) = NULL, @Page AS INTEGER, @PageSize AS INTEGER', 
        @FolderIds, @DateFrom, @DateTo, @Outcome, @Page, @PageSize;

        IF @InitialTransactionCount = 0 
        BEGIN 
           COMMIT TRANSACTION ProvAuditTransaction;
        END;
        ELSE BEGIN 
            WHILE @@TRANCOUNT > @InitialTransactionCount
            BEGIN 
                COMMIT TRANSACTION;
            END;
        END;
    END TRY
    BEGIN CATCH;
        SELECT @ReturnCode = CASE WHEN @ReturnCode <> -1 THEN @@ERROR ELSE @ReturnCode END, @ErrorMessage = ERROR_MESSAGE();
        SET @ErrorMessage = OBJECT_NAME(@@PROCID) + ' ['+@ErrorMessage+']';
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
        END;
        RAISERROR(@ErrorMessage, 16, 1) WITH LOG;
    END CATCH;
    RETURN @ReturnCode;
END;
GO
GRANT EXECUTE
	ON [dbo].[ap_adm01_get_provisioning_audits]
	TO [portalapp_role]
GO
