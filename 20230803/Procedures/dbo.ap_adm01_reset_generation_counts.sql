SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_adm01_reset_generation_counts]
(
    @ReplicationTypeFilter AS CHAR(1) = NULL,
    @Prepare AS BIT = 1
)
AS
    SET NOCOUNT ON;

    IF @Prepare = 1
    BEGIN 
        EXEC [dbo].[ap_adm01_prepare_reset_generation_counts];
    END;

    -- Dimension and Dimension Pkey Map tables
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_AGENT' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_AGENT', 'TS_DIM_AGENT_GC', 1;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_AGENT_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_AGENT_PKEY_MAP', 'TS_DIM_AGENT_PKEY_MAP_GC', 1001;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_AGENT_DESKTOP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_AGENT_DESKTOP', 'TS_DIM_AGENT_DESKTOP_GC', 2;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_AGENT_DESKTOP_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_AGENT_DESKTOP_PKEY_MAP', 'TS_DIM_AGENT_DESKTOP_PKEY_MAP_GC', 1002;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_AGENT_TEAM' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_AGENT_TEAM', 'TS_DIM_AGENT_TEAM_GC', 3;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_AGENT_TEAM_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_AGENT_TEAM_PKEY_MAP', 'TS_DIM_AGENT_TEAM_PKEY_MAP_GC', 1003;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_ALIAS' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_ALIAS', 'TS_DIM_ALIAS_GC', 116;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_ALIAS_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_ALIAS_PKEY_MAP', 'TS_DIM_ALIAS_PKEY_MAP_GC', 1116;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_ANNOUNCEMENT' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_ANNOUNCEMENT', 'TS_DIM_ANNOUNCEMENT_GC', 4;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_ANNOUNCEMENT_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_ANNOUNCEMENT_PKEY_MAP', 'TS_DIM_ANNOUNCEMENT_PKEY_MAP_GC', 1004;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_APPLICATION_GATEWAY' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_APPLICATION_GATEWAY', 'TS_DIM_APPLICATION_GATEWAY_GC', 5;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_APPLICATION_GATEWAY_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_APPLICATION_GATEWAY_PKEY_MAP', 'TS_DIM_APPLICATION_GATEWAY_PKEY_MAP_GC', 1005;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_APPLICATION_INSTANCE' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_APPLICATION_INSTANCE', 'TS_DIM_APPLICATION_INSTANCE_GC', 6;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_APPLICATION_INSTANCE_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_APPLICATION_INSTANCE_PKEY_MAP', 'TS_DIM_APPLICATION_INSTANCE_PKEY_MAP_GC', 1006;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_APPLICATION_USER' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_APPLICATION_USER', 'TS_DIM_APPLICATION_USER_GC', 7;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_APPLICATION_USER_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_APPLICATION_USER_PKEY_MAP', 'TS_DIM_APPLICATION_USER_PKEY_MAP_GC', 1007;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_BUCKET_INTERVAL' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_BUCKET_INTERVAL', 'TS_DIM_BUCKET_INTERVAL_GC', 8;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_BUCKET_INTERVAL_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_BUCKET_INTERVAL_PKEY_MAP', 'TS_DIM_BUCKET_INTERVAL_PKEY_MAP_GC', 1008;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_CALL_MANAGER_GROUP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_CALL_MANAGER_GROUP', 'TS_DIM_CALL_MANAGER_GROUP_GC', 10;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_CALL_MANAGER_GROUP_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_CALL_MANAGER_GROUP_PKEY_MAP', 'TS_DIM_CALL_MANAGER_GROUP_PKEY_MAP_GC', 1010;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_CALL_SOURCE' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_CALL_SOURCE', 'TS_DIM_CALL_SOURCE_GC', 11;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_CALL_SOURCE_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_CALL_SOURCE_PKEY_MAP', 'TS_DIM_CALL_SOURCE_PKEY_MAP_GC', 1011;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_CALL_TYPE' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_CALL_TYPE', 'TS_DIM_CALL_TYPE_GC', 12;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_CALL_TYPE_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_CALL_TYPE_PKEY_MAP', 'TS_DIM_CALL_TYPE_PKEY_MAP_GC', 1012;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_CALLING_SEARCH_SPACE' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_CALLING_SEARCH_SPACE', 'TS_DIM_CALLING_SEARCH_SPACE_GC', 9;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_CALLING_SEARCH_SPACE_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_CALLING_SEARCH_SPACE_PKEY_MAP', 'TS_DIM_CALLING_SEARCH_SPACE_PKEY_MAP_GC', 1009;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_CAMPAIGN' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_CAMPAIGN', 'TS_DIM_CAMPAIGN_GC', 13;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_CAMPAIGN_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_CAMPAIGN_PKEY_MAP', 'TS_DIM_CAMPAIGN_PKEY_MAP_GC', 1013;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_CATEGORY' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_CATEGORY', 'TS_DIM_CATEGORY_GC', 14;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_CATEGORY_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_CATEGORY_PKEY_MAP', 'TS_DIM_CATEGORY_PKEY_MAP_GC', 1014;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_CBR_RELEASE' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_CBR_RELEASE', 'TS_DIM_CBR_RELEASE_GC', 127;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_CBR_RELEASE_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_CBR_RELEASE_PKEY_MAP', 'TS_DIM_CBR_RELEASE_PKEY_MAP_GC', 1127;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_CHARGEBAND' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_CHARGEBAND', 'TS_DIM_CHARGEBAND_GC', 15;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_CHARGEBAND_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_CHARGEBAND_PKEY_MAP', 'TS_DIM_CHARGEBAND_PKEY_MAP_GC', 1015;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_CHAT_REFERRER_NAME' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_CHAT_REFERRER_NAME', 'TS_DIM_CHAT_REFERRER_NAME_GC', 162;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_CHAT_REFERRER_NAME_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_CHAT_REFERRER_NAME_PKEY_MAP', 'TS_DIM_CHAT_REFERRER_NAME_PKEY_MAP_GC', 1162;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_CHAT_REFERRER_URL' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_CHAT_REFERRER_URL', 'TS_DIM_CHAT_REFERRER_URL_GC', 163;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_CHAT_REFERRER_URL_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_CHAT_REFERRER_URL_PKEY_MAP', 'TS_DIM_CHAT_REFERRER_URL_PKEY_MAP_GC', 1163;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_CLI' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_CLI', 'TS_DIM_CLI_GC', 16;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_CLI_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_CLI_PKEY_MAP', 'TS_DIM_CLI_PKEY_MAP_GC', 1016;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_COBROWSE_PAGE' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_COBROWSE_PAGE', 'TS_DIM_COBROWSE_PAGE_GC', 161;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_COBROWSE_PAGE_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_COBROWSE_PAGE_PKEY_MAP', 'TS_DIM_COBROWSE_PAGE_PKEY_MAP_GC', 1161;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_CODE' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_CODE', 'TS_DIM_CODE_GC', 17;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_CODE_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_CODE_PKEY_MAP', 'TS_DIM_CODE_PKEY_MAP_GC', 1017;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_CODE_GROUP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_CODE_GROUP', 'TS_DIM_CODE_GROUP_GC', 18;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_CODE_GROUP_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_CODE_GROUP_PKEY_MAP', 'TS_DIM_CODE_GROUP_PKEY_MAP_GC', 1018;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_CONTENT_URL' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_CONTENT_URL', 'TS_DIM_CONTENT_URL_GC', 120;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_CONTENT_URL_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_CONTENT_URL_PKEY_MAP', 'TS_DIM_CONTENT_URL_PKEY_MAP_GC', 1120;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_CUSTOM' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_CUSTOM', 'TS_DIM_CUSTOM_GC', 19;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_CUSTOM_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_CUSTOM_PKEY_MAP', 'TS_DIM_CUSTOM_PKEY_MAP_GC', 1019;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_CUSTOM_ATTRIBUTE0' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_CUSTOM_ATTRIBUTE0', 'TS_DIM_CUSTOM_ATTRIBUTE0_GC', 132;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_CUSTOM_ATTRIBUTE0_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_CUSTOM_ATTRIBUTE0_PKEY_MAP', 'TS_DIM_CUSTOM_ATTRIBUTE0_PKEY_MAP_GC', 1132;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_CUSTOM_ATTRIBUTE1' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_CUSTOM_ATTRIBUTE1', 'TS_DIM_CUSTOM_ATTRIBUTE1_GC', 133;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_CUSTOM_ATTRIBUTE1_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_CUSTOM_ATTRIBUTE1_PKEY_MAP', 'TS_DIM_CUSTOM_ATTRIBUTE1_PKEY_MAP_GC', 1133;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_CUSTOM_ATTRIBUTE2' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_CUSTOM_ATTRIBUTE2', 'TS_DIM_CUSTOM_ATTRIBUTE2_GC', 134;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_CUSTOM_ATTRIBUTE2_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_CUSTOM_ATTRIBUTE2_PKEY_MAP', 'TS_DIM_CUSTOM_ATTRIBUTE2_PKEY_MAP_GC', 1134;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_CUSTOM_ATTRIBUTE3' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_CUSTOM_ATTRIBUTE3', 'TS_DIM_CUSTOM_ATTRIBUTE3_GC', 135;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_CUSTOM_ATTRIBUTE3_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_CUSTOM_ATTRIBUTE3_PKEY_MAP', 'TS_DIM_CUSTOM_ATTRIBUTE3_PKEY_MAP_GC', 1135;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_CUSTOM_ATTRIBUTE4' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_CUSTOM_ATTRIBUTE4', 'TS_DIM_CUSTOM_ATTRIBUTE4_GC', 136;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_CUSTOM_ATTRIBUTE4_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_CUSTOM_ATTRIBUTE4_PKEY_MAP', 'TS_DIM_CUSTOM_ATTRIBUTE4_PKEY_MAP_GC', 1136;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_CUSTOM_ATTRIBUTE5' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_CUSTOM_ATTRIBUTE5', 'TS_DIM_CUSTOM_ATTRIBUTE5_GC', 137;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_CUSTOM_ATTRIBUTE5_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_CUSTOM_ATTRIBUTE5_PKEY_MAP', 'TS_DIM_CUSTOM_ATTRIBUTE5_PKEY_MAP_GC', 1137;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_CUSTOM_ATTRIBUTE6' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_CUSTOM_ATTRIBUTE6', 'TS_DIM_CUSTOM_ATTRIBUTE6_GC', 138;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_CUSTOM_ATTRIBUTE6_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_CUSTOM_ATTRIBUTE6_PKEY_MAP', 'TS_DIM_CUSTOM_ATTRIBUTE6_PKEY_MAP_GC', 1138;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_CUSTOM_ATTRIBUTE7' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_CUSTOM_ATTRIBUTE7', 'TS_DIM_CUSTOM_ATTRIBUTE7_GC', 139;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_CUSTOM_ATTRIBUTE7_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_CUSTOM_ATTRIBUTE7_PKEY_MAP', 'TS_DIM_CUSTOM_ATTRIBUTE7_PKEY_MAP_GC', 1139;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_CUSTOM_ATTRIBUTE8' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_CUSTOM_ATTRIBUTE8', 'TS_DIM_CUSTOM_ATTRIBUTE8_GC', 140;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_CUSTOM_ATTRIBUTE8_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_CUSTOM_ATTRIBUTE8_PKEY_MAP', 'TS_DIM_CUSTOM_ATTRIBUTE8_PKEY_MAP_GC', 1140;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_CUSTOM_ATTRIBUTE9' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_CUSTOM_ATTRIBUTE9', 'TS_DIM_CUSTOM_ATTRIBUTE9_GC', 141;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_CUSTOM_ATTRIBUTE9_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_CUSTOM_ATTRIBUTE9_PKEY_MAP', 'TS_DIM_CUSTOM_ATTRIBUTE9_PKEY_MAP_GC', 1141;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_CUSTOM_ENTRY' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_CUSTOM_ENTRY', 'TS_DIM_CUSTOM_ENTRY_GC', 30;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_CUSTOM_ENTRY_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_CUSTOM_ENTRY_PKEY_MAP', 'TS_DIM_CUSTOM_ENTRY_PKEY_MAP_GC', 1030;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_CUSTOM0' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_CUSTOM0', 'TS_DIM_CUSTOM0_GC', 20;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_CUSTOM0_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_CUSTOM0_PKEY_MAP', 'TS_DIM_CUSTOM0_PKEY_MAP_GC', 1020;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_CUSTOM1' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_CUSTOM1', 'TS_DIM_CUSTOM1_GC', 21;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_CUSTOM1_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_CUSTOM1_PKEY_MAP', 'TS_DIM_CUSTOM1_PKEY_MAP_GC', 1021;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_CUSTOM2' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_CUSTOM2', 'TS_DIM_CUSTOM2_GC', 22;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_CUSTOM2_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_CUSTOM2_PKEY_MAP', 'TS_DIM_CUSTOM2_PKEY_MAP_GC', 1022;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_CUSTOM3' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_CUSTOM3', 'TS_DIM_CUSTOM3_GC', 23;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_CUSTOM3_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_CUSTOM3_PKEY_MAP', 'TS_DIM_CUSTOM3_PKEY_MAP_GC', 1023;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_CUSTOM4' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_CUSTOM4', 'TS_DIM_CUSTOM4_GC', 24;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_CUSTOM4_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_CUSTOM4_PKEY_MAP', 'TS_DIM_CUSTOM4_PKEY_MAP_GC', 1024;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_CUSTOM5' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_CUSTOM5', 'TS_DIM_CUSTOM5_GC', 25;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_CUSTOM5_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_CUSTOM5_PKEY_MAP', 'TS_DIM_CUSTOM5_PKEY_MAP_GC', 1025;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_CUSTOM6' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_CUSTOM6', 'TS_DIM_CUSTOM6_GC', 26;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_CUSTOM6_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_CUSTOM6_PKEY_MAP', 'TS_DIM_CUSTOM6_PKEY_MAP_GC', 1026;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_CUSTOM7' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_CUSTOM7', 'TS_DIM_CUSTOM7_GC', 27;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_CUSTOM7_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_CUSTOM7_PKEY_MAP', 'TS_DIM_CUSTOM7_PKEY_MAP_GC', 1027;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_CUSTOM8' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_CUSTOM8', 'TS_DIM_CUSTOM8_GC', 28;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_CUSTOM8_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_CUSTOM8_PKEY_MAP', 'TS_DIM_CUSTOM8_PKEY_MAP_GC', 1028;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_CUSTOM9' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_CUSTOM9', 'TS_DIM_CUSTOM9_GC', 29;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_CUSTOM9_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_CUSTOM9_PKEY_MAP', 'TS_DIM_CUSTOM9_PKEY_MAP_GC', 1029;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_DATE_TIME_SETTING' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_DATE_TIME_SETTING', 'TS_DIM_DATE_TIME_SETTING_GC', 31;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_DATE_TIME_SETTING_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_DATE_TIME_SETTING_PKEY_MAP', 'TS_DIM_DATE_TIME_SETTING_PKEY_MAP_GC', 1031;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_DEPARTMENT' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_DEPARTMENT', 'TS_DIM_DEPARTMENT_GC', 111;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_DEPARTMENT_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_DEPARTMENT_PKEY_MAP', 'TS_DIM_DEPARTMENT_PKEY_MAP_GC', 1111;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_DEVICE_POOL' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_DEVICE_POOL', 'TS_DIM_DEVICE_POOL_GC', 32;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_DEVICE_POOL_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_DEVICE_POOL_PKEY_MAP', 'TS_DIM_DEVICE_POOL_PKEY_MAP_GC', 1032;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_DEVICE_PROFILE' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_DEVICE_PROFILE', 'TS_DIM_DEVICE_PROFILE_GC', 33;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_DEVICE_PROFILE_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_DEVICE_PROFILE_PKEY_MAP', 'TS_DIM_DEVICE_PROFILE_PKEY_MAP_GC', 1033;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_DEVICE_TARGET' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_DEVICE_TARGET', 'TS_DIM_DEVICE_TARGET_GC', 34;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_DEVICE_TARGET_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_DEVICE_TARGET_PKEY_MAP', 'TS_DIM_DEVICE_TARGET_PKEY_MAP_GC', 1034;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_DIAL_NUMBER_PLAN' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_DIAL_NUMBER_PLAN', 'TS_DIM_DIAL_NUMBER_PLAN_GC', 37;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_DIAL_NUMBER_PLAN_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_DIAL_NUMBER_PLAN_PKEY_MAP', 'TS_DIM_DIAL_NUMBER_PLAN_PKEY_MAP_GC', 1037;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_DIALED_NUMBER' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_DIALED_NUMBER', 'TS_DIM_DIALED_NUMBER_GC', 35;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_DIALED_NUMBER_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_DIALED_NUMBER_PKEY_MAP', 'TS_DIM_DIALED_NUMBER_PKEY_MAP_GC', 1035;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_DIALER' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_DIALER', 'TS_DIM_DIALER_GC', 36;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_DIALER_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_DIALER_PKEY_MAP', 'TS_DIM_DIALER_PKEY_MAP_GC', 1036;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_DIRECTORY_NUMBER' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_DIRECTORY_NUMBER', 'TS_DIM_DIRECTORY_NUMBER_GC', 38;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_DIRECTORY_NUMBER_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_DIRECTORY_NUMBER_PKEY_MAP', 'TS_DIM_DIRECTORY_NUMBER_PKEY_MAP_GC', 1038;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_DOCUMENT' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_DOCUMENT', 'TS_DIM_DOCUMENT_GC', 112;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_ECC_PAYLOAD' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_ECC_PAYLOAD', 'TS_DIM_ECC_PAYLOAD_GC', 157;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_ECC_PAYLOAD_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_ECC_PAYLOAD_PKEY_MAP', 'TS_DIM_ECC_PAYLOAD_PKEY_MAP_GC', 1157;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_EMAIL' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_EMAIL', 'TS_DIM_EMAIL_GC', 39;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_EMAIL_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_EMAIL_PKEY_MAP', 'TS_DIM_EMAIL_PKEY_MAP_GC', 1039;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_ENTERPRISE_ROUTE' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_ENTERPRISE_ROUTE', 'TS_DIM_ENTERPRISE_ROUTE_GC', 40;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_ENTERPRISE_ROUTE_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_ENTERPRISE_ROUTE_PKEY_MAP', 'TS_DIM_ENTERPRISE_ROUTE_PKEY_MAP_GC', 1040;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_ENTERPRISE_SERVICE' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_ENTERPRISE_SERVICE', 'TS_DIM_ENTERPRISE_SERVICE_GC', 41;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_ENTERPRISE_SERVICE_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_ENTERPRISE_SERVICE_PKEY_MAP', 'TS_DIM_ENTERPRISE_SERVICE_PKEY_MAP_GC', 1041;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_ENTERPRISE_SKILLGROUP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_ENTERPRISE_SKILLGROUP', 'TS_DIM_ENTERPRISE_SKILLGROUP_GC', 42;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_ENTERPRISE_SKILLGROUP_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_ENTERPRISE_SKILLGROUP_PKEY_MAP', 'TS_DIM_ENTERPRISE_SKILLGROUP_PKEY_MAP_GC', 1042;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_ENTRY_POINT' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_ENTRY_POINT', 'TS_DIM_ENTRY_POINT_GC', 115;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_ENTRY_POINT_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_ENTRY_POINT_PKEY_MAP', 'TS_DIM_ENTRY_POINT_PKEY_MAP_GC', 1115;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_EXPANDED_CALL_VARIABLE' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_EXPANDED_CALL_VARIABLE', 'TS_DIM_EXPANDED_CALL_VARIABLE_GC', 43;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_EXPANDED_CALL_VARIABLE_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_EXPANDED_CALL_VARIABLE_PKEY_MAP', 'TS_DIM_EXPANDED_CALL_VARIABLE_PKEY_MAP_GC', 1043;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_FILESHARE' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_FILESHARE', 'TS_DIM_FILESHARE_GC', 44;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_FILESHARE_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_FILESHARE_PKEY_MAP', 'TS_DIM_FILESHARE_PKEY_MAP_GC', 1044;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_GATEWAY_FUNCTION' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_GATEWAY_FUNCTION', 'TS_DIM_GATEWAY_FUNCTION_GC', 46;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_GATEWAY_FUNCTION_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_GATEWAY_FUNCTION_PKEY_MAP', 'TS_DIM_GATEWAY_FUNCTION_PKEY_MAP_GC', 1046;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_GATEWAY_RESULT' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_GATEWAY_RESULT', 'TS_DIM_GATEWAY_RESULT_GC', 47;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_GATEWAY_RESULT_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_GATEWAY_RESULT_PKEY_MAP', 'TS_DIM_GATEWAY_RESULT_PKEY_MAP_GC', 1047;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_GATEWAY_SERVER' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_GATEWAY_SERVER', 'TS_DIM_GATEWAY_SERVER_GC', 48;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_GATEWAY_SERVER_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_GATEWAY_SERVER_PKEY_MAP', 'TS_DIM_GATEWAY_SERVER_PKEY_MAP_GC', 1048;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_GHE_ANSWER' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_GHE_ANSWER', 'TS_DIM_GHE_ANSWER_GC', 130;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_GHE_ANSWER_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_GHE_ANSWER_PKEY_MAP', 'TS_DIM_GHE_ANSWER_PKEY_MAP_GC', 1130;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_GHE_CLUSTER' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_GHE_CLUSTER', 'TS_DIM_GHE_CLUSTER_GC', 164;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_GHE_CLUSTER_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_GHE_CLUSTER_PKEY_MAP', 'TS_DIM_GHE_CLUSTER_PKEY_MAP_GC', 1164;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_GHE_CLUSTER_GROUP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_GHE_CLUSTER_GROUP', 'TS_DIM_GHE_CLUSTER_GROUP_GC', 165;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_GHE_CLUSTER_GROUP_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_GHE_CLUSTER_GROUP_PKEY_MAP', 'TS_DIM_GHE_CLUSTER_GROUP_PKEY_MAP_GC', 1165;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_GHE_QUESTION' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_GHE_QUESTION', 'TS_DIM_GHE_QUESTION_GC', 129;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_GHE_QUESTION_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_GHE_QUESTION_PKEY_MAP', 'TS_DIM_GHE_QUESTION_PKEY_MAP_GC', 1129;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_HIERARCHY' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_HIERARCHY', 'TS_DIM_HIERARCHY_GC', 49;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_HIERARCHY_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_HIERARCHY_PKEY_MAP', 'TS_DIM_HIERARCHY_PKEY_MAP_GC', 1049;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_HIERARCHY_NODE' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_HIERARCHY_NODE', 'TS_DIM_HIERARCHY_NODE_GC', 50;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_HIERARCHY_NODE_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_HIERARCHY_NODE_PKEY_MAP', 'TS_DIM_HIERARCHY_NODE_PKEY_MAP_GC', 1050;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_HUNT_PILOT' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_HUNT_PILOT', 'TS_DIM_HUNT_PILOT_GC', 107;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_HUNT_PILOT_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_HUNT_PILOT_PKEY_MAP', 'TS_DIM_HUNT_PILOT_PKEY_MAP_GC', 1107;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_ICR_INSTANCE' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_ICR_INSTANCE', 'TS_DIM_ICR_INSTANCE_GC', 51;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_ICR_INSTANCE_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_ICR_INSTANCE_PKEY_MAP', 'TS_DIM_ICR_INSTANCE_PKEY_MAP_GC', 1051;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_IMPORT_RULE' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_IMPORT_RULE', 'TS_DIM_IMPORT_RULE_GC', 52;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_IMPORT_RULE_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_IMPORT_RULE_PKEY_MAP', 'TS_DIM_IMPORT_RULE_PKEY_MAP_GC', 1052;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_IP_ENDPOINT' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_IP_ENDPOINT', 'TS_DIM_IP_ENDPOINT_GC', 53;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_IP_ENDPOINT_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_IP_ENDPOINT_PKEY_MAP', 'TS_DIM_IP_ENDPOINT_PKEY_MAP_GC', 1053;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_IP_ENDPOINT_BUTTON_TEMPLATE' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_IP_ENDPOINT_BUTTON_TEMPLATE', 'TS_DIM_IP_ENDPOINT_BUTTON_TEMPLATE_GC', 54;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_IP_ENDPOINT_BUTTON_TEMPLATE_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_IP_ENDPOINT_BUTTON_TEMPLATE_PKEY_MAP', 'TS_DIM_IP_ENDPOINT_BUTTON_TEMPLATE_PKEY_MAP_GC', 1054;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_IVR_ENTRY_POINT' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_IVR_ENTRY_POINT', 'TS_DIM_IVR_ENTRY_POINT_GC', 55;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_IVR_ENTRY_POINT_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_IVR_ENTRY_POINT_PKEY_MAP', 'TS_DIM_IVR_ENTRY_POINT_PKEY_MAP_GC', 1055;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_IVR_MODULE' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_IVR_MODULE', 'TS_DIM_IVR_MODULE_GC', 56;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_IVR_MODULE_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_IVR_MODULE_PKEY_MAP', 'TS_DIM_IVR_MODULE_PKEY_MAP_GC', 1056;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_IVR_QUEUE' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_IVR_QUEUE', 'TS_DIM_IVR_QUEUE_GC', 57;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_IVR_QUEUE_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_IVR_QUEUE_PKEY_MAP', 'TS_DIM_IVR_QUEUE_PKEY_MAP_GC', 1057;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_IVR_ROUTING_TARGET' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_IVR_ROUTING_TARGET', 'TS_DIM_IVR_ROUTING_TARGET_GC', 58;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_IVR_ROUTING_TARGET_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_IVR_ROUTING_TARGET_PKEY_MAP', 'TS_DIM_IVR_ROUTING_TARGET_PKEY_MAP_GC', 1058;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_IVR_SCRIPT' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_IVR_SCRIPT', 'TS_DIM_IVR_SCRIPT_GC', 59;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_IVR_SCRIPT_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_IVR_SCRIPT_PKEY_MAP', 'TS_DIM_IVR_SCRIPT_PKEY_MAP_GC', 1059;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_IVR_SCRIPT_NODE' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_IVR_SCRIPT_NODE', 'TS_DIM_IVR_SCRIPT_NODE_GC', 60;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_IVR_SCRIPT_NODE_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_IVR_SCRIPT_NODE_PKEY_MAP', 'TS_DIM_IVR_SCRIPT_NODE_PKEY_MAP_GC', 1060;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_IVR_SCRIPT_NODE_EXIT_STATE' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_IVR_SCRIPT_NODE_EXIT_STATE', 'TS_DIM_IVR_SCRIPT_NODE_EXIT_STATE_GC', 61;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_IVR_SCRIPT_NODE_EXIT_STATE_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_IVR_SCRIPT_NODE_EXIT_STATE_PKEY_MAP', 'TS_DIM_IVR_SCRIPT_NODE_EXIT_STATE_PKEY_MAP_GC', 1061;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_IVR_SERVER' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_IVR_SERVER', 'TS_DIM_IVR_SERVER_GC', 62;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_IVR_SERVER_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_IVR_SERVER_PKEY_MAP', 'TS_DIM_IVR_SERVER_PKEY_MAP_GC', 1062;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_KB_ARTICLE' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_KB_ARTICLE', 'TS_DIM_KB_ARTICLE_GC', 123;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_KB_ARTICLE_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_KB_ARTICLE_PKEY_MAP', 'TS_DIM_KB_ARTICLE_PKEY_MAP_GC', 1123;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_KB_ARTICLE_REVIEW_STAGE' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_KB_ARTICLE_REVIEW_STAGE', 'TS_DIM_KB_ARTICLE_REVIEW_STAGE_GC', 172;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_KB_ARTICLE_REVIEW_STAGE_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_KB_ARTICLE_REVIEW_STAGE_PKEY_MAP', 'TS_DIM_KB_ARTICLE_REVIEW_STAGE_PKEY_MAP_GC', 1172;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_KB_ARTICLE_WORKFLOW' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_KB_ARTICLE_WORKFLOW', 'TS_DIM_KB_ARTICLE_WORKFLOW_GC', 158;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_KB_ARTICLE_WORKFLOW_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_KB_ARTICLE_WORKFLOW_PKEY_MAP', 'TS_DIM_KB_ARTICLE_WORKFLOW_PKEY_MAP_GC', 1158;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_KB_COMPLIANCE_POLICY' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_KB_COMPLIANCE_POLICY', 'TS_DIM_KB_COMPLIANCE_POLICY_GC', 171;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_KB_COMPLIANCE_POLICY_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_KB_COMPLIANCE_POLICY_PKEY_MAP', 'TS_DIM_KB_COMPLIANCE_POLICY_PKEY_MAP_GC', 1171;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_KB_FOLDER' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_KB_FOLDER', 'TS_DIM_KB_FOLDER_GC', 124;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_KB_FOLDER_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_KB_FOLDER_PKEY_MAP', 'TS_DIM_KB_FOLDER_PKEY_MAP_GC', 1124;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_KB_PORTAL' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_KB_PORTAL', 'TS_DIM_KB_PORTAL_GC', 121;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_KB_PORTAL_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_KB_PORTAL_PKEY_MAP', 'TS_DIM_KB_PORTAL_PKEY_MAP_GC', 1121;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_KB_TOPIC' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_KB_TOPIC', 'TS_DIM_KB_TOPIC_GC', 122;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_KB_TOPIC_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_KB_TOPIC_PKEY_MAP', 'TS_DIM_KB_TOPIC_PKEY_MAP_GC', 1122;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_LABEL' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_LABEL', 'TS_DIM_LABEL_GC', 63;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_LABEL_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_LABEL_PKEY_MAP', 'TS_DIM_LABEL_PKEY_MAP_GC', 1063;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_LOGICAL_INTERFACE_CONTROLLER' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_LOGICAL_INTERFACE_CONTROLLER', 'TS_DIM_LOGICAL_INTERFACE_CONTROLLER_GC', 64;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_LOGICAL_INTERFACE_CONTROLLER_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_LOGICAL_INTERFACE_CONTROLLER_PKEY_MAP', 'TS_DIM_LOGICAL_INTERFACE_CONTROLLER_PKEY_MAP_GC', 1064;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_MACHINE' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_MACHINE', 'TS_DIM_MACHINE_GC', 65;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_MACHINE_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_MACHINE_PKEY_MAP', 'TS_DIM_MACHINE_PKEY_MAP_GC', 1065;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_MACHINE_RESOURCE' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_MACHINE_RESOURCE', 'TS_DIM_MACHINE_RESOURCE_GC', 66;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_MACHINE_RESOURCE_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_MACHINE_RESOURCE_PKEY_MAP', 'TS_DIM_MACHINE_RESOURCE_PKEY_MAP_GC', 1066;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_MEDIA_CLASS' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_MEDIA_CLASS', 'TS_DIM_MEDIA_CLASS_GC', 67;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_MEDIA_CLASS_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_MEDIA_CLASS_PKEY_MAP', 'TS_DIM_MEDIA_CLASS_PKEY_MAP_GC', 1067;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_MEDIA_ROUTING_DOMAIN' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_MEDIA_ROUTING_DOMAIN', 'TS_DIM_MEDIA_ROUTING_DOMAIN_GC', 68;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_MEDIA_ROUTING_DOMAIN_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_MEDIA_ROUTING_DOMAIN_PKEY_MAP', 'TS_DIM_MEDIA_ROUTING_DOMAIN_PKEY_MAP_GC', 1068;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_MEDIAFILE' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_MEDIAFILE', 'TS_DIM_MEDIAFILE_GC', 108;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_MEDIAFILE_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_MEDIAFILE_PKEY_MAP', 'TS_DIM_MEDIAFILE_PKEY_MAP_GC', 1108;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_MEDIAFILE_SERVER' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_MEDIAFILE_SERVER', 'TS_DIM_MEDIAFILE_SERVER_GC', 109;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_MEDIAFILE_SERVER_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_MEDIAFILE_SERVER_PKEY_MAP', 'TS_DIM_MEDIAFILE_SERVER_PKEY_MAP_GC', 1109;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_NETWORK_TRUNK_GROUP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_NETWORK_TRUNK_GROUP', 'TS_DIM_NETWORK_TRUNK_GROUP_GC', 69;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_NETWORK_TRUNK_GROUP_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_NETWORK_TRUNK_GROUP_PKEY_MAP', 'TS_DIM_NETWORK_TRUNK_GROUP_PKEY_MAP_GC', 1069;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_NETWORK_VRU' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_NETWORK_VRU', 'TS_DIM_NETWORK_VRU_GC', 70;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_NETWORK_VRU_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_NETWORK_VRU_PKEY_MAP', 'TS_DIM_NETWORK_VRU_PKEY_MAP_GC', 1070;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_NETWORK_VRU_SCRIPT' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_NETWORK_VRU_SCRIPT', 'TS_DIM_NETWORK_VRU_SCRIPT_GC', 71;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_NETWORK_VRU_SCRIPT_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_NETWORK_VRU_SCRIPT_PKEY_MAP', 'TS_DIM_NETWORK_VRU_SCRIPT_PKEY_MAP_GC', 1071;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_NOTIFY_CATEGORY' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_NOTIFY_CATEGORY', 'TS_DIM_NOTIFY_CATEGORY_GC', 125;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_NOTIFY_CATEGORY_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_NOTIFY_CATEGORY_PKEY_MAP', 'TS_DIM_NOTIFY_CATEGORY_PKEY_MAP_GC', 1125;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_NOTIFY_CHANNEL' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_NOTIFY_CHANNEL', 'TS_DIM_NOTIFY_CHANNEL_GC', 159;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_NOTIFY_CHANNEL_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_NOTIFY_CHANNEL_PKEY_MAP', 'TS_DIM_NOTIFY_CHANNEL_PKEY_MAP_GC', 1159;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_NOTIFY_MESSAGE_TYPE' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_NOTIFY_MESSAGE_TYPE', 'TS_DIM_NOTIFY_MESSAGE_TYPE_GC', 128;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_NOTIFY_MESSAGE_TYPE_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_NOTIFY_MESSAGE_TYPE_PKEY_MAP', 'TS_DIM_NOTIFY_MESSAGE_TYPE_PKEY_MAP_GC', 1128;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_NOTIFY_ORIGIN' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_NOTIFY_ORIGIN', 'TS_DIM_NOTIFY_ORIGIN_GC', 160;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_NOTIFY_ORIGIN_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_NOTIFY_ORIGIN_PKEY_MAP', 'TS_DIM_NOTIFY_ORIGIN_PKEY_MAP_GC', 1160;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_OBJECT_TYPE' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_OBJECT_TYPE', 'TS_DIM_OBJECT_TYPE_GC', 72;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_OBJECT_TYPE_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_OBJECT_TYPE_PKEY_MAP', 'TS_DIM_OBJECT_TYPE_PKEY_MAP_GC', 1072;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_OFFER' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_OFFER', 'TS_DIM_OFFER_GC', 118;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_OFFER_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_OFFER_PKEY_MAP', 'TS_DIM_OFFER_PKEY_MAP_GC', 1118;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_OFFER_BANNER' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_OFFER_BANNER', 'TS_DIM_OFFER_BANNER_GC', 119;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_OFFER_BANNER_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_OFFER_BANNER_PKEY_MAP', 'TS_DIM_OFFER_BANNER_PKEY_MAP_GC', 1119;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_PERIPHERAL' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_PERIPHERAL', 'TS_DIM_PERIPHERAL_GC', 73;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_PERIPHERAL_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_PERIPHERAL_PKEY_MAP', 'TS_DIM_PERIPHERAL_PKEY_MAP_GC', 1073;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_PERSON' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_PERSON', 'TS_DIM_PERSON_GC', 74;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_PERSON_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_PERSON_PKEY_MAP', 'TS_DIM_PERSON_PKEY_MAP_GC', 1074;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_PHYSICAL_INTERFACE_CONTROLLER' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_PHYSICAL_INTERFACE_CONTROLLER', 'TS_DIM_PHYSICAL_INTERFACE_CONTROLLER_GC', 75;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_PHYSICAL_INTERFACE_CONTROLLER_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_PHYSICAL_INTERFACE_CONTROLLER_PKEY_MAP', 'TS_DIM_PHYSICAL_INTERFACE_CONTROLLER_PKEY_MAP_GC', 1075;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_PORT' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_PORT', 'TS_DIM_PORT_GC', 76;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_PORT_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_PORT_PKEY_MAP', 'TS_DIM_PORT_PKEY_MAP_GC', 1076;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_PRECISION_ATTRIBUTE' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_PRECISION_ATTRIBUTE', 'TS_DIM_PRECISION_ATTRIBUTE_GC', 77;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_PRECISION_ATTRIBUTE_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_PRECISION_ATTRIBUTE_PKEY_MAP', 'TS_DIM_PRECISION_ATTRIBUTE_PKEY_MAP_GC', 1077;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_PRECISION_QUEUE' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_PRECISION_QUEUE', 'TS_DIM_PRECISION_QUEUE_GC', 78;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_PRECISION_QUEUE_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_PRECISION_QUEUE_PKEY_MAP', 'TS_DIM_PRECISION_QUEUE_PKEY_MAP_GC', 1078;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_PRECISION_QUEUE_STEP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_PRECISION_QUEUE_STEP', 'TS_DIM_PRECISION_QUEUE_STEP_GC', 79;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_PRECISION_QUEUE_STEP_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_PRECISION_QUEUE_STEP_PKEY_MAP', 'TS_DIM_PRECISION_QUEUE_STEP_PKEY_MAP_GC', 1079;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_QUERY_RULE' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_QUERY_RULE', 'TS_DIM_QUERY_RULE_GC', 81;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_QUERY_RULE_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_QUERY_RULE_PKEY_MAP', 'TS_DIM_QUERY_RULE_PKEY_MAP_GC', 1081;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_QUEUE' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_QUEUE', 'TS_DIM_QUEUE_GC', 113;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_QUEUE_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_QUEUE_PKEY_MAP', 'TS_DIM_QUEUE_PKEY_MAP_GC', 1113;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_RATING_PERIOD' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_RATING_PERIOD', 'TS_DIM_RATING_PERIOD_GC', 83;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_RATING_PERIOD_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_RATING_PERIOD_PKEY_MAP', 'TS_DIM_RATING_PERIOD_PKEY_MAP_GC', 1083;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_REASON_CODE' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_REASON_CODE', 'TS_DIM_REASON_CODE_GC', 84;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_REASON_CODE_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_REASON_CODE_PKEY_MAP', 'TS_DIM_REASON_CODE_PKEY_MAP_GC', 1084;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_REGION' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_REGION', 'TS_DIM_REGION_GC', 85;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_REGION_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_REGION_PKEY_MAP', 'TS_DIM_REGION_PKEY_MAP_GC', 1085;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_ROUTE' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_ROUTE', 'TS_DIM_ROUTE_GC', 86;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_ROUTE_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_ROUTE_PKEY_MAP', 'TS_DIM_ROUTE_PKEY_MAP_GC', 1086;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_ROUTE_PARTITION' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_ROUTE_PARTITION', 'TS_DIM_ROUTE_PARTITION_GC', 87;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_ROUTE_PARTITION_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_ROUTE_PARTITION_PKEY_MAP', 'TS_DIM_ROUTE_PARTITION_PKEY_MAP_GC', 1087;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_ROUTING_CLIENT' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_ROUTING_CLIENT', 'TS_DIM_ROUTING_CLIENT_GC', 88;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_ROUTING_CLIENT_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_ROUTING_CLIENT_PKEY_MAP', 'TS_DIM_ROUTING_CLIENT_PKEY_MAP_GC', 1088;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_ROUTING_PROFILE' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_ROUTING_PROFILE', 'TS_DIM_ROUTING_PROFILE_GC', 547;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_ROUTING_PROFILE_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_ROUTING_PROFILE_PKEY_MAP', 'TS_DIM_ROUTING_PROFILE_PKEY_MAP_GC', 1547;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_ROUTING_SCRIPT' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_ROUTING_SCRIPT', 'TS_DIM_ROUTING_SCRIPT_GC', 89;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_ROUTING_SCRIPT_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_ROUTING_SCRIPT_PKEY_MAP', 'TS_DIM_ROUTING_SCRIPT_PKEY_MAP_GC', 1089;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_SCHEDULE' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_SCHEDULE', 'TS_DIM_SCHEDULE_GC', 90;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_SCHEDULE_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_SCHEDULE_PKEY_MAP', 'TS_DIM_SCHEDULE_PKEY_MAP_GC', 1090;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_SCHEDULED_TARGET' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_SCHEDULED_TARGET', 'TS_DIM_SCHEDULED_TARGET_GC', 91;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_SCHEDULED_TARGET_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_SCHEDULED_TARGET_PKEY_MAP', 'TS_DIM_SCHEDULED_TARGET_PKEY_MAP_GC', 1091;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_SCL_ADAPTER' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_SCL_ADAPTER', 'TS_DIM_SCL_ADAPTER_GC', 142;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_SCL_ADAPTER_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_SCL_ADAPTER_PKEY_MAP', 'TS_DIM_SCL_ADAPTER_PKEY_MAP_GC', 1142;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_SCL_SEARCH' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_SCL_SEARCH', 'TS_DIM_SCL_SEARCH_GC', 143;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_SCL_SEARCH_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_SCL_SEARCH_PKEY_MAP', 'TS_DIM_SCL_SEARCH_PKEY_MAP_GC', 1143;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_SCRIPT' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_SCRIPT', 'TS_DIM_SCRIPT_GC', 92;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_SCRIPT_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_SCRIPT_PKEY_MAP', 'TS_DIM_SCRIPT_PKEY_MAP_GC', 1092;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_SCRIPT_NODE' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_SCRIPT_NODE', 'TS_DIM_SCRIPT_NODE_GC', 93;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_SCRIPT_NODE_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_SCRIPT_NODE_PKEY_MAP', 'TS_DIM_SCRIPT_NODE_PKEY_MAP_GC', 1093;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_SERVICE' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_SERVICE', 'TS_DIM_SERVICE_GC', 94;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_SERVICE_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_SERVICE_PKEY_MAP', 'TS_DIM_SERVICE_PKEY_MAP_GC', 1094;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_SKILLGROUP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_SKILLGROUP', 'TS_DIM_SKILLGROUP_GC', 95;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_SKILLGROUP_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_SKILLGROUP_PKEY_MAP', 'TS_DIM_SKILLGROUP_PKEY_MAP_GC', 1095;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_SLA_BUCKET_INTERVAL' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_SLA_BUCKET_INTERVAL', 'TS_DIM_SLA_BUCKET_INTERVAL_GC', 131;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_SLA_BUCKET_INTERVAL_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_SLA_BUCKET_INTERVAL_PKEY_MAP', 'TS_DIM_SLA_BUCKET_INTERVAL_PKEY_MAP_GC', 1131;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_STRATEGY' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_STRATEGY', 'TS_DIM_STRATEGY_GC', 96;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_STRATEGY_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_STRATEGY_PKEY_MAP', 'TS_DIM_STRATEGY_PKEY_MAP_GC', 1096;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_SUB_CODE' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_SUB_CODE', 'TS_DIM_SUB_CODE_GC', 117;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_SUB_CODE_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_SUB_CODE_PKEY_MAP', 'TS_DIM_SUB_CODE_PKEY_MAP_GC', 1117;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_TENANT' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_TENANT', 'TS_DIM_TENANT_GC', 97;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_TENANT_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_TENANT_PKEY_MAP', 'TS_DIM_TENANT_PKEY_MAP_GC', 1097;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_TIMEBAND' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_TIMEBAND', 'TS_DIM_TIMEBAND_GC', 98;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_TIMEBAND_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_TIMEBAND_PKEY_MAP', 'TS_DIM_TIMEBAND_PKEY_MAP_GC', 1098;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_TLI' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_TLI', 'TS_DIM_TLI_GC', 99;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_TLI_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_TLI_PKEY_MAP', 'TS_DIM_TLI_PKEY_MAP_GC', 1099;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_TRANSLATION_ROUTE' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_TRANSLATION_ROUTE', 'TS_DIM_TRANSLATION_ROUTE_GC', 106;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_TRANSLATION_ROUTE_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_TRANSLATION_ROUTE_PKEY_MAP', 'TS_DIM_TRANSLATION_ROUTE_PKEY_MAP_GC', 1106;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_TRUNK' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_TRUNK', 'TS_DIM_TRUNK_GC', 100;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_TRUNK_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_TRUNK_PKEY_MAP', 'TS_DIM_TRUNK_PKEY_MAP_GC', 1100;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_TRUNK_GROUP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_TRUNK_GROUP', 'TS_DIM_TRUNK_GROUP_GC', 101;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_TRUNK_GROUP_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_TRUNK_GROUP_PKEY_MAP', 'TS_DIM_TRUNK_GROUP_PKEY_MAP_GC', 1101;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_UC_SERVICE_PROFILE' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_UC_SERVICE_PROFILE', 'TS_DIM_UC_SERVICE_PROFILE_GC', 167;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_UC_SERVICE_PROFILE_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_UC_SERVICE_PROFILE_PKEY_MAP', 'TS_DIM_UC_SERVICE_PROFILE_PKEY_MAP_GC', 1167;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_USER_GROUP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_USER_GROUP', 'TS_DIM_USER_GROUP_GC', 114;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_USER_GROUP_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_USER_GROUP_PKEY_MAP', 'TS_DIM_USER_GROUP_PKEY_MAP_GC', 1114;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_USER_VARIABLE' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_USER_VARIABLE', 'TS_DIM_USER_VARIABLE_GC', 102;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_USER_VARIABLE_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_USER_VARIABLE_PKEY_MAP', 'TS_DIM_USER_VARIABLE_PKEY_MAP_GC', 1102;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_VA_ASSISTANT' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_VA_ASSISTANT', 'TS_DIM_VA_ASSISTANT_GC', 144;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_VA_ASSISTANT_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_VA_ASSISTANT_PKEY_MAP', 'TS_DIM_VA_ASSISTANT_PKEY_MAP_GC', 1144;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_VA_ATTRIBUTE' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_VA_ATTRIBUTE', 'TS_DIM_VA_ATTRIBUTE_GC', 145;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_VA_ATTRIBUTE_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_VA_ATTRIBUTE_PKEY_MAP', 'TS_DIM_VA_ATTRIBUTE_PKEY_MAP_GC', 1145;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_VA_CASE' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_VA_CASE', 'TS_DIM_VA_CASE_GC', 147;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_VA_CASE_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_VA_CASE_PKEY_MAP', 'TS_DIM_VA_CASE_PKEY_MAP_GC', 1147;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_VA_CATEGORY' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_VA_CATEGORY', 'TS_DIM_VA_CATEGORY_GC', 149;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_VA_CATEGORY_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_VA_CATEGORY_PKEY_MAP', 'TS_DIM_VA_CATEGORY_PKEY_MAP_GC', 1149;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_VA_CLASSIFIER' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_VA_CLASSIFIER', 'TS_DIM_VA_CLASSIFIER_GC', 168;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_VA_CLASSIFIER_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_VA_CLASSIFIER_PKEY_MAP', 'TS_DIM_VA_CLASSIFIER_PKEY_MAP_GC', 1168;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_VA_CUSTOMER' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_VA_CUSTOMER', 'TS_DIM_VA_CUSTOMER_GC', 170;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_VA_CUSTOMER_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_VA_CUSTOMER_PKEY_MAP', 'TS_DIM_VA_CUSTOMER_PKEY_MAP_GC', 1170;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_VA_DOMAIN' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_VA_DOMAIN', 'TS_DIM_VA_DOMAIN_GC', 151;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_VA_DOMAIN_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_VA_DOMAIN_PKEY_MAP', 'TS_DIM_VA_DOMAIN_PKEY_MAP_GC', 1151;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_VA_INTENT' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_VA_INTENT', 'TS_DIM_VA_INTENT_GC', 166;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_VA_INTENT_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_VA_INTENT_PKEY_MAP', 'TS_DIM_VA_INTENT_PKEY_MAP_GC', 1166;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_VA_KEYWORD' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_VA_KEYWORD', 'TS_DIM_VA_KEYWORD_GC', 153;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_VA_KEYWORD_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_VA_KEYWORD_PKEY_MAP', 'TS_DIM_VA_KEYWORD_PKEY_MAP_GC', 1153;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_VA_SCORE' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_VA_SCORE', 'TS_DIM_VA_SCORE_GC', 169;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_VA_SCORE_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_VA_SCORE_PKEY_MAP', 'TS_DIM_VA_SCORE_PKEY_MAP_GC', 1169;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_VA_URL' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_VA_URL', 'TS_DIM_VA_URL_GC', 155;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_VA_URL_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_VA_URL_PKEY_MAP', 'TS_DIM_VA_URL_PKEY_MAP_GC', 1155;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_VECTOR' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_VECTOR', 'TS_DIM_VECTOR_GC', 103;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_VECTOR_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_VECTOR_PKEY_MAP', 'TS_DIM_VECTOR_PKEY_MAP_GC', 1103;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_VECTOR_DIRECTORY_NUMBER' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_VECTOR_DIRECTORY_NUMBER', 'TS_DIM_VECTOR_DIRECTORY_NUMBER_GC', 104;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_VECTOR_DIRECTORY_NUMBER_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_VECTOR_DIRECTORY_NUMBER_PKEY_MAP', 'TS_DIM_VECTOR_DIRECTORY_NUMBER_PKEY_MAP_GC', 1104;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_VXMLAPPLICATION_SERVER' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_VXMLAPPLICATION_SERVER', 'TS_DIM_VXMLAPPLICATION_SERVER_GC', 110;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_VXMLAPPLICATION_SERVER_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_VXMLAPPLICATION_SERVER_PKEY_MAP', 'TS_DIM_VXMLAPPLICATION_SERVER_PKEY_MAP_GC', 1110;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_WRAPUP_CODE' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_WRAPUP_CODE', 'TS_DIM_WRAPUP_CODE_GC', 105;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_WRAPUP_CODE_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_WRAPUP_CODE_PKEY_MAP', 'TS_DIM_WRAPUP_CODE_PKEY_MAP_GC', 1105;
    END;

    -- Member and Member Pkey Map Tables
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_AGENT_AGENT_DESKTOP_MEMBER' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_AGENT_AGENT_DESKTOP_MEMBER', 'TS_DIM_AGENT_AGENT_DESKTOP_MEMBER_GC', 200;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_AGENT_AGENT_DESKTOP_MEMBER_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_AGENT_AGENT_DESKTOP_MEMBER_PKEY_MAP', 'TS_DIM_AGENT_AGENT_DESKTOP_MEMBER_PKEY_MAP_GC', 1200;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_AGENT_AGENT_TEAM_MEMBER' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_AGENT_AGENT_TEAM_MEMBER', 'TS_DIM_AGENT_AGENT_TEAM_MEMBER_GC', 201;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_AGENT_AGENT_TEAM_MEMBER_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_AGENT_AGENT_TEAM_MEMBER_PKEY_MAP', 'TS_DIM_AGENT_AGENT_TEAM_MEMBER_PKEY_MAP_GC', 1201;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_AGENT_DESKTOP_DIALED_NUMBER_MEMBER' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_AGENT_DESKTOP_DIALED_NUMBER_MEMBER', 'TS_DIM_AGENT_DESKTOP_DIALED_NUMBER_MEMBER_GC', 202;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_AGENT_DESKTOP_DIALED_NUMBER_MEMBER_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_AGENT_DESKTOP_DIALED_NUMBER_MEMBER_PKEY_MAP', 'TS_DIM_AGENT_DESKTOP_DIALED_NUMBER_MEMBER_PKEY_MAP_GC', 1202;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_AGENT_PERIPHERAL_MEMBER' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_AGENT_PERIPHERAL_MEMBER', 'TS_DIM_AGENT_PERIPHERAL_MEMBER_GC', 203;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_AGENT_PERIPHERAL_MEMBER_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_AGENT_PERIPHERAL_MEMBER_PKEY_MAP', 'TS_DIM_AGENT_PERIPHERAL_MEMBER_PKEY_MAP_GC', 1203;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_AGENT_PERSON_MEMBER' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_AGENT_PERSON_MEMBER', 'TS_DIM_AGENT_PERSON_MEMBER_GC', 204;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_AGENT_PERSON_MEMBER_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_AGENT_PERSON_MEMBER_PKEY_MAP', 'TS_DIM_AGENT_PERSON_MEMBER_PKEY_MAP_GC', 1204;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_AGENT_PRECISION_ATTRIBUTE_MEMBER' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_AGENT_PRECISION_ATTRIBUTE_MEMBER', 'TS_DIM_AGENT_PRECISION_ATTRIBUTE_MEMBER_GC', 205;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_AGENT_PRECISION_ATTRIBUTE_MEMBER_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_AGENT_PRECISION_ATTRIBUTE_MEMBER_PKEY_MAP', 'TS_DIM_AGENT_PRECISION_ATTRIBUTE_MEMBER_PKEY_MAP_GC', 1205;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_AGENT_SKILLGROUP_MEMBER' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_AGENT_SKILLGROUP_MEMBER', 'TS_DIM_AGENT_SKILLGROUP_MEMBER_GC', 206;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_AGENT_SKILLGROUP_MEMBER_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_AGENT_SKILLGROUP_MEMBER_PKEY_MAP', 'TS_DIM_AGENT_SKILLGROUP_MEMBER_PKEY_MAP_GC', 1206;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_AGENT_TEAM_DIALED_NUMBER_MEMBER' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_AGENT_TEAM_DIALED_NUMBER_MEMBER', 'TS_DIM_AGENT_TEAM_DIALED_NUMBER_MEMBER_GC', 207;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_AGENT_TEAM_DIALED_NUMBER_MEMBER_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_AGENT_TEAM_DIALED_NUMBER_MEMBER_PKEY_MAP', 'TS_DIM_AGENT_TEAM_DIALED_NUMBER_MEMBER_PKEY_MAP_GC', 1207;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_AGENT_TEAM_PERIPHERAL_MEMBER' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_AGENT_TEAM_PERIPHERAL_MEMBER', 'TS_DIM_AGENT_TEAM_PERIPHERAL_MEMBER_GC', 208;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_AGENT_TEAM_PERIPHERAL_MEMBER_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_AGENT_TEAM_PERIPHERAL_MEMBER_PKEY_MAP', 'TS_DIM_AGENT_TEAM_PERIPHERAL_MEMBER_PKEY_MAP_GC', 1208;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_AGENT_USER_GROUP_MEMBER' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_AGENT_USER_GROUP_MEMBER', 'TS_DIM_AGENT_USER_GROUP_MEMBER_GC', 257;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_AGENT_USER_GROUP_MEMBER_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_AGENT_USER_GROUP_MEMBER_PKEY_MAP', 'TS_DIM_AGENT_USER_GROUP_MEMBER_PKEY_MAP_GC', 1257;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_CALL_TYPE_BUCKET_INTERVAL_MEMBER' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_CALL_TYPE_BUCKET_INTERVAL_MEMBER', 'TS_DIM_CALL_TYPE_BUCKET_INTERVAL_MEMBER_GC', 209;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_CALL_TYPE_BUCKET_INTERVAL_MEMBER_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_CALL_TYPE_BUCKET_INTERVAL_MEMBER_PKEY_MAP', 'TS_DIM_CALL_TYPE_BUCKET_INTERVAL_MEMBER_PKEY_MAP_GC', 1209;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_CALL_TYPE_ROUTING_SCRIPT_MEMBER' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_CALL_TYPE_ROUTING_SCRIPT_MEMBER', 'TS_DIM_CALL_TYPE_ROUTING_SCRIPT_MEMBER_GC', 210;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_CALL_TYPE_ROUTING_SCRIPT_MEMBER_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_CALL_TYPE_ROUTING_SCRIPT_MEMBER_PKEY_MAP', 'TS_DIM_CALL_TYPE_ROUTING_SCRIPT_MEMBER_PKEY_MAP_GC', 1210;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_CODE_CODE_GROUP_MEMBER' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_CODE_CODE_GROUP_MEMBER', 'TS_DIM_CODE_CODE_GROUP_MEMBER_GC', 211;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_CODE_CODE_GROUP_MEMBER_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_CODE_CODE_GROUP_MEMBER_PKEY_MAP', 'TS_DIM_CODE_CODE_GROUP_MEMBER_PKEY_MAP_GC', 1211;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_CUSTOM_ENTRY_CUSTOM_MEMBER' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_CUSTOM_ENTRY_CUSTOM_MEMBER', 'TS_DIM_CUSTOM_ENTRY_CUSTOM_MEMBER_GC', 212;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_CUSTOM_ENTRY_CUSTOM_MEMBER_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_CUSTOM_ENTRY_CUSTOM_MEMBER_PKEY_MAP', 'TS_DIM_CUSTOM_ENTRY_CUSTOM_MEMBER_PKEY_MAP_GC', 1212;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_DEVICE_POOL_CALL_MANAGER_GROUP_MEMBER' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_DEVICE_POOL_CALL_MANAGER_GROUP_MEMBER', 'TS_DIM_DEVICE_POOL_CALL_MANAGER_GROUP_MEMBER_GC', 213;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_DEVICE_POOL_CALL_MANAGER_GROUP_MEMBER_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_DEVICE_POOL_CALL_MANAGER_GROUP_MEMBER_PKEY_MAP', 'TS_DIM_DEVICE_POOL_CALL_MANAGER_GROUP_MEMBER_PKEY_MAP_GC', 1213;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_DEVICE_POOL_DATE_TIME_SETTING_MEMBER' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_DEVICE_POOL_DATE_TIME_SETTING_MEMBER', 'TS_DIM_DEVICE_POOL_DATE_TIME_SETTING_MEMBER_GC', 214;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_DEVICE_POOL_DATE_TIME_SETTING_MEMBER_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_DEVICE_POOL_DATE_TIME_SETTING_MEMBER_PKEY_MAP', 'TS_DIM_DEVICE_POOL_DATE_TIME_SETTING_MEMBER_PKEY_MAP_GC', 1214;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_DEVICE_PROFILE_DIRECTORY_NUMBER_MEMBER' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_DEVICE_PROFILE_DIRECTORY_NUMBER_MEMBER', 'TS_DIM_DEVICE_PROFILE_DIRECTORY_NUMBER_MEMBER_GC', 215;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_DEVICE_PROFILE_DIRECTORY_NUMBER_MEMBER_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_DEVICE_PROFILE_DIRECTORY_NUMBER_MEMBER_PKEY_MAP', 'TS_DIM_DEVICE_PROFILE_DIRECTORY_NUMBER_MEMBER_PKEY_MAP_GC', 1215;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_DEVICE_PROFILE_IP_ENDPOINT_BUTTON_TEMPLATE_MEMBER' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_DEVICE_PROFILE_IP_ENDPOINT_BUTTON_TEMPLATE_MEMBER', 'TS_DIM_DEVICE_PROFILE_IP_ENDPOINT_BUTTON_TEMPLATE_MEMBER_GC', 216;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_DEVICE_PROFILE_IP_ENDPOINT_BUTTON_TEMPLATE_MEMBER_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_DEVICE_PROFILE_IP_ENDPOINT_BUTTON_TEMPLATE_MEMBER_PKEY_MAP', 'TS_DIM_DEVICE_PROFILE_IP_ENDPOINT_BUTTON_TEMPLATE_MEMBER_PKEY_MAP_GC', 1216;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_DEVICE_PROFILE_PERSON_MEMBER' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_DEVICE_PROFILE_PERSON_MEMBER', 'TS_DIM_DEVICE_PROFILE_PERSON_MEMBER_GC', 217;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_DEVICE_PROFILE_PERSON_MEMBER_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_DEVICE_PROFILE_PERSON_MEMBER_PKEY_MAP', 'TS_DIM_DEVICE_PROFILE_PERSON_MEMBER_PKEY_MAP_GC', 1217;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_DIALED_NUMBER_CALL_TYPE_MEMBER' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_DIALED_NUMBER_CALL_TYPE_MEMBER', 'TS_DIM_DIALED_NUMBER_CALL_TYPE_MEMBER_GC', 218;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_DIALED_NUMBER_CALL_TYPE_MEMBER_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_DIALED_NUMBER_CALL_TYPE_MEMBER_PKEY_MAP', 'TS_DIM_DIALED_NUMBER_CALL_TYPE_MEMBER_PKEY_MAP_GC', 1218;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_DIALED_NUMBER_MEDIA_ROUTING_DOMAIN_MEMBER' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_DIALED_NUMBER_MEDIA_ROUTING_DOMAIN_MEMBER', 'TS_DIM_DIALED_NUMBER_MEDIA_ROUTING_DOMAIN_MEMBER_GC', 219;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_DIALED_NUMBER_MEDIA_ROUTING_DOMAIN_MEMBER_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_DIALED_NUMBER_MEDIA_ROUTING_DOMAIN_MEMBER_PKEY_MAP', 'TS_DIM_DIALED_NUMBER_MEDIA_ROUTING_DOMAIN_MEMBER_PKEY_MAP_GC', 1219;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_DIALED_NUMBER_ROUTING_CLIENT_MEMBER' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_DIALED_NUMBER_ROUTING_CLIENT_MEMBER', 'TS_DIM_DIALED_NUMBER_ROUTING_CLIENT_MEMBER_GC', 220;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_DIALED_NUMBER_ROUTING_CLIENT_MEMBER_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_DIALED_NUMBER_ROUTING_CLIENT_MEMBER_PKEY_MAP', 'TS_DIM_DIALED_NUMBER_ROUTING_CLIENT_MEMBER_PKEY_MAP_GC', 1220;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_EXPANDED_CALL_VARIABLE_ECC_PAYLOAD_MEMBER' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_EXPANDED_CALL_VARIABLE_ECC_PAYLOAD_MEMBER', 'TS_DIM_EXPANDED_CALL_VARIABLE_ECC_PAYLOAD_MEMBER_GC', 267;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_EXPANDED_CALL_VARIABLE_ECC_PAYLOAD_MEMBER_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_EXPANDED_CALL_VARIABLE_ECC_PAYLOAD_MEMBER_PKEY_MAP', 'TS_DIM_EXPANDED_CALL_VARIABLE_ECC_PAYLOAD_MEMBER_PKEY_MAP_GC', 1267;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_GHE_CLUSTER_GHE_CLUSTER_GROUP_MEMBER' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_GHE_CLUSTER_GHE_CLUSTER_GROUP_MEMBER', 'TS_DIM_GHE_CLUSTER_GHE_CLUSTER_GROUP_MEMBER_GC', 268;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_GHE_CLUSTER_GHE_CLUSTER_GROUP_MEMBER_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_GHE_CLUSTER_GHE_CLUSTER_GROUP_MEMBER_PKEY_MAP', 'TS_DIM_GHE_CLUSTER_GHE_CLUSTER_GROUP_MEMBER_PKEY_MAP_GC', 1268;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_GHE_QUESTION_GHE_ANSWER_MEMBER' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_GHE_QUESTION_GHE_ANSWER_MEMBER', 'TS_DIM_GHE_QUESTION_GHE_ANSWER_MEMBER_GC', 260;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_GHE_QUESTION_GHE_ANSWER_MEMBER_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_GHE_QUESTION_GHE_ANSWER_MEMBER_PKEY_MAP', 'TS_DIM_GHE_QUESTION_GHE_ANSWER_MEMBER_PKEY_MAP_GC', 1260;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_IP_ENDPOINT_CALLING_SEARCH_SPACE_MEMBER' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_IP_ENDPOINT_CALLING_SEARCH_SPACE_MEMBER', 'TS_DIM_IP_ENDPOINT_CALLING_SEARCH_SPACE_MEMBER_GC', 221;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_IP_ENDPOINT_CALLING_SEARCH_SPACE_MEMBER_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_IP_ENDPOINT_CALLING_SEARCH_SPACE_MEMBER_PKEY_MAP', 'TS_DIM_IP_ENDPOINT_CALLING_SEARCH_SPACE_MEMBER_PKEY_MAP_GC', 1221;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_IP_ENDPOINT_DEVICE_POOL_MEMBER' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_IP_ENDPOINT_DEVICE_POOL_MEMBER', 'TS_DIM_IP_ENDPOINT_DEVICE_POOL_MEMBER_GC', 222;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_IP_ENDPOINT_DEVICE_POOL_MEMBER_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_IP_ENDPOINT_DEVICE_POOL_MEMBER_PKEY_MAP', 'TS_DIM_IP_ENDPOINT_DEVICE_POOL_MEMBER_PKEY_MAP_GC', 1222;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_IP_ENDPOINT_DIRECTORY_NUMBER_MEMBER' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_IP_ENDPOINT_DIRECTORY_NUMBER_MEMBER', 'TS_DIM_IP_ENDPOINT_DIRECTORY_NUMBER_MEMBER_GC', 223;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_IP_ENDPOINT_DIRECTORY_NUMBER_MEMBER_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_IP_ENDPOINT_DIRECTORY_NUMBER_MEMBER_PKEY_MAP', 'TS_DIM_IP_ENDPOINT_DIRECTORY_NUMBER_MEMBER_PKEY_MAP_GC', 1223;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_IP_ENDPOINT_IP_ENDPOINT_BUTTON_TEMPLATE_MEMBER' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_IP_ENDPOINT_IP_ENDPOINT_BUTTON_TEMPLATE_MEMBER', 'TS_DIM_IP_ENDPOINT_IP_ENDPOINT_BUTTON_TEMPLATE_MEMBER_GC', 224;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_IP_ENDPOINT_IP_ENDPOINT_BUTTON_TEMPLATE_MEMBER_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_IP_ENDPOINT_IP_ENDPOINT_BUTTON_TEMPLATE_MEMBER_PKEY_MAP', 'TS_DIM_IP_ENDPOINT_IP_ENDPOINT_BUTTON_TEMPLATE_MEMBER_PKEY_MAP_GC', 1224;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_IP_ENDPOINT_PERIPHERAL_MEMBER' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_IP_ENDPOINT_PERIPHERAL_MEMBER', 'TS_DIM_IP_ENDPOINT_PERIPHERAL_MEMBER_GC', 225;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_IP_ENDPOINT_PERIPHERAL_MEMBER_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_IP_ENDPOINT_PERIPHERAL_MEMBER_PKEY_MAP', 'TS_DIM_IP_ENDPOINT_PERIPHERAL_MEMBER_PKEY_MAP_GC', 1225;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_IVR_ENTRY_POINT_DIALED_NUMBER_MEMBER' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_IVR_ENTRY_POINT_DIALED_NUMBER_MEMBER', 'TS_DIM_IVR_ENTRY_POINT_DIALED_NUMBER_MEMBER_GC', 226;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_IVR_ENTRY_POINT_DIALED_NUMBER_MEMBER_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_IVR_ENTRY_POINT_DIALED_NUMBER_MEMBER_PKEY_MAP', 'TS_DIM_IVR_ENTRY_POINT_DIALED_NUMBER_MEMBER_PKEY_MAP_GC', 1226;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_IVR_ENTRY_POINT_IVR_SCRIPT_MEMBER' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_IVR_ENTRY_POINT_IVR_SCRIPT_MEMBER', 'TS_DIM_IVR_ENTRY_POINT_IVR_SCRIPT_MEMBER_GC', 227;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_IVR_ENTRY_POINT_IVR_SCRIPT_MEMBER_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_IVR_ENTRY_POINT_IVR_SCRIPT_MEMBER_PKEY_MAP', 'TS_DIM_IVR_ENTRY_POINT_IVR_SCRIPT_MEMBER_PKEY_MAP_GC', 1227;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_IVR_ROUTING_TARGET_IVR_SCRIPT_MEMBER' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_IVR_ROUTING_TARGET_IVR_SCRIPT_MEMBER', 'TS_DIM_IVR_ROUTING_TARGET_IVR_SCRIPT_MEMBER_GC', 228;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_IVR_ROUTING_TARGET_IVR_SCRIPT_MEMBER_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_IVR_ROUTING_TARGET_IVR_SCRIPT_MEMBER_PKEY_MAP', 'TS_DIM_IVR_ROUTING_TARGET_IVR_SCRIPT_MEMBER_PKEY_MAP_GC', 1228;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_IVR_SCRIPT_NODE_IVR_MODULE_MEMBER' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_IVR_SCRIPT_NODE_IVR_MODULE_MEMBER', 'TS_DIM_IVR_SCRIPT_NODE_IVR_MODULE_MEMBER_GC', 229;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_IVR_SCRIPT_NODE_IVR_MODULE_MEMBER_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_IVR_SCRIPT_NODE_IVR_MODULE_MEMBER_PKEY_MAP', 'TS_DIM_IVR_SCRIPT_NODE_IVR_MODULE_MEMBER_PKEY_MAP_GC', 1229;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_KB_ARTICLE_KB_TOPIC_MEMBER' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_KB_ARTICLE_KB_TOPIC_MEMBER', 'TS_DIM_KB_ARTICLE_KB_TOPIC_MEMBER_GC', 258;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_KB_ARTICLE_KB_TOPIC_MEMBER_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_KB_ARTICLE_KB_TOPIC_MEMBER_PKEY_MAP', 'TS_DIM_KB_ARTICLE_KB_TOPIC_MEMBER_PKEY_MAP_GC', 1258;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_LABEL_DIALED_NUMBER_MEMBER' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_LABEL_DIALED_NUMBER_MEMBER', 'TS_DIM_LABEL_DIALED_NUMBER_MEMBER_GC', 230;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_LABEL_DIALED_NUMBER_MEMBER_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_LABEL_DIALED_NUMBER_MEMBER_PKEY_MAP', 'TS_DIM_LABEL_DIALED_NUMBER_MEMBER_PKEY_MAP_GC', 1230;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_LABEL_ROUTING_CLIENT_MEMBER' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_LABEL_ROUTING_CLIENT_MEMBER', 'TS_DIM_LABEL_ROUTING_CLIENT_MEMBER_GC', 231;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_LABEL_ROUTING_CLIENT_MEMBER_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_LABEL_ROUTING_CLIENT_MEMBER_PKEY_MAP', 'TS_DIM_LABEL_ROUTING_CLIENT_MEMBER_PKEY_MAP_GC', 1231;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_MEDIA_ROUTING_DOMAIN_MEDIA_CLASS_MEMBER' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_MEDIA_ROUTING_DOMAIN_MEDIA_CLASS_MEMBER', 'TS_DIM_MEDIA_ROUTING_DOMAIN_MEDIA_CLASS_MEMBER_GC', 232;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_MEDIA_ROUTING_DOMAIN_MEDIA_CLASS_MEMBER_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_MEDIA_ROUTING_DOMAIN_MEDIA_CLASS_MEMBER_PKEY_MAP', 'TS_DIM_MEDIA_ROUTING_DOMAIN_MEDIA_CLASS_MEMBER_PKEY_MAP_GC', 1232;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_NETWORK_VRU_SCRIPT_NETWORK_VRU_MEMBER' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_NETWORK_VRU_SCRIPT_NETWORK_VRU_MEMBER', 'TS_DIM_NETWORK_VRU_SCRIPT_NETWORK_VRU_MEMBER_GC', 233;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_NETWORK_VRU_SCRIPT_NETWORK_VRU_MEMBER_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_NETWORK_VRU_SCRIPT_NETWORK_VRU_MEMBER_PKEY_MAP', 'TS_DIM_NETWORK_VRU_SCRIPT_NETWORK_VRU_MEMBER_PKEY_MAP_GC', 1233;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_PERIPHERAL_LOGICAL_INTERFACE_CONTROLLER_MEMBER' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_PERIPHERAL_LOGICAL_INTERFACE_CONTROLLER_MEMBER', 'TS_DIM_PERIPHERAL_LOGICAL_INTERFACE_CONTROLLER_MEMBER_GC', 234;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_PERIPHERAL_LOGICAL_INTERFACE_CONTROLLER_MEMBER_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_PERIPHERAL_LOGICAL_INTERFACE_CONTROLLER_MEMBER_PKEY_MAP', 'TS_DIM_PERIPHERAL_LOGICAL_INTERFACE_CONTROLLER_MEMBER_PKEY_MAP_GC', 1234;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_PHYSICAL_CONTROLLER_LOGICAL_CONTROLLER_MEMBER' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_PHYSICAL_CONTROLLER_LOGICAL_CONTROLLER_MEMBER', 'TS_DIM_PHYSICAL_CONTROLLER_LOGICAL_CONTROLLER_MEMBER_GC', 235;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_PHYSICAL_CONTROLLER_LOGICAL_CONTROLLER_MEMBER_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_PHYSICAL_CONTROLLER_LOGICAL_CONTROLLER_MEMBER_PKEY_MAP', 'TS_DIM_PHYSICAL_CONTROLLER_LOGICAL_CONTROLLER_MEMBER_PKEY_MAP_GC', 1235;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_PRECISION_QUEUE_BUCKET_INTERVAL_MEMBER' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_PRECISION_QUEUE_BUCKET_INTERVAL_MEMBER', 'TS_DIM_PRECISION_QUEUE_BUCKET_INTERVAL_MEMBER_GC', 236;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_PRECISION_QUEUE_BUCKET_INTERVAL_MEMBER_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_PRECISION_QUEUE_BUCKET_INTERVAL_MEMBER_PKEY_MAP', 'TS_DIM_PRECISION_QUEUE_BUCKET_INTERVAL_MEMBER_PKEY_MAP_GC', 1236;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_PRECISION_QUEUE_MEDIA_ROUTING_DOMAIN_MEMBER' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_PRECISION_QUEUE_MEDIA_ROUTING_DOMAIN_MEMBER', 'TS_DIM_PRECISION_QUEUE_MEDIA_ROUTING_DOMAIN_MEMBER_GC', 259;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_PRECISION_QUEUE_MEDIA_ROUTING_DOMAIN_MEMBER_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_PRECISION_QUEUE_MEDIA_ROUTING_DOMAIN_MEMBER_PKEY_MAP', 'TS_DIM_PRECISION_QUEUE_MEDIA_ROUTING_DOMAIN_MEMBER_PKEY_MAP_GC', 1259;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_PRECISION_QUEUE_STEP_PRECISION_ATTRIBUTE_MEMBER' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_PRECISION_QUEUE_STEP_PRECISION_ATTRIBUTE_MEMBER', 'TS_DIM_PRECISION_QUEUE_STEP_PRECISION_ATTRIBUTE_MEMBER_GC', 237;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_PRECISION_QUEUE_STEP_PRECISION_ATTRIBUTE_MEMBER_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_PRECISION_QUEUE_STEP_PRECISION_ATTRIBUTE_MEMBER_PKEY_MAP', 'TS_DIM_PRECISION_QUEUE_STEP_PRECISION_ATTRIBUTE_MEMBER_PKEY_MAP_GC', 1237;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_PRECISION_QUEUE_STEP_PRECISION_QUEUE_MEMBER' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_PRECISION_QUEUE_STEP_PRECISION_QUEUE_MEMBER', 'TS_DIM_PRECISION_QUEUE_STEP_PRECISION_QUEUE_MEMBER_GC', 238;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_PRECISION_QUEUE_STEP_PRECISION_QUEUE_MEMBER_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_PRECISION_QUEUE_STEP_PRECISION_QUEUE_MEMBER_PKEY_MAP', 'TS_DIM_PRECISION_QUEUE_STEP_PRECISION_QUEUE_MEMBER_PKEY_MAP_GC', 1238;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_QUERY_RULE_CAMPAIGN_MEMBER' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_QUERY_RULE_CAMPAIGN_MEMBER', 'TS_DIM_QUERY_RULE_CAMPAIGN_MEMBER_GC', 239;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_QUERY_RULE_CAMPAIGN_MEMBER_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_QUERY_RULE_CAMPAIGN_MEMBER_PKEY_MAP', 'TS_DIM_QUERY_RULE_CAMPAIGN_MEMBER_PKEY_MAP_GC', 1239;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_QUERY_RULE_IMPORT_RULE_MEMBER' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_QUERY_RULE_IMPORT_RULE_MEMBER', 'TS_DIM_QUERY_RULE_IMPORT_RULE_MEMBER_GC', 240;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_QUERY_RULE_IMPORT_RULE_MEMBER_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_QUERY_RULE_IMPORT_RULE_MEMBER_PKEY_MAP', 'TS_DIM_QUERY_RULE_IMPORT_RULE_MEMBER_PKEY_MAP_GC', 1240;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_ROUTE_ENTERPRISE_ROUTE_MEMBER' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_ROUTE_ENTERPRISE_ROUTE_MEMBER', 'TS_DIM_ROUTE_ENTERPRISE_ROUTE_MEMBER_GC', 241;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_ROUTE_ENTERPRISE_ROUTE_MEMBER_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_ROUTE_ENTERPRISE_ROUTE_MEMBER_PKEY_MAP', 'TS_DIM_ROUTE_ENTERPRISE_ROUTE_MEMBER_PKEY_MAP_GC', 1241;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_ROUTE_PARTITION_CALLING_SEARCH_SPACE_MEMBER' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_ROUTE_PARTITION_CALLING_SEARCH_SPACE_MEMBER', 'TS_DIM_ROUTE_PARTITION_CALLING_SEARCH_SPACE_MEMBER_GC', 242;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_ROUTE_PARTITION_CALLING_SEARCH_SPACE_MEMBER_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_ROUTE_PARTITION_CALLING_SEARCH_SPACE_MEMBER_PKEY_MAP', 'TS_DIM_ROUTE_PARTITION_CALLING_SEARCH_SPACE_MEMBER_PKEY_MAP_GC', 1242;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_ROUTE_SKILLGROUP_MEMBER' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_ROUTE_SKILLGROUP_MEMBER', 'TS_DIM_ROUTE_SKILLGROUP_MEMBER_GC', 243;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_ROUTE_SKILLGROUP_MEMBER_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_ROUTE_SKILLGROUP_MEMBER_PKEY_MAP', 'TS_DIM_ROUTE_SKILLGROUP_MEMBER_PKEY_MAP_GC', 1243;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_ROUTING_CLIENT_PERIPHERAL_MEMBER' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_ROUTING_CLIENT_PERIPHERAL_MEMBER', 'TS_DIM_ROUTING_CLIENT_PERIPHERAL_MEMBER_GC', 244;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_ROUTING_CLIENT_PERIPHERAL_MEMBER_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_ROUTING_CLIENT_PERIPHERAL_MEMBER_PKEY_MAP', 'TS_DIM_ROUTING_CLIENT_PERIPHERAL_MEMBER_PKEY_MAP_GC', 1244;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_SCRIPT_ROUTING_SCRIPT_MEMBER' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_SCRIPT_ROUTING_SCRIPT_MEMBER', 'TS_DIM_SCRIPT_ROUTING_SCRIPT_MEMBER_GC', 246;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_SCRIPT_ROUTING_SCRIPT_MEMBER_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_SCRIPT_ROUTING_SCRIPT_MEMBER_PKEY_MAP', 'TS_DIM_SCRIPT_ROUTING_SCRIPT_MEMBER_PKEY_MAP_GC', 1246;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_SERVICE_ENTERPRISE_SERVICE_MEMBER' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_SERVICE_ENTERPRISE_SERVICE_MEMBER', 'TS_DIM_SERVICE_ENTERPRISE_SERVICE_MEMBER_GC', 247;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_SERVICE_ENTERPRISE_SERVICE_MEMBER_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_SERVICE_ENTERPRISE_SERVICE_MEMBER_PKEY_MAP', 'TS_DIM_SERVICE_ENTERPRISE_SERVICE_MEMBER_PKEY_MAP_GC', 1247;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_SERVICE_MEDIA_ROUTING_DOMAIN_MEMBER' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_SERVICE_MEDIA_ROUTING_DOMAIN_MEMBER', 'TS_DIM_SERVICE_MEDIA_ROUTING_DOMAIN_MEMBER_GC', 248;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_SERVICE_MEDIA_ROUTING_DOMAIN_MEMBER_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_SERVICE_MEDIA_ROUTING_DOMAIN_MEMBER_PKEY_MAP', 'TS_DIM_SERVICE_MEDIA_ROUTING_DOMAIN_MEMBER_PKEY_MAP_GC', 1248;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_SERVICE_PERIPHERAL_MEMBER' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_SERVICE_PERIPHERAL_MEMBER', 'TS_DIM_SERVICE_PERIPHERAL_MEMBER_GC', 249;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_SERVICE_PERIPHERAL_MEMBER_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_SERVICE_PERIPHERAL_MEMBER_PKEY_MAP', 'TS_DIM_SERVICE_PERIPHERAL_MEMBER_PKEY_MAP_GC', 1249;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_SKILLGROUP_CAMPAIGN_MEMBER' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_SKILLGROUP_CAMPAIGN_MEMBER', 'TS_DIM_SKILLGROUP_CAMPAIGN_MEMBER_GC', 250;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_SKILLGROUP_CAMPAIGN_MEMBER_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_SKILLGROUP_CAMPAIGN_MEMBER_PKEY_MAP', 'TS_DIM_SKILLGROUP_CAMPAIGN_MEMBER_PKEY_MAP_GC', 1250;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_SKILLGROUP_ENTERPRISE_SKILLGROUP_MEMBER' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_SKILLGROUP_ENTERPRISE_SKILLGROUP_MEMBER', 'TS_DIM_SKILLGROUP_ENTERPRISE_SKILLGROUP_MEMBER_GC', 251;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_SKILLGROUP_ENTERPRISE_SKILLGROUP_MEMBER_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_SKILLGROUP_ENTERPRISE_SKILLGROUP_MEMBER_PKEY_MAP', 'TS_DIM_SKILLGROUP_ENTERPRISE_SKILLGROUP_MEMBER_PKEY_MAP_GC', 1251;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_SKILLGROUP_MEDIA_ROUTING_DOMAIN_MEMBER' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_SKILLGROUP_MEDIA_ROUTING_DOMAIN_MEMBER', 'TS_DIM_SKILLGROUP_MEDIA_ROUTING_DOMAIN_MEMBER_GC', 252;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_SKILLGROUP_MEDIA_ROUTING_DOMAIN_MEMBER_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_SKILLGROUP_MEDIA_ROUTING_DOMAIN_MEMBER_PKEY_MAP', 'TS_DIM_SKILLGROUP_MEDIA_ROUTING_DOMAIN_MEMBER_PKEY_MAP_GC', 1252;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_SKILLGROUP_PERIPHERAL_MEMBER' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_SKILLGROUP_PERIPHERAL_MEMBER', 'TS_DIM_SKILLGROUP_PERIPHERAL_MEMBER_GC', 253;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_SKILLGROUP_PERIPHERAL_MEMBER_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_SKILLGROUP_PERIPHERAL_MEMBER_PKEY_MAP', 'TS_DIM_SKILLGROUP_PERIPHERAL_MEMBER_PKEY_MAP_GC', 1253;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_SKILLGROUP_SERVICE_MEMBER' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_SKILLGROUP_SERVICE_MEMBER', 'TS_DIM_SKILLGROUP_SERVICE_MEMBER_GC', 254;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_SKILLGROUP_SERVICE_MEMBER_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_SKILLGROUP_SERVICE_MEMBER_PKEY_MAP', 'TS_DIM_SKILLGROUP_SERVICE_MEMBER_PKEY_MAP_GC', 1254;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_TRUNK_GROUP_NETWORK_TRUNK_GROUP_MEMBER' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_TRUNK_GROUP_NETWORK_TRUNK_GROUP_MEMBER', 'TS_DIM_TRUNK_GROUP_NETWORK_TRUNK_GROUP_MEMBER_GC', 255;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_TRUNK_GROUP_NETWORK_TRUNK_GROUP_MEMBER_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_TRUNK_GROUP_NETWORK_TRUNK_GROUP_MEMBER_PKEY_MAP', 'TS_DIM_TRUNK_GROUP_NETWORK_TRUNK_GROUP_MEMBER_PKEY_MAP_GC', 1255;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_TRUNK_TRUNK_GROUP_MEMBER' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_TRUNK_TRUNK_GROUP_MEMBER', 'TS_DIM_TRUNK_TRUNK_GROUP_MEMBER_GC', 256;
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_TRUNK_TRUNK_GROUP_MEMBER_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_TRUNK_TRUNK_GROUP_MEMBER_PKEY_MAP', 'TS_DIM_TRUNK_TRUNK_GROUP_MEMBER_PKEY_MAP_GC', 1256;
    END;

    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_CHANNEL_ADDRESS' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_CHANNEL_ADDRESS';
    END;
        
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_CONTACT' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_CONTACT';
    END;
    
    -- Reset System Table GCs
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_CLU_CONNECTION' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_CLU_CONNECTION', 'TS_CLU_CONNECTION_GC', 5000;    -- 5000 hard coded in VW_ADM_DATA_GENERATION_COUNT
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_SEC_FOLDER' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_SEC_FOLDER';
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_SEC_ROLE_MAPPING' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_SEC_ROLE_MAPPING';
    END;    
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_SEC_ROLE' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_SEC_ROLE';
    END;    
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_SEC_POLICY' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_SEC_POLICY';
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_SEC_GROUP_MEMBER' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_SEC_GROUP_MEMBER';
    END;    
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_SEC_POLICY_USER_ROLE' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_SEC_POLICY_USER_ROLE';
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_SEC_INFORMATION_NOTICE' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_SEC_INFORMATION_NOTICE';
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_SEC_SEARCH_FOLDER' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN  
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_SEC_SEARCH_FOLDER';
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TE_DIM_ITEM_SUBTYPE' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TE_DIM_ITEM_SUBTYPE';
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_CLU_RESOURCE' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_CLU_RESOURCE';
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_CLU_RESOURCE_INSTANCE' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_CLU_RESOURCE_INSTANCE';
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_CLU_RESOURCE_FOLDER_MAPPING' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_CLU_RESOURCE_FOLDER_MAPPING';
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_CLU_RESOURCE_FOLDER_ITEM_MAPPING' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_CLU_RESOURCE_FOLDER_ITEM_MAPPING';
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_CLU_RESOURCE_ENTITY_TYPE_MAPPING' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_CLU_RESOURCE_ENTITY_TYPE_MAPPING';
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_REP_PARAMETER_SET' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_REP_PARAMETER_SET';
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_REP_REPORT' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_REP_REPORT';
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_REP_DASHBOARD' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_REP_DASHBOARD';
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_REP_DASHBOARD_LAYOUT' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_REP_DASHBOARD_LAYOUT';
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_REP_REPORT_MODEL' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_REP_REPORT_MODEL';
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_REP_ANALYZER_MODEL' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_REP_ANALYZER_MODEL';
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_REP_ANALYZER_VIEW' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_REP_ANALYZER_VIEW';
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_ADM_GADGET' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_ADM_GADGET';
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_ADM_GADGET_SET' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_ADM_GADGET_SET';
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_ADM_GADGET_SET_MAPPING' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_ADM_GADGET_SET_MAPPING';
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_ADM_GADGET_VERSION' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_ADM_GADGET_VERSION';
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_ADM_GADGET_VERSION_FILE' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_ADM_GADGET_VERSION_FILE';
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_ADM_RESOURCE_GROUP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_ADM_RESOURCE_GROUP';
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_ADM_RESOURCE_GROUP_TENANT_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_ADM_RESOURCE_GROUP_TENANT_MAP';
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_ADM_GADGET_VERSION_TENANT_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_ADM_GADGET_VERSION_TENANT_MAP';
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_ADM_GADGET_VERSION_USER_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_ADM_GADGET_VERSION_USER_MAP';
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_ADM_GADGET_RESOURCE_GROUP_FILE' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_ADM_GADGET_RESOURCE_GROUP_FILE';
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_ADM_CALENDAR' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_ADM_CALENDAR';
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_ADM_RESOURCE_PROVISIONING_TEMPLATE' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_ADM_RESOURCE_PROVISIONING_TEMPLATE';
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_ADM_RESOURCE_SET' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_ADM_RESOURCE_SET';
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_SCH_PROVISIONING_JOB' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_SCH_PROVISIONING_JOB';
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_REP_THRESHOLD' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_REP_THRESHOLD';
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_REP_STRING' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_REP_STRING';
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_ADM_PROPERTY' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_ADM_PROPERTY';
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_CATEGORY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_CATEGORY_MAP';
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_TIME' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_TIME';
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_DATE' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_DATE';
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_FISCAL_YEAR' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_FISCAL_YEAR';
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_FISCAL_QUARTER' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_FISCAL_QUARTER';
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_FISCAL_MONTH' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_FISCAL_MONTH';
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_FISCAL_WEEK' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_FISCAL_WEEK';
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_NNG' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_NNG';
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_HIERARCHY_LEVEL' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_HIERARCHY_LEVEL';
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_HIERARCHY_CONSTRAINT' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_HIERARCHY_CONSTRAINT';
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TE_DIM_ITEM_TYPE' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TE_DIM_ITEM_TYPE';
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TE_DIM_MEMBER_TYPE' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TE_DIM_MEMBER_TYPE';
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_DIM_ITEM_HIERARCHY_NODE_MEMBER' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_DIM_ITEM_HIERARCHY_NODE_MEMBER';
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_CLU_RESOURCE_INSTANCE_COMPONENT' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_CLU_RESOURCE_INSTANCE_COMPONENT';
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_CLU_RESOURCE_MEMBER' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_CLU_RESOURCE_MEMBER';
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_CLU_SERVER' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_CLU_SERVER';
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TE_CLU_CONNECTION_TYPE' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TE_CLU_CONNECTION_TYPE';
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TE_CLU_RESOURCE_INSTANCE_COMPONENT_TYPE' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TE_CLU_RESOURCE_INSTANCE_COMPONENT_TYPE';
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TE_CLU_RESOURCE_TYPE_GROUP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TE_CLU_RESOURCE_TYPE_GROUP';
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TE_ADM_CLUSTER_RESOURCE_TYPE' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TE_ADM_CLUSTER_RESOURCE_TYPE';
    END;        
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_SEC_USER_PKEY_MAP' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_SEC_USER_PKEY_MAP';
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_REP_REPORT_CHART' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_REP_REPORT_CHART';
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TE_DIM_CODE_CONSTRAINT_TYPE' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TE_DIM_CODE_CONSTRAINT_TYPE';
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_ADM_CUSTOM_ATTRIBUTE' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_ADM_CUSTOM_ATTRIBUTE';
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_ADM_CUSTOM_ATTRIBUTE_LOCALIZATION' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_ADM_CUSTOM_ATTRIBUTE_LOCALIZATION';
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_ADM_RESOURCE_TEMPLATE' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_ADM_RESOURCE_TEMPLATE';
    END;

    -- Special cases where table name is fake
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_SEC_USER' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_SEC_USER', NULL, NULL, 'SELECT @TableGenerationCountUrn, USER_ID, 0, 0, ''I'' FROM TB_SEC_USER WHERE USER_TYPE = ''U''', 'GUID_KEY';
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_SEC_GROUP', NULL, NULL, 'SELECT @TableGenerationCountUrn, USER_ID, 0, 0, ''I'' FROM TB_SEC_USER WHERE USER_TYPE = ''G''', 'GUID_KEY';
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_SEC_GROUP_MEMBER' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_SEC_USER_GROUP_MEMBER', NULL, NULL, 'SELECT @TableGenerationCountUrn, MEMBER_ID, 0, 0, ''I'' FROM TB_SEC_GROUP_MEMBER groupMember INNER JOIN TB_SEC_USER secUser ON secUser.USER_ID = groupMember.CHILD_ID WHERE secUser.USER_TYPE = ''U''', 'GUID_KEY';
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'TB_SEC_GROUP_GROUP_MEMBER', NULL, NULL, 'SELECT @TableGenerationCountUrn, MEMBER_ID, 0, 0, ''I'' FROM TB_SEC_GROUP_MEMBER groupMember INNER JOIN TB_SEC_USER secUser ON secUser.USER_ID = groupMember.CHILD_ID WHERE secUser.USER_TYPE = ''G''', 'GUID_KEY';
    END;
    IF @ReplicationTypeFilter IS NULL OR EXISTS(SELECT 1 FROM dbo.TB_ADM_TABLE WHERE SYSOBJECT_NAME = 'TB_ADM_XML' AND REPLICATED = @ReplicationTypeFilter)
    BEGIN 
        EXEC [dbo].[ap_adm01_reset_generation_count] 'dbo', 'VW_ADM_XML_H_GC', NULL, NULL, 'SELECT @TableGenerationCountUrn, XML_ID, 0, 0, ''I'' FROM TB_ADM_XML WHERE TYPE = ''H''', 'GUID_KEY';
    END;
    -- Ensure table names for olap processor tables which do not require row level changes
    MERGE INTO dbo.TS_ADM_TABLE_GENERATION_COUNT tab
    USING ( SELECT TABLE_NAME
            FROM (VALUES('TB_DIM_DATE_STD_MONTH'),
                        ('TB_DIM_DATE_STD_QUARTER'),
                        ('TB_DIM_DATE_STD_WEEK'),
                        ('TB_DIM_TIME_5M'),
                        ('TB_DIM_TIME_QH'),
                        ('TB_DIM_TIME_HH'),
                        ('TB_DIM_TIME_H'),
                        ('TB_DIM_CUSTOMER'),
                        ('TB_DIM_KB_SEARCH_STRING')) a(TABLE_NAME)
            JOIN [dbo].[TB_ADM_TABLE] t ON t.SYSOBJECT_NAME = a.TABLE_NAME
            WHERE t.REPLICATED = @ReplicationTypeFilter
            OR @ReplicationTypeFilter IS NULL    
            ) correctValues
        (TABLE_NAME)
    ON (tab.TABLE_NAME = correctValues.TABLE_NAME)
    WHEN MATCHED THEN
        UPDATE SET GENERATION_COUNT = 0
    WHEN NOT MATCHED THEN 
        INSERT (TABLE_NAME, GENERATION_COUNT)
        VALUES (correctValues.TABLE_NAME, 0);
    
    -- Create a new Cache Engine Persistance Token
    UPDATE [dbo].[TB_ADM_LOCAL_PROPERTY] SET [PROPERTY_VALUE] = NEWID(), MODIFIED_DATE = GETUTCDATE()
    WHERE [PROPERTY_KEY] = 'PROP_CACHE_ENGINE_PERSISTANCE_TOKEN';
GO
GRANT EXECUTE
	ON [dbo].[ap_adm01_reset_generation_counts]
	TO [portalapp_role]
GO
