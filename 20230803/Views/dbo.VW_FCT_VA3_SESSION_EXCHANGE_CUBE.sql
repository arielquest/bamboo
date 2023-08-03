SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_FCT_VA3_SESSION_EXCHANGE_CUBE]
AS 
    SELECT  [x].[PARTITION_URN],
            [x].[CLUSTER_RESOURCE_URN],
            [x].[SEQ_ID],
            [x].[SESSION_ID],
            [x].[TENANT_URN],
            [x].[VA_ASSISTANT_URN],
            [x].[VA_INTENT_URN],
            [x].[VA_CATEGORY_URN],
            [x].[VA_CLASSFIER_URN],
            [x].[VA_DOMAIN_URN],
            [x].[VA_SCORE_TYPE_URN],
            [x].[VA_URL_URN],
            [x].[VA_CHANNEL_URN],
            [x].[KB_ARTICLE_URN],
            [x].[LANGUAGE_URN],
            [x].[EXCHANGE_LABEL_URN],

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

            CAST([x].[ARTICLE_SHOWN] AS BIGINT) AS [Article Shown],
            CAST([x].[CHATS_ACCEPTED] AS BIGINT) AS [Chats Accepted],
            CAST([x].[CHATS_ELIGIBLE] AS BIGINT) AS [Chats Eligible],
            CAST([x].[CHATS_MISSED] AS BIGINT) AS [Chats Missed],
            CAST([x].[CHATS_OFF_HOURS] AS BIGINT) AS [Chats Off Hours],
            CAST([x].[CHATS_OFFERED] AS BIGINT) AS [Chats Offered],
            CAST([x].[CHATS_REJECTED] AS BIGINT) AS [Chats Rejected],     
            CAST([x].[ESCALATION_ACCEPTED] AS BIGINT) AS [Escalation Accepted],
            CAST([x].[ESCALATION_ELIGIBLE] AS BIGINT) AS [Escalation Eligible],
            CAST([x].[ESCALATION_MISSED] AS BIGINT) AS [Escalation Missed],
            CAST([x].[ESCALATION_OFF_HOURS] AS BIGINT) AS [Escalation Off Hours],
            CAST([x].[ESCALATION_OFFERED] AS BIGINT) AS [Escalation Offered],
            CAST([x].[ESCALATION_REJECTED] AS BIGINT) AS [Escalation Rejected],
            CAST([x].[EXCHANGE] AS BIGINT) AS [Exchange],
            CAST([x].[INTENT_IDENTIFIED] AS BIGINT) AS [Intent Identified],
            CAST([x].[URL_PUSHED] AS BIGINT) AS [Url Pushed],
            CAST([x].[WARM_XFER_ACCEPTED] AS BIGINT) AS [Warm Xfer Accepted],
            CAST([x].[WARM_XFER_ELIGIBLE] AS BIGINT) AS [Warm Xfer Eligible],
            CAST([x].[WARM_XFER_MISSED] AS BIGINT) AS [Warm Xfer Missed],
            CAST([x].[WARM_XFER_OFF_HOURS] AS BIGINT) AS [Warm Xfer Off Hours],
            CAST([x].[WARM_XFER_OFFERED] AS BIGINT) AS [Warm Xfer Offered],
            CAST([x].[WARM_XFER_REJECTED] AS BIGINT) AS [Warm Xfer Rejected],
            CAST(ISNULL([x].[SCORE], 0) AS FLOAT) AS [Score],
            
            [x].[PARTITION_ID],
            [x].[Row Count]
    FROM    [dbo].[VW_FCT_VA3_SESSION_EXCHANGE] [x]
    INNER JOIN [dbo].[VW_DIM_TIME_STD_CUBE] [tt] ON [x].[TIME_UTC_URN] = [tt].[TIME_URN]
    INNER JOIN [dbo].[TS_ADM_TIME_ZONE_DATA] [tzd] ON [tzd].[DATE_UTC_URN] = [x].[DATE_UTC_URN]
                                                    AND [tzd].[TIME_UTC_URN] = [tt].[QUARTER_HOUR_URN];
GO
GRANT SELECT
	ON [dbo].[VW_FCT_VA3_SESSION_EXCHANGE_CUBE]
	TO [portalapp_role]
GO
