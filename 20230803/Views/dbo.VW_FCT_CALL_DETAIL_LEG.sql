SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-------------------------------------------------------------------------------
--
-------------------------------------------------------------------------------
CREATE VIEW [dbo].[VW_FCT_CALL_DETAIL_LEG]
--WITH ENCRYPTION
AS
SELECT  [CALL_DETAIL_LEG_URN],
        [STARTDATE_URN],
        [STARTTIME_URN],
        [STARTDATE_UTC_URN],
        [STARTTIME_UTC_URN],
        [START_DATE_TIME],
        [START_UTC_TIMEZONE],
        [CALL_DETAIL_URN],
        [SEQUENCE_NUMBER],
        [DURATION_TIMEBAND_URN],
        [SEGMENT_TIME_TIMEBAND_URN],
        [NETWORK_Q_TIME_TIMEBAND_URN],
        [IVR_TALK_TIME_TIMEBAND_URN],
        [DIALED_NUMBER_URN],
        [SCRIPT_URN],
        [CALL_OUTCOME_URN],
        [ROUTE_URN],
        [LABEL_URN],
        [FINAL_LABEL_URN],
        [CALL_TYPE_URN],
        [CLI_NNG_URN],
        [CLI_URN],
        [VALUE_URN],
        [SATISFACTION_URN],
        [RATING_PERIOD_URN],
        [CHARGEBAND_URN],
        [CLI_STRING],
        [MEDIA_ROUTING_DOMAIN_URN],
        [REQUEST_TYPE_URN],
        [ORIGINATOR_TYPE_URN],
        [TARGET_TYPE_URN],
        [MESSAGE_ORIGIN_URN],
        [CLUSTER_RESOURCE_URN],
        [CUSTOM_DIMENSION_0],
        [CUSTOM_DIMENSION_1],
        [CUSTOM_DIMENSION_2],
        [CUSTOM_DIMENSION_3],
        [CUSTOM_DIMENSION_4],
        [CUSTOM_DIMENSION_5],
        [CUSTOM_DIMENSION_6],
        [CUSTOM_DIMENSION_7],
        [CUSTOM_DIMENSION_8],
        [CUSTOM_DIMENSION_9],
        [FINAL_SCRIPT_NODE],
        [SOURCE_ERROR_CODE],
        [DURATION],
        [SEGMENT_TIME],
        [NETWORK_Q_TIME],
        [SCRIPT_COUNT],
        [IVR_TALK_TIME],
        [COST],
        [ROUTER_Q_TIME],
        [CUSTOM_MEASURE_0],
        [CUSTOM_MEASURE_1],
        [CUSTOM_MEASURE_2],
        [CUSTOM_MEASURE_3],
        [CUSTOM_MEASURE_4],
        [CUSTOM_MEASURE_5],
        [CUSTOM_MEASURE_6],
        [CUSTOM_MEASURE_7],
        [CUSTOM_MEASURE_8],
        [CUSTOM_MEASURE_9],
        [PARTITION_ID],
        1 AS [Row Count]
FROM    dbo.VW_PARTITIONED_FCT_CALL_DETAIL_LEG;
GO
GRANT SELECT
	ON [dbo].[VW_FCT_CALL_DETAIL_LEG]
	TO [portalreporting_role]
GO
