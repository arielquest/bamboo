SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_dim01_do_type2_item_pkey_map]
(
    @SessionId UNIQUEIDENTIFIER, 
    @PkeyMapUrn INT = -1 OUTPUT,
    @PkeyMapBusinessUrn INT = -1 OUTPUT,
    @ItemTypeUrn INT,
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
            RAISERROR(50157, 16, 5, 'ap_dim01_do_type2_item_pkey_map');
            RETURN @ReturnCode;
        END;
                
        BEGIN TRANSACTION TypeTwoitemPKEYTransaction;

        DECLARE @TYPE_TWO AS TABLE (ItemTypeUrn INT);
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 1;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 2;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 3;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 116;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 4;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 5;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 6;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 7;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 8;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 10;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 11;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 12;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 9;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 13;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 14;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 127;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 15;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 162;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 163;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 16;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 161;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 17;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 18;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 120;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 19;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 132;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 133;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 134;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 135;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 136;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 137;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 138;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 139;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 140;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 141;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 30;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 20;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 21;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 22;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 23;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 24;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 25;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 26;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 27;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 28;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 29;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 31;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 111;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 32;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 33;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 34;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 37;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 35;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 36;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 38;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 157;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 39;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 40;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 41;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 42;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 115;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 43;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 44;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 46;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 47;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 48;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 130;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 164;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 165;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 129;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 49;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 50;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 107;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 51;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 52;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 53;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 54;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 55;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 56;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 57;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 58;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 59;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 60;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 61;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 62;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 123;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 172;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 158;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 171;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 124;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 121;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 122;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 63;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 64;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 65;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 66;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 67;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 68;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 108;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 109;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 69;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 70;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 71;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 125;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 159;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 128;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 160;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 72;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 118;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 119;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 73;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 74;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 75;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 76;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 77;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 78;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 79;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 81;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 113;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 83;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 84;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 85;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 86;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 87;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 88;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 547;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 89;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 90;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 91;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 142;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 143;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 92;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 93;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 94;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 95;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 131;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 96;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 117;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 97;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 98;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 99;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 106;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 100;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 101;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 167;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 114;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 102;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 144;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 145;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 147;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 149;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 168;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 170;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 151;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 166;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 153;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 169;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 155;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 103;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 104;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 110;
        INSERT INTO @TYPE_TWO (ItemTypeUrn)
        SELECT 105;

        IF NOT EXISTS (SELECT 1 FROM @TYPE_TWO WHERE ItemTypeUrn = @ItemTypeUrn)
        BEGIN
            RAISERROR('ap_dim01_do_type2_item_pkey_map: Invalid item type for type 2', 16, 1) WITH LOG;
        END;
                 
        IF @ItemTypeUrn = 1
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_agent_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 2
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_agent_desktop_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 3
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_agent_team_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 116
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_alias_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 4
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_announcement_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 5
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_application_gateway_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 6
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_application_instance_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 7
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_application_user_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 8
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_bucket_interval_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 10
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_call_manager_group_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 11
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_call_source_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 12
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_call_type_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 9
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_calling_search_space_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 13
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_campaign_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 14
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_category_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 127
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_cbr_release_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 15
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_chargeband_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 162
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_chat_referrer_name_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 163
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_chat_referrer_url_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 16
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_cli_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 161
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_cobrowse_page_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 17
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_code_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 18
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_code_group_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 120
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_content_url_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 19
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_custom_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 132
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_custom_attribute0_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 133
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_custom_attribute1_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 134
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_custom_attribute2_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 135
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_custom_attribute3_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 136
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_custom_attribute4_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 137
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_custom_attribute5_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 138
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_custom_attribute6_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 139
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_custom_attribute7_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 140
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_custom_attribute8_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 141
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_custom_attribute9_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 30
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_custom_entry_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 20
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_custom0_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 21
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_custom1_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 22
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_custom2_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 23
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_custom3_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 24
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_custom4_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 25
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_custom5_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 26
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_custom6_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 27
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_custom7_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 28
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_custom8_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 29
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_custom9_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 31
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_date_time_setting_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 111
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_department_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 32
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_device_pool_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 33
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_device_profile_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 34
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_device_target_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 37
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_dial_number_plan_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 35
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_dialed_number_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 36
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_dialer_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 38
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_directory_number_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 157
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_ecc_payload_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 39
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_email_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 40
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_enterprise_route_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 41
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_enterprise_service_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 42
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_enterprise_skillgroup_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 115
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_entry_point_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 43
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_expanded_call_variable_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 44
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_fileshare_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 46
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_gateway_function_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 47
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_gateway_result_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 48
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_gateway_server_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 130
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_ghe_answer_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 164
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_ghe_cluster_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 165
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_ghe_cluster_group_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 129
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_ghe_question_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 49
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_hierarchy_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 50
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_hierarchy_node_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 107
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_hunt_pilot_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 51
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_icr_instance_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 52
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_import_rule_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 53
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_ip_endpoint_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 54
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_ip_endpoint_button_template_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 55
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_ivr_entry_point_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 56
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_ivr_module_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 57
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_ivr_queue_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 58
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_ivr_routing_target_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 59
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_ivr_script_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 60
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_ivr_script_node_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 61
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_ivr_script_node_exit_state_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 62
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_ivr_server_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 123
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_kb_article_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 172
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_kb_article_review_stage_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 158
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_kb_article_workflow_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 171
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_kb_compliance_policy_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 124
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_kb_folder_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 121
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_kb_portal_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 122
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_kb_topic_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 63
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_label_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 64
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_logical_interface_controller_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 65
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_machine_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 66
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_machine_resource_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 67
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_media_class_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 68
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_media_routing_domain_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 108
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_mediafile_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 109
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_mediafile_server_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 69
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_network_trunk_group_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 70
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_network_vru_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 71
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_network_vru_script_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 125
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_notify_category_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 159
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_notify_channel_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 128
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_notify_message_type_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 160
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_notify_origin_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 72
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_object_type_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 118
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_offer_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 119
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_offer_banner_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 73
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_peripheral_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 74
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_person_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 75
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_physical_interface_controller_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 76
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_port_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 77
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_precision_attribute_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 78
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_precision_queue_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 79
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_precision_queue_step_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 81
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_query_rule_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 113
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_queue_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 83
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_rating_period_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 84
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_reason_code_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 85
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_region_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 86
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_route_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 87
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_route_partition_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 88
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_routing_client_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 547
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_routing_profile_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 89
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_routing_script_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 90
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_schedule_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 91
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_scheduled_target_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 142
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_scl_adapter_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 143
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_scl_search_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 92
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_script_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 93
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_script_node_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 94
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_service_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 95
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_skillgroup_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 131
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_sla_bucket_interval_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 96
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_strategy_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 117
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_sub_code_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 97
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_tenant_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 98
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_timeband_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 99
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_tli_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 106
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_translation_route_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 100
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_trunk_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 101
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_trunk_group_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 167
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_uc_service_profile_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 114
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_user_group_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 102
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_user_variable_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 144
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_va_assistant_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 145
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_va_attribute_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 147
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_va_case_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 149
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_va_category_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 168
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_va_classifier_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 170
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_va_customer_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 151
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_va_domain_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 166
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_va_intent_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 153
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_va_keyword_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 169
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_va_score_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 155
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_va_url_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 103
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_vector_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 104
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_vector_directory_number_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 110
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_vxmlapplication_server_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;
 
        IF @ItemTypeUrn = 105
        BEGIN   
            EXECUTE @ReturnCode = dbo.ap_dim01_do_type2_wrapup_code_pkey_map @SessionId, @PkeyMapUrn OUT, @PkeyMapBusinessUrn OUT, @ChangeStamp, @EffectiveFrom, @IgnoreConsolidationPeriod, @MaintainBusinessKey;
        END;

        IF @InitialTransactionCount = 0 
        BEGIN 
            COMMIT TRANSACTION TypeTwoitemPKEYTransaction;
        END;
        ELSE BEGIN 
            WHILE @@TRANCOUNT > @InitialTransactionCount
            BEGIN 
                COMMIT TRANSACTION;
            END;
        END;
    END TRY
    BEGIN CATCH;
        SELECT @ReturnCode = ERROR_NUMBER(), @ErrorMessage = OBJECT_NAME(@@PROCID) + ISNULL(': ' + ERROR_MESSAGE(),'');
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
        END;
        RAISERROR(@ErrorMessage, 16, 1, @ReturnCode) WITH LOG;
    END;
    
    RETURN @ReturnCode;
GO
GRANT EXECUTE
	ON [dbo].[ap_dim01_do_type2_item_pkey_map]
	TO [portalapp_role]
GO
