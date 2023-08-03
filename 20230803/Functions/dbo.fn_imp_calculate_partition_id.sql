SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
------------------------------------------------------------------------------- 
-- This function is used during the execution of reports generated out of 
-- the new Historical SRP - Agent Logout.sm semantic model
------------------------------------------------------------------------------ 
CREATE FUNCTION [dbo].[fn_imp_calculate_partition_id]
    (
      @dateTimeStamp DATETIME
    )
RETURNS INT
AS
    BEGIN 
        DECLARE @partitionID INT;
    
        SET @partitionID = ( ( DATEPART(yyyy, @dateTimeStamp)
                               * 54 ) + ( DATEPART(wk,
                                            @dateTimeStamp)
                                          - 1 ) ) % 256;
    
        RETURN @partitionID;
    END;
GO
