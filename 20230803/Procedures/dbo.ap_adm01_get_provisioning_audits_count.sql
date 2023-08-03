SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_adm01_get_provisioning_audits_count]
(
    @FolderIds dbo.GuidTableType READONLY,
    @ItemTypeIds dbo.GuidTableType READONLY,
    @DateFrom DATETIME,
    @DateTo DATETIME,
    @Outcome CHAR(1) = NULL
) AS
BEGIN 
    DECLARE @SQL NVARCHAR(MAX);

    IF @Outcome IS NULL
    BEGIN 
        SELECT @SQL = 'SELECT SUM(theCOUNT_BIG) AS [COUNT_BIG]' + CHAR(13) + CHAR(10) + 
                      'FROM (SELECT COUNT_BIG(*)' + CHAR(13) + CHAR(10) + SPACE(6) +
                            'FROM (SELECT ITEM_BIZ_URN, LATEST, ITEM_TYPE_URN' + CHAR(13) + CHAR(10) + SPACE(12) +
                            'FROM dbo.VW_DIM_ITEM' + CHAR(13) + CHAR(10) + SPACE(12) +
                            'WHERE ITEM_TYPE_ID IN ('+ STUFF((SELECT ',' + CHAR(39) + CAST([GUID] AS VARCHAR(36)) + CHAR(39)
                                                              FROM @ItemTypeIds
                                                              FOR XML PATH(''), TYPE).value('.','NVARCHAR(MAX)')
                                                              ,1,1,'') + ') ' + 
                            'AND FOLDER_ID IN (SELECT [GUID] FROM @FolderIds)' + CHAR(13) + CHAR(10) + SPACE(12) +
                            'AND LATEST = 1' + CHAR(13) + CHAR(10) + SPACE(12) +
                            ') items' + CHAR(13) + CHAR(10) + SPACE(6) +
                            'INNER JOIN dbo.VW_FCT_AUDIT audit ON (items.ITEM_TYPE_URN = audit.INT_VAL_3 AND items.ITEM_BIZ_URN = audit.INT_VAL_1)' + CHAR(13) + CHAR(10) + SPACE(6) +
                            'INNER JOIN dbo.TE_ADM_AUDIT_TYPE auditType ON audit.AUDIT_TYPE_ID = auditType.AUDIT_TYPE_ID' + CHAR(13) + CHAR(10) + SPACE(6) +
                            ' WHERE (auditType.INTERNAL_NAME LIKE ' + CHAR(39) + 'AT\_DIMENSION\_%' + CHAR(39) + ' ESCAPE '+CHAR(39)+'\'+CHAR(39)+ 
                            ' OR auditType.INTERNAL_NAME LIKE ' + CHAR(39) + 'AT\_MEMBER\_%' + CHAR(39) + ' ESCAPE '+CHAR(39)+'\'+CHAR(39)+') AND' + CHAR(13) + CHAR(10) + SPACE(6) + 
                            'audit.EVENT_UTC_DATE_TIME BETWEEN @DateFrom AND @DateTo' + CHAR(13) + CHAR(10) + SPACE(6) + 
                            'UNION ALL' + CHAR(13) + CHAR(10) + SPACE(6) + 
                            'SELECT COUNT_BIG(*)' + CHAR(13) + CHAR(10) + SPACE(6) +
                            'FROM (SELECT ITEM_BIZ_URN, LATEST, ITEM_TYPE_URN' + CHAR(13) + CHAR(10) + SPACE(12) +
                            'FROM dbo.VW_DIM_ITEM' + CHAR(13) + CHAR(10) + SPACE(12) +
                            'WHERE ITEM_TYPE_ID IN ('+ STUFF((SELECT ',' + CHAR(39) + CAST([GUID] AS VARCHAR(36)) + CHAR(39)
                                                              FROM @ItemTypeIds
                                                              FOR XML PATH(''), TYPE).value('.','NVARCHAR(MAX)')
                                                              ,1,1,'') + ') ' + 
                            'AND FOLDER_ID IN (SELECT [GUID] FROM @FolderIds)' + CHAR(13) + CHAR(10) + SPACE(12) +
                            'AND LATEST = 1' + CHAR(13) + CHAR(10) + SPACE(12) +
                            ') items' + CHAR(13) + CHAR(10) + SPACE(6) +
                            'INNER JOIN dbo.VW_FCT_AUDIT audit ON (items.ITEM_TYPE_URN = audit.INT_VAL_4 AND items.ITEM_BIZ_URN = audit.INT_VAL_2)' + CHAR(13) + CHAR(10) + SPACE(6) +
                            'INNER JOIN dbo.TE_ADM_AUDIT_TYPE auditType ON audit.AUDIT_TYPE_ID = auditType.AUDIT_TYPE_ID' + CHAR(13) + CHAR(10) + SPACE(6) +
                            ' WHERE (auditType.INTERNAL_NAME LIKE ' + CHAR(39) + 'AT\_DIMENSION\_%' + CHAR(39) + '  ESCAPE '+CHAR(39)+'\'+CHAR(39)+
                            ' OR auditType.INTERNAL_NAME LIKE ' + CHAR(39) + 'AT\_MEMBER\_%' + CHAR(39) + ' ESCAPE '+CHAR(39)+'\'+CHAR(39)+') AND' + CHAR(13) + CHAR(10) + SPACE(6) + 
                            'audit.EVENT_UTC_DATE_TIME BETWEEN @DateFrom AND @DateTo' + CHAR(13) + CHAR(10) + SPACE(6) +
                            ') a(theCOUNT_BIG);';
        EXECUTE sp_executesql @SQL, N'@FolderIds dbo.GuidTableType READONLY, @DateFrom DATETIME, @DateTo DATETIME', @FolderIds = @FolderIds, @DateFrom = @DateFrom, @DateTo = @DateTo;
    END;
    ELSE BEGIN 
        SELECT @SQL = 'SELECT SUM(theCOUNT_BIG) AS [COUNT_BIG]' + CHAR(13) + CHAR(10) + 
                      'FROM (SELECT COUNT_BIG(*)' + CHAR(13) + CHAR(10) + SPACE(6) +
                            'FROM (SELECT ITEM_BIZ_URN, LATEST, ITEM_TYPE_URN' + CHAR(13) + CHAR(10) + SPACE(12) +
                            'FROM dbo.VW_DIM_ITEM' + CHAR(13) + CHAR(10) + SPACE(12) +
                            'WHERE ITEM_TYPE_ID IN ('+ STUFF((SELECT ',' + CHAR(39) + CAST([GUID] AS VARCHAR(36)) + CHAR(39)
                                                              FROM @ItemTypeIds
                                                              FOR XML PATH(''), TYPE).value('.','NVARCHAR(MAX)')
                                                              ,1,1,'') + ') ' + 
                            'AND FOLDER_ID IN (SELECT [GUID] FROM @FolderIds)' + CHAR(13) + CHAR(10) + SPACE(12) +
                            'AND LATEST = 1' + CHAR(13) + CHAR(10) + SPACE(12) +
                            ') items' + CHAR(13) + CHAR(10) + SPACE(6) +
                            'INNER JOIN dbo.VW_FCT_AUDIT audit ON (items.ITEM_TYPE_URN = audit.INT_VAL_3 AND items.ITEM_BIZ_URN = audit.INT_VAL_1)' + CHAR(13) + CHAR(10) + SPACE(6) +
                            'INNER JOIN dbo.TE_ADM_AUDIT_TYPE auditType ON audit.AUDIT_TYPE_ID = auditType.AUDIT_TYPE_ID' + CHAR(13) + CHAR(10) + SPACE(6) +
                            ' WHERE (auditType.INTERNAL_NAME LIKE ' + CHAR(39) + 'AT\_DIMENSION\_%' + CHAR(39) + '  ESCAPE '+CHAR(39)+'\'+CHAR(39)+
                            ' OR auditType.INTERNAL_NAME LIKE ' + CHAR(39) + 'AT\_MEMBER\_%' + CHAR(39) + ' ESCAPE '+CHAR(39)+'\'+CHAR(39)+') AND' + CHAR(13) + CHAR(10) + SPACE(6) + 
                            'audit.EVENT_UTC_DATE_TIME BETWEEN @DateFrom AND @DateTo AND audit.EVENT_OUTCOME = @Outcome' + CHAR(13) + CHAR(10) + SPACE(6) + 
                            'UNION ALL' + CHAR(13) + CHAR(10) + SPACE(6) + 
                            'SELECT COUNT_BIG(*)' + CHAR(13) + CHAR(10) + SPACE(6) +
                            'FROM (SELECT ITEM_BIZ_URN, LATEST, ITEM_TYPE_URN' + CHAR(13) + CHAR(10) + SPACE(12) +
                            'FROM dbo.VW_DIM_ITEM' + CHAR(13) + CHAR(10) + SPACE(12) +
                            'WHERE ITEM_TYPE_ID IN ('+ STUFF((SELECT ',' + CHAR(39) + CAST([GUID] AS VARCHAR(36)) + CHAR(39)
                                                              FROM @ItemTypeIds
                                                              FOR XML PATH(''), TYPE).value('.','NVARCHAR(MAX)')
                                                              ,1,1,'') + ') ' + 
                            'AND FOLDER_ID IN (SELECT [GUID] FROM @FolderIds)' + CHAR(13) + CHAR(10) + SPACE(12) +
                            'AND LATEST = 1' + CHAR(13) + CHAR(10) + SPACE(12) +
                            ') items' + CHAR(13) + CHAR(10) + SPACE(6) +
                            'INNER JOIN dbo.VW_FCT_AUDIT audit ON (items.ITEM_TYPE_URN = audit.INT_VAL_4 AND items.ITEM_BIZ_URN = audit.INT_VAL_2)' + CHAR(13) + CHAR(10) + SPACE(6) +
                            'INNER JOIN dbo.TE_ADM_AUDIT_TYPE auditType ON audit.AUDIT_TYPE_ID = auditType.AUDIT_TYPE_ID' + CHAR(13) + CHAR(10) + SPACE(6) +
                            ' WHERE (auditType.INTERNAL_NAME LIKE ' + CHAR(39) + 'AT\_DIMENSION\_%' + CHAR(39) + '  ESCAPE '+CHAR(39)+'\'+CHAR(39)+
                            ' OR auditType.INTERNAL_NAME LIKE ' + CHAR(39) + 'AT\_MEMBER\_%' + CHAR(39) + ' ESCAPE '+CHAR(39)+'\'+CHAR(39)+') AND' + CHAR(13) + CHAR(10) + SPACE(6) + 
                            'audit.EVENT_UTC_DATE_TIME BETWEEN @DateFrom AND @DateTo AND audit.EVENT_OUTCOME = @Outcome' + CHAR(13) + CHAR(10) + SPACE(6) +
                            ') a(theCOUNT_BIG);';
        EXECUTE sp_executesql @SQL, N'@FolderIds dbo.GuidTableType READONLY, @DateFrom DATETIME, @DateTo DATETIME, @Outcome CHAR(1)', @FolderIds = @FolderIds, @DateFrom = @DateFrom, @DateTo = @DateTo, @Outcome = @Outcome;
    END;
END;
GO
GRANT EXECUTE
	ON [dbo].[ap_adm01_get_provisioning_audits_count]
	TO [portalapp_role]
GO
