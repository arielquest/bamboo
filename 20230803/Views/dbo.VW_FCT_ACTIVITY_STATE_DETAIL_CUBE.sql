SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_FCT_ACTIVITY_STATE_DETAIL_CUBE]
AS
SELECT  [PARTITION_URN],
        [CLUSTER_RESOURCE_URN],
        [ACTIVITY_ID],
        [CASE_ID],
        [TENANT_URN],
        [ENTRY_POINT_URN],
        [ALIAS_URN],
        [CUSTOMER_URN],
        [AGENT_URN],
        [PERSON_URN],
        [QUEUE_URN],
        [AGENT_TEAM_URN],
        [SKILLGROUP_URN],
        [CASE_URN],
        [ACTIVITY_TYPE_CODE_URN],
        [ACTIVITY_SUB_TYPE_CODE_URN],
        [ACTIVITY_ORIGIN],
        [SCL_ADAPTER_URN],
        [SCL_SEARCH_URN],
        [SCL_ADAPTER_TYPE_CODE_URN], 
        [SCL_ADAPTER_TYPE_SUB_CODE_URN], 

        x.[DATE_UTC_URN],
        x.[TIME_UTC_URN],
        tzd.[OLAP_DATETIME_UTC] AS [DATETIME_UTC_URN],
        tzd.[OLAP_DATETIME_TIMEZONE_0] AS [TIME_ZONE_0_URN],
        tzd.[OLAP_DATETIME_TIMEZONE_1] AS [TIME_ZONE_1_URN],
        tzd.[OLAP_DATETIME_TIMEZONE_2] AS [TIME_ZONE_2_URN],
        tzd.[OLAP_DATETIME_TIMEZONE_3] AS [TIME_ZONE_3_URN],
        tzd.[OLAP_DATETIME_TIMEZONE_4] AS [TIME_ZONE_4_URN],
        tzd.[OLAP_DATETIME_TIMEZONE_5] AS [TIME_ZONE_5_URN],
        tzd.[OLAP_DATETIME_TIMEZONE_6] AS [TIME_ZONE_6_URN],
        tzd.[OLAP_DATETIME_TIMEZONE_7] AS [TIME_ZONE_7_URN],
        tzd.[OLAP_DATETIME_TIMEZONE_8] AS [TIME_ZONE_8_URN],
        tzd.[OLAP_DATETIME_TIMEZONE_9] AS [TIME_ZONE_9_URN],
        tzd.[OLAP_DATETIME_TIMEZONE_10] AS [TIME_ZONE_10_URN],
        tzd.[OLAP_DATETIME_TIMEZONE_11] AS [TIME_ZONE_11_URN],
        tzd.[OLAP_DATETIME_TIMEZONE_12] AS [TIME_ZONE_12_URN],
        tzd.[OLAP_DATETIME_TIMEZONE_13] AS [TIME_ZONE_13_URN],
        tzd.[OLAP_DATETIME_TIMEZONE_14] AS [TIME_ZONE_14_URN],
        tzd.[OLAP_DATETIME_TIMEZONE_15] AS [TIME_ZONE_15_URN],
        tzd.[OLAP_DATETIME_TIMEZONE_16] AS [TIME_ZONE_16_URN],
        tzd.[OLAP_DATETIME_TIMEZONE_17] AS [TIME_ZONE_17_URN],
        tzd.[OLAP_DATETIME_TIMEZONE_18] AS [TIME_ZONE_18_URN],
        tzd.[OLAP_DATETIME_TIMEZONE_19] AS [TIME_ZONE_19_URN],

        CAST([CALLTRACK_HOLD_STATE_TIME] AS BIGINT) AS [Calltrack Hold State Time],
        CAST([CALLTRACK_WORK_STATE_TIME] AS BIGINT) AS [Calltrack Work State Time],
        CAST([CALLTRACK_WRAP_STATE_TIME] AS BIGINT) AS [Calltrack Wrap State Time],
        CAST([CHAT_WORK_STATE_TIME] AS BIGINT) AS [Chat Work State Time],
        CAST([CHAT_WRAP_STATE_TIME] AS BIGINT) AS [Chat Wrap State Time],
        CAST([EMAIL_WORK_STATE_TIME] AS BIGINT) AS [Email Work State Time],
        CAST([SOCIAL_WORK_STATE_TIME] AS BIGINT) AS [Social Work State Time],
        CAST([TASKS_WORK_STATE_TIME] AS BIGINT) AS [Tasks Work State Time],
        CAST([VCHAT_WORK_STATE_TIME] AS BIGINT) AS [VChat Work State Time],
        CAST([VCHAT_WRAP_STATE_TIME] AS BIGINT) AS [VChat Wrap State Time],

        [PARTITION_ID],
        [Row Count],

        -- Custom Dimension columns
        [CUSTOM_ATTRIBUTE_0] AS [CUSTOM_ATTRIBUTE_0],
        [CUSTOM_ATTRIBUTE_1] AS [CUSTOM_ATTRIBUTE_1],
        [CUSTOM_ATTRIBUTE_2] AS [CUSTOM_ATTRIBUTE_2],
        [CUSTOM_ATTRIBUTE_3] AS [CUSTOM_ATTRIBUTE_3],
        [CUSTOM_ATTRIBUTE_4] AS [CUSTOM_ATTRIBUTE_4],
        [CUSTOM_ATTRIBUTE_5] AS [CUSTOM_ATTRIBUTE_5],
        [CUSTOM_ATTRIBUTE_6] AS [CUSTOM_ATTRIBUTE_6],
        [CUSTOM_ATTRIBUTE_7] AS [CUSTOM_ATTRIBUTE_7],
        [CUSTOM_ATTRIBUTE_8] AS [CUSTOM_ATTRIBUTE_8],
        [CUSTOM_ATTRIBUTE_9] AS [CUSTOM_ATTRIBUTE_9],
        CAST([CUSTOM_MEASURE_0] AS BIGINT) AS [Custom Measure 0],
        CAST([CUSTOM_MEASURE_1] AS BIGINT) AS [Custom Measure 1],
        CAST([CUSTOM_MEASURE_2] AS BIGINT) AS [Custom Measure 2],
        CAST([CUSTOM_MEASURE_3] AS BIGINT) AS [Custom Measure 3],
        CAST([CUSTOM_MEASURE_4] AS BIGINT) AS [Custom Measure 4],
        CAST([CUSTOM_MEASURE_5] AS BIGINT) AS [Custom Measure 5],
        CAST([CUSTOM_MEASURE_6] AS BIGINT) AS [Custom Measure 6],
        CAST([CUSTOM_MEASURE_7] AS BIGINT) AS [Custom Measure 7],
        CAST([CUSTOM_MEASURE_8] AS BIGINT) AS [Custom Measure 8],
        CAST([CUSTOM_MEASURE_9] AS BIGINT) AS [Custom Measure 9]
    FROM [dbo].[VW_FCT_ACTIVITY_STATE_DETAIL] x
    INNER JOIN [dbo].[VW_DIM_TIME_STD_CUBE] tt ON x.[TIME_UTC_URN] = tt.[TIME_URN]
    INNER JOIN [dbo].[TS_ADM_TIME_ZONE_DATA] tzd ON tzd.[DATE_UTC_URN] = x.[DATE_UTC_URN] AND tzd.[TIME_UTC_URN] = tt.[QUARTER_HOUR_URN];
GO
GRANT SELECT
	ON [dbo].[VW_FCT_ACTIVITY_STATE_DETAIL_CUBE]
	TO [portalapp_role]
GO