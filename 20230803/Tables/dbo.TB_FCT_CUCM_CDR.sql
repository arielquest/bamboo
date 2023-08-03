SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_FCT_CUCM_CDR] (
		[PARTITION_URN]                                      [int] NOT NULL,
		[PARTITION_ID]                                       [int] NOT NULL,
		[PARTITION_GLOBAL_URN]                               [bigint] NOT NULL,
		[ORIGINATION_DATE_UTC_URN]                           [int] NOT NULL,
		[ORIGINATION_TIME_UTC_URN]                           [smallint] NOT NULL,
		[ORIGINATION_DATE_TIME_UTC]                          [datetime] NOT NULL,
		[CONNECT_DATE_TIME_UTC]                              [datetime] NULL,
		[DISCONNECT_DATE_TIME_UTC]                           [datetime] NOT NULL,
		[CDR_RECORD_TYPE]                                    [tinyint] NOT NULL,
		[GLOBAL_CALL_ID_CALL_MANAGER_ID]                     [int] NOT NULL,
		[GLOBAL_CALL_ID_CALL_ID]                             [int] NOT NULL,
		[ORIG_LEG_CALL_IDENTIFIER]                           [int] NOT NULL,
		[DATE_TIME_ORIGINATION]                              [bigint] NOT NULL,
		[DATE_TIME_CONNECT]                                  [bigint] NOT NULL,
		[DATE_TIME_DISCONNECT]                               [bigint] NOT NULL,
		[CALLING_PARTY_NUMBER]                               [varchar](50) COLLATE Latin1_General_CI_AS NULL,
		[CALLING_PARTY_NUMBER_PARTITION]                     [varchar](50) COLLATE Latin1_General_CI_AS NULL,
		[CALLING_PARTY_NUMBER_URI]                           [varchar](255) COLLATE Latin1_General_CI_AS NULL,
		[CALLING_PARTY_UNICODE_LOGIN_USER_ID]                [varchar](128) COLLATE Latin1_General_CI_AS NULL,
		[ORIGINAL_CALLED_PARTY_NUMBER]                       [varchar](50) COLLATE Latin1_General_CI_AS NULL,
		[ORIGINAL_CALLED_PARTY_NUMBER_PARTITION]             [varchar](50) COLLATE Latin1_General_CI_AS NULL,
		[ORIGINAL_CALLED_PARTY_NUMBER_URI]                   [varchar](255) COLLATE Latin1_General_CI_AS NULL,
		[FINAL_CALLED_PARTY_NUMBER]                          [varchar](50) COLLATE Latin1_General_CI_AS NULL,
		[FINAL_CALLED_PARTY_NUMBER_PARTITION]                [varchar](50) COLLATE Latin1_General_CI_AS NULL,
		[FINAL_CALLED_PARTY_NUMBER_URI]                      [varchar](255) COLLATE Latin1_General_CI_AS NULL,
		[FINAL_CALLED_PARTY_UNICODE_LOGIN_USER_ID]           [varchar](128) COLLATE Latin1_General_CI_AS NULL,
		[LAST_REDIRECT_DN]                                   [varchar](50) COLLATE Latin1_General_CI_AS NULL,
		[LAST_REDIRECT_DN_PARTITION]                         [varchar](50) COLLATE Latin1_General_CI_AS NULL,
		[LAST_REDIRECT_DN_URI]                               [varchar](255) COLLATE Latin1_General_CI_AS NULL,
		[HUNT_PILOT_DN]                                      [varchar](50) COLLATE Latin1_General_CI_AS NULL,
		[HUNT_PILOT_PARTITION]                               [varchar](50) COLLATE Latin1_General_CI_AS NULL,
		[ORIG_NODE_ID]                                       [int] NOT NULL,
		[ORIG_SPAN]                                          [int] NOT NULL,
		[ORIG_IP_ADDRESS]                                    [int] NOT NULL,
		[ORIG_CAUSE_LOCATION]                                [int] NOT NULL,
		[ORIG_CAUSE_VALUE]                                   [int] NOT NULL,
		[ORIG_PRECEDENCE_LEVEL]                              [int] NOT NULL,
		[ORIG_MEDIA_TRANSPORT_ADDRESS_IP]                    [bigint] NOT NULL,
		[ORIG_MEDIA_TRANSPORT_ADDRESS_PORT]                  [int] NOT NULL,
		[ORIG_MEDIA_CAP_PAYLOAD_CAPABILITY]                  [int] NOT NULL,
		[ORIG_MEDIA_CAP_MAX_FRAMES_PER_PACKET]               [int] NOT NULL,
		[ORIG_MEDIA_CAP_G723_BIT_RATE]                       [int] NOT NULL,
		[ORIG_VIDEO_CAP_CODEC]                               [int] NOT NULL,
		[ORIG_VIDEO_CAP_BANDWIDTH]                           [int] NOT NULL,
		[ORIG_VIDEO_CAP_RESOLUTION]                          [int] NOT NULL,
		[ORIG_VIDEO_TRANSPORT_ADDRESS_IP]                    [bigint] NOT NULL,
		[ORIG_VIDEO_TRANSPORT_ADDRESS_PORT]                  [int] NOT NULL,
		[ORIG_RSVP_AUDIO_STAT]                               [varchar](64) COLLATE Latin1_General_CI_AS NULL,
		[ORIG_RSVP_VIDEO_STAT]                               [varchar](64) COLLATE Latin1_General_CI_AS NULL,
		[DEST_LEG_IDENTIFIER]                                [int] NOT NULL,
		[DEST_NODE_ID]                                       [int] NOT NULL,
		[DEST_SPAN]                                          [int] NOT NULL,
		[DEST_IP_ADDRESS]                                    [int] NOT NULL,
		[DEST_CAUSE_LOCATION]                                [int] NOT NULL,
		[DEST_CAUSE_VALUE]                                   [int] NOT NULL,
		[DEST_PRECEDENCE_LEVEL]                              [int] NOT NULL,
		[DEST_MEDIA_TRANSPORT_ADDRESS_IP]                    [bigint] NOT NULL,
		[DEST_MEDIA_TRANSPORT_ADDRESS_PORT]                  [int] NOT NULL,
		[DEST_MEDIA_CAP_PAYLOAD_CAPABILITY]                  [int] NOT NULL,
		[DEST_MEDIA_CAP_MAX_FRAMES_PER_PACKET]               [int] NOT NULL,
		[DEST_MEDIA_CAP_G723_BIT_RATE]                       [int] NOT NULL,
		[DEST_VIDEO_CAP_CODEC]                               [int] NOT NULL,
		[DEST_VIDEO_CAP_BANDWIDTH]                           [int] NOT NULL,
		[DEST_VIDEO_CAP_RESOLUTION]                          [int] NOT NULL,
		[DEST_VIDEO_TRANSPORT_ADDRESS_IP]                    [bigint] NOT NULL,
		[DEST_VIDEO_TRANSPORT_ADDRESS_PORT]                  [int] NOT NULL,
		[DEST_RSVP_AUDIO_STAT]                               [varchar](64) COLLATE Latin1_General_CI_AS NULL,
		[DEST_RSVP_VIDEO_STAT]                               [varchar](64) COLLATE Latin1_General_CI_AS NULL,
		[PKID]                                               [uniqueidentifier] NOT NULL,
		[DURATION]                                           [bigint] NOT NULL,
		[ORIG_DEVICE_NAME]                                   [varchar](129) COLLATE Latin1_General_CI_AS NULL,
		[DEST_DEVICE_NAME]                                   [varchar](129) COLLATE Latin1_General_CI_AS NULL,
		[ORIG_CALL_TERMINATION_ON_BEHALF_OF]                 [int] NOT NULL,
		[DEST_CALL_TERMINATION_ON_BEHALF_OF]                 [int] NOT NULL,
		[ORIG_CALLED_PARTY_REDIRECT_ON_BEHALF_OF]            [int] NOT NULL,
		[LAST_REDIRECT_REDIRECT_ON_BEHALF_OF]                [int] NOT NULL,
		[ORIG_CALLED_PARTY_REDIRECT_REASON]                  [int] NOT NULL,
		[LAST_REDIRECT_REDIRECT_REASON]                      [int] NOT NULL,
		[DEST_CONVERSATION_ID]                               [int] NOT NULL,
		[GLOBAL_CALLID_CLUSTER_ID]                           [varchar](50) COLLATE Latin1_General_CI_AS NULL,
		[JOIN_ON_BEHALF_OF]                                  [int] NOT NULL,
		[CDR_COMMENT]                                        [varchar](2048) COLLATE Latin1_General_CI_AS NULL,
		[AUTH_CODE_DESCRIPTION]                              [varchar](50) COLLATE Latin1_General_CI_AS NULL,
		[AUTHORIZATION_LEVEL]                                [int] NOT NULL,
		[CLIENT_MATTER_CODE]                                 [varchar](32) COLLATE Latin1_General_CI_AS NULL,
		[ORIG_DTMF_METHOD]                                   [int] NOT NULL,
		[DEST_DTMF_METHOD]                                   [int] NOT NULL,
		[CALL_SECURED_STATUS]                                [int] NOT NULL,
		[ORIG_CONVERSATION_ID]                               [int] NOT NULL,
		[ORIG_MEDIACAP_BANDWIDTH]                            [int] NOT NULL,
		[DEST_MEDIACAP_BANDWIDTH]                            [int] NOT NULL,
		[AUTHORIZATION_CODE_VALUE]                           [varchar](32) COLLATE Latin1_General_CI_AS NULL,
		[OUTPULSED_CALLING_PARTY_NUMBER]                     [varchar](50) COLLATE Latin1_General_CI_AS NULL,
		[OUTPULSED_CALLED_PARTY_NUMBER]                      [varchar](50) COLLATE Latin1_General_CI_AS NULL,
		[ORIG_IP_V4_V6_ADDRESS]                              [varchar](64) COLLATE Latin1_General_CI_AS NULL,
		[DEST_IP_V4_V6_ADDRESS]                              [varchar](64) COLLATE Latin1_General_CI_AS NULL,
		[ORIG_VIDEO_CAP_CODEC_CHANNEL2]                      [int] NOT NULL,
		[ORIG_VIDEO_CAP_BANDWIDTH_CHANNEL2]                  [int] NOT NULL,
		[ORIG_VIDEOCAP_RESOLUTION_CHANNEL2]                  [int] NOT NULL,
		[ORIG_VIDEO_TRANSPORT_ADDRESS_IP_CHANNEL2]           [int] NOT NULL,
		[ORIG_VIDEO_TRANSPORT_ADDRESS_PORT_CHANNEL2]         [int] NOT NULL,
		[ORIG_VIDEO_CHANNEL_ROLE_CHANNEL2]                   [int] NOT NULL,
		[DEST_VIDEO_CAP_CODEC_CHANNEL2]                      [int] NOT NULL,
		[DEST_VIDEO_CAP_BANDWIDTH_CHANNEL2]                  [int] NOT NULL,
		[DEST_VIDEO_CAP_RESOLUTION_CHANNEL2]                 [int] NOT NULL,
		[DEST_VIDEO_TRANSPORT_ADDRESS_IP_CHANNEL2]           [int] NOT NULL,
		[DEST_VIDEO_TRANSPORT_ADDRESS_PORT_CHANNEL2]         [int] NOT NULL,
		[DEST_VIDEO_CHANNEL_ROLE_CHANNEL2]                   [int] NOT NULL,
		[INCOMING_PROTOCOL_ID]                               [int] NOT NULL,
		[INCOMING_PROTOCOL_CALL_REF]                         [varchar](32) COLLATE Latin1_General_CI_AS NULL,
		[OUTGOING_PROTOCOL_ID]                               [int] NOT NULL,
		[OUTGOING_PROTOCOL_CALL_REF]                         [varchar](32) COLLATE Latin1_General_CI_AS NULL,
		[CURRENT_ROUTING_REASON]                             [int] NOT NULL,
		[ORIG_ROUTING_REASON]                                [int] NOT NULL,
		[LAST_REDIRECTING_ROUTING_REASON]                    [int] NOT NULL,
		[CALLED_PARTY_PATTERN_USAGE]                         [int] NOT NULL,
		[INCOMING_IC_ID]                                     [varchar](50) COLLATE Latin1_General_CI_AS NULL,
		[INCOMING_ORIG_IOI]                                  [varchar](50) COLLATE Latin1_General_CI_AS NULL,
		[INCOMING_TERM_IOI]                                  [varchar](50) COLLATE Latin1_General_CI_AS NULL,
		[OUTGOING_IC_ID]                                     [varchar](50) COLLATE Latin1_General_CI_AS NULL,
		[OUTGOING_ORIG_IOI]                                  [varchar](50) COLLATE Latin1_General_CI_AS NULL,
		[OUTGOING_TERM_IOI]                                  [varchar](50) COLLATE Latin1_General_CI_AS NULL,
		[OUTPULSED_ORIGINAL_CALLED_PARTY_NUMBER]             [varchar](50) COLLATE Latin1_General_CI_AS NULL,
		[OUTPULSED_LAST_REDIRECTING_NUMBER]                  [varchar](50) COLLATE Latin1_General_CI_AS NULL,
		[WAS_CALL_QUEUED]                                    [smallint] NOT NULL,
		[TOTAL_WAIT_TIME_IN_QUEUE]                           [smallint] NOT NULL,
		[RING_TIME]                                          [int] NOT NULL,
		[TALK_TIME]                                          [int] NOT NULL,
		[ORIG_IP_ENDPOINT_URN]                               [int] NOT NULL,
		[DEST_IP_ENDPOINT_URN]                               [int] NOT NULL,
		[CALLING_PARTY_HUNT_PILOT_URN]                       [int] NOT NULL,
		[CALLING_PARTY_DIRECTORY_NUMBER_URN]                 [int] NOT NULL,
		[ORIG_CALLED_PARTY_HUNT_PILOT_URN]                   [int] NOT NULL,
		[ORIG_CALLED_PARTY_DIRECTORY_NUMBER_URN]             [int] NOT NULL,
		[FINAL_CALLED_PARTY_HUNT_PILOT_URN]                  [int] NOT NULL,
		[FINAL_CALLED_PARTY_DIRECTORY_NUMBER_URN]            [int] NOT NULL,
		[LAST_REDIRECT_HUNT_PILOT_URN]                       [int] NOT NULL,
		[LAST_REDIRECT_DIRECTORY_NUMBER_URN]                 [int] NOT NULL,
		[HUNT_PILOT_URN]                                     [int] NOT NULL,
		[PERIPHERAL_CALL_KEY]                                [int] NOT NULL,
		[SOURCE_FILE_NAME]                                   [varchar](2000) COLLATE Latin1_General_CI_AS NOT NULL,
		[CLUSTER_RESOURCE_URN]                               [int] NOT NULL,
		[DB_DATETIME]                                        [datetime] NOT NULL,
		[CUSTOM_DIMENSION_0]                                 [int] NOT NULL,
		[CUSTOM_DIMENSION_1]                                 [int] NOT NULL,
		[CUSTOM_DIMENSION_2]                                 [int] NOT NULL,
		[CUSTOM_DIMENSION_3]                                 [int] NOT NULL,
		[CUSTOM_DIMENSION_4]                                 [int] NOT NULL,
		[CUSTOM_DIMENSION_5]                                 [int] NOT NULL,
		[CUSTOM_DIMENSION_6]                                 [int] NOT NULL,
		[CUSTOM_DIMENSION_7]                                 [int] NOT NULL,
		[CUSTOM_DIMENSION_8]                                 [int] NOT NULL,
		[CUSTOM_DIMENSION_9]                                 [int] NOT NULL,
		[CUSTOM_MEASURE_0]                                   [int] NULL,
		[CUSTOM_MEASURE_1]                                   [int] NULL,
		[CUSTOM_MEASURE_2]                                   [int] NULL,
		[CUSTOM_MEASURE_3]                                   [int] NULL,
		[CUSTOM_MEASURE_4]                                   [int] NULL,
		[CUSTOM_MEASURE_5]                                   [int] NULL,
		[CUSTOM_MEASURE_6]                                   [int] NULL,
		[CUSTOM_MEASURE_7]                                   [int] NULL,
		[CUSTOM_MEASURE_8]                                   [int] NULL,
		[CUSTOM_MEASURE_9]                                   [int] NULL,
		[MOBILE_CALLING_PARTY_NUMBER]                        [varchar](50) COLLATE Latin1_General_CI_AS NULL,
		[FINAL_MOBILE_CALLED_PARTY_NUMBER]                   [varchar](50) COLLATE Latin1_General_CI_AS NULL,
		[ORIG_MOBILE_DEVICE_NAME]                            [varchar](129) COLLATE Latin1_General_CI_AS NULL,
		[DEST_MOBILE_DEVICE_NAME]                            [varchar](129) COLLATE Latin1_General_CI_AS NULL,
		[MOBILE_CALL_TYPE]                                   [int] NULL,
		[ORIGINAL_CALLED_PARTY_PATTERN]                      [varchar](100) COLLATE Latin1_General_CI_AS NULL,
		[FINAL_CALLED_PARTY_PATTERN]                         [varchar](100) COLLATE Latin1_General_CI_AS NULL,
		[LAST_REDIRECTING_PARTY_PATTERN]                     [varchar](100) COLLATE Latin1_General_CI_AS NULL,
		[HUNT_PILOT_PATTERN]                                 [varchar](100) COLLATE Latin1_General_CI_AS NULL,
		[MOBILE_CALLING_PARTY_DIRECTORY_NUMBER_URN]          [int] NOT NULL,
		[FINAL_MOBILE_CALLED_PARTY_DIRECTORY_NUMBER_URN]     [int] NOT NULL,
		[ORIG_MOBILE_IP_ENDPOINT_URN]                        [int] NOT NULL,
		[DEST_MOBILE_IP_ENDPOINT_URN]                        [int] NOT NULL
) ON [FCTGROUP]
GO
EXEC sp_addextendedproperty N'MS_Description', N'This table holds data for the Call Detail Records (CDR) from Cisco Unified Call Manager. Please refer to Cisco Unified Call Manager Call Detail Records Admnistration Guide for detailed explanation of the columns that are not documented in this table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CUCM_CDR', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary Key Identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CUCM_CDR', 'COLUMN', N'PARTITION_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number for the current partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CUCM_CDR', 'COLUMN', N'PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column holds a value that uniquely identifies a row across all the partition tables for this partition type.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CUCM_CDR', 'COLUMN', N'PARTITION_GLOBAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key to TB_DIM_DATE. Contains the Date URN for the originiation utc datetime associated with the CDR.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CUCM_CDR', 'COLUMN', N'ORIGINATION_DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DATE', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CUCM_CDR', 'COLUMN', N'ORIGINATION_DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key to TB_DIM_TIME. Contains the Time URN for the originiation utc datetime associated with the CDR.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CUCM_CDR', 'COLUMN', N'ORIGINATION_TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_TIME', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CUCM_CDR', 'COLUMN', N'ORIGINATION_TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is DATE_TIME_ORIGINATION represented as datetime.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CUCM_CDR', 'COLUMN', N'ORIGINATION_DATE_TIME_UTC'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is DATE_TIME_CONNECT represented as datetime.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CUCM_CDR', 'COLUMN', N'CONNECT_DATE_TIME_UTC'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is DATE_TIME_DISCONNECT represented as datetime.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CUCM_CDR', 'COLUMN', N'DISCONNECT_DATE_TIME_UTC'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is calculated as a difference between DATE_TIME_CONNECT and DATE_TIME_ORIGINATION. This value is in seconds.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CUCM_CDR', 'COLUMN', N'RING_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is calculated as a difference between DATE_TIME_DISCONNECT and DATE_TIME_CONNECT. This value is in seconds.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CUCM_CDR', 'COLUMN', N'TALK_TIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key to TB_DIM_IP_ENDPOINT. Repesents the ip endpoint corresponding to ORIG_DEVICE_NAME.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CUCM_CDR', 'COLUMN', N'ORIG_IP_ENDPOINT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_IP_ENDPOINT', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CUCM_CDR', 'COLUMN', N'ORIG_IP_ENDPOINT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key to TB_DIM_IP_ENDPOINT. Repesents the ip endpoint corresponding to DEST_DEVICE_NAME.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CUCM_CDR', 'COLUMN', N'DEST_IP_ENDPOINT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_IP_ENDPOINT', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CUCM_CDR', 'COLUMN', N'DEST_IP_ENDPOINT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key to TB_DIM_HUNT_PILOT. Repesents the hunt pilot corresponding to CALLING_PARTY_NUMBER. This is looked up together with CALLING_PARTY_NUMBER_PARTITION if set.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CUCM_CDR', 'COLUMN', N'CALLING_PARTY_HUNT_PILOT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_HUNT_PILOT', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CUCM_CDR', 'COLUMN', N'CALLING_PARTY_HUNT_PILOT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key to TB_DIM_DIRECTORY_NUMBER.  Repesents the directory number corresponding to CALLING_PARTY_NUMBER. This is looked up together with CALLING_PARTY_NUMBER_PARTITION if set.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CUCM_CDR', 'COLUMN', N'CALLING_PARTY_DIRECTORY_NUMBER_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DIRECTORY_NUMBER', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CUCM_CDR', 'COLUMN', N'CALLING_PARTY_DIRECTORY_NUMBER_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key to TB_DIM_HUNT_PILOT. Repesents the hunt pilot corresponding to ORIGINAL_CALLED_PARTY_NUMBER. This is looked up together with ORIGINAL_CALLED_PARTY_NUMBER_PARTITION if set.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CUCM_CDR', 'COLUMN', N'ORIG_CALLED_PARTY_HUNT_PILOT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_HUNT_PILOT', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CUCM_CDR', 'COLUMN', N'ORIG_CALLED_PARTY_HUNT_PILOT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key to TB_DIM_DIRECTORY_NUMBER.  Repesents the directory number corresponding to ORIGINAL_CALLED_PARTY_NUMBER. This is looked up together with ORIGINAL_CALLED_PARTY_NUMBER_PARTITION if set.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CUCM_CDR', 'COLUMN', N'ORIG_CALLED_PARTY_DIRECTORY_NUMBER_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DIRECTORY_NUMBER', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CUCM_CDR', 'COLUMN', N'ORIG_CALLED_PARTY_DIRECTORY_NUMBER_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key to TB_DIM_HUNT_PILOT. Repesents the hunt pilot corresponding to FINAL_CALLED_PARTY_NUMBER. This is looked up together with FINAL_CALLED_PARTY_NUMBER_PARTITION if set.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CUCM_CDR', 'COLUMN', N'FINAL_CALLED_PARTY_HUNT_PILOT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_HUNT_PILOT', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CUCM_CDR', 'COLUMN', N'FINAL_CALLED_PARTY_HUNT_PILOT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key to TB_DIM_DIRECTORY_NUMBER.  Repesents the directory number corresponding to FINAL_CALLED_PARTY_NUMBER. This is looked up together with FINAL_CALLED_PARTY_NUMBER_PARTITION if set.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CUCM_CDR', 'COLUMN', N'FINAL_CALLED_PARTY_DIRECTORY_NUMBER_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DIRECTORY_NUMBER', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CUCM_CDR', 'COLUMN', N'FINAL_CALLED_PARTY_DIRECTORY_NUMBER_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key to TB_DIM_HUNT_PILOT. Repesents the hunt pilot corresponding to LAST_REDIRECT_DN. This is looked up together with LAST_REDIRECT_DN_PARTITION if set.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CUCM_CDR', 'COLUMN', N'LAST_REDIRECT_HUNT_PILOT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_HUNT_PILOT', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CUCM_CDR', 'COLUMN', N'LAST_REDIRECT_HUNT_PILOT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key to TB_DIM_DIRECTORY_NUMBER. Repesents the directory number corresponding to LAST_REDIRECT_DN. This is looked up together with LAST_REDIRECT_DN_PARTITION if set.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CUCM_CDR', 'COLUMN', N'LAST_REDIRECT_DIRECTORY_NUMBER_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_DIRECTORY_NUMBER', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CUCM_CDR', 'COLUMN', N'LAST_REDIRECT_DIRECTORY_NUMBER_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key to TB_DIM_HUNT_PILOT. Repesents the hunt pilot corresponding to HUNT_PILOT_DN. This is looked up together with HUNT_PILOT_PARTITION if set.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CUCM_CDR', 'COLUMN', N'HUNT_PILOT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_HUNT_PILOT', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CUCM_CDR', 'COLUMN', N'HUNT_PILOT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This value is calculated using GLOBAL_CALL_ID_CALL_MANAGER_ID and GLOBAL_CALL_ID_CALL_ID. This value can be used to link the CUCM CDR with UCCE TCD records.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CUCM_CDR', 'COLUMN', N'PERIPHERAL_CALL_KEY'
GO
EXEC sp_addextendedproperty N'MS_Description', N'String representing the name of the CDR file which was the source of the data row.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CUCM_CDR', 'COLUMN', N'SOURCE_FILE_NAME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key to TB_CLU_RESOURCE. Repesents the source call manager resource.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CUCM_CDR', 'COLUMN', N'CLUSTER_RESOURCE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the UTC data time indicating when the data was read from the CDR files.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CUCM_CDR', 'COLUMN', N'DB_DATETIME'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CUCM_CDR', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM0', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CUCM_CDR', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CUCM_CDR', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM1', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CUCM_CDR', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CUCM_CDR', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM2', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CUCM_CDR', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CUCM_CDR', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM3', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CUCM_CDR', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CUCM_CDR', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM4', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CUCM_CDR', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CUCM_CDR', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM5', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CUCM_CDR', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CUCM_CDR', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM6', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CUCM_CDR', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CUCM_CDR', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM7', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CUCM_CDR', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CUCM_CDR', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM8', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CUCM_CDR', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CUCM_CDR', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM9', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CUCM_CDR', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CUCM_CDR', 'COLUMN', N'CUSTOM_MEASURE_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CUCM_CDR', 'COLUMN', N'CUSTOM_MEASURE_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CUCM_CDR', 'COLUMN', N'CUSTOM_MEASURE_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CUCM_CDR', 'COLUMN', N'CUSTOM_MEASURE_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CUCM_CDR', 'COLUMN', N'CUSTOM_MEASURE_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CUCM_CDR', 'COLUMN', N'CUSTOM_MEASURE_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CUCM_CDR', 'COLUMN', N'CUSTOM_MEASURE_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CUCM_CDR', 'COLUMN', N'CUSTOM_MEASURE_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CUCM_CDR', 'COLUMN', N'CUSTOM_MEASURE_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CUCM_CDR', 'COLUMN', N'CUSTOM_MEASURE_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key to TB_DIM_DIRECTORY_NUMBER. This is looked up together with CALLING_PARTY_NUMBER_PARTITION if set.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CUCM_CDR', 'COLUMN', N'MOBILE_CALLING_PARTY_DIRECTORY_NUMBER_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key to TB_DIM_DIRECTORY_NUMBER. This is looked up together with FINAL_CALLED_PARTY_NUMBER_PARTITION if set.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CUCM_CDR', 'COLUMN', N'FINAL_MOBILE_CALLED_PARTY_DIRECTORY_NUMBER_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key to TB_DIM_IP_ENDPOINT.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CUCM_CDR', 'COLUMN', N'ORIG_MOBILE_IP_ENDPOINT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Foreign key to TB_DIM_IP_ENDPOINT.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CUCM_CDR', 'COLUMN', N'DEST_MOBILE_IP_ENDPOINT_URN'
GO
GRANT SELECT
	ON [dbo].[TB_FCT_CUCM_CDR]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_FCT_CUCM_CDR]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_FCT_CUCM_CDR]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_FCT_CUCM_CDR] SET (LOCK_ESCALATION = TABLE)
GO
