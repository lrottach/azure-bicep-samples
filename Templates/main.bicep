targetScope = 'subscription'

// General parameter
@allowed([
  'switzerlandnorth'
  'westeurope'
  'centralus'
  'centralindia'
])
param location string = 'switzerlandnorth'

@allowed([
  'production'
  'development'
  'test'
])
param environment string

// Virtual network parameter
param vnet1Name string = 'network1'
param vnet1Range string = '10.100.0.0/16'
param vnet1SubnetAdresses array = [
  '10.100.1.0/24'
  '10.100.2.0/24'
  '10.100.3.0/24'
]
param vnet1SubnetNames array = [
  'GatewaySubnet'
  'BastionSubnet'
  'FirewallSubnet'
]

param vnet2Name string = 'network2'
param vnet2Range string = '10.101.0.0/16'
param vnet2SubnetAdresses array = [
  '10.101.1.0/24'
  '10.101.2.0/24'
  '10.101.3.0/24'
]
param vnet2SubnetNames array = [
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
