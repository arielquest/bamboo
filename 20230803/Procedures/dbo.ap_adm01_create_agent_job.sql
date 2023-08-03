SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_adm01_create_agent_job]
    (
      @name NVARCHAR(128),
      @description NVARCHAR(1024),
      @owner NVARCHAR(128),
      @steps XML
    )
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @error INT = 0,
        @InitialTransactionCount INT = @@TRANCOUNT,
        @jobID BINARY(16),
        @ErrorMessage VARCHAR(2048),
        @SQL NVARCHAR(MAX);

    BEGIN TRANSACTION [AgentJob];
    BEGIN TRY
        -- VALIDATE INPUTS
        IF @steps IS NULL
        BEGIN
            RAISERROR (N'Unable to install job ''[%s]'' since specified the steps are null!', 16, 1, @name);
        END;

        IF OBJECT_ID('tempdb..#jobsteps') IS NOT NULL
        BEGIN
            DROP TABLE [#jobsteps];
        END;

        CREATE TABLE [#jobsteps]
            (
              [step_id] INT NOT NULL,
              [step_name] NVARCHAR(128) NOT NULL,
              [command] NVARCHAR(MAX) NOT NULL,
              [database_name] NVARCHAR(128) NOT NULL,
              [server] NVARCHAR(128) NOT NULL,
              [database_user_name] NVARCHAR(128) NOT NULL,
              [subsystem] NCHAR(4) NOT NULL,
              [cmdexec_success_code] INT NOT NULL,
              [flags] INT NOT NULL,
              [retry_attempts] INT NOT NULL,
              [retry_interval] INT NOT NULL,
              [output_file_name] NVARCHAR(200) NOT NULL,
              [on_success_step_id] INT NOT NULL,
              [on_success_action] INT NOT NULL,
              [on_fail_step_id] INT NOT NULL,
              [on_fail_action] INT NOT NULL,
              CONSTRAINT [PK_tmp_jobsteps] PRIMARY KEY CLUSTERED ( [step_id] )
            );

        INSERT  INTO [#jobsteps]
                (
                  [step_id],
                  [step_name],
                  [command],
                  [database_name],
                  [server],
                  [database_user_name],
                  [subsystem],
                  [cmdexec_success_code],
                  [flags],
                  [retry_attempts],
                  [retry_interval],
                  [output_file_name],
                  [on_success_step_id],
                  [on_success_action],
                  [on_fail_step_id],
                  [on_fail_action]
                )
        SELECT  [xmldata].[val].[value]('id[1]', 'int') AS [step_id],
                [xmldata].[val].[value]('name[1]', 'nvarchar(128)') AS [step_name],
                REPLACE([xmldata].[val].[value]('command[1]', 'nvarchar(max)'), '''', '''''') AS [command],
                DB_NAME() AS [database_name],
                ISNULL([xmldata].[val].[value]('server[1]', 'nvarchar(128)'), '') AS [server],
                ISNULL([xmldata].[val].[value]('database_user_name[1]', 'nvarchar(128)'), '') AS [database_user_name],
                N'TSQL' AS [subsystem],
                [xmldata].[val].[value]('cmdexec_success_code[1]', 'int') AS [cmdexec_success_code],
                [xmldata].[val].[value]('flags[1]', 'int') AS [flags],
                [xmldata].[val].[value]('retry_attempts[1]', 'int') AS [retry_attempts],
                [xmldata].[val].[value]('retry_interval[1]', 'int') AS [retry_interval],
                ISNULL([xmldata].[val].[value]('output_file_name[1]', 'nvarchar(200)'), '') AS [output_file_name],
                [xmldata].[val].[value]('on_success_step_id[1]', 'int') AS [on_success_step_id],
                [xmldata].[val].[value]('on_success_action[1]', 'int') AS [on_success_action],
                [xmldata].[val].[value]('on_fail_step_id[1]', 'int') AS [on_fail_step_id],
                [xmldata].[val].[value]('on_fail_action[1]', 'int') AS [on_fail_action]
        FROM    @steps.[nodes]('//job/steps/step') [xmldata] ( [val] );        

        IF NOT EXISTS ( SELECT  1
                        FROM    [sys].[syslogins]
                        WHERE   [name] = @owner )
        BEGIN
            RAISERROR (N'Unable to install job ''[%s]'' since specified owner [%s] does not exist', 16, 1, @name, @owner);
        END;

        -- TRY TO FIND JOB ID
        SELECT  @jobID = [job_id]
        FROM    [msdb].[dbo].[sysjobs]
        WHERE   [name] = @name;

        -- IF JOB NAME EXISTS, DELETE THE OLD ONE
        IF @jobID IS NOT NULL
        BEGIN 
        -- CAN'T DELETE A MULTI-SERVER JOB
            IF EXISTS ( SELECT  1
                        FROM    [msdb].[dbo].[sysjobservers]
                        WHERE   [job_id] = @jobID
                                AND [server_id] <> 0 )
            BEGIN 
                RAISERROR (N'Unable to install job ''[%s]'' since there is already a multi-server job with this name.', 16, 1, @name);
            END;
            ELSE
            BEGIN 
                EXECUTE [msdb].[dbo].[sp_delete_job] @job_name = @name;
            END;

            -- RESET THE JOB ID TO NULL
            SET @jobID = NULL;
        END;

        -- ADD THE CATEGORY IF IT DOESN'T EXIST
        IF NOT EXISTS ( SELECT  1
                        FROM    [msdb].[dbo].[syscategories]
                        WHERE   [name] = N'X5' )
        BEGIN 
            EXECUTE [msdb].[dbo].[sp_add_category] @name = N'X5';
        END;

        -- ADD THE JOB
        EXECUTE @error = [msdb].[dbo].[sp_add_job] @job_id = @jobID OUTPUT, @job_name = @name, @owner_login_name = @owner, @description = @description,
            @category_name = N'X5', @enabled = 1, @notify_level_email = 0, @notify_level_page = 0, @notify_level_netsend = 0, @notify_level_eventlog = 2,
            @delete_level = 0;

        IF @error <> 0
        BEGIN 
            RAISERROR (50016, 16, 1, @name) WITH LOG;
        END;

        DECLARE @stepid INT;

        WHILE EXISTS ( SELECT   1
                       FROM     [#jobsteps] )
        BEGIN
            SELECT TOP 1
                    @stepid = [step_id]
            FROM    [#jobsteps]
            ORDER BY [step_id];

            SET @SQL = NULL;

            SELECT  @SQL = 'EXECUTE @error = [msdb].[dbo].[sp_add_jobstep] @job_id = @jobID, @step_id = @stepid, @step_name = N' + CHAR(39) + [step_name]
                    + CHAR(39) + ', @command = N' + CHAR(39) + [command] + CHAR(39) + ', @database_name = N' + CHAR(39) + [database_name] + CHAR(39)
                    + ', @server = N' + CHAR(39) + [server] + CHAR(39) + ', @database_user_name = N' + CHAR(39) + [database_user_name] + CHAR(39)
                    + ', @subsystem = N' + CHAR(39) + [subsystem] + CHAR(39) + ', @cmdexec_success_code = ' + CAST([cmdexec_success_code] AS VARCHAR(10))
                    + ', @flags = ' + CAST([flags] AS VARCHAR(10)) + ', @retry_attempts = ' + CAST([retry_attempts] AS VARCHAR(10)) + ',@retry_interval = '
                    + CAST([retry_interval] AS VARCHAR(10)) + ', @output_file_name = N' + CHAR(39) + [subsystem] + CHAR(39) + ', @on_success_step_id = '
                    + CAST([on_success_step_id] AS VARCHAR(10)) + ', @on_success_action = ' + CAST([on_success_action] AS VARCHAR(10)) + ', @on_fail_step_id = '
                    + CAST([on_fail_step_id] AS VARCHAR(10)) + ', @on_fail_action = ' + CAST([on_fail_action] AS VARCHAR(10)) + ';'
            FROM    [#jobsteps]
            WHERE   [step_id] = @stepid;

            EXECUTE [sys].[sp_executesql] @SQL, N'@jobID BINARY(16), @stepid INT, @error INT OUTPUT', @stepid = @stepid, @jobID = @jobID, @error = @error OUTPUT;

            IF @error <> 0
            BEGIN 
                RAISERROR (50016, 16, 1, @name) WITH LOG;
            END;

            DELETE  FROM [#jobsteps]
            WHERE   [step_id] = @stepid;
        END;

        IF OBJECT_ID('tempdb..#jobschedule') IS NOT NULL
        BEGIN
            DROP TABLE [#jobschedule];
        END;

        CREATE TABLE [#jobschedule]
            (
              [name] NVARCHAR(128) NOT NULL,
              [enabled] INT NOT NULL,
              [frequency_type] INT NOT NULL,
              [start_date] INT NOT NULL,
              [start_time] INT NOT NULL,
              [frequency_interval] INT NOT NULL,
              [frequency_subday_type] INT NOT NULL,
              [frequency_subday_interval] INT NOT NULL,
              [frequency_relative_interval] INT NOT NULL,
              [frequency_recurrence_factor] INT NOT NULL,
              [end_date] INT NOT NULL,
              [end_time] INT NOT NULL,
              CONSTRAINT [PK_tmp_jobschedules] PRIMARY KEY CLUSTERED ( [name] )
            );

        INSERT  INTO [#jobschedule]
                (
                  [name],
                  [enabled],
                  [frequency_type],
                  [start_date],
                  [start_time],
                  [frequency_interval],
                  [frequency_subday_type],
                  [frequency_subday_interval],
                  [frequency_relative_interval],
                  [frequency_recurrence_factor],
                  [end_date],
                  [end_time]
                )
        SELECT  [xmldata].[val].[value]('name[1]', 'nvarchar(128)') AS [name],
                [xmldata].[val].[value]('enabled[1]', 'int') AS [enabled],
                [xmldata].[val].[value]('frequency_type[1]', 'int') AS [frequency_type],
                ISNULL([xmldata].[val].[value]('start_date[1]', 'int'), YEAR(GETDATE()) * 10000 + MONTH(GETDATE()) * 100 + DAY(GETDATE())) AS [start_date],
                ISNULL([xmldata].[val].[value]('start_time[1]', 'int'), 0) AS [start_time],
                [xmldata].[val].[value]('frequency_interval[1]', 'int') AS [frequency_interval],
                [xmldata].[val].[value]('frequency_subday_type[1]', 'int') AS [frequency_subday_type],
                [xmldata].[val].[value]('frequency_subday_interval[1]', 'int') AS [frequency_subday_interval],
                [xmldata].[val].[value]('frequency_relative_interval[1]', 'int') AS [frequency_relative_interval],
                [xmldata].[val].[value]('frequency_recurrence_factor[1]', 'int') AS [frequency_recurrence_factor],
                [xmldata].[val].[value]('end_date[1]', 'int') AS [end_date],
                [xmldata].[val].[value]('end_time[1]', 'int') AS [end_time]
        FROM    @steps.[nodes]('//job/schedules/schedule') [xmldata] ( [val] );       

        DECLARE @schedule_name NVARCHAR(128);

        WHILE EXISTS ( SELECT   1
                       FROM     [#jobschedule] )
        BEGIN
            SELECT TOP 1
                    @schedule_name = [name]
            FROM    [#jobschedule]
            ORDER BY [name];

            SET @SQL = NULL;

            SELECT  @SQL = 'EXECUTE @error = [msdb].[dbo].[sp_add_jobschedule] @job_id = @jobID, @name = @schedule_name, @enabled = '
                    + CAST([enabled] AS VARCHAR(19)) + ', @freq_type = ' + CAST([frequency_type] AS VARCHAR(19)) + ', @active_start_date = '
                    + CAST([start_date] AS VARCHAR(19)) + ', @active_start_time = ' + CAST([start_time] AS VARCHAR(19)) + ', @freq_interval = '
                    + CAST([frequency_interval] AS VARCHAR(19)) + ', @freq_subday_type = ' + CAST([frequency_subday_type] AS VARCHAR(19))
                    + ', @freq_subday_interval = ' + CAST([frequency_subday_interval] AS VARCHAR(19)) + ', @freq_relative_interval = '
                    + CAST([frequency_relative_interval] AS VARCHAR(19)) + ', @freq_recurrence_factor = ' + CAST([frequency_recurrence_factor] AS VARCHAR(19))
                    + ', @active_end_date = ' + CAST([end_date] AS VARCHAR(19)) + ', @active_end_time = ' + CAST([end_time] AS VARCHAR(19)) + ';'
            FROM    [#jobschedule]
            WHERE   [name] = @schedule_name;

            EXECUTE [sys].[sp_executesql] @SQL, N'@jobID BINARY(16), @schedule_name NVARCHAR(128), @error INT OUTPUT', @schedule_name = @schedule_name,
                @jobID = @jobID, @error = @error OUTPUT;

            IF @error <> 0
            BEGIN 
                RAISERROR (50016, 16, 1, @name) WITH LOG;
            END;

            DELETE  FROM [#jobschedule]
            WHERE   [name] = @schedule_name;
        END;

        -- Add the Target Servers
        EXECUTE @error = [msdb].[dbo].[sp_add_jobserver] @job_id = @jobID, @server_name = N'(local)';

        IF @error <> 0
        BEGIN 
            RAISERROR (50016, 16, 1, @name) WITH LOG;
        END;
        
        COMMIT;
    END TRY
    BEGIN CATCH
        SET @ErrorMessage = ERROR_MESSAGE();
        IF @InitialTransactionCount = 0
            AND @@TRANCOUNT > 0
        BEGIN 
            ROLLBACK TRANSACTION;
        END;
        ELSE
        BEGIN 
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
                SET @ErrorMessage = ISNULL(@ErrorMessage, OBJECT_NAME(@@PROCID));
            END;
        END;
        -- RETHROW ERROR UP A LEVEL
        RAISERROR (@ErrorMessage, 16, 1) WITH LOG;
    END CATCH;
END;
GO
