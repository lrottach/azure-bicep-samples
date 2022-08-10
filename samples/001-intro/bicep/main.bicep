targetScope = 'subscription'

param deploymentLocation string = 'West Europe'

param saRgName string = 'rg-storage-data-we-002'
param saName string = 'dcsto${uniqueString(subscription().subscriptionId)}'
param saFileShare string = 'profiles'
param saFileShareSize int = 64

resource saRgFileServices 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: saRgName
  location: deploymentLocation
}

module sa 'modules.storage/module-fileservices.bicep' = {
  scope: saRgFileServices
  name: 'deploy-fileservices'
  params: {
    deploymentLocation: deploymentLocation
    shareSize: saFileShareSize
    storageAccountFileShare: saFileShare
    storageAccountName: saName
  }
}
