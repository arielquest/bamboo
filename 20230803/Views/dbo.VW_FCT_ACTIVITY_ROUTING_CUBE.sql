SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_FCT_ACTIVITY_ROUTING_CUBE]
AS
   SELECT   [PARTITION_URN],
            [CLUSTER_RESOURCE_URN],
            [ACTIVITY_SUB_TYPE_CODE_URN], 
            [ACTIVITY_STATE],
            [CASE_STATE],            
            [IS_ESCALATED],
            [UNDELIVERABLE_MAIL],            
            [CASE_SEVERITY], -- CHECK
            [TENANT_URN],
            [ACTIVITY_TYPE_CODE_URN],
            [CUSTOMER_URN],
            [AGENT_URN],
            [PERSON_URN],
            [AGENT_TEAM_URN],
            [ACTOR_AGENT_URN],
            [ACTOR_PERSON_URN],
            [ACTOR_AGENT_TEAM_URN],
            [QUEUE_URN],
            [SKILLGROUP_URN],
            [REASON_CODE_URN],
            [CASE_URN],
            [ENTRY_POINT_URN],
            [ALIAS_URN],
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
                        
            CAST([EXISTING_IN_QUEUE_CASE_CNTR] AS BIGINT) AS [Exists in Queue],            
            CAST([MANUAL_XFER_FROM_DEPT_CNTR] AS BIGINT) AS [Manual XFER from Department],
            CAST([MANUAL_XFER_FROM_QUEUE_CNTR] AS BIGINT) AS [Manual XFER from Queue],
            CAST([MANUAL_XFER_FROM_USER_CNTR] AS BIGINT) AS [Manual XFER from User],
            CAST([MANUAL_XFER_TO_DEPT_CNTR] AS BIGINT) AS [Manual XFER to Department],
            CAST([MANUAL_XFER_TO_QUEUE_CNTR] AS BIGINT) AS [Manual XFER to Queue],
            CAST([MANUAL_XFER_TO_USER_CNTR] AS BIGINT) AS [Manual XFER to User],            
            CAST([NEW_IN_QUEUE_CASE_CNTR] AS BIGINT) AS [New in Queue],            
            CAST([OBJECT_OPERATION] AS BIGINT) AS [Object Operation],            
            CAST([PULLED_BY_USER_CNTR] AS BIGINT) AS [Pulled by User],
            CAST([PULLED_FROM_USER_CNTR] AS BIGINT) AS [Pulled From User],
            CAST([PUSHED_TO_USER_CNTR] AS BIGINT) AS [Pushed to User],
            CAST([PUSHEDBACK_TO_QUEUE_CNTR] AS BIGINT) AS [Pushed Back to Queue],            
            CAST([WORKFLOW_XFER_FROM_DEPT_CNTR] AS BIGINT) AS [Workflow XFER from Department],
            CAST([WORKFLOW_XFER_FROM_QUEUE_CNTR] AS BIGINT) AS [Workflow XFER from Queue],
            CAST([WORKFLOW_XFER_FROM_USER_CNTR] AS BIGINT) AS [Workflow XFER from User],
            CAST([WORKFLOW_XFER_TO_DEPT_CNTR] AS BIGINT) AS [Workflow XFER to Department],
            CAST([WORKFLOW_XFER_TO_QUEUE_CNTR] AS BIGINT) AS [Workflow XFER to Queue],
            CAST([WORKFLOW_XFER_TO_USER_CNTR] AS BIGINT) AS [Workflow XFER to User],
            CAST([MANUAL_XFER_BACK_CNTR] AS BIGINT) AS [Manual XFER Back],
            CAST([WORKFLOW_XFER_BACK_CNTR] AS BIGINT) AS [Workflow XFER Back],
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
    FROM [dbo].[VW_FCT_ACTIVITY_ROUTING] x
    INNER JOIN [dbo].[VW_DIM_TIME_STD_CUBE] tt ON x.[TIME_UTC_URN] = tt.[TIME_URN]
    INNER JOIN [dbo].[TS_ADM_TIME_ZONE_DATA] tzd ON tzd.[DATE_UTC_URN] = x.[DATE_UTC_URN] AND tzd.[TIME_UTC_URN] = tt.[QUARTER_HOUR_URN];
GO
GRANT SELECT
	ON [dbo].[VW_FCT_ACTIVITY_ROUTING_CUBE]
	TO [portalapp_role]
GO