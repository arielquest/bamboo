SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_ADM_CAPACITY] (
		[CAPACITY_ID]                  [uniqueidentifier] NOT NULL,
		[TENANT_ID]                    [uniqueidentifier] NULL,
		[ITEM_TYPE_ID]                 [uniqueidentifier] NULL,
		[MEMBER_TYPE_ID]               [uniqueidentifier] NULL,
		[CLUSTER_RESOURCE_TYPE_ID]     [uniqueidentifier] NULL,
		[CLUSTER_RESOURCE_ID]          [uniqueidentifier] NULL,
		[DEFAULT_CAPACITY]             [int] NOT NULL,
		[MIN_CAPACITY]                 [int] NOT NULL,
		[MAX_CAPACITY]                 [int] NOT NULL,
		[FLEX_PERCENTAGE]              [smallint] NOT NULL,
		[WARN_PERCENTAGE]              [smallint] NOT NULL,
		[INTERNAL_NAME]                [nvarchar](100) COLLATE Latin1_General_CI_AS NULL,
		[DESCRIPTION]                  [nvarchar](500) COLLATE Latin1_General_CI_AS NULL,
		[CREATION_DATE]                [smalldatetime] NOT NULL,
		[MODIFIED_DATE]                [smalldatetime] NOT NULL,
		[ARCHIVED]                     [bit] NOT NULL,
		[HIDDEN]                       [bit] NOT NULL,
		[ENABLED]                      [bit] NOT NULL,
		[SYSTEM]                       [bit] NOT NULL,
		[VIA_MEMBER_TYPE_ID]           [uniqueidentifier] NULL,
		[msrepl_tran_version]          [uniqueidentifier] NOT NULL,
		CONSTRAINT [UN_ADM_CAPACITY_INTERNAL_NAME]
		UNIQUE
		NONCLUSTERED
		([INTERNAL_NAME], [TENANT_ID], [CLUSTER_RESOURCE_ID], [CLUSTER_RESOURCE_TYPE_ID], [SYSTEM])
		ON [ADMINDEXGROUP],
		CONSTRAINT [PK_TB_ADM_CAPACITY]
		PRIMARY KEY
		CLUSTERED
		([CAPACITY_ID])
	ON [ADMGROUP]
) ON [ADMGROUP]
GO
ALTER TABLE [dbo].[TB_ADM_CAPACITY]
	ADD
	CONSTRAINT [DF_ADM_CAPACITY_ID]
	DEFAULT (newid()) FOR [CAPACITY_ID]
GO
ALTER TABLE [dbo].[TB_ADM_CAPACITY]
	ADD
	CONSTRAINT [DF_ADM_CAPACITY_DEFAULT_CAPACITY]
	DEFAULT ((-1)) FOR [DEFAULT_CAPACITY]
GO
ALTER TABLE [dbo].[TB_ADM_CAPACITY]
	ADD
	CONSTRAINT [DF_ADM_CAPACITY_MIN_CAPACITY]
	DEFAULT ((-1)) FOR [MIN_CAPACITY]
GO
ALTER TABLE [dbo].[TB_ADM_CAPACITY]
	ADD
	CONSTRAINT [DF_ADM_CAPACITY_MAX_CAPACITY]
	DEFAULT ((-1)) FOR [MAX_CAPACITY]
GO
ALTER TABLE [dbo].[TB_ADM_CAPACITY]
	ADD
	CONSTRAINT [DF_ADM_CAPACITY_FLEX_PERCENTAGE_CAPACITY]
	DEFAULT ((0)) FOR [FLEX_PERCENTAGE]
GO
ALTER TABLE [dbo].[TB_ADM_CAPACITY]
	ADD
	CONSTRAINT [DF_ADM_CAPACITY_WARN_PERCENTAGE_CAPACITY]
	DEFAULT ((80)) FOR [WARN_PERCENTAGE]
GO
ALTER TABLE [dbo].[TB_ADM_CAPACITY]
	ADD
	CONSTRAINT [DF_ADM_CAPACITY_CREATION_DATE]
	DEFAULT (getutcdate()) FOR [CREATION_DATE]
GO
ALTER TABLE [dbo].[TB_ADM_CAPACITY]
	ADD
	CONSTRAINT [DF_ADM_CAPACITY_MODIFIED_DATE]
	DEFAULT (getutcdate()) FOR [MODIFIED_DATE]
GO
ALTER TABLE [dbo].[TB_ADM_CAPACITY]
	ADD
	CONSTRAINT [DF_ADM_CAPACITY_ARCHIVED]
	DEFAULT ((0)) FOR [ARCHIVED]
GO
ALTER TABLE [dbo].[TB_ADM_CAPACITY]
	ADD
	CONSTRAINT [DF_ADM_CAPACITY_HIDDEN]
	DEFAULT ((0)) FOR [HIDDEN]
GO
ALTER TABLE [dbo].[TB_ADM_CAPACITY]
	ADD
	CONSTRAINT [DF_ADM_CAPACITY_ENABLED]
	DEFAULT ((1)) FOR [ENABLED]
GO
ALTER TABLE [dbo].[TB_ADM_CAPACITY]
	ADD
	CONSTRAINT [DF_ADM_CAPACITY_SYSTEM]
	DEFAULT ((0)) FOR [SYSTEM]
GO
ALTER TABLE [dbo].[TB_ADM_CAPACITY]
	ADD
	CONSTRAINT [DF_ADM_CAPACITY_msrepl_tran_version]
	DEFAULT (newid()) FOR [msrepl_tran_version]
GO
ALTER TABLE [dbo].[TB_ADM_CAPACITY]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_ADM_CAPACITY_TB_SEC_FOLDER]
	FOREIGN KEY ([TENANT_ID]) REFERENCES [dbo].[TB_SEC_FOLDER] ([FOLDER_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_ADM_CAPACITY]
	CHECK CONSTRAINT [FK_TB_ADM_CAPACITY_TB_SEC_FOLDER]

GO
ALTER TABLE [dbo].[TB_ADM_CAPACITY]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_ADM_CAPACITY_TE_DIM_ITEM_TYPE]
	FOREIGN KEY ([ITEM_TYPE_ID]) REFERENCES [dbo].[TE_DIM_ITEM_TYPE] ([ITEM_TYPE_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_ADM_CAPACITY]
	CHECK CONSTRAINT [FK_TB_ADM_CAPACITY_TE_DIM_ITEM_TYPE]

GO
ALTER TABLE [dbo].[TB_ADM_CAPACITY]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_ADM_CAPACITY_PARENT_TE_DIM_MEMBER_TYPE]
	FOREIGN KEY ([MEMBER_TYPE_ID]) REFERENCES [dbo].[TE_DIM_MEMBER_TYPE] ([MEMBER_TYPE_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_ADM_CAPACITY]
	CHECK CONSTRAINT [FK_TB_ADM_CAPACITY_PARENT_TE_DIM_MEMBER_TYPE]

GO
ALTER TABLE [dbo].[TB_ADM_CAPACITY]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_ADM_CAPACITY_PARENT_TE_DIM_MEMBER_TYPE_2]
	FOREIGN KEY ([VIA_MEMBER_TYPE_ID]) REFERENCES [dbo].[TE_DIM_MEMBER_TYPE] ([MEMBER_TYPE_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_ADM_CAPACITY]
	CHECK CONSTRAINT [FK_TB_ADM_CAPACITY_PARENT_TE_DIM_MEMBER_TYPE_2]

GO
ALTER TABLE [dbo].[TB_ADM_CAPACITY]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_ADM_CAPACITY_PARENT_TE_ADM_CLUSTER_RESOURCE_TYPE]
	FOREIGN KEY ([CLUSTER_RESOURCE_TYPE_ID]) REFERENCES [dbo].[TE_ADM_CLUSTER_RESOURCE_TYPE] ([CLUSTER_RESOURCE_TYPE_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_ADM_CAPACITY]
	CHECK CONSTRAINT [FK_TB_ADM_CAPACITY_PARENT_TE_ADM_CLUSTER_RESOURCE_TYPE]

GO
ALTER TABLE [dbo].[TB_ADM_CAPACITY]
	WITH NOCHECK
	ADD CONSTRAINT [FK_TB_ADM_CAPACITY_TB_CLU_RESOURCE]
	FOREIGN KEY ([CLUSTER_RESOURCE_ID]) REFERENCES [dbo].[TB_CLU_RESOURCE] ([RESOURCE_ID])
	NOT FOR REPLICATION
ALTER TABLE [dbo].[TB_ADM_CAPACITY]
	CHECK CONSTRAINT [FK_TB_ADM_CAPACITY_TB_CLU_RESOURCE]

GO
SET ANSI_PADDING ON
GO
CREATE UNIQUE NONCLUSTERED INDEX [UN_ADM_CAPACITY_TYPE_KEY]
	ON [dbo].[TB_ADM_CAPACITY] ([ITEM_TYPE_ID], [MEMBER_TYPE_ID], [VIA_MEMBER_TYPE_ID], [TENANT_ID], [CLUSTER_RESOURCE_ID], [CLUSTER_RESOURCE_TYPE_ID], [SYSTEM])
	WHERE (([ITEM_TYPE_ID] IS NOT NULL AND [CLUSTER_RESOURCE_ID] IS NOT NULL))
	ON [ADMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_ADM_CAPACITY_CLUSTER_RESOURCE_ID]
	ON [dbo].[TB_ADM_CAPACITY] ([CLUSTER_RESOURCE_ID])
	ON [ADMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_ADM_CAPACITY_CLUSTER_RESOURCE_TYPE_ID]
	ON [dbo].[TB_ADM_CAPACITY] ([CLUSTER_RESOURCE_TYPE_ID])
	ON [ADMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_ADM_CAPACITY_MEMBER_TYPE_ID]
	ON [dbo].[TB_ADM_CAPACITY] ([MEMBER_TYPE_ID])
	ON [ADMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_ADM_CAPACITY_TENANT_ID]
	ON [dbo].[TB_ADM_CAPACITY] ([TENANT_ID])
	ON [ADMINDEXGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_TB_ADM_CAPACITY_VIA_MEMBER_TYPE_ID]
	ON [dbo].[TB_ADM_CAPACITY] ([VIA_MEMBER_TYPE_ID])
	ON [ADMINDEXGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This tables holds all the capacity constraints defined in the application. Capacities can be defined for individual dimension item types or for specific parent child item type relationships. Further, these capacities can be defined at global application level, folder or tenant level, equipment type level or specific equipment level. There can also be capacities defined on various other combinations.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_CAPACITY', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary key identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_CAPACITY', 'COLUMN', N'CAPACITY_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id of the tenant folder as in TB_SEC_FOLDER. If specified, this corresponds to the tenant on which the capacity is defined.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_CAPACITY', 'COLUMN', N'TENANT_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TE_DIM_ITEM_TYPE corresponding to the item type for which the capacity is defined. If defined, this will limit number of dimensions of this type. If defined with a MEMBER_TYPE_ID it will instead apply a limit to the membership.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_CAPACITY', 'COLUMN', N'ITEM_TYPE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TE_DIM_MEMBER_TYPE where the ITEM_TYPE_ID is either a parent or a child. If defined, the capacity of the membership will be applied to items of type ITEM_TYPE_ID. e.g. if the member is MT_AGENT_SKILLGROUP_MEMBER and the item is IT_AGENT, then the capacity rule applied is Number of Skillgroups Per Agent.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_CAPACITY', 'COLUMN', N'MEMBER_TYPE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TE_ADM_CLUSTER_RESOURCE_TYPE that corresponds to the equipment type for which the capacity is defined. For example, capacities can be defined for CICMs or Callmanagers.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_CAPACITY', 'COLUMN', N'CLUSTER_RESOURCE_TYPE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TB_CLU_RESOURCE that corresponds to a specific equipment of type defined by the column CLUSTER_RESOURCE_TYPE_ID. For example different capacities can be difined for different CICMs or Callmanagers configured.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_CAPACITY', 'COLUMN', N'CLUSTER_RESOURCE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the default capacity. Default Value -1 indicates no default capacity constraint.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_CAPACITY', 'COLUMN', N'DEFAULT_CAPACITY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the minimum space on a membership that must be available when selecting a item. e.g. there must be space for a further 20 Phones on a Call Manager Group for a Call Manager Group to be seleced. Default Value -1 indicates no minimum capacity constraint.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_CAPACITY', 'COLUMN', N'MIN_CAPACITY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the maximum capacity. Default Value -1 indicates no maximum capacity constraint.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_CAPACITY', 'COLUMN', N'MAX_CAPACITY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flexible percentage value that defines the extra capacity that the system should allow, expressed as a percentage of the maximum configured capacity.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_CAPACITY', 'COLUMN', N'FLEX_PERCENTAGE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a warning cut off percentage after which the system would generate warning a warning message that the capacity limit is close.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_CAPACITY', 'COLUMN', N'WARN_PERCENTAGE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the systems internal name for the capacity constraint..', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_CAPACITY', 'COLUMN', N'INTERNAL_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a brief descriptin for the capacity constraint.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_CAPACITY', 'COLUMN', N'DESCRIPTION'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a UTC datetime stamp indicating when the capacity constraint was created.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_CAPACITY', 'COLUMN', N'CREATION_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a UTC datetime stamp indicating when the capacity constraint was last modified.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_CAPACITY', 'COLUMN', N'MODIFIED_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the capacity constraint has been set for archive. Value 1 indicates archived.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_CAPACITY', 'COLUMN', N'ARCHIVED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the capacity constraint is hidden or not. Value 1 indicates hidden.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_CAPACITY', 'COLUMN', N'HIDDEN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the capacity constraint is enabled or not. Value 1 indicates enabled.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_CAPACITY', 'COLUMN', N'ENABLED'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a flag indicating whether the capacity constraint is owned by the system or not. Value 1 indicates system owned capacity constraint.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_CAPACITY', 'COLUMN', N'SYSTEM'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the id as in TE_DIM_MEMBER_TYPE which is an additional membertype to join onto during the capaciy calculation. The VIA_MEMBER_TYPE_ID will hang off the paren tor child the MEMBER_TYPE_ID.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_CAPACITY', 'COLUMN', N'VIA_MEMBER_TYPE_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Replication key identifier.', 'SCHEMA', N'dbo', 'TABLE', N'TB_ADM_CAPACITY', 'COLUMN', N'msrepl_tran_version'
GO
GRANT DELETE
	ON [dbo].[TB_ADM_CAPACITY]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_ADM_CAPACITY]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_ADM_CAPACITY]
	TO [portalapp_role]
GO
GRANT UPDATE
	ON [dbo].[TB_ADM_CAPACITY]
	TO [portalapp_role]
GO
GRANT SELECT
	ON [dbo].[TB_ADM_CAPACITY]
	TO [portal_database_configuration_read_role]
GO
GRANT DELETE
	ON [dbo].[TB_ADM_CAPACITY]
	TO [portal_database_configuration_role]
GO
GRANT INSERT
	ON [dbo].[TB_ADM_CAPACITY]
	TO [portal_database_configuration_role]
GO
GRANT SELECT
	ON [dbo].[TB_ADM_CAPACITY]
	TO [portal_database_configuration_role]
GO
GRANT UPDATE
	ON [dbo].[TB_ADM_CAPACITY]
	TO [portal_database_configuration_role]
GO
ALTER TABLE [dbo].[TB_ADM_CAPACITY] SET (LOCK_ESCALATION = TABLE)
GO
