SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TS_IMP_CDR_LC_CHECKPOINT] (
		[CDR_LC_CHECKPOINT_URN]     [int] IDENTITY(1, 2) NOT FOR REPLICATION NOT NULL,
		[CDR_SESSION_URN]           [int] NOT NULL,
		[TYPE]                      [varchar](30) COLLATE Latin1_General_CI_AS NOT NULL,
		[START]                     [datetime] NOT NULL,
		[DNI]                       [int] NOT NULL,
		[TLI]                       [int] NOT NULL,
		[CLI]                       [varchar](30) COLLATE Latin1_General_CI_AS NOT NULL,
		[DATE]                      [int] NOT NULL,
		[TIME]                      [smallint] NOT NULL,
		[RINGTIME]                  [float] NOT NULL,
		[TALKTIME]                  [float] NOT NULL,
		[SOURCE_URN]                [int] NOT NULL,
		[SOURCE_CODE]               [int] NOT NULL,
		[SOURCE_TYPE]               [tinyint] NOT NULL,
		[OUTCOME]                   [tinyint] NOT NULL,
		[LINK]                      [int] NOT NULL,
		CONSTRAINT [PK_TS_IMP_CDR_LC_CHECKPOINT]
		PRIMARY KEY
		CLUSTERED
		([CDR_LC_CHECKPOINT_URN])
	ON [STGGROUP]
) ON [STGGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table is the staging table used by the IN processor to maintain various stages of processing summary CDR data for long calls only.', 'SCHEMA', N'dbo', 'TABLE', N'TS_IMP_CDR_LC_CHECKPOINT', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TS_IMP_CDR_LC_CHECKPOINT', 'COLUMN', N'CDR_LC_CHECKPOINT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_IMP_CDR_SESSION corresponding to the CDR import session associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TS_IMP_CDR_LC_CHECKPOINT', 'COLUMN', N'CDR_SESSION_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a string representing the type of summary data being processed.', 'SCHEMA', N'dbo', 'TABLE', N'TS_IMP_CDR_LC_CHECKPOINT', 'COLUMN', N'TYPE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a UTC date time stamp indicating when the processing was started.', 'SCHEMA', N'dbo', 'TABLE', N'TS_IMP_CDR_LC_CHECKPOINT', 'COLUMN', N'START'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DIALED_NUMBER for an item of type IT_DIALED_NUMBER. This is the destination number associated with the call.', 'SCHEMA', N'dbo', 'TABLE', N'TS_IMP_CDR_LC_CHECKPOINT', 'COLUMN', N'DNI'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TLI for an item of type IT_TLI. This is the termination line identifier associated with the call.', 'SCHEMA', N'dbo', 'TABLE', N'TS_IMP_CDR_LC_CHECKPOINT', 'COLUMN', N'TLI'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_CLI for an item of type IT_CLI. This is the caller line identifier associated with the call.', 'SCHEMA', N'dbo', 'TABLE', N'TS_IMP_CDR_LC_CHECKPOINT', 'COLUMN', N'CLI'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the date associated with the call.', 'SCHEMA', N'dbo', 'TABLE', N'TS_IMP_CDR_LC_CHECKPOINT', 'COLUMN', N'DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the time associated with the call.', 'SCHEMA', N'dbo', 'TABLE', N'TS_IMP_CDR_LC_CHECKPOINT', 'COLUMN', N'TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'', 'SCHEMA', N'dbo', 'TABLE', N'TS_IMP_CDR_LC_CHECKPOINT', 'COLUMN', N'RINGTIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'', 'SCHEMA', N'dbo', 'TABLE', N'TS_IMP_CDR_LC_CHECKPOINT', 'COLUMN', N'TALKTIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_CALL_SOURCE for an item of type IT_CALL_SOURCE.', 'SCHEMA', N'dbo', 'TABLE', N'TS_IMP_CDR_LC_CHECKPOINT', 'COLUMN', N'SOURCE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the code associated with the call source.', 'SCHEMA', N'dbo', 'TABLE', N'TS_IMP_CDR_LC_CHECKPOINT', 'COLUMN', N'SOURCE_CODE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the type of the call source. The types can possible be Marconi or Nortel.', 'SCHEMA', N'dbo', 'TABLE', N'TS_IMP_CDR_LC_CHECKPOINT', 'COLUMN', N'SOURCE_TYPE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_CODE for an item of type CG_CALL_OUTCOME.', 'SCHEMA', N'dbo', 'TABLE', N'TS_IMP_CDR_LC_CHECKPOINT', 'COLUMN', N'OUTCOME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'', 'SCHEMA', N'dbo', 'TABLE', N'TS_IMP_CDR_LC_CHECKPOINT', 'COLUMN', N'LINK'
GO
ALTER TABLE [dbo].[TS_IMP_CDR_LC_CHECKPOINT] SET (LOCK_ESCALATION = TABLE)
GO
