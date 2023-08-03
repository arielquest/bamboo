SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_FCT_CALLTRACK_ACTIVITY_DETAIL_CUBE]
AS
    SELECT  [x].[PARTITION_URN],
            [x].[PARTITION_ID],
            [x].[CLUSTER_RESOURCE_URN],
            [x].[CASE_URN],
            [x].[CUSTOMER_URN],
            [x].[AGENT_URN],
            [x].[MANAGER_AGENT_URN],
            [x].[AGENT_TEAM_URN],
            [x].[PERSON_URN],
            [x].[QUEUE_URN],
            [x].[TENANT_URN],
            atc.[ACTIVITY_TYPE_CODE_URN],
            [x].[ACTIVITY_SUB_TYPE_CODE_URN],
            [x].[DATE_UTC_URN],
            [x].[TIME_UTC_URN],
            [x].[ACTIVITY_DURATION_BIZCAL],

            [tzd].[OLAP_DATETIME_UTC] AS [DATETIME_UTC_URN],
            [tzd].[OLAP_DATETIME_TIMEZONE_0] AS [TIME_ZONE_0_URN],
            [tzd].[OLAP_DATETIME_TIMEZONE_1] AS [TIME_ZONE_1_URN],
            [tzd].[OLAP_DATETIME_TIMEZONE_2] AS [TIME_ZONE_2_URN],
            [tzd].[OLAP_DATETIME_TIMEZONE_3] AS [TIME_ZONE_3_URN],
            [tzd].[OLAP_DATETIME_TIMEZONE_4] AS [TIME_ZONE_4_URN],
            [tzd].[OLAP_DATETIME_TIMEZONE_5] AS [TIME_ZONE_5_URN],
            [tzd].[OLAP_DATETIME_TIMEZONE_6] AS [TIME_ZONE_6_URN],
            [tzd].[OLAP_DATETIME_TIMEZONE_7] AS [TIME_ZONE_7_URN],
            [tzd].[OLAP_DATETIME_TIMEZONE_8] AS [TIME_ZONE_8_URN],
            [tzd].[OLAP_DATETIME_TIMEZONE_9] AS [TIME_ZONE_9_URN],
            [tzd].[OLAP_DATETIME_TIMEZONE_10] AS [TIME_ZONE_10_URN],
            [tzd].[OLAP_DATETIME_TIMEZONE_11] AS [TIME_ZONE_11_URN],
            [tzd].[OLAP_DATETIME_TIMEZONE_12] AS [TIME_ZONE_12_URN],
            [tzd].[OLAP_DATETIME_TIMEZONE_13] AS [TIME_ZONE_13_URN],
            [tzd].[OLAP_DATETIME_TIMEZONE_14] AS [TIME_ZONE_14_URN],
            [tzd].[OLAP_DATETIME_TIMEZONE_15] AS [TIME_ZONE_15_URN],
            [tzd].[OLAP_DATETIME_TIMEZONE_16] AS [TIME_ZONE_16_URN],
            [tzd].[OLAP_DATETIME_TIMEZONE_17] AS [TIME_ZONE_17_URN],
            [tzd].[OLAP_DATETIME_TIMEZONE_18] AS [TIME_ZONE_18_URN],
            [tzd].[OLAP_DATETIME_TIMEZONE_19] AS [TIME_ZONE_19_URN],

            CAST([x].[ACTIVITY_DURATION] AS BIGINT) AS [Activity Duration],
            CAST([x].[ASSIGNED_TO_SYSTEM_CNTR] AS BIGINT) AS [Assigned To System Counter],
            CAST([x].[COMPLETED_CNTR] AS BIGINT) AS [Completed Counter],
            CAST([x].[COMPLETED_MET_SLA_CNTR] AS BIGINT) AS [Completed Met SLA Counter],
            CAST([x].[COMPLETED_NOT_MET_SLA_CNTR] AS BIGINT) AS [Completed Not Met SLA Counter],
            CAST([x].[COMPLETED_NO_SLA_CNTR] AS BIGINT) AS [Completed No SLA Counter],
            CAST([x].[EXISTING_CALLS_IN_CNTR] AS BIGINT) AS [Existing Calls In Counter],
            CAST([x].[EXISTING_CALLS_OUT_CNTR] AS BIGINT) AS [Existing Calls Out Counter],
            CAST([x].[HANDLE_TIME] AS BIGINT) AS [Handle Time],
            CAST([x].[LINKED_TO_CUSTOMER_CNTR] AS BIGINT) AS [Linked To Customer Counter],
            CAST([x].[NEW_CALLS_IN_CNTR] AS BIGINT) AS [New Calls In Counter],
            CAST([x].[NEW_CALLS_OUT_CNTR] AS BIGINT) AS [New Calls Out Counter],
            CAST([x].[TRANSCRIPT_SENT_CNTR] AS BIGINT) AS [Transcript Sent Counter],
            CAST([x].[WORK_STATE_TIME] AS BIGINT) AS [Work State Time],

            [x].[CUSTOM_DIMENSION_0] AS [CUSTOM_DIMENSION_0],
            [x].[CUSTOM_DIMENSION_1] AS [CUSTOM_DIMENSION_1],
            [x].[CUSTOM_DIMENSION_2] AS [CUSTOM_DIMENSION_2],
            [x].[CUSTOM_DIMENSION_3] AS [CUSTOM_DIMENSION_3],
            [x].[CUSTOM_DIMENSION_4] AS [CUSTOM_DIMENSION_4],
            [x].[CUSTOM_DIMENSION_5] AS [CUSTOM_DIMENSION_5],
            [x].[CUSTOM_DIMENSION_6] AS [CUSTOM_DIMENSION_6],
            [x].[CUSTOM_DIMENSION_7] AS [CUSTOM_DIMENSION_7],
            [x].[CUSTOM_DIMENSION_8] AS [CUSTOM_DIMENSION_8],
            [x].[CUSTOM_DIMENSION_9] AS [CUSTOM_DIMENSION_9],
            CAST([x].[CUSTOM_MEASURE_0] AS BIGINT) AS [Custom Measure 0],
            CAST([x].[CUSTOM_MEASURE_1] AS BIGINT) AS [Custom Measure 1],
            CAST([x].[CUSTOM_MEASURE_2] AS BIGINT) AS [Custom Measure 2],
            CAST([x].[CUSTOM_MEASURE_3] AS BIGINT) AS [Custom Measure 3],
            CAST([x].[CUSTOM_MEASURE_4] AS BIGINT) AS [Custom Measure 4],
            CAST([x].[CUSTOM_MEASURE_5] AS BIGINT) AS [Custom Measure 5],
            CAST([x].[CUSTOM_MEASURE_6] AS BIGINT) AS [Custom Measure 6],
            CAST([x].[CUSTOM_MEASURE_7] AS BIGINT) AS [Custom Measure 7],
            CAST([x].[CUSTOM_MEASURE_8] AS BIGINT) AS [Custom Measure 8],
            CAST([x].[CUSTOM_MEASURE_9] AS BIGINT) AS [Custom Measure 9],
            [x].[Row Count]
    FROM    [dbo].[VW_FCT_CALLTRACK_ACTIVITY_DETAIL] [x]
    INNER JOIN [dbo].[VW_DIM_TIME_STD_CUBE] [tt] ON [x].[TIME_UTC_URN] = [tt].[TIME_URN]
    INNER JOIN [dbo].[TS_ADM_TIME_ZONE_DATA] [tzd] ON [tzd].[DATE_UTC_URN] = [x].[DATE_UTC_URN]
                                                    AND [tzd].[TIME_UTC_URN] = [tt].[QUARTER_HOUR_URN]
    CROSS APPLY ( SELECT TOP 1
                            c.[ITEM_BIZ_URN] AS [ACTIVITY_TYPE_CODE_URN]
                  FROM      [dbo].[TB_DIM_CODE_GROUP] AS cg
                  INNER JOIN [dbo].[TB_DIM_CODE_CODE_GROUP_MEMBER] AS m ON m.[PARENT_ITEM_BIZ_URN] = cg.[ITEM_BIZ_URN]
                  INNER JOIN [dbo].[TB_DIM_CODE] AS c ON c.[ITEM_BIZ_URN] = m.[CHILD_ITEM_BIZ_URN]
                  WHERE     cg.[INTERNAL_NAME] = 'CG_ACTIVITY_TYPE'
                            AND UPPER(c.[INTERNAL_NAME]) = 'CALL_TRACK'
                  ORDER BY c.[ITEM_URN]
                ) atc;
GO
GRANT SELECT
	ON [dbo].[VW_FCT_CALLTRACK_ACTIVITY_DETAIL_CUBE]
	TO [portalapp_role]
GO
