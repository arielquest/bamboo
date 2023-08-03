SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_FCT_REPEAT_INTERACTION_EVENT]
AS
WITH    tbCte
          AS ( SELECT   RANK() OVER ( ORDER BY PERIOD_START ) AS _RANK,
                        ITEM_URN AS TIMEBAND_URN
               FROM     dbo.TB_DIM_TIMEBAND
               WHERE    ITEM_SUBTYPE_ID = '6F59FFAD-AD85-4891-A77F-1264DF0665F9'
             )
    SELECT  x.*,
            CASE WHEN x.ORIGINAL_CONTACT_ID = '' THEN CONVERT(NVARCHAR, ( ( CAST(x.CALL_KEY1 AS BIGINT) * POWER(CAST(2 AS BIGINT), 32) )  
              | CAST(x.CALL_KEY2 AS BIGINT) ) )
              ELSE x.ORIGINAL_CONTACT_ID END AS CALL_KEY,  
            1 AS [Row Count],
            CAST(COALESCE(b.REPEAT_TRIGGERED, 0) AS BIGINT) AS [REPEAT_TRIGGERED]
            -- If a call triggered a repeat within the the upper bounds of a lower timeband, then it will be included as repeat triggered in all higher timebands
            ,
            CAST(( CASE WHEN b.TIMEBAND_URN IN ( SELECT TIMEBAND_URN
                                                 FROM   tbCte
                                                 WHERE  _RANK IN ( 1 ) )
                        THEN COALESCE(b.REPEAT_TRIGGERED, 0)
                        ELSE 0
                   END ) AS BIGINT) AS [REPEAT_TRIGGERED_T1],
            CAST(( CASE WHEN b.TIMEBAND_URN IN ( SELECT TIMEBAND_URN
                                                 FROM   tbCte
                                                 WHERE  _RANK IN ( 1, 2 ) )
                        THEN COALESCE(b.REPEAT_TRIGGERED, 0)
                        ELSE 0
                   END ) AS BIGINT) AS [REPEAT_TRIGGERED_T2],
            CAST(( CASE WHEN b.TIMEBAND_URN IN ( SELECT TIMEBAND_URN
                                                 FROM   tbCte
                                                 WHERE  _RANK IN ( 1, 2, 3 ) )
                        THEN COALESCE(b.REPEAT_TRIGGERED, 0)
                        ELSE 0
                   END ) AS BIGINT) AS [REPEAT_TRIGGERED_T3],
            CAST(( CASE WHEN b.TIMEBAND_URN IN (
                             SELECT TIMEBAND_URN
                             FROM   tbCte
                             WHERE  _RANK IN ( 1, 2, 3, 4 ) )
                        THEN COALESCE(b.REPEAT_TRIGGERED, 0)
                        ELSE 0
                   END ) AS BIGINT) AS [REPEAT_TRIGGERED_T4],
            CAST(CASE WHEN x.IS_REPEAT = 1
                           AND COALESCE(b.TIMEBAND_URN, -2) < 0
                           AND x.[TIMEBAND_URN] > 0 THEN 1
                      ELSE 0
                 END AS BIGINT) AS [REPEAT_RECEIVED],
            CASE WHEN x.IS_REPEAT = 1
                      AND x.[TIMEBAND_URN] > 0
                      AND x.TIMEBAND_URN IN ( SELECT    TIMEBAND_URN
                                              FROM      tbCte
                                              WHERE     _RANK IN ( 1 ) )
                 THEN 1
                 ELSE 0
            END REPEAT_RECEIVED_T1,
            CASE WHEN x.IS_REPEAT = 1
                      AND x.[TIMEBAND_URN] > 0
                      AND x.TIMEBAND_URN IN ( SELECT    TIMEBAND_URN
                                              FROM      tbCte
                                              WHERE     _RANK IN ( 1, 2 ) )
                 THEN 1
                 ELSE 0
            END REPEAT_RECEIVED_T2,
            CASE WHEN x.IS_REPEAT = 1
                      AND x.[TIMEBAND_URN] > 0
                      AND x.TIMEBAND_URN IN ( SELECT    TIMEBAND_URN
                                              FROM      tbCte
                                              WHERE     _RANK IN ( 1, 2, 3 ) )
                 THEN 1
                 ELSE 0
            END REPEAT_RECEIVED_T3,
            CASE WHEN x.IS_REPEAT = 1
                      AND x.[TIMEBAND_URN] > 0
                      AND x.TIMEBAND_URN IN (
                      SELECT    TIMEBAND_URN
                      FROM      tbCte
                      WHERE     _RANK IN ( 1, 2, 3, 4 ) ) THEN 1
                 ELSE 0
            END REPEAT_RECEIVED_T4,
            CAST(CASE x.IS_REPEAT
                   WHEN 0 THEN 1
                   ELSE 0
                 END AS BIGINT) AS [NON_REPEAT],
            CASE WHEN (
                        x.IS_REPEAT = 0
                        AND x.[TIMEBAND_URN] > 0
                        AND x.TIMEBAND_URN = ( SELECT   TIMEBAND_URN
                                               FROM     tbCte
                                               WHERE    _RANK IN ( 1 )
                                             )
                      )
                      OR (
                           x.IS_REPEAT = 1
                           AND x.TIMEBAND_URN < 0
                           AND (
                                 COALESCE(b.REPEAT_TRIGGERED, 1) = 1
                                 AND b.TIMEBAND_URN = ( SELECT
                                                              TIMEBAND_URN
                                                        FROM  tbCte
                                                        WHERE _RANK IN ( 1 )
                                                      )
                               )
                         )
                      OR (
                           x.IS_REPEAT = 1
                           AND x.SEQUENCE = 0
                           AND x.TIMEBAND_URN < 0
                         )
                      OR (
                           x.IS_REPEAT = 1
                           AND x.[TIMEBAND_URN] > 0
                           AND x.TIMEBAND_URN IN ( SELECT   TIMEBAND_URN
                                                   FROM     tbCte
                                                   WHERE    _RANK > 1 )
                         ) THEN 1
                 ELSE 0
            END NON_REPEAT_T1,
            CASE WHEN (
                        x.IS_REPEAT = 0
                        AND x.[TIMEBAND_URN] > 0
                        AND x.TIMEBAND_URN = ( SELECT   TIMEBAND_URN
                                               FROM     tbCte
                                               WHERE    _RANK IN ( 2 )
                                             )
                      )
                      OR (
                           x.IS_REPEAT = 1
                           AND x.TIMEBAND_URN < 0
                           AND (
                                 (b.REPEAT_TRIGGERED = 1
                                 AND b.TIMEBAND_URN IN (
                                 SELECT TIMEBAND_URN
                                 FROM   tbCte
                                 WHERE  _RANK IN ( 1, 2 ) ))
                               )
                         )
                      OR (
                           x.IS_REPEAT = 1
                           AND x.SEQUENCE = 0
                           AND x.TIMEBAND_URN < 0
                         )
                      OR (
                           x.SEQUENCE > 0
                           AND x.TIMEBAND_URN < 0
                           AND b.TIMEBAND_URN IN ( SELECT   TIMEBAND_URN
                                                   FROM     tbCte
                                                   WHERE    _RANK < 2 )
                         )
                      OR (
                           x.IS_REPEAT = 1
                           AND x.[TIMEBAND_URN] > 0
                           AND x.TIMEBAND_URN IN ( SELECT   TIMEBAND_URN
                                                   FROM     tbCte
                                                   WHERE    _RANK > 2 )
                         )
                      OR (
                           x.IS_REPEAT = 0
                           AND COALESCE(b.IS_ANCHOR, 0) = 0
                           AND x.TIMEBAND_URN IN ( SELECT   TIMEBAND_URN
                                                   FROM     tbCte
                                                   WHERE    _RANK < 2 )
                         ) THEN 1
                 ELSE 0
            END NON_REPEAT_T2,
            CASE WHEN (
                        x.IS_REPEAT = 0
                        AND x.[TIMEBAND_URN] > 0
                        AND x.TIMEBAND_URN IN ( SELECT  TIMEBAND_URN
                                                FROM    tbCte
                                                WHERE   _RANK IN ( 3 ) )
                      )
                      OR (
                           x.IS_REPEAT = 1
                           AND x.TIMEBAND_URN < 0
                           AND (
                                 (b.REPEAT_TRIGGERED = 1
                                 AND b.TIMEBAND_URN IN (
                                 SELECT TIMEBAND_URN
                                 FROM   tbCte
                                 WHERE  _RANK IN ( 1, 2, 3 ) ))
                               )
                         )
                      OR (
                           x.IS_REPEAT = 1
                           AND x.SEQUENCE = 0
                           AND x.TIMEBAND_URN < 0
                         )
                      OR (
                           x.SEQUENCE > 0
                           AND x.TIMEBAND_URN < 0
                           AND b.TIMEBAND_URN IN ( SELECT   TIMEBAND_URN
                                                   FROM     tbCte
                                                   WHERE    _RANK < 3 )
                         )
                      OR (
                           x.IS_REPEAT = 1
                           AND x.[TIMEBAND_URN] > 0
                           AND x.TIMEBAND_URN IN ( SELECT   TIMEBAND_URN
                                                   FROM     tbCte
                                                   WHERE    _RANK > 3 )
                         )
                      OR (
                           x.IS_REPEAT = 0
                           AND COALESCE(b.IS_ANCHOR, 0) = 0
                           AND x.TIMEBAND_URN IN ( SELECT   TIMEBAND_URN
                                                   FROM     tbCte
                                                   WHERE    _RANK < 3 )
                         ) THEN 1
                 ELSE 0
            END NON_REPEAT_T3,
            CASE WHEN (
                        x.IS_REPEAT = 0
                        AND x.[TIMEBAND_URN] > 0
                        AND x.TIMEBAND_URN = ( SELECT   TIMEBAND_URN
                                               FROM     tbCte
                                               WHERE    _RANK IN ( 4 )
                                             )
                      ) -- Are you a unique physical event in this period
                      OR (
                           x.IS_REPEAT = 1
                           AND x.TIMEBAND_URN < 0
                           AND (
                                 (b.REPEAT_TRIGGERED = 1
                                 AND b.TIMEBAND_URN IN (
                                 SELECT TIMEBAND_URN
                                 FROM   tbCte
                                 WHERE  _RANK IN ( 1, 2, 3, 4 ) ))
                               )
                         ) -- If you are an anchor event and you triggered a repeat in this then you are unique offered in this timeband
                      OR (
                           x.IS_REPEAT = 1
                           AND x.SEQUENCE = 0
                           AND x.TIMEBAND_URN < 0
                         ) -- Are you the anchor event of the chain that starts of as a repeat
                      OR (
                           x.SEQUENCE > 0
                           AND x.TIMEBAND_URN < 0
                           AND b.TIMEBAND_URN IN ( SELECT   TIMEBAND_URN
                                                   FROM     tbCte
                                                   WHERE    _RANK < 4 )
                         )  -- if you are an anchor with previous non repeat then the triggered event should be in the lower bands
                      OR (
                           x.IS_REPEAT = 0
                           AND COALESCE(b.IS_ANCHOR, 0) = 0
                           AND x.TIMEBAND_URN IN ( SELECT   TIMEBAND_URN
                                                   FROM     tbCte
                                                   WHERE    _RANK < 4 )
                         ) -- did you stop after have non repeat events upto the previous period
                      THEN 1
                 ELSE 0
            END NON_REPEAT_T4
    FROM    dbo.VW_PARTITIONED_FCT_REPEAT_INTERACTION_EVENT AS x
    OUTER APPLY ( SELECT    CASE WHEN IS_REPEAT = 1
                                      AND x.IS_REPEAT = 1 THEN 1
                                 ELSE 0
                            END AS REPEAT_TRIGGERED,
                            CASE WHEN x.IS_REPEAT = 0 THEN 1
                                 ELSE 0
                            END AS IS_ANCHOR,
                            CASE WHEN (
                                        IS_REPEAT = 1
                                        AND x.IS_REPEAT = 1
                                      )
                                      OR ( x.IS_REPEAT = 0 ) THEN TIMEBAND_URN
                                 ELSE -1
                            END AS TIMEBAND_URN
                  FROM      dbo.VW_PARTITIONED_FCT_REPEAT_INTERACTION_EVENT
                  WHERE     CHAIN_ID = x.CHAIN_ID
                            AND SEQUENCE = x.SEQUENCE + 1
                            AND IS_REPEAT = x.IS_REPEAT
                            AND CLUSTER_RESOURCE_URN = x.CLUSTER_RESOURCE_URN
                ) AS b ( REPEAT_TRIGGERED, IS_ANCHOR, TIMEBAND_URN );
 -- did the current event generated a subsequent repeat
GO
GRANT SELECT
	ON [dbo].[VW_FCT_REPEAT_INTERACTION_EVENT]
	TO [portalreporting_role]
GO
