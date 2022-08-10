targetScope = 'resourceGroup'

param deploymentLocation string
param storageAccountName string
param shareSize int
param storageAccountFileShare string

resource sa 'Microsoft.Storage/storageAccounts@2021-09-01' = {
  name: storageAccountName
  location: deploymentLocation
  sku: {
    name: 'Premium_LRS'
  }
  kind: 'FileStorage'
  properties: {
    minimumTlsVersion: 'TLS1_2'
    supportsHttpsTrafficOnly: false
    allowBlobPublicAccess: true
    allowSharedKeyAccess: true
    largeFileSharesState: 'Enabled'
  }
}

resource fs 'Microsoft.Storage/storageAccounts/fileServices/shares@2021-09-01' = {
  name: '${sa.name}/default/${storageAccountFileShare}'
  properties: {
    enabledProtocols: 'SMB'
    shareQuota: shareSize
    accessTier: 'Premium'
    metadata: {
      azureBackupProtected: 'true'
    }
  }
}

output saId string = sa.id
