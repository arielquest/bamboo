SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_FCT_VA3_SESSION_CUBE]
AS 
    SELECT  [x].[PARTITION_URN],
            [x].[CLUSTER_RESOURCE_URN],
            [x].[SESSION_ID],
            [x].[TENANT_URN],
            [x].[VA_ASSISTANT_URN],
            [x].[VA_CHANNEL_URN],
            [x].[CUSTOMER_URN],
            [x].[LANGUAGE_URN],
            [x].[SESSION_LABEL_URN],

            [x].[DATE_UTC_URN],
            [x].[TIME_UTC_URN],
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

            CAST([x].[ABANDONED_SESSION] AS BIGINT) AS [Abandoned Session],
            CAST([x].[ACTIVE_SESSION] AS BIGINT) AS [Active Session],
            CAST([x].[CURIOSITY_CLICK] AS BIGINT) AS [Curiosity Click],
            CAST([x].[DURATION] AS BIGINT) AS [Duration],
            CAST([x].[ESCALATED_SESSION] AS BIGINT) AS [Escalated Session],
            CAST([x].[EXCHANGES] AS BIGINT) AS [Exchanges],
            CAST([x].[QUALITY_SESSION] AS BIGINT) AS [Quality Session],
            CAST([x].[SELF_SERVED_SESSION] AS BIGINT) AS [Self Served Session],
            CAST([x].[SESSIONS] AS BIGINT) AS [Sessions],
            CAST([x].[SESSION_WITH_CHAT] AS BIGINT) AS [Session With Chat],
            CAST([x].[WARM_XFERRED_SESSION] AS BIGINT) AS [Warm Xferred Session],
            
            CASE WHEN [x].[PARTITION_GLOBAL_URN] = ISNULL([Unique].[PARTITION_GLOBAL_URN], 0) THEN 1 ELSE 0 END AS [Unique Session Quarter Hour],
            CASE WHEN [x].[PARTITION_GLOBAL_URN] = ISNULL([Unique].[PARTITION_GLOBAL_URN], 0) AND [x].[ABANDONED_SESSION] = 1 THEN 1 ELSE 0 END AS [Unique Abandoned Quarter Hour],
            CASE WHEN [x].[PARTITION_GLOBAL_URN] = ISNULL([Unique].[PARTITION_GLOBAL_URN], 0) AND [x].[ESCALATED_SESSION] = 1 THEN 1 ELSE 0 END AS [Unique Escalated Quarter Hour],
            CASE WHEN [x].[PARTITION_GLOBAL_URN] = ISNULL([Unique].[PARTITION_GLOBAL_URN], 0) AND [x].[QUALITY_SESSION] = 1 THEN 1 ELSE 0 END AS [Unique Quality Quarter Hour],
            CASE WHEN [x].[PARTITION_GLOBAL_URN] = ISNULL([Unique].[PARTITION_GLOBAL_URN], 0) AND [x].[SELF_SERVED_SESSION] = 1 THEN 1 ELSE 0 END AS [Unique Self Served Quarter Hour],
            CASE WHEN [x].[PARTITION_GLOBAL_URN] = ISNULL([Unique].[PARTITION_GLOBAL_URN], 0) AND [x].[SESSION_WITH_CHAT] = 1 THEN 1 ELSE 0 END AS [Unique Session With Chat Quarter Hour],
            CASE WHEN [x].[PARTITION_GLOBAL_URN] = ISNULL([Unique].[PARTITION_GLOBAL_URN], 0) AND [x].[WARM_XFERRED_SESSION] = 1 THEN 1 ELSE 0 END AS [Unique Warm Xferred Quarter Hour],

            [x].[PARTITION_ID],
            [x].[Row Count]
    FROM    [dbo].[VW_FCT_VA3_SESSION] [x]
    INNER JOIN [dbo].[VW_DIM_TIME_STD_CUBE] [tt] ON [x].[TIME_UTC_URN] = [tt].[TIME_URN]
    INNER JOIN [dbo].[TS_ADM_TIME_ZONE_DATA] [tzd] ON [tzd].[DATE_UTC_URN] = [x].[DATE_UTC_URN]
                                                    AND [tzd].[TIME_UTC_URN] = [tt].[QUARTER_HOUR_URN]
    OUTER APPLY (SELECT TOP 1 [active].[PARTITION_GLOBAL_URN]
        FROM [dbo].[VW_FCT_VA3_SESSION] [active]  
        INNER JOIN [dbo].[VW_DIM_TIME_STD_CUBE] [time] ON [active].[TIME_UTC_URN] = [time].[TIME_URN]
        WHERE [active].[CLUSTER_RESOURCE_URN] = [X].[CLUSTER_RESOURCE_URN]    
        AND [active].[CUSTOMER_URN] = [x].[CUSTOMER_URN] 
        AND [active].[DATE_UTC_URN] = [x].[DATE_UTC_URN]
        AND [time].[QUARTER_HOUR_URN] = [tt].[QUARTER_HOUR_URN]   
        AND [active].[ACTIVE_SESSION] = 1   
        ORDER BY [active].[DATE_TIME_UTC]) [Unique];
GO
GRANT SELECT
	ON [dbo].[VW_FCT_VA3_SESSION_CUBE]
	TO [portalapp_role]
GO
