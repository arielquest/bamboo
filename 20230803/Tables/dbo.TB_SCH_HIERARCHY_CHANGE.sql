SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_SCH_HIERARCHY_CHANGE] (
		[HIERARCHY_CHANGE_ID]        [uniqueidentifier] NOT NULL,
		[HIERARCHY_BUSINESS_URN]     [int] NOT NULL,
		[EFFECTIVE_FROM]             [datetime] NOT NULL,
		[STATUS]                     [char](1) COLLATE Latin1_General_CI_AS NOT NULL,
		[msrepl_tran_version]        [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TB_SCH_HIERARCHY_CHANGE]
		PRIMARY KEY
		CLUSTERED
		([HIERARCHY_CHANGE_ID])
	ON [ADMGROUP]
) ON [ADMGROUP]
GO
ALTER TABLE [dbo].[TB_SCH_HIERARCHY_CHANGE]
	ADD
	CONSTRAINT [CK_TB_SCH_HIERARCHY_CHANGE_STATUS]
	CHECK
	([STATUS]='R' OR [STATUS]='P' OR [STATUS]='C' OR [STATUS]='E')
GO
ALTER TABLE [dbo].[TB_SCH_HIERARCHY_CHANGE]
CHECK CONSTRAINT [CK_TB_SCH_HIERARCHY_CHANGE_STATUS]
GO
ALTER TABLE [dbo].[TB_SCH_HIERARCHY_CHANGE]
	ADD
	CONSTRAINT [DF_TB_SCH_HIERARCHY_CHANGE_STATUS]
	DEFAULT ('P') FOR [STATUS]
GO
ALTER TABLE [dbo].[TB_SCH_HIERARCHY_CHANGE]
	ADD
	CONSTRAINT [DF_TB_SCH_HIERARCHY_CHANGE_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table holds all the specific information of schedules of type "H" (Hierarchy Change). This table is derived from TB_SCH_TASK that holds the common information about all kinds of supported schedules.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SCH_HIERARCHY_CHANGE', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary Key identifier. This is also a foreign key to table TB_SCH_TASK indicating a schedule of Type "H" (Hierarchy Change).', 'SCHEMA', N'dbo', 'TABLE', N'TB_SCH_HIERARCHY_CHANGE', 'COLUMN', N'HIERARCHY_CHANGE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the PARENT_URN (Business Urn) from TB_DIM_HIERARCHY for an item of type IT_HIERARCHY. This indicates the hierarchy, the current change is associated to.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SCH_HIERARCHY_CHANGE', 'COLUMN', N'HIERARCHY_BUSINESS_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a datetime value in UTC indicating the date and time when the change should be effective from.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SCH_HIERARCHY_CHANGE', 'COLUMN', N'EFFECTIVE_FROM'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Charactor flag indicating the status of the hierarchy change. Possible values are P: Pending, C: Complete, E: Error, R: Retrying', 'SCHEMA', N'dbo', 'TABLE', N'TB_SCH_HIERARCHY_CHANGE', 'COLUMN', N'STATUS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SCH_HIERARCHY_CHANGE', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_SCH_HIERARCHY_CHANGE]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_SCH_HIERARCHY_CHANGE]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_SCH_HIERARCHY_CHANGE]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_SCH_HIERARCHY_CHANGE]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_SCH_HIERARCHY_CHANGE] SET (LOCK_ESCALATION = TABLE)
GO
