param location string = resourceGroup().location
param vnetName string
param vnetRange string
param subnetAdresses array
param subnetNames array

resource vnet 'Microsoft.Network/virtualNetworks@2020-08-01' = {
  name : vnetName
  location : location
  properties : {
    addressSpace : {
      addressPrefixes : [
        vnetRange
      ]
    }
    subnets : [for (adress, i) in subnetAdresses: {
      name : subnetNames[i]
      properties : {
        addressPrefix : adress
      }
    }]
  }
}
