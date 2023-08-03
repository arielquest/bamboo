SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_dim_create_date_dimension]
    @startDate DATE = '2010-01-01',
    @endDate DATE = '2050-12-31'
AS
    BEGIN 
        SET NOCOUNT ON;

        DECLARE @error INT,
            @InitialTransactionCount INT = @@TRANCOUNT,
            @ErrorMessage VARCHAR(1000),
            @startDateHolder VARCHAR(30) = FORMAT(@startDate, 'yyyy-MM-dd', 'en-US'),
            @endDateHolder VARCHAR(30)= FORMAT(@endDate, 'yyyy-MM-dd', 'en-US');

        BEGIN TRY;
            IF ( TRY_CAST(@startDate AS SMALLDATETIME) IS NULL
                 OR TRY_CAST(@endDate AS SMALLDATETIME) IS NULL
               )
            BEGIN
                RAISERROR ('Error creating date dimension: @startDate [%s] and @endDate [%s] must be fit between 1900-01-01 and 2076-06-06', 16, 1, @startDateHolder, @endDateHolder);
            END;

            IF @endDate <= @startDate
            BEGIN
                RAISERROR ('Error creating date dimension: @startDate [%s] must be greater than @endDate [%s]', 16, 1, @startDateHolder, @endDateHolder);
            END;

            DECLARE @DATES TABLE
                (
                  [DATE] DATETIME NOT NULL
                                  PRIMARY KEY,
                  [YEAR] INT NOT NULL,
                  [MONTH] INT NOT NULL,
                  [DAY] INT NOT NULL,
                  [WEEK] INT NOT NULL,
                  [PERIOD_START] DATETIME NOT NULL,
                  [PERIOD_END] DATETIME NOT NULL,
                  [QUARTER] INT NOT NULL
                );

            WITH    [t1]
                      AS ( SELECT   1 [N]
                           UNION ALL
                           SELECT   1 [N]
                         ), /*2 rows*/
                    [t2]
                      AS ( SELECT   1 [N]
                           FROM     [t1] [x]
                           CROSS JOIN [t1] [y]
                         ), /*4 rows (2*2)*/
                    [t3]
                      AS ( SELECT   1 [N]
                           FROM     [t2] [x]
                           CROSS JOIN [t2] [y]
                         ), /*16 rows (4*4)*/
                    [t4]
                      AS ( SELECT   1 [N]
                           FROM     [t3] [x]
                           CROSS JOIN [t3] [y]
                         ), /*256 rows (16*16)*/
                    [t5]
                      AS ( SELECT TOP 65535
                                    1 [N]
                           FROM     [t4] [x]
                           CROSS JOIN [t4] [y]
                         ), /*65,536 rows (256*256), limit to 65,535 days because between 1900-01-01 and 2079-06-06, min and max SMALLDATETIME*/
                    [tally]
                      AS ( SELECT   0 AS [n]
                           UNION ALL --ensuring my "numbers" start at 0
                           SELECT TOP ( ( DATEDIFF(DAY, @startDate, @endDate) ) )
                                    ROW_NUMBER() OVER ( ORDER BY ( SELECT   NULL
                                                                 ) )
                           FROM     [t5] [x]
                           CROSS JOIN [t5] [y]
                           ORDER BY [x].[N]
                         ),
                    [dates]
                      AS ( SELECT   DATEADD(DAY, [tally].[n], CAST(@startDate AS DATETIME)) AS [DATE]
                           FROM     [tally]
                           WHERE    DATEADD(DAY, [tally].[n], CAST(@startDate AS DATETIME)) <= CAST(@endDate AS DATETIME)
                         )
                INSERT  INTO @DATES
                SELECT  [dates].[DATE],
                        YEAR([dates].[DATE]) AS [YEAR],
                        MONTH([dates].[DATE]) AS [MONTH],
                        DAY([dates].[DATE]) AS [DAY],
                        DATEPART(WEEK, [dates].[DATE]) AS [WEEK],
                        DATEADD(MONTH, DATEDIFF(MONTH, 0, [dates].[DATE]), 0) AS [PERIOD_START],
                        DATEADD(DAY, -1, DATEADD(MONTH, DATEDIFF(MONTH, 0, [dates].[DATE]) + 1, 0)) AS [PERIOD_END],
                        CASE WHEN MONTH([dates].[DATE]) IN ( 1, 2, 3 ) THEN '1'
                             WHEN MONTH([dates].[DATE]) IN ( 4, 5, 6 ) THEN '2'
                             WHEN MONTH([dates].[DATE]) IN ( 7, 8, 9 ) THEN '3'
                             ELSE '4'
                        END AS [QUARTER]
                FROM    [dates]
                WHERE   DATEADD(DAY, -1, DATEADD(MONTH, DATEDIFF(MONTH, 0, [dates].[DATE]) + 1, 0)) <= '2079-06-06';

            BEGIN TRANSACTION [AddDateDimTransaction];

            DELETE  FROM [dbo].[TB_DIM_DATE];

            DELETE  FROM [dbo].[TB_DIM_DATE_STD_WEEK];

            DELETE  FROM [dbo].[TB_DIM_DATE_STD_MONTH];

            DELETE  FROM [dbo].[TB_DIM_DATE_STD_QUARTER];

            DELETE  FROM [dbo].[TB_DIM_DATE_STD_YEAR];

            INSERT  INTO [dbo].[TB_DIM_DATE_STD_YEAR]
                    ( [YEAR_ID],
                      [YEAR],
                      [NAME],
                      [INTERNAL_NAME],
                      [PERIOD_START],
                      [PERIOD_END]
                    )
            SELECT  [YEAR] AS [YEAR_ID],
                    [YEAR],
                    CAST([YEAR] AS CHAR(4)) AS [NAME],
                    CAST([YEAR] AS CHAR(4)) AS [INTERNAL_NAME],
                    MIN([PERIOD_START]) AS [PERIOD_START],
                    MAX([PERIOD_END]) AS [PERIOD_END]
            FROM    @DATES
            GROUP BY [YEAR];

            INSERT  INTO [dbo].[TB_DIM_DATE_STD_QUARTER]
                    ( [QUARTER_ID],
                      [YEAR_ID],
                      [YEAR],
                      [QUARTER],
                      [NAME],
                      [INTERNAL_NAME],
                      [PERIOD_START],
                      [PERIOD_END]
                    )
            SELECT  CAST([YEAR] AS CHAR(4)) + 'Q' + CAST([QUARTER] AS CHAR(1)) AS [QUARTER_ID],
                    [YEAR] AS [YEAR_ID],
                    [YEAR],
                    [QUARTER],
                    CAST([YEAR] AS CHAR(4)) + ' Q' + CAST([QUARTER] AS CHAR(1)) AS [NAME],
                    CAST([YEAR] AS CHAR(4)) + ' Q' + CAST([QUARTER] AS CHAR(1)) AS [INTERNAL_NAME],
                    MIN([PERIOD_START]) AS [PERIOD_START],
                    MAX([PERIOD_END]) AS [PERIOD_END]
            FROM    @DATES
            GROUP BY [YEAR],
                    [QUARTER];

            INSERT  INTO [dbo].[TB_DIM_DATE_STD_MONTH]
                    ( [MONTH_ID],
                      [QUARTER_ID],
                      [YEAR],
                      [MONTH],
                      [NAME],
                      [INTERNAL_NAME],
                      [PERIOD_START],
                      [PERIOD_END]
                    )
            SELECT  CONVERT(VARCHAR(7), MIN([PERIOD_START]), 21) AS [MONTH_ID],
                    CAST([YEAR] AS CHAR(4)) + 'Q' + CAST([QUARTER] AS CHAR(1)) AS [QUARTER_ID],
                    [YEAR],
                    [MONTH],
                    CONVERT(VARCHAR(7), MIN([PERIOD_START]), 21) AS [NAME],
                    CONVERT(VARCHAR(7), MIN([PERIOD_START]), 21) AS [INTERNAL_NAME],
                    MIN([PERIOD_START]) AS [PERIOD_START],
                    MAX([PERIOD_END]) AS [PERIOD_END]
            FROM    @DATES
            GROUP BY [YEAR],
                    [QUARTER],
                    [MONTH]
            ORDER BY [MONTH];

            INSERT  INTO [dbo].[TB_DIM_DATE_STD_WEEK]
                    ( [WEEK_ID],
                      [YEAR_ID],
                      [YEAR],
                      [WEEK],
                      [NAME],
                      [INTERNAL_NAME],
                      [PERIOD_START],
                      [PERIOD_END]
                    )
            SELECT  [a].[WEEK_ID],
                    [a].[YEAR_ID],
                    [a].[YEAR],
                    [a].[WEEK],
                    [a].[NAME],
                    [a].[INTERNAL_NAME],
                    [b].[PERIOD_START],
                    [c].[PERIOD_END]
            FROM    ( SELECT    CAST([YEAR] AS CHAR(4)) + 'W' + RIGHT('0' + CONVERT(VARCHAR(2), [WEEK]), 2) AS [WEEK_ID],
                                [YEAR] AS [YEAR_ID],
                                [YEAR],
                                [WEEK],
                                CAST([YEAR] AS CHAR(4)) + ' W' + CONVERT(VARCHAR(2), [WEEK]) AS [NAME],
                                CAST([YEAR] AS CHAR(4)) + ' W' + CONVERT(VARCHAR(2), [WEEK]) AS [INTERNAL_NAME]
                      FROM      @DATES
                      GROUP BY  [YEAR],
                                [WEEK]
                    ) [a]
            CROSS APPLY ( SELECT    MIN([DATE]) AS [PERIOD_START]
                          FROM      @DATES
                          WHERE     [YEAR] = [a].[YEAR]
                                    AND [WEEK] = [a].[WEEK]
                        ) [b]
            CROSS APPLY ( SELECT    MAX([DATE]) AS [PERIOD_END]
                          FROM      @DATES
                          WHERE     [YEAR] = [a].[YEAR]
                                    AND [WEEK] = [a].[WEEK]
                        ) [c];

            INSERT  INTO [dbo].[TB_DIM_DATE]
                    ( [DATE_URN],
                      [STD_WEEK_ID],
                      [STD_MONTH_ID],
                      [YEAR],
                      [MONTH],
                      [DAY],
                      [NAME],
                      [INTERNAL_NAME],
                      [DATE_VALUE]
                    )
            SELECT  DATEDIFF(DAY, 0, [DATE]) AS [DATE_URN],
                    CAST([YEAR] AS CHAR(4)) + 'W' + RIGHT('0' + CONVERT(VARCHAR(2), [WEEK]), 2) AS [WEEK_ID],
                    CONVERT(VARCHAR(7), [DATE], 21) AS [MONTH_ID],
                    [YEAR],
                    [MONTH],
                    [DAY],
                    CONVERT(VARCHAR(10), [DATE], 103) AS [NAME],
                    CONVERT(VARCHAR(10), [DATE], 103) AS [INTERNAL_NAME],
                    [DATE] AS [DATE_VALUE]
            FROM    @DATES;

            SELECT  @error = @@ERROR;

            IF @InitialTransactionCount = 0
            BEGIN 
                COMMIT TRANSACTION [AddDateDimTransaction];
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
            RAISERROR (@ErrorMessage, 16, 1) WITH LOG;
        END CATCH;

        RETURN @error;
    END;
GO
