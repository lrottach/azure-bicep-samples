targetScope = 'subscription'

// General parameter
param location string = 'switzerlandnorth'

// Virtual network parameter
param vnetName string = 'vnet-sn-01'
param vnetRange string = '10.100.0.0/16'
param subnetAdresses array = [
  '10.100.1.0/24'
  '10.100.2.0/24'
  '10.100.3.0/24'
]
param subnetNames array = [
  'GatewaySubnet'
  'BastionSubnet'
  'FirewallSubnet'
]

// Resource Group variables
var rgName_Network = 'rg-network-sn-01'
var rgName_Storage = 'rg-storage-sn-01'
var rgName_Vault = 'rg-vault-sn-01'
var rgName_Wvd = 'rg-wvd-sn-01'
var rgName_WvdHosts = 'rg-wvd-sh-sn-01'

resource rg_network 'Microsoft.Resources/resourceGroups@2020-06-01' = {
  name: rgName_Network
  location: location
}

resource rg_storage 'Microsoft.Resources/resourceGroups@2020-06-01' = {
  name: rgName_Storage
  location: location
}

resource rg_vault 'Microsoft.Resources/resourceGroups@2020-06-01' = {
  name: rgName_Vault
  location: location
}

// WVD Backend: workspaces, pools, application groups
resource rg_wvd 'Microsoft.Resources/resourceGroups@2020-06-01' = {
  name: rgName_Wvd
  location: location
}

// Session Hosts
resource rg_hosts 'Microsoft.Resources/resourceGroups@2020-06-01' = {
  name: rgName_WvdHosts
  location: location
}

module vnet 'Modules/network.bicep' = {
  name : 'networkDeployment'
  scope : resourceGroup(rg_network.name)
  params : {
    vnetName : vnetName
    vnetRange : vnetRange
    subnetAdresses : subnetAdresses
    subnetNames : subnetNames
  }
}
