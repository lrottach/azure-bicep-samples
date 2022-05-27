targetScope = 'subscription'

//
// Parameter Area
// 

param rgName string = 'rg-test-vm-we-001'
param rgLocation string = 'West Europe'
param kvName string = 'prod-vault-we-001'
param kvRgName string = 'rg-prod-vault-we-001'

//
// Resource Area
//

resource kv 'Microsoft.KeyVault/vaults@2021-11-01-preview' existing = {
  name: kvName
  scope: resourceGroup(kvRgName)
}

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: rgName
  location: rgLocation
  tags: {
    'Environment': 'Test'
    'Reaper_Lifetime': '120'
  }
}

module vm 'modules/vm.bicep' = {
  scope: rg
  name: 'vm-deploy'
  params: {
    location: rgLocation
    adminPassword: kv.getSecret('testLocalVmPassword')
    adminUsername: 'vmadmin'
    diagStorageAccountName: 'prodavdstoragediagwe001'
    diagStorageRgName: 'rg-prod-avd-storage-we-001'
    existingSubnetName: 'TestSubnet'
    existingVnetName: 'prod-avd-vnet-we-002'
    existingVnetRgName: 'rg-prod-avd-vnet-we-002'
    vmName: 'test-vm-we-001'
    vmSize: 'Standard_D2s_v5'
  }
}

output vmIpAddress string = vm.outputs.privateIpAdress
