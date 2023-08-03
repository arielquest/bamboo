SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_FCT_AUDIT]
AS
SELECT  PARTITION_GLOBAL_URN AS AUDIT_URN,
        SESSION_ID,
        AUDIT_TYPE_ID,
        EVENT_UTC_DATE_TIME,
        EVENT_UTC_DATE_URN,
        EVENT_UTC_TIME_URN,
        INT_VAL_1,
        INT_VAL_2,
        INT_VAL_3,
        INT_VAL_4,
        GUID_VAL_1,
        GUID_VAL_2,
        EVENT_DESCRIPTION,
        EVENT_RAW_DESCRIPTION,
        EVENT_OUTCOME,
        EVENT_DURATION,
        CONVERT(XML, FIELD_CHANGE_XML_DATA) AS FIELD_CHANGE_XML_DATA,
        CONVERT(XML, XML_DATA) AS XML_DATA,
        PARTITION_URN,
        PARTITION_ID
FROM    dbo.VW_PARTITIONED_FCT_SYSTEM_AUDIT_ARCHIVE
UNION ALL
SELECT  -AUDIT_URN AS AUDIT_URN,
        SESSION_ID,
        AUDIT_TYPE_ID,
        EVENT_UTC_DATE_TIME,
        EVENT_UTC_DATE_URN,
        EVENT_UTC_TIME_URN,
        INT_VAL_1,
        INT_VAL_2,
        INT_VAL_3,
        INT_VAL_4,
        GUID_VAL_1,
        GUID_VAL_2,
        EVENT_DESCRIPTION,
        EVENT_RAW_DESCRIPTION,
        EVENT_OUTCOME,
        EVENT_DURATION,
        CONVERT(XML, FIELD_CHANGE_XML_DATA) AS FIELD_CHANGE_XML_DATA,
        CONVERT(XML, XML_DATA) AS XML_DATA,
        -1 AS PARTITION_URN,
        0 AS PARTITION_ID
FROM    dbo.TB_FCT_SYSTEM_AUDIT;
GO
GRANT SELECT
	ON [dbo].[VW_FCT_AUDIT]
	TO [portalreporting_role]
GO
