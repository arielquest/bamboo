SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Skill_Group]
AS
SELECT  CAST([skillGroup].[PKEY1] AS INT) AS SkillTargetID,
        NULL AS ScheduleID,
        CAST([peripheral].[PKEY1] AS INT) AS PeripheralID,
        [skillGroup].[NAME] AS EnterpriseName,
        [skillGroup].[PERIPHERAL_NUMBER] AS PeripheralNumber,
        [skillGroup].[PERIPHERAL_NAME] AS PeripheralName,
        [skillGroup].[AVAILABLE_HOLDOFF_DELAY] AS AvailableHoldoffDelay,
        [skillGroup].[PRIORITY] AS Priority,
        NULL AS BaseSkillTargetID,
        [skillGroup].[EXTENSION] AS Extension,
        NULL AS SubGroupMaskType,
        [skillGroup].[SUB_SKILLGROUP_MASK] AS SubSkillGroupMask,
        NULL AS ConfigParam,
        [skillGroup].[DESCRIPTION] AS Description,
        CASE [skillGroup].[DELETED]
          WHEN 0 THEN 'N'
          ELSE 'Y'
        END AS Deleted,
        CAST([MRDomain].[PKEY1] AS INT) AS MRDomainID,
        [skillGroup].[IPTA] AS IPTA,
        [skillGroup].[DEFAULT_ENTRY] AS DefaultEntry,
        [skillGroup].[USER_DELETABLE] AS UserDeletable,
        [skillGroup].[SERVICE_LEVEL_THRESHOLD] AS ServiceLevelThreshold,
        [skillGroup].[SERVICE_LEVEL_TYPE] AS ServiceLevelType,
        [skillGroup].[SOURCE_CHANGE_STAMP] AS ChangeStamp
FROM    [dbo].[VW_DIM_SKILLGROUP_PKEY] skillGroup
JOIN    [dbo].[VW_DIM_SKILLGROUP_PERIPHERAL_MEMBER] AS skillGroupPeripheralMember ON [skillGroupPeripheralMember].[CHILD_ITEM_BIZ_URN] = [skillGroup].[ITEM_URN]
                                                              AND [skillGroupPeripheralMember].[LATEST] = 1
JOIN    [dbo].[VW_DIM_PERIPHERAL_PKEY] AS peripheral ON [peripheral].[ITEM_URN] = [skillGroupPeripheralMember].[PARENT_ITEM_BIZ_URN]
JOIN    [dbo].[VW_DIM_SKILLGROUP_MEDIA_ROUTING_DOMAIN_MEMBER] AS skillGroupMRDomainMember ON [skillGroupMRDomainMember].[CHILD_ITEM_BIZ_URN] = [skillGroup].[ITEM_URN]
                                                              AND [skillGroupMRDomainMember].[LATEST] = 1
JOIN    [dbo].[VW_DIM_MEDIA_ROUTING_DOMAIN_PKEY] MRDomain ON [MRDomain].[ITEM_URN] = [skillGroupMRDomainMember].[PARENT_ITEM_BIZ_URN];
GO
