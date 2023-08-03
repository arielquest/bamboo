SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_REP_PARAMETER_EXPRESSION] (
		[PARAMETER_ID]                      [uniqueidentifier] NOT NULL,
		[EXPRESSION]                        [nvarchar](max) COLLATE Latin1_General_CI_AS NOT NULL,
		[COMPONENT_TYPE_ID]                 [uniqueidentifier] NULL,
		[DATASOURCE_VARIABLE_PARAMETER]     [nvarchar](100) COLLATE Latin1_General_CI_AS NOT NULL,
		[VALUE_COLUMN]                      [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[DISPLAY_COLUMN]                    [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[DELETED]                           [bit] NOT NULL,
		[HIDDEN]                            [bit] NOT NULL,
		[SYSTEM]                            [bit] NOT NULL,
		[LATEST]                            [bit] NOT NULL,
		[CREATED_BY_ID]                     [uniqueidentifier] NOT NULL,
		[MODIFIED_BY_ID]                    [uniqueidentifier] NOT NULL,
		[CREATION_DATE]                     [datetime] NOT NULL,
		[MODIFIED_DATE]                     [datetime] NOT NULL,
		[CHANGE_STAMP]                      [int] NOT NULL,
		[msrepl_tran_version]               [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_TB_REP_PARAMETER_EXPRESSION]
		PRIMARY KEY
		CLUSTERED
		([PARAMETER_ID])
	ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[TB_REP_PARAMETER_EXPRESSION]
	ADD
	CONSTRAINT [DF_TB_REP_PARAMETER_EXPRESSION_DELETED]
	DEFAULT ((0)) FOR [DELETED]
GO
ALTER TABLE [dbo].[TB_REP_PARAMETER_EXPRESSION]
	ADD
	CONSTRAINT [DF_TB_REP_PARAMETER_EXPRESSION_HIDDEN]
	DEFAULT ((0)) FOR [HIDDEN]
GO
ALTER TABLE [dbo].[TB_REP_PARAMETER_EXPRESSION]
	ADD
	CONSTRAINT [DF_TB_REP_PARAMETER_EXPRESSION_SYSTEM]
	DEFAULT ((0)) FOR [SYSTEM]
GO
ALTER TABLE [dbo].[TB_REP_PARAMETER_EXPRESSION]
	ADD
	CONSTRAINT [DF_TB_REP_PARAMETER_EXPRESSION_LATEST]
	DEFAULT ((1)) FOR [LATEST]
GO
ALTER TABLE [dbo].[TB_REP_PARAMETER_EXPRESSION]
	ADD
	CONSTRAINT [DF_TB_REP_PARAMETER_EXPRESSION_CREATION_DATE]
	DEFAULT (getutcdate()) FOR [CREATION_DATE]
GO
ALTER TABLE [dbo].[TB_REP_PARAMETER_EXPRESSION]
	ADD
	CONSTRAINT [DF_TB_REP_PARAMETER_EXPRESSION_MODIFIED_DATE]
	DEFAULT (getutcdate()) FOR [MODIFIED_DATE]
GO
ALTER TABLE [dbo].[TB_REP_PARAMETER_EXPRESSION]
	ADD
	CONSTRAINT [DF_TB_REP_PARAMETER_EXPRESSION_CHANGE_STAMP]
	DEFAULT ((0)) FOR [CHANGE_STAMP]
GO
ALTER TABLE [dbo].[TB_REP_PARAMETER_EXPRESSION]
	ADD
	CONSTRAINT [DF_TB_REP_PARAMETER_EXPRESSION_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_REP_PARAMETER_EXPRESSION]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_REP_PARAMETER_EXPRESSION_TB_REP_REPORT_PARAMETER_PARAMETER_ID]
	FOREIGN KEY ([PARAMETER_ID]) REFERENCES [dbo].[TB_REP_PARAMETER] ([PARAMETER_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_REP_PARAMETER_EXPRESSION]
	CHECK CONSTRAINT [FK_TB_REP_PARAMETER_EXPRESSION_TB_REP_REPORT_PARAMETER_PARAMETER_ID]

GO
ALTER TABLE [dbo].[TB_REP_PARAMETER_EXPRESSION]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_REP_PARAMETER_EXPRESSION_TE_CLU_RESOURCE_INSTANCE_COMPONENT_TYPE_ID]
	FOREIGN KEY ([COMPONENT_TYPE_ID]) REFERENCES [dbo].[TE_CLU_RESOURCE_INSTANCE_COMPONENT_TYPE] ([COMPONENT_TYPE_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_REP_PARAMETER_EXPRESSION]
	CHECK CONSTRAINT [FK_TB_REP_PARAMETER_EXPRESSION_TE_CLU_RESOURCE_INSTANCE_COMPONENT_TYPE_ID]

GO
CREATE NONCLUSTERED INDEX [IX_TB_REP_PARAMETER_EXPRESSION_COMPONENT_TYPE_ID]
	ON [dbo].[TB_REP_PARAMETER_EXPRESSION] ([COMPONENT_TYPE_ID])
	ON [PRIMARY]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table contains information relating to queries etc. that must be executed to return the values and names for selection in report parameters', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_PARAMETER_EXPRESSION', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record. Foreign key on TB_REP_PARAMETER.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_PARAMETER_EXPRESSION', 'COLUMN', N'PARAMETER_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The expression that is evaluated by the Application Server to identify suitable values for the parameter.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_PARAMETER_EXPRESSION', 'COLUMN', N'EXPRESSION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key on TE_CLU_RESOURCE_INSTANCE_COMPONENT_TYPE. This is the type of component that the expressions should be executed against.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_PARAMETER_EXPRESSION', 'COLUMN', N'COMPONENT_TYPE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Contains a reference to a parameter ID from TB_ADM_PARAMETER to feed into the logic used to receive a suitable connection to a datasource of type COMPONENT_TYPE_ID e.g. pClusterID.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_PARAMETER_EXPRESSION', 'COLUMN', N'DATASOURCE_VARIABLE_PARAMETER'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Contains the name of the column that returns the value to assign from the parameter dropdown.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_PARAMETER_EXPRESSION', 'COLUMN', N'VALUE_COLUMN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Contains the name of the column that returns the display name to display in the parameter dropdown.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_PARAMETER_EXPRESSION', 'COLUMN', N'DISPLAY_COLUMN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the item is deleted or not. Value 1 indicates deleted.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_PARAMETER_EXPRESSION', 'COLUMN', N'DELETED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the item is hidden or not. Value 1 indicates hidden.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_PARAMETER_EXPRESSION', 'COLUMN', N'HIDDEN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the item is owned by the system or not. Value 1 indicates system owned item.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_PARAMETER_EXPRESSION', 'COLUMN', N'SYSTEM'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the item is latest or not. Value 1 indicates latest. For type 2 dimension change this value is set to 0 for parent items.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_PARAMETER_EXPRESSION', 'COLUMN', N'LATEST'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TB_SEC_USER corresponding to the user who created the item.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_PARAMETER_EXPRESSION', 'COLUMN', N'CREATED_BY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TB_SEC_USER corresponding to the user who last modified the item.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_PARAMETER_EXPRESSION', 'COLUMN', N'MODIFIED_BY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the UTC date time stamp indicating when the item was created.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_PARAMETER_EXPRESSION', 'COLUMN', N'CREATION_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the UTC date time stamp indicating when the item was last modified.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_PARAMETER_EXPRESSION', 'COLUMN', N'MODIFIED_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is an incremental number indicating the change stamp for the specific item.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_PARAMETER_EXPRESSION', 'COLUMN', N'CHANGE_STAMP'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_REP_PARAMETER_EXPRESSION', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_REP_PARAMETER_EXPRESSION]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_REP_PARAMETER_EXPRESSION]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_REP_PARAMETER_EXPRESSION]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_REP_PARAMETER_EXPRESSION]
	TO [portalapp_role]
GO
ALTER TABLE [dbo].[TB_REP_PARAMETER_EXPRESSION] SET (LOCK_ESCALATION = TABLE)
GO
