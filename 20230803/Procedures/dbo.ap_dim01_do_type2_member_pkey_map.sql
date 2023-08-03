SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_dim01_do_type2_member_pkey_map]
(
    @SessionId UNIQUEIDENTIFIER, 
    @PkeyMapUrn INT = -1 OUTPUT,
    @PkeyMapBusinessUrn INT = -1 OUTPUT,
    @MemberTypeUrn INT,
    @ChangeStamp INT, 
    @EffectiveFrom DATETIME = NULL,
    @IgnoreConsolidationPeriod BIT = 0,
    @MaintainBusinessKey BIT = 1
)
AS
    SET NOCOUNT ON;
    
    DECLARE @InitialTransactionCount AS INT = @@TRANCOUNT, @ReturnCode AS INT = 0, @ErrorMessage NVARCHAR(1024) = '';
    
    BEGIN TRY;
        -- Check Session Id
        IF @SessionId IS NULL
        BEGIN 
            SET @ReturnCode = 50157;
            RAISERROR(50157, 16, 5, 'ap_dim01_do_type2_member_pkey_map');
            RETURN @ReturnCode;
        END;
                
        BEGIN TRANSACTION TypeTwoMemberItemPKEYTransaction;
            IF @MemberTypeUrn = 200
            BEGIN 
                EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_agent_agent_desktop_member_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
            END;
            ELSE IF @MemberTypeUrn = 201
            BEGIN 
                EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_agent_agent_team_member_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
            END;
            ELSE IF @MemberTypeUrn = 202
            BEGIN 
                EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_agent_desktop_dialed_number_member_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
            END;
            ELSE IF @MemberTypeUrn = 203
            BEGIN 
                EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_agent_peripheral_member_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
            END;
            ELSE IF @MemberTypeUrn = 204
            BEGIN 
                EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_agent_person_member_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
            END;
            ELSE IF @MemberTypeUrn = 205
            BEGIN 
                EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_agent_precision_attribute_member_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
            END;
            ELSE IF @MemberTypeUrn = 206
            BEGIN 
                EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_agent_skillgroup_member_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
            END;
            ELSE IF @MemberTypeUrn = 207
            BEGIN 
                EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_agent_team_dialed_number_member_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
            END;
            ELSE IF @MemberTypeUrn = 208
            BEGIN 
                EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_agent_team_peripheral_member_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
            END;
            ELSE IF @MemberTypeUrn = 257
            BEGIN 
                EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_agent_user_group_member_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
            END;
            ELSE IF @MemberTypeUrn = 209
            BEGIN 
                EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_call_type_bucket_interval_member_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
            END;
            ELSE IF @MemberTypeUrn = 210
            BEGIN 
                EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_call_type_routing_script_member_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
            END;
            ELSE IF @MemberTypeUrn = 211
            BEGIN 
                EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_code_code_group_member_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
            END;
            ELSE IF @MemberTypeUrn = 212
            BEGIN 
                EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_custom_entry_custom_member_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
            END;
            ELSE IF @MemberTypeUrn = 213
            BEGIN 
                EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_device_pool_call_manager_group_member_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
            END;
            ELSE IF @MemberTypeUrn = 214
            BEGIN 
                EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_device_pool_date_time_setting_member_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
            END;
            ELSE IF @MemberTypeUrn = 215
            BEGIN 
                EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_device_profile_directory_number_member_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
            END;
            ELSE IF @MemberTypeUrn = 216
            BEGIN 
                EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_device_profile_ip_endpoint_button_template_member_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
            END;
            ELSE IF @MemberTypeUrn = 217
            BEGIN 
                EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_device_profile_person_member_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
            END;
            ELSE IF @MemberTypeUrn = 218
            BEGIN 
                EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_dialed_number_call_type_member_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
            END;
            ELSE IF @MemberTypeUrn = 219
            BEGIN 
                EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_dialed_number_media_routing_domain_member_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
            END;
            ELSE IF @MemberTypeUrn = 220
            BEGIN 
                EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_dialed_number_routing_client_member_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
            END;
            ELSE IF @MemberTypeUrn = 267
            BEGIN 
                EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_expanded_call_variable_ecc_payload_member_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
            END;
            ELSE IF @MemberTypeUrn = 268
            BEGIN 
                EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_ghe_cluster_ghe_cluster_group_member_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
            END;
            ELSE IF @MemberTypeUrn = 260
            BEGIN 
                EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_ghe_question_ghe_answer_member_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
            END;
            ELSE IF @MemberTypeUrn = 221
            BEGIN 
                EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_ip_endpoint_calling_search_space_member_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
            END;
            ELSE IF @MemberTypeUrn = 222
            BEGIN 
                EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_ip_endpoint_device_pool_member_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
            END;
            ELSE IF @MemberTypeUrn = 223
            BEGIN 
                EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_ip_endpoint_directory_number_member_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
            END;
            ELSE IF @MemberTypeUrn = 224
            BEGIN 
                EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_ip_endpoint_ip_endpoint_button_template_member_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
            END;
            ELSE IF @MemberTypeUrn = 225
            BEGIN 
                EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_ip_endpoint_peripheral_member_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
            END;
            ELSE IF @MemberTypeUrn = 226
            BEGIN 
                EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_ivr_entry_point_dialed_number_member_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
            END;
            ELSE IF @MemberTypeUrn = 227
            BEGIN 
                EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_ivr_entry_point_ivr_script_member_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
            END;
            ELSE IF @MemberTypeUrn = 228
            BEGIN 
                EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_ivr_routing_target_ivr_script_member_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
            END;
            ELSE IF @MemberTypeUrn = 229
            BEGIN 
                EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_ivr_script_node_ivr_module_member_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
            END;
            ELSE IF @MemberTypeUrn = 258
            BEGIN 
                EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_kb_article_kb_topic_member_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
            END;
            ELSE IF @MemberTypeUrn = 230
            BEGIN 
                EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_label_dialed_number_member_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
            END;
            ELSE IF @MemberTypeUrn = 231
            BEGIN 
                EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_label_routing_client_member_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
            END;
            ELSE IF @MemberTypeUrn = 232
            BEGIN 
                EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_media_routing_domain_media_class_member_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
            END;
            ELSE IF @MemberTypeUrn = 233
            BEGIN 
                EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_network_vru_script_network_vru_member_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
            END;
            ELSE IF @MemberTypeUrn = 234
            BEGIN 
                EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_peripheral_logical_interface_controller_member_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
            END;
            ELSE IF @MemberTypeUrn = 235
            BEGIN 
                EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_physical_controller_logical_controller_member_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
            END;
            ELSE IF @MemberTypeUrn = 236
            BEGIN 
                EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_precision_queue_bucket_interval_member_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
            END;
            ELSE IF @MemberTypeUrn = 259
            BEGIN 
                EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_precision_queue_media_routing_domain_member_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
            END;
            ELSE IF @MemberTypeUrn = 237
            BEGIN 
                EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_precision_queue_step_precision_attribute_member_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
            END;
            ELSE IF @MemberTypeUrn = 238
            BEGIN 
                EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_precision_queue_step_precision_queue_member_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
            END;
            ELSE IF @MemberTypeUrn = 239
            BEGIN 
                EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_query_rule_campaign_member_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
            END;
            ELSE IF @MemberTypeUrn = 240
            BEGIN 
                EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_query_rule_import_rule_member_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
            END;
            ELSE IF @MemberTypeUrn = 241
            BEGIN 
                EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_route_enterprise_route_member_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
            END;
            ELSE IF @MemberTypeUrn = 242
            BEGIN 
                EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_route_partition_calling_search_space_member_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
            END;
            ELSE IF @MemberTypeUrn = 243
            BEGIN 
                EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_route_skillgroup_member_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
            END;
            ELSE IF @MemberTypeUrn = 244
            BEGIN 
                EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_routing_client_peripheral_member_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
            END;
            ELSE IF @MemberTypeUrn = 246
            BEGIN 
                EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_script_routing_script_member_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
            END;
            ELSE IF @MemberTypeUrn = 247
            BEGIN 
                EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_service_enterprise_service_member_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
            END;
            ELSE IF @MemberTypeUrn = 248
            BEGIN 
                EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_service_media_routing_domain_member_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
            END;
            ELSE IF @MemberTypeUrn = 249
            BEGIN 
                EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_service_peripheral_member_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
            END;
            ELSE IF @MemberTypeUrn = 250
            BEGIN 
                EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_skillgroup_campaign_member_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
            END;
            ELSE IF @MemberTypeUrn = 251
            BEGIN 
                EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_skillgroup_enterprise_skillgroup_member_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
            END;
            ELSE IF @MemberTypeUrn = 252
            BEGIN 
                EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_skillgroup_media_routing_domain_member_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
            END;
            ELSE IF @MemberTypeUrn = 253
            BEGIN 
                EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_skillgroup_peripheral_member_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
            END;
            ELSE IF @MemberTypeUrn = 254
            BEGIN 
                EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_skillgroup_service_member_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
            END;
            ELSE IF @MemberTypeUrn = 255
            BEGIN 
                EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_trunk_group_network_trunk_group_member_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
            END;
            ELSE IF @MemberTypeUrn = 256
            BEGIN 
                EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_trunk_trunk_group_member_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
            END;
            ELSE
            BEGIN 
                RAISERROR('ap_dim01_do_type2_member_pkey_map: Invalid member type for type 2', 16, 1) WITH LOG;
            END;
        IF @InitialTransactionCount = 0 
        BEGIN 
           COMMIT TRANSACTION TypeTwoMemberItemPKEYTransaction;
        END;
        ELSE BEGIN 
            WHILE @@TRANCOUNT > @InitialTransactionCount
            BEGIN 
                COMMIT TRANSACTION;
            END;
        END;
        SET @ReturnCode = 0;
    END TRY
    BEGIN CATCH;
        SELECT @ReturnCode = ERROR_NUMBER(), @ErrorMessage = OBJECT_NAME(@@PROCID)+ISNULL(': '+ERROR_MESSAGE(),'');
    END CATCH;

    IF @InitialTransactionCount = 0 AND @@TRANCOUNT > 0
    BEGIN 
        ROLLBACK;
    END;
    
    IF @ErrorMessage <> '' OR @ReturnCode <> 0
    BEGIN 
        IF @InitialTransactionCount = 0 AND @@TRANCOUNT > 0
        BEGIN 
            ROLLBACK TRANSACTION;
        END;
        ELSE IF @InitialTransactionCount <> 0 AND @@TRANCOUNT > @InitialTransactionCount
        BEGIN 
            IF (XACT_STATE()) = -1
            BEGIN 
                SET @ErrorMessage = ISNULL(NULLIF(@ErrorMessage,''),OBJECT_NAME(@@PROCID))+' [Uncommittable Transaction!]';
                ROLLBACK TRANSACTION;
                -- THIS IS TO AVOID TRANSACTION MISMATCHES IN THE CALLING APPLICATION
                DECLARE @transactionFake INT = @@TRANCOUNT;
                WHILE @transactionFake < @InitialTransactionCount
                BEGIN 
                    BEGIN TRANSACTION;
                    SET @transactionFake = @transactionFake + 1;
                END;
            END;
            ELSE BEGIN 
                WHILE @@TRANCOUNT > @InitialTransactionCount
                BEGIN 
                    COMMIT TRANSACTION;
                END;
            END;
            SET @ErrorMessage = ISNULL(@ErrorMessage,OBJECT_NAME(@@PROCID));
        END;
        RAISERROR(@ErrorMessage, 16, 1, @ReturnCode) WITH LOG;
    END;
    
    RETURN @ReturnCode;
GO
GRANT EXECUTE
	ON [dbo].[ap_dim01_do_type2_member_pkey_map]
	TO [portalapp_role]
GO
