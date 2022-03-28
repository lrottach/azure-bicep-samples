// Template scope
targetScope = 'subscription'

// ----------------------- 
// Parameter
// -----------------------
param location string = 'switzerlandnorth'
param rgName_NetworkHub string = 'rg-network-sn-01'
param rgName_NetworkSpoke string = 'rg-network-sn-01'
param rgName_Storage string = 'rg-storage-sn-01'
param rgName_Vault string = 'rg-vault-sn-01'
param rgName_Wvd string = 'rg-wvd-sn-01'
param rgName_AvdHosts string = 'rg-avd-sh-sn-01'

// ----------------------- 
// Resource Group deployments
// -----------------------
resource rg_network_spoke 'Microsoft.Resources/resourceGroups@2020-06-01' = {
  name: rgName_NetworkHub
  location: location
}

resource rg_network_hub 'Microsoft.Resources/resourceGroups@2020-06-01' = {
  name: rgName_NetworkSpoke
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

// AVD Backend: workspaces, pools, application groups
resource rg_wvd 'Microsoft.Resources/resourceGroups@2020-06-01' = {
  name: rgName_Wvd
  location: location
}

// Session Hosts
resource rg_hosts 'Microsoft.Resources/resourceGroups@2020-06-01' = {
  name: rgName_AvdHosts
  location: location
}

// ----------------------- 
// Modules
// -----------------------
