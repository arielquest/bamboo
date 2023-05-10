CREATE EXTERNAL DATA SOURCE [AzureDlsTncServco]
WITH (
	TYPE = BLOB_STORAGE,
	LOCATION = 'https://apexlssancoba.blob.core.windows.net/20230224',
	CREDENTIAL = [azurecred]
)
GO
