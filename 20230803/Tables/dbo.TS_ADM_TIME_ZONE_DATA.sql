SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TS_ADM_TIME_ZONE_DATA] (
		[DATE_UTC_URN]                  [int] NOT NULL,
		[TIME_UTC_URN]                  [smallint] NOT NULL,
		[DATETIME_UTC]                  [datetime] NOT NULL,
		[OLAP_DATETIME_UTC]             [bigint] NOT NULL,
		[OLAP_DATETIME_TIMEZONE_0]      [bigint] NOT NULL,
		[OLAP_DATETIME_TIMEZONE_1]      [bigint] NOT NULL,
		[OLAP_DATETIME_TIMEZONE_2]      [bigint] NOT NULL,
		[OLAP_DATETIME_TIMEZONE_3]      [bigint] NOT NULL,
		[OLAP_DATETIME_TIMEZONE_4]      [bigint] NOT NULL,
		[OLAP_DATETIME_TIMEZONE_5]      [bigint] NOT NULL,
		[OLAP_DATETIME_TIMEZONE_6]      [bigint] NOT NULL,
		[OLAP_DATETIME_TIMEZONE_7]      [bigint] NOT NULL,
		[OLAP_DATETIME_TIMEZONE_8]      [bigint] NOT NULL,
		[OLAP_DATETIME_TIMEZONE_9]      [bigint] NOT NULL,
		[OLAP_DATETIME_TIMEZONE_10]     [bigint] NOT NULL,
		[OLAP_DATETIME_TIMEZONE_11]     [bigint] NOT NULL,
		[OLAP_DATETIME_TIMEZONE_12]     [bigint] NOT NULL,
		[OLAP_DATETIME_TIMEZONE_13]     [bigint] NOT NULL,
		[OLAP_DATETIME_TIMEZONE_14]     [bigint] NOT NULL,
		[OLAP_DATETIME_TIMEZONE_15]     [bigint] NOT NULL,
		[OLAP_DATETIME_TIMEZONE_16]     [bigint] NOT NULL,
		[OLAP_DATETIME_TIMEZONE_17]     [bigint] NOT NULL,
		[OLAP_DATETIME_TIMEZONE_18]     [bigint] NOT NULL,
		[OLAP_DATETIME_TIMEZONE_19]     [bigint] NOT NULL,
		[DATE_URN_TIMEZONE_0]           [int] NOT NULL,
		[DATE_URN_TIMEZONE_1]           [int] NOT NULL,
		[DATE_URN_TIMEZONE_2]           [int] NOT NULL,
		[DATE_URN_TIMEZONE_3]           [int] NOT NULL,
		[DATE_URN_TIMEZONE_4]           [int] NOT NULL,
		[DATE_URN_TIMEZONE_5]           [int] NOT NULL,
		[DATE_URN_TIMEZONE_6]           [int] NOT NULL,
		[DATE_URN_TIMEZONE_7]           [int] NOT NULL,
		[DATE_URN_TIMEZONE_8]           [int] NOT NULL,
		[DATE_URN_TIMEZONE_9]           [int] NOT NULL,
		[DATE_URN_TIMEZONE_10]          [int] NOT NULL,
		[DATE_URN_TIMEZONE_11]          [int] NOT NULL,
		[DATE_URN_TIMEZONE_12]          [int] NOT NULL,
		[DATE_URN_TIMEZONE_13]          [int] NOT NULL,
		[DATE_URN_TIMEZONE_14]          [int] NOT NULL,
		[DATE_URN_TIMEZONE_15]          [int] NOT NULL,
		[DATE_URN_TIMEZONE_16]          [int] NOT NULL,
		[DATE_URN_TIMEZONE_17]          [int] NOT NULL,
		[DATE_URN_TIMEZONE_18]          [int] NOT NULL,
		[DATE_URN_TIMEZONE_19]          [int] NOT NULL,
		[TIME_URN_TIMEZONE_0]           [smallint] NOT NULL,
		[TIME_URN_TIMEZONE_1]           [smallint] NOT NULL,
		[TIME_URN_TIMEZONE_2]           [smallint] NOT NULL,
		[TIME_URN_TIMEZONE_3]           [smallint] NOT NULL,
		[TIME_URN_TIMEZONE_4]           [smallint] NOT NULL,
		[TIME_URN_TIMEZONE_5]           [smallint] NOT NULL,
		[TIME_URN_TIMEZONE_6]           [smallint] NOT NULL,
		[TIME_URN_TIMEZONE_7]           [smallint] NOT NULL,
		[TIME_URN_TIMEZONE_8]           [smallint] NOT NULL,
		[TIME_URN_TIMEZONE_9]           [smallint] NOT NULL,
		[TIME_URN_TIMEZONE_10]          [smallint] NOT NULL,
		[TIME_URN_TIMEZONE_11]          [smallint] NOT NULL,
		[TIME_URN_TIMEZONE_12]          [smallint] NOT NULL,
		[TIME_URN_TIMEZONE_13]          [smallint] NOT NULL,
		[TIME_URN_TIMEZONE_14]          [smallint] NOT NULL,
		[TIME_URN_TIMEZONE_15]          [smallint] NOT NULL,
		[TIME_URN_TIMEZONE_16]          [smallint] NOT NULL,
		[TIME_URN_TIMEZONE_17]          [smallint] NOT NULL,
		[TIME_URN_TIMEZONE_18]          [smallint] NOT NULL,
		[TIME_URN_TIMEZONE_19]          [smallint] NOT NULL,
		CONSTRAINT [PK_TS_ADM_TIME_ZONE_DATA]
		PRIMARY KEY
		CLUSTERED
		([DATE_UTC_URN], [TIME_UTC_URN])
	WITH FILLFACTOR=99
	ON [STGGROUP]
) ON [STGGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TS_ADM_TIME_ZONE_DATA_DATETIME_UTC]
	ON [dbo].[TS_ADM_TIME_ZONE_DATA] ([DATETIME_UTC])
	WITH ( FILLFACTOR = 99)
	ON [STGGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table stores the calculated date and time values for the 10 different timezones defined in TB_ADM_TIME_ZONE_CONFIG. The data in this table is used by the cube views.', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_TIME_ZONE_DATA', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'The utc date that this row describes in different timezones.', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_TIME_ZONE_DATA', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The utc time that this row describes in different timezones.', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_TIME_ZONE_DATA', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The utc date time that this row describes in different timezones.', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_TIME_ZONE_DATA', 'COLUMN', N'DATETIME_UTC'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The utc date time in the unique OLAP format.', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_TIME_ZONE_DATA', 'COLUMN', N'OLAP_DATETIME_UTC'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The timezone 0 date time in the unique OLAP format.', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_TIME_ZONE_DATA', 'COLUMN', N'OLAP_DATETIME_TIMEZONE_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The timezone 1 date time in the unique OLAP format.', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_TIME_ZONE_DATA', 'COLUMN', N'OLAP_DATETIME_TIMEZONE_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The timezone 2 date time in the unique OLAP format.', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_TIME_ZONE_DATA', 'COLUMN', N'OLAP_DATETIME_TIMEZONE_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The timezone 3 date time in the unique OLAP format.', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_TIME_ZONE_DATA', 'COLUMN', N'OLAP_DATETIME_TIMEZONE_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The timezone 4 date time in the unique OLAP format.', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_TIME_ZONE_DATA', 'COLUMN', N'OLAP_DATETIME_TIMEZONE_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The timezone 5 date time in the unique OLAP format.', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_TIME_ZONE_DATA', 'COLUMN', N'OLAP_DATETIME_TIMEZONE_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The timezone 6 date time in the unique OLAP format.', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_TIME_ZONE_DATA', 'COLUMN', N'OLAP_DATETIME_TIMEZONE_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The timezone 7 date time in the unique OLAP format.', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_TIME_ZONE_DATA', 'COLUMN', N'OLAP_DATETIME_TIMEZONE_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The timezone 8 date time in the unique OLAP format.', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_TIME_ZONE_DATA', 'COLUMN', N'OLAP_DATETIME_TIMEZONE_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The timezone 9 date time in the unique OLAP format.', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_TIME_ZONE_DATA', 'COLUMN', N'OLAP_DATETIME_TIMEZONE_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The timezone 0 date time in the unique OLAP format.', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_TIME_ZONE_DATA', 'COLUMN', N'OLAP_DATETIME_TIMEZONE_10'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The timezone 1 date time in the unique OLAP format.', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_TIME_ZONE_DATA', 'COLUMN', N'OLAP_DATETIME_TIMEZONE_11'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The timezone 2 date time in the unique OLAP format.', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_TIME_ZONE_DATA', 'COLUMN', N'OLAP_DATETIME_TIMEZONE_12'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The timezone 3 date time in the unique OLAP format.', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_TIME_ZONE_DATA', 'COLUMN', N'OLAP_DATETIME_TIMEZONE_13'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The timezone 4 date time in the unique OLAP format.', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_TIME_ZONE_DATA', 'COLUMN', N'OLAP_DATETIME_TIMEZONE_14'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The timezone 5 date time in the unique OLAP format.', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_TIME_ZONE_DATA', 'COLUMN', N'OLAP_DATETIME_TIMEZONE_15'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The timezone 6 date time in the unique OLAP format.', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_TIME_ZONE_DATA', 'COLUMN', N'OLAP_DATETIME_TIMEZONE_16'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The timezone 7 date time in the unique OLAP format.', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_TIME_ZONE_DATA', 'COLUMN', N'OLAP_DATETIME_TIMEZONE_17'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The timezone 8 date time in the unique OLAP format.', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_TIME_ZONE_DATA', 'COLUMN', N'OLAP_DATETIME_TIMEZONE_18'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The timezone 9 date time in the unique OLAP format.', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_TIME_ZONE_DATA', 'COLUMN', N'OLAP_DATETIME_TIMEZONE_19'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The timezone 0 date urn.', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_TIME_ZONE_DATA', 'COLUMN', N'DATE_URN_TIMEZONE_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The timezone 1 date urn.', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_TIME_ZONE_DATA', 'COLUMN', N'DATE_URN_TIMEZONE_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The timezone 2 date urn.', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_TIME_ZONE_DATA', 'COLUMN', N'DATE_URN_TIMEZONE_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The timezone 3 date urn.', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_TIME_ZONE_DATA', 'COLUMN', N'DATE_URN_TIMEZONE_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The timezone 4 date urn.', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_TIME_ZONE_DATA', 'COLUMN', N'DATE_URN_TIMEZONE_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The timezone 5 date urn.', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_TIME_ZONE_DATA', 'COLUMN', N'DATE_URN_TIMEZONE_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The timezone 6 date urn.', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_TIME_ZONE_DATA', 'COLUMN', N'DATE_URN_TIMEZONE_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The timezone 7 date urn.', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_TIME_ZONE_DATA', 'COLUMN', N'DATE_URN_TIMEZONE_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The timezone 8 date urn.', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_TIME_ZONE_DATA', 'COLUMN', N'DATE_URN_TIMEZONE_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The timezone 9 date urn.', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_TIME_ZONE_DATA', 'COLUMN', N'DATE_URN_TIMEZONE_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The timezone 0 date urn.', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_TIME_ZONE_DATA', 'COLUMN', N'DATE_URN_TIMEZONE_10'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The timezone 1 date urn.', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_TIME_ZONE_DATA', 'COLUMN', N'DATE_URN_TIMEZONE_11'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The timezone 2 date urn.', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_TIME_ZONE_DATA', 'COLUMN', N'DATE_URN_TIMEZONE_12'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The timezone 3 date urn.', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_TIME_ZONE_DATA', 'COLUMN', N'DATE_URN_TIMEZONE_13'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The timezone 4 date urn.', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_TIME_ZONE_DATA', 'COLUMN', N'DATE_URN_TIMEZONE_14'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The timezone 5 date urn.', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_TIME_ZONE_DATA', 'COLUMN', N'DATE_URN_TIMEZONE_15'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The timezone 6 date urn.', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_TIME_ZONE_DATA', 'COLUMN', N'DATE_URN_TIMEZONE_16'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The timezone 7 date urn.', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_TIME_ZONE_DATA', 'COLUMN', N'DATE_URN_TIMEZONE_17'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The timezone 8 date urn.', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_TIME_ZONE_DATA', 'COLUMN', N'DATE_URN_TIMEZONE_18'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The timezone 9 date urn.', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_TIME_ZONE_DATA', 'COLUMN', N'DATE_URN_TIMEZONE_19'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The timezone 0 time urn.', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_TIME_ZONE_DATA', 'COLUMN', N'TIME_URN_TIMEZONE_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The timezone 1 time urn.', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_TIME_ZONE_DATA', 'COLUMN', N'TIME_URN_TIMEZONE_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The timezone 2 time urn.', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_TIME_ZONE_DATA', 'COLUMN', N'TIME_URN_TIMEZONE_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The timezone 3 time urn.', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_TIME_ZONE_DATA', 'COLUMN', N'TIME_URN_TIMEZONE_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The timezone 4 time urn.', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_TIME_ZONE_DATA', 'COLUMN', N'TIME_URN_TIMEZONE_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The timezone 5 time urn.', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_TIME_ZONE_DATA', 'COLUMN', N'TIME_URN_TIMEZONE_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The timezone 6 time urn.', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_TIME_ZONE_DATA', 'COLUMN', N'TIME_URN_TIMEZONE_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The timezone 7 time urn.', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_TIME_ZONE_DATA', 'COLUMN', N'TIME_URN_TIMEZONE_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The timezone 8 time urn.', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_TIME_ZONE_DATA', 'COLUMN', N'TIME_URN_TIMEZONE_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The timezone 9 time urn.', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_TIME_ZONE_DATA', 'COLUMN', N'TIME_URN_TIMEZONE_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The timezone 0 time urn.', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_TIME_ZONE_DATA', 'COLUMN', N'TIME_URN_TIMEZONE_10'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The timezone 1 time urn.', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_TIME_ZONE_DATA', 'COLUMN', N'TIME_URN_TIMEZONE_11'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The timezone 2 time urn.', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_TIME_ZONE_DATA', 'COLUMN', N'TIME_URN_TIMEZONE_12'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The timezone 3 time urn.', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_TIME_ZONE_DATA', 'COLUMN', N'TIME_URN_TIMEZONE_13'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The timezone 4 time urn.', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_TIME_ZONE_DATA', 'COLUMN', N'TIME_URN_TIMEZONE_14'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The timezone 5 time urn.', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_TIME_ZONE_DATA', 'COLUMN', N'TIME_URN_TIMEZONE_15'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The timezone 6 time urn.', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_TIME_ZONE_DATA', 'COLUMN', N'TIME_URN_TIMEZONE_16'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The timezone 7 time urn.', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_TIME_ZONE_DATA', 'COLUMN', N'TIME_URN_TIMEZONE_17'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The timezone 8 time urn.', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_TIME_ZONE_DATA', 'COLUMN', N'TIME_URN_TIMEZONE_18'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The timezone 9 time urn.', 'SCHEMA', N'dbo', 'TABLE', N'TS_ADM_TIME_ZONE_DATA', 'COLUMN', N'TIME_URN_TIMEZONE_19'
GO
GRANT DELETE
	ON [dbo].[TS_ADM_TIME_ZONE_DATA]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TS_ADM_TIME_ZONE_DATA]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TS_ADM_TIME_ZONE_DATA]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TS_ADM_TIME_ZONE_DATA]
	TO [portalrs_role]
GO
ALTER TABLE [dbo].[TS_ADM_TIME_ZONE_DATA] SET (LOCK_ESCALATION = TABLE)
GO
