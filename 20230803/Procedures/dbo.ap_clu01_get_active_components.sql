SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ap_clu01_get_active_components] (@SourceComponentTypeName AS NVARCHAR(50), @SinkResourceId AS UNIQUEIDENTIFIER, 
@SourcePublisherOnly AS BIT = 1, @ConnectionCheckThresholdMinutes AS INT = 5) AS
SET NOCOUNT ON;

DECLARE @ReturnCode INT = 0, @ErrorMessage VARCHAR(200);

BEGIN TRY;
    IF @ConnectionCheckThresholdMinutes < 0
    BEGIN 
        SET @ReturnCode = -1;
        RAISERROR ('ap_clu01_get_active_components: @ConnectionCheckThresholdMinutes must be positive.', 16, 1) WITH LOG;
    END;

    SELECT DISTINCT sinkCompType.INTERNAL_NAME AS COMPONENT_TYPE
    -- source component
    FROM dbo.TB_CLU_RESOURCE_INSTANCE srcInstance
    INNER JOIN dbo.TB_CLU_RESOURCE_INSTANCE_COMPONENT srcComp ON srcComp.RESOURCE_INSTANCE_ID = srcInstance.RESOURCE_INSTANCE_ID
    INNER JOIN dbo.TE_CLU_RESOURCE_INSTANCE_COMPONENT_TYPE srcCompType ON srcCompType.COMPONENT_TYPE_ID = srcComp.COMPONENT_TYPE_ID
    -- connection
    INNER JOIN dbo.TB_CLU_CONNECTION conn ON conn.SOURCE_COMPONENT_ID = srcComp.COMPONENT_ID
    INNER JOIN dbo.TB_CLU_CONNECTION_STATUS connStatus ON conn.CONNECTION_ID = connStatus.CONNECTION_ID
    -- sink component
    INNER JOIN dbo.TB_CLU_RESOURCE_INSTANCE_COMPONENT sinkComp ON sinkComp.COMPONENT_ID = conn.SINK_COMPONENT_ID
    INNER JOIN dbo.TE_CLU_RESOURCE_INSTANCE_COMPONENT_TYPE sinkCompType ON sinkCompType.COMPONENT_TYPE_ID = sinkComp.COMPONENT_TYPE_ID
    INNER JOIN dbo.TB_CLU_RESOURCE_INSTANCE sinkInstance ON sinkInstance.RESOURCE_INSTANCE_ID = sinkComp.RESOURCE_INSTANCE_ID
    WHERE srcCompType.INTERNAL_NAME = @SourceComponentTypeName AND srcInstance.IS_PUBLISHER = 1 
    AND srcInstance.IS_PUBLISHER = @SourcePublisherOnly AND conn.ENABLED = 1 AND connStatus.STATUS = 'A'
    AND DATEADD(minute, @ConnectionCheckThresholdMinutes, connStatus.LAST_STATUS_CHECK) > GETUTCDATE() 
    AND sinkInstance.RESOURCE_ID = @SinkResourceId;
   
END TRY
BEGIN CATCH;
    SELECT @ReturnCode = CASE WHEN @ReturnCode <> -1 THEN @@ERROR ELSE @ReturnCode END,
           @ErrorMessage = '['+OBJECT_NAME(@@PROCID)+']' + ISNULL(':' + @ErrorMessage,'');
    
        RAISERROR(@ErrorMessage, 16, 1) WITH LOG;
END CATCH;

RETURN @ReturnCode;
GO
GRANT EXECUTE
	ON [dbo].[ap_clu01_get_active_components]
	TO [portalapp_role]
GO
