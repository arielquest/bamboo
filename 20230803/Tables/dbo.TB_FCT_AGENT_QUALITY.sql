SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_FCT_AGENT_QUALITY] (
		[PARTITION_URN]                      [int] IDENTITY(0, 1) NOT NULL,
		[PARTITION_ID]                       [int] NOT NULL,
		[PARTITION_GLOBAL_URN]               [bigint] NOT NULL,
		[DATE_URN]                           [int] NOT NULL,
		[TIME_URN]                           [smallint] NOT NULL,
		[DATE_UTC_URN]                       [int] NOT NULL,
		[TIME_UTC_URN]                       [smallint] NOT NULL,
		[DATE_TIME]                          [datetime] NOT NULL,
		[UTC_TIMEZONE]                       [int] NOT NULL,
		[SUBJECT_URN]                        [int] NOT NULL,
		[EVALUATION_URN]                     [int] NOT NULL,
		[EVALUATION_MODIFICATION_NUMBER]     [int] NOT NULL,
		[EVALUATION_FORM_NAME]               [nvarchar](max) COLLATE Latin1_General_CI_AS NOT NULL,
		[EVALUATION_FORM_TYPE]               [int] NOT NULL,
		[EVALUATION_SCORE]                   [float] NOT NULL
) ON [FCTICMGROUP] TEXTIMAGE_ON [FCTICMGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table is for future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_QUALITY', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_QUALITY', 'COLUMN', N'PARTITION_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number for the current partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_QUALITY', 'COLUMN', N'PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column holds a value that uniquely identifies a row across all the partition tables for this partition type.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_QUALITY', 'COLUMN', N'PARTITION_GLOBAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the date of the DATE_TIME value.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_QUALITY', 'COLUMN', N'DATE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the time of the DATE_TIME value.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_QUALITY', 'COLUMN', N'TIME_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the date of the DATE_TIME_UTC value.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_QUALITY', 'COLUMN', N'DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the time of the DATE_TIME_UTC value.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_QUALITY', 'COLUMN', N'TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is represents the datetime of the item.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_QUALITY', 'COLUMN', N'DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This repesents the UTC timezone.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_QUALITY', 'COLUMN', N'UTC_TIMEZONE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This repesents the subject URN.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_QUALITY', 'COLUMN', N'SUBJECT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This repesents the evaluation URN.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_QUALITY', 'COLUMN', N'EVALUATION_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This repesents the evaluation modifcation number.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_QUALITY', 'COLUMN', N'EVALUATION_MODIFICATION_NUMBER'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This repesents the evaluation form name.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_QUALITY', 'COLUMN', N'EVALUATION_FORM_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This repesents the evaluation form type.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_QUALITY', 'COLUMN', N'EVALUATION_FORM_TYPE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This repesents the evaluation form score.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_AGENT_QUALITY', 'COLUMN', N'EVALUATION_SCORE'
GO
GRANT SELECT
	ON [dbo].[TB_FCT_AGENT_QUALITY]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_FCT_AGENT_QUALITY]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_FCT_AGENT_QUALITY]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_FCT_AGENT_QUALITY] SET (LOCK_ESCALATION = TABLE)
GO
