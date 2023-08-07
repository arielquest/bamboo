SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

/*@@objectName:[dbo]..[Get_UserTaskQ_Hierarchy]*/
CREATE PROCEDURE [dbo].[Get_UserTaskQ_Hierarchy] 
    @CustomerId int,
    @ProductId int,
    @flg int = null,
    --@StatusId int = null,
    --@PriorityId int = null,
    @User varchar(100),
    @Createdby varchar(100) = null
AS 
/*
Modifications:
WHO                WHEN        WHAT
Deep            2020-06-17  removed TaskActivityLog from query to use denormalized columns
Scott            2020-06-17    Check for TaskActivityLog.
Deep            2020-06-20    Added task.TypeId column in resultset to return TaskType to front-end
Mike            2020-12-18  Trim Region in support of filtering.
Ed/Jose/Sunil    2021-01-29    Hot fix to implement parameter sniffing patch; and, use readuncommitted hint for #GroupNames query
Ed/Jose/Sunil    2021-01-29    Hot fix to change EXISTS to INNER/OUTER JOINs
Ed/Jose            20210525    Rewrite Task statement, performance tuning
EXEC Get_UserTaskQ_Hierarchy 16,2,NULL,'executive1'
exec Get_UserTaskQ_Hierarchy @User=N'amearnest',@CustomerId=16,@ProductId=2,@flg=1
*/
begin 
DECLARE @v_customer_id int = @CustomerID;
DECLARE @v_product_id int = @ProductID;
DECLARE @v_user varchar(100) = @User;
declare @v_start_time datetime = getDate();
declare @v_end_time datetime;
-- By default, users can not see employee member data
DECLARE @v_health_care_employee_override_yn bit = 0;
SET NOCOUNT ON;
SELECT @v_health_care_employee_override_yn = dbo.fnABCBSUserMemberCheck( @User );
DROP table if exists #Status
CREATE TABLE #Status
(
    StatusId int
)
INSERT into #Status
select 
    codeid 
from 
    Lookup_Generic_Code (readuncommitted)
where 
    CodeTypeID =13  and Label NOT IN ('Completed','Owner Changed')
--Create a Group table
DROP TABLE IF EXISTS #GroupNames
CREATE TABLE #GroupNames (
GroupID int    
)
CREATE INDEX IX_GroupNames ON #GroupNames ( GroupID )
INSERT into #GroupNames (
GroupID
)
select
    lhaga.Group_ID
from
    AspnetIdentity.dbo.AspnetUsers (readuncommitted) au
    join Link_HpAlertGroupAgent (readuncommitted) lhaga
        on au.Id = lhaga.Agent_ID
        and au.UserName = @v_user;
;
END
GO
