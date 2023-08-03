SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
----------------------------------------------------------------------------------
-- This procedure returns the per week data counts in the specified cube view
----------------------------------------------------------------------------------
CREATE PROCEDURE [dbo].[ap_imp01_get_rdbms_data_counts]
(
    @CubeViewName     AS NVARCHAR(255),
    @SliceFactKey     AS NVARCHAR(100)
) AS
BEGIN 
    SET NOCOUNT ON;
    
    DECLARE @Query    AS NVARCHAR(2000);
    
    -- The procedure input parameter @SliceFactKey is not being used for Portal Cube related views.
    -- Will be used in the future when all the SLICE_FACT_KEY in TB_ADM_OLAP_OBJECT Portal Cube is UTC Date URN based.
    DECLARE @v_SliceFactKey AS NVARCHAR(100)
    SELECT @v_SliceFactKey = CASE @CubeViewName     
                                WHEN 'VW_FCT_CALL_DETAIL_END_CUBE' THEN 'STARTDATE_UTC_URN'
                                WHEN 'VW_FCT_AGENT_EVENT_CUBE' THEN 'EVENT_DATE_UTC_URN'
                                WHEN 'VW_FCT_AGENT_LOGOUT_CUBE' THEN 'STARTDATE_UTC_URN'
                                WHEN 'VW_SUM_AGENT_SKILLGROUP_INTERVAL_CUBE' THEN 'DATE_UTC_URN'
                                WHEN 'VW_SUM_AGENT_INTERVAL_CUBE' THEN 'DATE_UTC_URN'
                                WHEN 'VW_FCT_CALL_DETAIL_LEG_CUBE' THEN 'STARTDATE_UTC_URN'
                                WHEN 'VW_SUM_CALL_TYPE_INTERVAL_CUBE' THEN 'DATE_UTC_URN'
                                WHEN 'VW_SUM_CAMPAIGN_QUERY_RULE_INTERVAL_CUBE' THEN 'DATE_UTC_URN'
                                WHEN 'VW_SUM_DIALER_INTERVAL_CUBE' THEN 'DATE_UTC_URN'
                                WHEN 'VW_FCT_FORM_CLOSED_RESPONSE_CUBE' THEN 'STARTDATE_UTC_URN'
                                WHEN 'VW_SUM_NETWORK_TRUNK_GROUP_HH_CUBE' THEN 'DATE_UTC_URN'
                                WHEN 'VW_SUM_PERIPHERAL_INTERVAL_CUBE' THEN 'DATE_UTC_URN'
                                WHEN 'VW_SUM_SERVICE_INTERVAL_CUBE' THEN 'DATE_UTC_URN'
                                WHEN 'VW_SUM_SKILLGROUP_INTERVAL_CUBE' THEN 'DATE_UTC_URN'
                                WHEN 'VW_SUM_TRUNK_GROUP_HH_CUBE' THEN 'DATE_UTC_URN'
                                WHEN 'VW_SUM_CALL_TYPE_SKILLGROUP_INTERVAL_CUBE' THEN 'DATE_UTC_URN'
                                WHEN 'VW_SUM_ROUTER_QUEUE_INTERVAL_CUBE' THEN 'DATE_UTC_URN'
                            ELSE @SliceFactKey
                            END
    
    SET @Query = N'                
            SELECT w.PERIOD_START AS WEEK_START, COUNT(*) AS ROW_COUNT
            FROM [' + @CubeViewName + '] e 
            JOIN VW_DIM_DATE_CUBE d ON e.[' + @v_SliceFactKey + '] = d.DATE_URN
            JOIN TB_DIM_DATE_STD_WEEK w ON w.YEAR = d.YEAR AND w.WEEK = d.WEEK
            GROUP BY w.PERIOD_START
            ORDER BY w.PERIOD_START;';

    EXEC sp_executesql @Query;
END;
GO
GRANT EXECUTE
	ON [dbo].[ap_imp01_get_rdbms_data_counts]
	TO [portalapp_role]
GO
