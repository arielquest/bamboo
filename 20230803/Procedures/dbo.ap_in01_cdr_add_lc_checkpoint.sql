SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_in01_cdr_add_lc_checkpoint]
(
    @I_SessionUrn    [INT],
    @I_Type            [VARCHAR](30),
    @I_Start        [DATETIME],
    @I_Dni            [INT],
    @I_Tli            [INT],
    @I_Cli            [VARCHAR](30),
    @I_Date            [INT],
    @I_Time            [SMALLINT],
    @I_Ringtime        [FLOAT](53),
    @I_Talktime        [FLOAT](53),
    @I_SourceUrn    [INT],
    @I_SourceCode    [INT],
    @I_SourceType    [TINYINT],
    @I_Outcome        [TINYINT],
    @I_Link            [INT]
) AS
BEGIN 
    SET NOCOUNT ON;

    INSERT INTO [dbo].[TS_IMP_CDR_LC_CHECKPOINT] ([CDR_SESSION_URN], [TYPE], [START], [DNI], [TLI], 
                                                  [CLI], [DATE], [TIME], [RINGTIME], [TALKTIME], [SOURCE_URN], 
                                                  [SOURCE_CODE], [SOURCE_TYPE], [OUTCOME], [LINK])
    VALUES (@I_SessionUrn, @I_Type, @I_Start, @I_Dni, @I_Tli, 
           @I_Cli, @I_Date, @I_Time, @I_Ringtime, @I_Talktime, @I_SourceUrn, 
           @I_SourceCode, @I_SourceType, @I_Outcome, @I_Link);

    RETURN @@ERROR;
END;
GO
