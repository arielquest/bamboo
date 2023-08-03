SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[TB_SCH_HIERARCHY_CHANGE_RESULT] (
		[HIERARCHY_CHANGE_RESULT_ID]     [uniqueidentifier] NOT NULL,
		[RESULT_UTC_DATE_TIME]           [datetime] NOT NULL,
		[HIERARCHY_CHANGE_ID]            [uniqueidentifier] NOT NULL,
		[ITEM_TYPE_ID]                   [uniqueidentifier] NOT NULL,
		[ITEM_BUSINESS_URN]              [int] NOT NULL,
		[EFFECTIVE_FROM]                 [datetime] NOT NULL,
		[EFFECTIVE_TO]                   [datetime] NOT NULL,
		[msrepl_tran_version]            [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TB_SCH_HIERARCHY_CHANGE_RESULT]
		PRIMARY KEY
		CLUSTERED
		([HIERARCHY_CHANGE_RESULT_ID])
	ON [ADMGROUP]
) ON [ADMGROUP]
GO
ALTER TABLE [dbo].[TB_SCH_HIERARCHY_CHANGE_RESULT]
	ADD
	CONSTRAINT [DF_TB_SCH_HIERARCHY_CHANGE_RESULT_HIERARCHY_CHANGE_RESULT_ID]
	DEFAULT (newid()) FOR [HIERARCHY_CHANGE_RESULT_ID]
GO
ALTER TABLE [dbo].[TB_SCH_HIERARCHY_CHANGE_RESULT]
	ADD
	CONSTRAINT [DF_TB_SCH_HIERARCHY_CHANGE_RESULT_HIERARCHY_RESULT_UTC_DATE_TIME]
	DEFAULT (getutcdate()) FOR [RESULT_UTC_DATE_TIME]
GO
ALTER TABLE [dbo].[TB_SCH_HIERARCHY_CHANGE_RESULT]
	ADD
	CONSTRAINT [DF_TB_SCH_HIERARCHY_CHANGE_RESULT_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_SCH_HIERARCHY_CHANGE_RESULT]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_SCH_HIERARCHY_CHANGE_RESULT_TB_SCH_HIERARCHY_CHANGE]
	FOREIGN KEY ([HIERARCHY_CHANGE_ID]) REFERENCES [dbo].[TB_SCH_HIERARCHY_CHANGE] ([HIERARCHY_CHANGE_ID])
	ON DELETE CASCADE
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_SCH_HIERARCHY_CHANGE_RESULT]
	CHECK CONSTRAINT [FK_TB_SCH_HIERARCHY_CHANGE_RESULT_TB_SCH_HIERARCHY_CHANGE]

GO
ALTER TABLE [dbo].[TB_SCH_HIERARCHY_CHANGE_RESULT]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_SCH_HIERARCHY_CHANGE_RESULT_TE_DIM_ITEM_TYPE]
	FOREIGN KEY ([ITEM_TYPE_ID]) REFERENCES [dbo].[TE_DIM_ITEM_TYPE] ([ITEM_TYPE_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_SCH_HIERARCHY_CHANGE_RESULT]
	CHECK CONSTRAINT [FK_TB_SCH_HIERARCHY_CHANGE_RESULT_TE_DIM_ITEM_TYPE]

GO
CREATE NONCLUSTERED INDEX [IX_TB_SCH_HIERARCHY_CHANGE_RESULT_HIERARCHY_CHANGE_ID]
	ON [dbo].[TB_SCH_HIERARCHY_CHANGE_RESULT] ([HIERARCHY_CHANGE_ID])
	ON [ADMGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_SCH_HIERARCHY_CHANGE_RESULT_ITEM_TYPE_ID]
	ON [dbo].[TB_SCH_HIERARCHY_CHANGE_RESULT] ([ITEM_TYPE_ID])
	ON [ADMGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table holds information about the affected dimension items as a result of a past hiearchy change. This table is populated during the execution of the hierarchy changes that have been made for a past date. This dimension information is later used to updated historical fact and summary data with the correct surrogates of the dimensions.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SCH_HIERARCHY_CHANGE_RESULT', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SCH_HIERARCHY_CHANGE_RESULT', 'COLUMN', N'HIERARCHY_CHANGE_RESULT_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a date time field indicating when the record was written into the database. This is used for sequencing the execution of historical fact/summary data update.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SCH_HIERARCHY_CHANGE_RESULT', 'COLUMN', N'RESULT_UTC_DATE_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key referencing the HIERARCHY_CHANGE_ID in TB_SCH_HIERARCHY_CHANGE. This indicates the hierarchy change associated with the result.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SCH_HIERARCHY_CHANGE_RESULT', 'COLUMN', N'HIERARCHY_CHANGE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a foreign key referencing the ITEM_TYPE_ID in TE_DIM_ITEM_TYPE. This indicates the dimension type of the current affected dimension item.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SCH_HIERARCHY_CHANGE_RESULT', 'COLUMN', N'ITEM_TYPE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the business key of the dimension item. Business key for an item is the value of ITEM_BIZ_URN in VW_DIM_ITEM (of a specific item type) where ITEM_URN is the same as ITEM_BIZ_URN. This value continues to be the same in ITEM_BIZ_URN field for all other surrogates for the item.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SCH_HIERARCHY_CHANGE_RESULT', 'COLUMN', N'ITEM_BUSINESS_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This indicates the end of the invalid period of the dimension item after the execution of the hierarchy change.  All historical fact data that use the dimension item will be updated with the correct surrogate of the dimension up to this time.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SCH_HIERARCHY_CHANGE_RESULT', 'COLUMN', N'EFFECTIVE_FROM'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This indicates the end of the invalid period of the dimension item after the execution of hierarchy change. All historical fact data that use the dimension item will be updated with the correct surrogate of the dimension starting from this time.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SCH_HIERARCHY_CHANGE_RESULT', 'COLUMN', N'EFFECTIVE_TO'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_SCH_HIERARCHY_CHANGE_RESULT', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_SCH_HIERARCHY_CHANGE_RESULT]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_SCH_HIERARCHY_CHANGE_RESULT]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_SCH_HIERARCHY_CHANGE_RESULT]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_SCH_HIERARCHY_CHANGE_RESULT]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_SCH_HIERARCHY_CHANGE_RESULT] SET (LOCK_ESCALATION = TABLE)
GO
