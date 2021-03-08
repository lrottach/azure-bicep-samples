// Azure virtual network data
param vnetName string = 'vnet-001-sn'
param vnetRgName string = 'rg-vnet-001-sn'

// Azure WVD host pool data
param hostpoolName string = 'wvd1-pool1-sn'
param hostpoolRgName string = 'rg-wvd1-pool1-sn'

module host './Modules/sessionHost.bicep' = {
  name: 'SessionHost Deployment'
  params:{
    sessionHostName : 'wvd1-sh101-sn'
    sessionHostRg : 'rg-wvd1-sh101-sn'
  }
}