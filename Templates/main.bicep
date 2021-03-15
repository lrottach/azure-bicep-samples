// Azure virtual network data
resource stg 'Microsoft.Storage/storageAccounts@2019-06-01' = {
  name : 'unipostonam001z'
  location : 'westeurope'
  kind : 'BlobStorage'
  sku :{
    name : 'Standard_LRS'
  }
}