SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_DIM_NNG] (
		[NNG_URN]                 [int] IDENTITY(1, 4) NOT FOR REPLICATION NOT NULL,
		[PARENT_URN]              [int] NULL,
		[SKIP_LEVEL]              [int] NULL,
		[MEMBER]                  [nvarchar](100) COLLATE Latin1_General_CI_AS NOT NULL,
		[MEMBER_LENGTH]           [smallint] NULL,
		[DESCRIPTION]             [nvarchar](500) COLLATE Latin1_General_CI_AS NOT NULL,
		[FIELD1]                  [int] NULL,
		[FIELD2]                  [int] NULL,
		[FIELD3]                  [int] NULL,
		[EFFECTIVE_FROM]          [datetime] NOT NULL,
		[EFFECTIVE_TO]            [datetime] NOT NULL,
		[CREATED_BY_ID]           [uniqueidentifier] NULL,
		[MODIFIED_BY_ID]          [uniqueidentifier] NULL,
		[CREATION_DATE]           [smalldatetime] NOT NULL,
		[MODIFIED_DATE]           [smalldatetime] NOT NULL,
		[ARCHIVED]                [bit] NOT NULL,
		[DELETED]                 [bit] NOT NULL,
		[ENABLED]                 [bit] NOT NULL,
		[EXPORT]                  [bit] NOT NULL,
		[HIDDEN]                  [bit] NOT NULL,
		[LATEST]                  [bit] NOT NULL,
		[SYSTEM]                  [bit] NOT NULL,
		[LENGTH]                  [int] NOT NULL,
		[OSGRID]                  [nvarchar](12) COLLATE Latin1_General_CI_AS NULL,
		[LAT_LONG]                [nvarchar](15) COLLATE Latin1_General_CI_AS NULL,
		[REGION]                  [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
		[TIMEZONE_OFFSET]         [int] NULL,
		[DAYLIGHT_SAVINGS]        [bit] NOT NULL,
		[msrepl_tran_version]     [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TB_DIM_NNG]
		PRIMARY KEY
		CLUSTERED
		([NNG_URN])
	ON [DIMGROUP]
) ON [DIMGROUP]
GO
ALTER TABLE [dbo].[TB_DIM_NNG]
	ADD
	CONSTRAINT [DF_TB_DIM_NNG_DESCRIPTION]
	DEFAULT (N'') FOR [DESCRIPTION]
GO
ALTER TABLE [dbo].[TB_DIM_NNG]
	ADD
	CONSTRAINT [DF_TB_DIM_NNG_EFFECTIVE_FROM]
	DEFAULT ('1/1/1900') FOR [EFFECTIVE_FROM]
GO
ALTER TABLE [dbo].[TB_DIM_NNG]
	ADD
	CONSTRAINT [DF_TB_DIM_NNG_EFFECTIVE_TO]
	DEFAULT ('2079-06-06 00:00:00') FOR [EFFECTIVE_TO]
GO
ALTER TABLE [dbo].[TB_DIM_NNG]
	ADD
	CONSTRAINT [DF_TB_DIM_NNG_CREATION_DATE]
	DEFAULT (getutcdate()) FOR [CREATION_DATE]
GO
ALTER TABLE [dbo].[TB_DIM_NNG]
	ADD
	CONSTRAINT [DF_TB_DIM_NNG_MODIFIED_DATE]
	DEFAULT (getutcdate()) FOR [MODIFIED_DATE]
GO
ALTER TABLE [dbo].[TB_DIM_NNG]
	ADD
	CONSTRAINT [DF_TB_DIM_NNG_ARCHIVED]
	DEFAULT ((0)) FOR [ARCHIVED]
GO
ALTER TABLE [dbo].[TB_DIM_NNG]
	ADD
	CONSTRAINT [DF_TB_DIM_NNG_DELETED]
	DEFAULT ((0)) FOR [DELETED]
GO
ALTER TABLE [dbo].[TB_DIM_NNG]
	ADD
	CONSTRAINT [DF_TB_DIM_NNG_ENABLED]
	DEFAULT ((1)) FOR [ENABLED]
GO
ALTER TABLE [dbo].[TB_DIM_NNG]
	ADD
	CONSTRAINT [DF_TB_DIM_NNG_EXPORT]
	DEFAULT ((0)) FOR [EXPORT]
GO
ALTER TABLE [dbo].[TB_DIM_NNG]
	ADD
	CONSTRAINT [DF_TB_DIM_NNG_HIDDEN]
	DEFAULT ((0)) FOR [HIDDEN]
GO
ALTER TABLE [dbo].[TB_DIM_NNG]
	ADD
	CONSTRAINT [DF_TB_DIM_NNG_LATEST]
	DEFAULT ((1)) FOR [LATEST]
GO
ALTER TABLE [dbo].[TB_DIM_NNG]
	ADD
	CONSTRAINT [DF_TB_DIM_NNG_SYSTEM]
	DEFAULT ((1)) FOR [SYSTEM]
GO
ALTER TABLE [dbo].[TB_DIM_NNG]
	ADD
	CONSTRAINT [DF_TB_DIM_NNG_SKIP_LEVEL]
	DEFAULT ((0)) FOR [SKIP_LEVEL]
GO
ALTER TABLE [dbo].[TB_DIM_NNG]
	ADD
	CONSTRAINT [DF_TB_DIM_NNG_LENGTH]
	DEFAULT ((0)) FOR [LENGTH]
GO
ALTER TABLE [dbo].[TB_DIM_NNG]
	ADD
	CONSTRAINT [DF_TB_DIM_NNG_OSGRID]
	DEFAULT (N'') FOR [OSGRID]
GO
ALTER TABLE [dbo].[TB_DIM_NNG]
	ADD
	CONSTRAINT [DF_TB_DIM_NNG_LAT_LONG]
	DEFAULT (N'') FOR [LAT_LONG]
GO
ALTER TABLE [dbo].[TB_DIM_NNG]
	ADD
	CONSTRAINT [DF_TB_DIM_NNG_DAYLIGHT_SAVINGS]
	DEFAULT ((0)) FOR [DAYLIGHT_SAVINGS]
GO
ALTER TABLE [dbo].[TB_DIM_NNG]
	ADD
	CONSTRAINT [DF_TB_DIM_NNG_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table is a repository for all the National Number Groups (NNG) for the all the countries supported by the application. The NNGs are stored in a hierarchical levels from as low as the actual NNG dialing code upto the name of the continent. The data in this table should not be modified at any time, unless specified otherwise.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_NNG', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_NNG', 'COLUMN', N'NNG_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from the table corresponding to the immediate parent for the current NNG code or Area.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_NNG', 'COLUMN', N'PARENT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Not used.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_NNG', 'COLUMN', N'SKIP_LEVEL'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a string representing either the actual NNG dialing code or the name of the Area.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_NNG', 'COLUMN', N'MEMBER'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a number specifying the the length of the NNG dialing code. This is used only for the records with the actual dialing codes.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_NNG', 'COLUMN', N'MEMBER_LENGTH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a brief description for the NNG.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_NNG', 'COLUMN', N'DESCRIPTION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_NNG', 'COLUMN', N'FIELD1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_NNG', 'COLUMN', N'FIELD2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_NNG', 'COLUMN', N'FIELD3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a UTC date time indicating when the NNG will become active.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_NNG', 'COLUMN', N'EFFECTIVE_FROM'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a UTC date time indicating when the NNG will cease to exist.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_NNG', 'COLUMN', N'EFFECTIVE_TO'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TB_SEC_USER corresponding to the user who created the NNG record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_NNG', 'COLUMN', N'CREATED_BY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TB_SEC_USER corresponding to the user who last modified the NNG record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_NNG', 'COLUMN', N'MODIFIED_BY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a UTC date time stamp indicating when the NNG record was created.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_NNG', 'COLUMN', N'CREATION_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a UTC date time stamp indicating when the NNG record was last modified.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_NNG', 'COLUMN', N'MODIFIED_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is flag indicating whether the NNG has been set for archive or not. Value of 1 indicates archived.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_NNG', 'COLUMN', N'ARCHIVED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is flag indicating whether the NNG has been deleted or not. Value of 1 indicates deleted.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_NNG', 'COLUMN', N'DELETED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is flag indicating whether the NNG has is enabled or not. Value of 1 indicates enabled.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_NNG', 'COLUMN', N'ENABLED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Not used.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_NNG', 'COLUMN', N'EXPORT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is flag indicating whether the NNG has is hidden or not. Value of 1 indicates hidden.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_NNG', 'COLUMN', N'HIDDEN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is flag indicating whether the NNG has is latest or not. Value of 1 indicates latest.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_NNG', 'COLUMN', N'LATEST'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is flag indicating whether the NNG record is owned by the system or not. Value of 1 indicates system owned NNG record..', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_NNG', 'COLUMN', N'SYSTEM'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Not used.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_NNG', 'COLUMN', N'LENGTH'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a string representing the Ordinance Survey Grid for the current NNG location.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_NNG', 'COLUMN', N'OSGRID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a string representing the Latitute and Longitude for the current NNG location.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_NNG', 'COLUMN', N'LAT_LONG'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is string representing the geographic region, which the current NNG falls into.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_NNG', 'COLUMN', N'REGION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is an integer representing the timezone offset in minutes from UTC for the the current NNG location.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_NNG', 'COLUMN', N'TIMEZONE_OFFSET'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the daylight savings option is enabled for the current NNG location. Value 1 indication daylight savings on.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_NNG', 'COLUMN', N'DAYLIGHT_SAVINGS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_DIM_NNG', 'COLUMN', N'msrepl_tran_version'
GO
DENY DELETE
	ON [dbo].[TB_DIM_NNG]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_DIM_NNG]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_DIM_NNG]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_DIM_NNG]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_DIM_NNG] SET (LOCK_ESCALATION = TABLE)
GO
