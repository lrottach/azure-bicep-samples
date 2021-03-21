targetScope = 'subscription'

param location string = 'switzerlandnorth'

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