SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_FCT_CHAT_ACTIVITY_DETAIL_CUBE]
AS
SELECT  [PARTITION_URN],
        [CLUSTER_RESOURCE_URN],
        [ACTIVITY_ID],
        [ACTIVITY_STATE],
        [CASE_ID],
        [CASE_STATE],
        [CASE_SEVERITY],
        [TENANT_URN],
        [ENTRY_POINT_URN],
        [CUSTOMER_URN],
        [AGENT_URN],
        [PERSON_URN],
        [QUEUE_URN],
        [AGENT_TEAM_URN],
        [SKILLGROUP_URN],
        atc.[ACTIVITY_TYPE_CODE_URN],
        [ACTIVITY_SUB_TYPE_CODE_URN],
        [ACTIVITY_ORIGIN],
        [CASE_URN],
        [MANAGER_AGENT_URN],
        [CHAT_REFERRER_NAME_URN],
        [CHAT_REFERRER_URL_URN],
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
        CAST([ABANDONED_CNTR] AS BIGINT) AS [Abandoned Counter],
        CAST([ASSIGNED_DURATION] AS BIGINT) AS [Assigned Duration],
        CAST([ASSIGNED_TO_USER_CNTR] AS BIGINT) AS [Assigned to User Counter],
        CAST([CHAT_DURATION] AS BIGINT) AS [Chat Duration],
        CAST([COMPLETED_CNTR] AS BIGINT) AS [Completed Counter],
        CAST([EXISTING_CASE_CNTR] AS BIGINT) AS [Existing Case Counter],
        CAST([FIRST_SERVICED_CNTR] AS BIGINT) AS [First Serviced Counter],
        CAST([FOLLOWUP_EMAIL_CNTR] AS BIGINT) AS [Followup Email Counter],
        CAST([NEW_CASE_CNTR] AS BIGINT) AS [New Case Counter],
        CAST([PULLED_BY_USER_CNTR] AS BIGINT) AS [Pulled by User Counter],
        CAST([SERVICED_CNTR] AS BIGINT) AS [Serviced Counter],
        CAST([UNASSIGNED_FROM_USER_CNTR] AS BIGINT) AS [Unassigned from User Counter],
        CAST([WAIT_ABANDONED_TIME] AS BIGINT) AS [Wait Abandoned Time],
        CAST([WAIT_SERVICED_TIME] AS BIGINT) AS [Wait Serviced Time],
        CAST([WORK_TIME] AS BIGINT) AS [Work Time],
        CAST([WRAP_TIME] AS BIGINT) AS [Wrap Time],
        CAST([AGENT_DURATION] AS BIGINT) AS [Agent Duration],
        CAST([HANDLED] AS BIGINT) AS [Handled],
        CAST([INCOMING_QUEUE] AS BIGINT) AS [Incoming Queue],
        CAST([INCOMING_WAIT_SERVICED_TIME] AS BIGINT) AS [Incoming Wait Serviced Time],
        CAST([WORK_STATE_TIME] AS BIGINT) AS [Work State Time],
        CAST([WRAP_STATE_TIME] AS BIGINT) AS [Wrap State Time],
        CAST([CONFERENCE_IN_CNTR] AS BIGINT) AS [Conference In Counter],
        CAST([AUTO_COMPLETED_CNTR] AS BIGINT) AS [Auto Completed Counter],
        CAST([COMPLETED_BY_AGENT_CNTR] AS BIGINT) AS [Completed By Agent Counter],
        CAST([COMPLETED_BY_ERROR_CNTR] AS BIGINT) AS [Completed By Error Counter],
        CAST([COMPLETED_BY_OTHER_USER_CNTR] AS BIGINT) AS [Completed By Other User Counter],
        CAST([ABANDONED_MET_SLA] AS BIGINT) AS [Abandoned Met SLA Counter],
        CAST([ABANDONED_NOT_MET_SLA] AS BIGINT) AS [Abandoned Not Met SLA Counter],
        CAST([SERVICED_MET_SLA] AS BIGINT) AS [Serviced Met SLA Counter],
        CAST([SERVICED_NOT_MET_SLA] AS BIGINT) AS [Serviced Not Met SLA Counter],
        CAST([INCOMING_SERVICED_MET_SLA] AS BIGINT) AS [Incoming Serviced Met SLA Counter],
        CAST([INCOMING_SERVICED_NOT_MET_SLA] AS BIGINT) AS [Incoming Serviced Not Met SLA Counter],
        CAST([ABANDONED_AGENT_CNTR] AS BIGINT) AS [Abandoned Agent Counter],
        CAST([ABANDONED_QUEUE_CNTR] AS BIGINT) AS [Abandoned Queue Counter],
        CAST([INCOMING_ABANDONED_CNTR] AS BIGINT) AS [Incoming Abandoned Counter],
        CAST([INCOMING_ABANDONED_AGENT_CNTR] AS BIGINT) AS [Incoming Abandoned Agent Counter],
        CAST([INCOMING_ABANDONED_QUEUE_CNTR] AS BIGINT) AS [Incoming Abandoned Queue Counter],
        CAST([INCOMING_WAIT_ABANDONED_TIME] AS BIGINT) AS [Incoming Wait Abandoned Time],
        CAST([VA_SELF_SERVED_CNTR] AS BIGINT) AS [VA Self Served Counter],
        CAST([INCOMING_ABANDONED_SLA_MET_CNTR] AS BIGINT) AS [Incoming Abandoned Sla Met Counter],
        CAST([INCOMING_ABANDONED_SLA_NOT_MET_CNTR] AS BIGINT) AS [Incoming Abandoned Sla Not Met Counter],
        [PARTITION_ID],
        [Row Count],
       
        -- Custom Dimension columns
        [CUSTOM_DIMENSION_0] AS [CUSTOM_DIMENSION_0],
        [CUSTOM_DIMENSION_1] AS [CUSTOM_DIMENSION_1],
        [CUSTOM_DIMENSION_2] AS [CUSTOM_DIMENSION_2],
        [CUSTOM_DIMENSION_3] AS [CUSTOM_DIMENSION_3],
        [CUSTOM_DIMENSION_4] AS [CUSTOM_DIMENSION_4],
        [CUSTOM_DIMENSION_5] AS [CUSTOM_DIMENSION_5],
        [CUSTOM_DIMENSION_6] AS [CUSTOM_DIMENSION_6],
        [CUSTOM_DIMENSION_7] AS [CUSTOM_DIMENSION_7],
        [CUSTOM_DIMENSION_8] AS [CUSTOM_DIMENSION_8],
        [CUSTOM_DIMENSION_9] AS [CUSTOM_DIMENSION_9],
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
FROM    [dbo].[VW_FCT_CHAT_ACTIVITY_DETAIL] x
INNER JOIN [dbo].[VW_DIM_TIME_STD_CUBE] tt ON x.[TIME_UTC_URN] = tt.[TIME_URN]
INNER JOIN [dbo].[TS_ADM_TIME_ZONE_DATA] tzd ON tzd.[DATE_UTC_URN] = x.[DATE_UTC_URN]
                                                AND tzd.[TIME_UTC_URN] = tt.[QUARTER_HOUR_URN]
CROSS APPLY ( SELECT TOP 1
                        c.[ITEM_BIZ_URN] AS [ACTIVITY_TYPE_CODE_URN]
              FROM      [dbo].[TB_DIM_CODE_GROUP] AS cg
              INNER JOIN [dbo].[TB_DIM_CODE_CODE_GROUP_MEMBER] AS m ON m.[PARENT_ITEM_BIZ_URN] = cg.[ITEM_BIZ_URN]
              INNER JOIN [dbo].[TB_DIM_CODE] AS c ON c.[ITEM_BIZ_URN] = m.[CHILD_ITEM_BIZ_URN]
              WHERE     cg.[INTERNAL_NAME] = 'CG_ACTIVITY_TYPE'
                        AND UPPER(c.[INTERNAL_NAME]) = 'CHAT'
              ORDER BY c.[ITEM_URN]
            ) atc;
GO
GRANT SELECT
	ON [dbo].[VW_FCT_CHAT_ACTIVITY_DETAIL_CUBE]
	TO [portalapp_role]
GO
