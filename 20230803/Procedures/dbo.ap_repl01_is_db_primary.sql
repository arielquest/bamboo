SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_repl01_is_db_primary]
    (
      @ServerName VARCHAR(256) = NULL,
      @IsPrimary AS BIT OUT
    )
AS
    BEGIN
        IF @ServerName IS NOT NULL
        BEGIN
            IF EXISTS ( SELECT  1
                        FROM    [dbo].[TB_CLU_RESOURCE] [resource]
                        JOIN    [dbo].[TE_ADM_CLUSTER_RESOURCE_TYPE] [type] ON [type].[CLUSTER_RESOURCE_TYPE_ID] = [resource].[RESOURCE_TYPE_ID]
                        JOIN    [dbo].[TB_CLU_RESOURCE_INSTANCE] [instance] ON [instance].[RESOURCE_ID] = [resource].[RESOURCE_ID]
                        JOIN    [dbo].[TB_CLU_RESOURCE_INSTANCE_COMPONENT] [comp] ON [instance].[RESOURCE_INSTANCE_ID] = [comp].[RESOURCE_INSTANCE_ID]
                        JOIN    [dbo].[TE_CLU_RESOURCE_INSTANCE_COMPONENT_TYPE] [compType] ON [comp].[COMPONENT_TYPE_ID] = [compType].[COMPONENT_TYPE_ID]
                        JOIN    [dbo].[TB_CLU_SERVER] [server] ON [server].[SERVER_ID] = [comp].[SERVER_ID]
                        WHERE   [type].[INTERNAL_NAME] = 'CRT_EXONY_RELATIONAL_DB'
                                AND [compType].[INTERNAL_NAME] = 'CT_EXONY_RELATIONAL_DB_DEFAULT'
                                AND [instance].[IS_PUBLISHER] = 1
                                AND UPPER([server].[SERVER_NAME]) = UPPER(@ServerName) )
            BEGIN
                SET @IsPrimary = 1;
            END;
            ELSE
            BEGIN
                SET @IsPrimary = 0;
            END;
        END;
        ELSE
        BEGIN
            IF EXISTS ( SELECT  1
                        FROM    [dbo].[TB_CLU_RESOURCE] [resource]
                        JOIN    [dbo].[TE_ADM_CLUSTER_RESOURCE_TYPE] [type] ON [type].[CLUSTER_RESOURCE_TYPE_ID] = [resource].[RESOURCE_TYPE_ID]
                        JOIN    [dbo].[TB_CLU_RESOURCE_INSTANCE] [instance] ON [instance].[RESOURCE_ID] = [resource].[RESOURCE_ID]
                        JOIN    [dbo].[TB_CLU_RESOURCE_INSTANCE_COMPONENT] [comp] ON [instance].[RESOURCE_INSTANCE_ID] = [comp].[RESOURCE_INSTANCE_ID]
                        JOIN    [dbo].[TE_CLU_RESOURCE_INSTANCE_COMPONENT_TYPE] [compType] ON [comp].[COMPONENT_TYPE_ID] = [compType].[COMPONENT_TYPE_ID]
                        JOIN    [dbo].[TB_CLU_SERVER] [server] ON [server].[SERVER_ID] = [comp].[SERVER_ID]
                        WHERE   [type].[INTERNAL_NAME] = 'CRT_EXONY_RELATIONAL_DB'
                                AND [compType].[INTERNAL_NAME] = 'CT_EXONY_RELATIONAL_DB_DEFAULT'
                                AND [instance].[IS_PUBLISHER] = 1
                                AND ( UPPER([server].[SERVER_NAME]) = UPPER(CAST(SERVERPROPERTY('machinename') AS NVARCHAR(255)))
                                      OR UPPER([server].[SERVER_NAME]) = UPPER('localhost')
                                      OR UPPER([SERVER_NAME]) IN ( SELECT UPPER([dns_name]) COLLATE Latin1_General_CI_AS
                                                                   FROM   [sys].[availability_group_listeners] )
                                    ) )
            BEGIN
                SET @IsPrimary = 1;
            END;
            ELSE
            BEGIN
                SET @IsPrimary = 0;
            END;
        END;
    END;
GO
GRANT EXECUTE
	ON [dbo].[ap_repl01_is_db_primary]
	TO [portalapp_role]
GO
