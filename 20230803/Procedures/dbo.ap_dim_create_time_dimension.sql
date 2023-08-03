SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_dim_create_time_dimension]
AS
    BEGIN 
        SET NOCOUNT ON;

        DECLARE @error INT,
            @InitialTransactionCount INT = @@TRANCOUNT,
            @ErrorMessage VARCHAR(1000);

        BEGIN TRY;
            DECLARE @TIMES AS TABLE
                (
                  [DATETIME_TIME] DATETIME,
                  [TIME] VARCHAR(8),
                  [HOUR] TINYINT,
                  [MINUTE] TINYINT,
                  [HOUR_URN] INT,
                  [HALF_HOUR_PERIOD] BIT,
                  [QUARTER_HOUR_PERIOD] BIT,
                  [FIVE_MINUTE_PERIOD] BIT
                );

            WITH    [t1]
                      AS ( SELECT   1 [N]
                           UNION ALL
                           SELECT   1 [N]
                         ), /*2 rows*/
                    [t2]
                      AS ( SELECT   1 [N]
                           FROM     [t1] [x],
                                    [t1] [y]
                         ), /*4 rows*/
                    [t3]
                      AS ( SELECT   1 [N]
                           FROM     [t2] [x],
                                    [t2] [y]
                         ), /*16 rows*/
                    [t4]
                      AS ( SELECT   1 [N]
                           FROM     [t3] [x],
                                    [t3] [y]
                         ), /*256 rows*/
                    [tally]
                      AS ( SELECT   0 AS [n]
                           UNION ALL --ensuring my "numbers" start at 0
                           SELECT TOP 1439 /*limits the times to a 24 hour period*/
                                    ROW_NUMBER() OVER ( ORDER BY ( SELECT   NULL
                                                                 ) )
                           FROM     [t4] [x],
                                    [t4] [y]
                         ),
                    [times]
                      AS ( SELECT   DATEADD(MINUTE, [tally].[n], 0) AS [DATETIME_TIME],
                                    CONVERT(TIME(0), DATEADD(MINUTE, [tally].[n], 0)) AS [TIME],
                                    DATEPART(HOUR, DATEADD(MINUTE, [tally].[n], 0)) AS [HOUR],
                                    DATEPART(MINUTE, DATEADD(MINUTE, [tally].[n], 0)) AS [MINUTE],
                                    DATEPART(HOUR, DATEADD(MINUTE, [tally].[n], 0)) * 60 AS [HOUR_URN],
                                    CASE WHEN DATEPART(MINUTE, DATEADD(MINUTE, [tally].[n], 0)) % 30 = 0 THEN 1
                                         ELSE 0
                                    END AS [HALF_HOUR_PERIOD],
                                    CASE WHEN DATEPART(MINUTE, DATEADD(MINUTE, [tally].[n], 0)) % 15 = 0 THEN 1
                                         ELSE 0
                                    END AS [QUARTER_HOUR_PERIOD],
                                    CASE WHEN DATEPART(MINUTE, DATEADD(MINUTE, [tally].[n], 0)) % 5 = 0 THEN 1
                                         ELSE 0
                                    END AS [FIVE_MINUTE_PERIOD]
                           FROM     [tally]
                         )
                INSERT  INTO @TIMES
                        ( [DATETIME_TIME],
                          [TIME],
                          [HOUR],
                          [MINUTE],
                          [HOUR_URN],
                          [HALF_HOUR_PERIOD],
                          [QUARTER_HOUR_PERIOD],
                          [FIVE_MINUTE_PERIOD]
                        )
                SELECT  [times].[DATETIME_TIME],
                        [times].[TIME],
                        [times].[HOUR],
                        [times].[MINUTE],
                        [times].[HOUR_URN],
                        [times].[HALF_HOUR_PERIOD],
                        [times].[QUARTER_HOUR_PERIOD],
                        [times].[FIVE_MINUTE_PERIOD]
                FROM    [times];

            BEGIN TRANSACTION [AddTimeDimTransaction];

            DELETE  FROM [dbo].[TB_DIM_TIME];

            DELETE  FROM [dbo].[TB_DIM_TIME_5M];

            DELETE  FROM [dbo].[TB_DIM_TIME_QH];

            DELETE  FROM [dbo].[TB_DIM_TIME_HH];

            DELETE  FROM [dbo].[TB_DIM_TIME_H];

            INSERT  INTO [dbo].[TB_DIM_TIME_H]
                    ( [HOUR_URN],
                      [HOUR],
                      [NAME],
                      [INTERNAL_NAME],
                      [PERIOD_START],
                      [PERIOD_END]
                    )
            SELECT  [HOUR_URN],
                    [HOUR],
                    [TIME] AS [NAME],
                    [TIME] AS [INTERNAL_NAME],
                    [DATETIME_TIME] AS [PERIOD_START],
                    DATEADD(SECOND, -1, DATEADD(HOUR, 1, [DATETIME_TIME])) AS [PERIOD_END]
            FROM    @TIMES
            WHERE   [MINUTE] = 0;

            INSERT  INTO [dbo].[TB_DIM_TIME_HH]
                    ( [HALF_HOUR_URN],
                      [HOUR_URN],
                      [HOUR],
                      [MINUTE],
                      [NAME],
                      [INTERNAL_NAME],
                      [PERIOD_START],
                      [PERIOD_END]
                    )
            SELECT  30 * ( ROW_NUMBER() OVER ( ORDER BY [TIME] ) - 1 ) AS [HALF_HOUR_URN],
                    [HOUR_URN],
                    [HOUR],
                    [MINUTE],
                    [TIME] AS [NAME],
                    [TIME] AS [INTERNAL_NAME],
                    [DATETIME_TIME] AS [PERIOD_START],
                    DATEADD(SECOND, -1, DATEADD(MINUTE, 30, [DATETIME_TIME])) AS [PERIOD_END]
            FROM    @TIMES
            WHERE   [HALF_HOUR_PERIOD] = 1;

            INSERT  INTO [dbo].[TB_DIM_TIME_QH]
                    ( [QUARTER_HOUR_URN],
                      [HALF_HOUR_URN],
                      [HOUR],
                      [MINUTE],
                      [NAME],
                      [INTERNAL_NAME],
                      [PERIOD_START],
                      [PERIOD_END]
                    )
            SELECT  15 * ( ROW_NUMBER() OVER ( ORDER BY [TIME] ) - 1 ) AS [QUARTER_HOUR_URN],
                    30 * ( ( ROW_NUMBER() OVER ( ORDER BY [TIME] ) - 1 ) / 2 ) AS [HALF_HOUR_URN],
                    [HOUR],
                    [MINUTE],
                    [TIME] AS [NAME],
                    [TIME] AS [INTERNAL_NAME],
                    [DATETIME_TIME] AS [PERIOD_START],
                    DATEADD(SECOND, -1, DATEADD(MINUTE, 15, [DATETIME_TIME])) AS [PERIOD_END]
            FROM    @TIMES
            WHERE   [QUARTER_HOUR_PERIOD] = 1;

            INSERT  INTO [dbo].[TB_DIM_TIME_5M]
                    ( [FIVE_MINUTE_URN],
                      [QUARTER_HOUR_URN],
                      [HOUR],
                      [MINUTE],
                      [NAME],
                      [INTERNAL_NAME],
                      [PERIOD_START],
                      [PERIOD_END]
                    )
            SELECT  5 * ( ROW_NUMBER() OVER ( ORDER BY [TIME] ) - 1 ) AS [FIVE_MINUTE_URN],
                    15 * ( ( ROW_NUMBER() OVER ( ORDER BY [TIME] ) - 1 ) / 3 ) AS [QUARTER_HOUR_URN],
                    [HOUR],
                    [MINUTE],
                    [TIME] AS [NAME],
                    [TIME] AS [INTERNAL_NAME],
                    [DATETIME_TIME] AS [PERIOD_START],
                    DATEADD(SECOND, -1, DATEADD(MINUTE, 5, [DATETIME_TIME])) AS [PERIOD_END]
            FROM    @TIMES
            WHERE   [FIVE_MINUTE_PERIOD] = 1;

            INSERT  INTO [dbo].[TB_DIM_TIME]
                    ( [TIME_URN],
                      [FIVE_MINUTE_URN],
                      [HOUR],
                      [MINUTE],
                      [NAME],
                      [INTERNAL_NAME],
                      [SHIFT],
                      [EVENING],
                      [TIME_VALUE]
                    )
            SELECT  ( [a].[HOUR] * 60 ) + [a].[MINUTE] AS [TIME_URN],
                    ( [a].[HOUR] * 60 ) + CEILING([a].[MINUTE] / 5) * 5 AS [FIVE_MINUTE_URN],
                    [a].[HOUR],
                    [a].[MINUTE],
                    [a].[TIME] AS [NAME],
                    [a].[TIME] AS [INTERNAL_NAME],
                    0 AS [SHIFT],
                    CASE WHEN [a].[HOUR] IN ( 8, 9, 10, 11, 12, 13, 14, 15, 16, 17 ) THEN 0
                         ELSE 1
                    END AS [EVENING],
                    [a].[DATETIME_TIME] AS [TIME_VALUE]
            FROM    @TIMES [a]
            ORDER BY [a].[MINUTE],
                    [a].[HOUR];

            SELECT  @error = @@ERROR;

            IF @InitialTransactionCount = 0
            BEGIN 
                COMMIT TRANSACTION [AddTimeDimTransaction];
            END;
            ELSE
            BEGIN 
                WHILE @@TRANCOUNT > @InitialTransactionCount
                BEGIN 
                    COMMIT TRANSACTION;
                END;
            END;
        END TRY
        BEGIN CATCH;
            SELECT  @error = @@ERROR,
                    @ErrorMessage = ERROR_MESSAGE();
            SET @ErrorMessage = OBJECT_NAME(@@PROCID) + ' [' + @ErrorMessage + ']';
            IF @InitialTransactionCount = 0
                AND @@TRANCOUNT > 0
            BEGIN 
                ROLLBACK TRANSACTION;
            END;
            ELSE
                IF @InitialTransactionCount <> 0
                    AND @@TRANCOUNT > @InitialTransactionCount
                BEGIN 
                    IF ( XACT_STATE() ) = -1
                    BEGIN 
                        SET @ErrorMessage = ISNULL(@ErrorMessage, OBJECT_NAME(@@PROCID)) + ' [Uncommittable Transaction!]';
                        ROLLBACK TRANSACTION;
                -- THIS IS TO AVOID TRANSACTION MISMATCHES IN THE CALLING APPLICATION
                        DECLARE @transactionFake INT = @@TRANCOUNT;
                        WHILE @transactionFake < @InitialTransactionCount
                        BEGIN 
                            BEGIN TRANSACTION;
                            SET @transactionFake = @transactionFake + 1;
                        END;
                    END;
                    ELSE
                    BEGIN 
                        WHILE @@TRANCOUNT > @InitialTransactionCount
                        BEGIN 
                            COMMIT TRANSACTION;
                        END;
                    END;
                END;
            RAISERROR(@ErrorMessage, 16, 1) WITH LOG;
        END CATCH;

        RETURN @error;
    END;
GO
