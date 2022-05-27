/////////////////////////////
/// Parameter Area
/////////////////////////////

@description('Location for all resources.')
param location string = resourceGroup().location

// VM parameter
@description('Username for the Virtual Machine.')
param adminUsername string

@description('Password for the Virtual Machine.')
@minLength(12)
@secure()
param adminPassword string

@description('Size of the virtual machine.')
param vmSize string

@description('Name of the virtual machine.')
param vmName string

// Network parameter
param existingVnetName string
param existingVnetRgName string
param existingSubnetName string

param diagStorageAccountName string
param diagStorageRgName string



//////////////////////////////////
/// Variable Area
//////////////////////////////////
var vnetId = resourceId(existingVnetRgName, 'Microsoft.Network/virtualNetworks', existingVnetName)
var subnetId = '${vnetId}/subnets/${existingSubnetName}'
var nicName = '${vmName}-nic'
var networkSecurityGroupName = '${vmName}-nsg'



//////////////////////////////////
/// Resource Area
//////////////////////////////////

// Existing resources
resource diagStorage 'Microsoft.Storage/storageAccounts@2021-09-01' existing = {
  name: diagStorageAccountName
  scope: resourceGroup(diagStorageRgName)
}

// New resources

resource securityGroup 'Microsoft.Network/networkSecurityGroups@2021-02-01' = {
  name: networkSecurityGroupName
  location: location
  properties: {
    securityRules: [
      {
        name: 'default-allow-3389'
        properties: {
          priority: 1000
          access: 'Allow'
          direction: 'Inbound'
          destinationPortRange: '3389'
          protocol: 'Tcp'
          sourcePortRange: '*'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
        }
      }
    ]
  }
}

resource nic 'Microsoft.Network/networkInterfaces@2021-02-01' = {
  name: nicName
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: subnetId
          }
        }
      }
    ]
  }
}

resource vm 'Microsoft.Compute/virtualMachines@2021-03-01' = {
  name: vmName
  location: location
  properties: {
    hardwareProfile: {
      vmSize: vmSize
    }
    osProfile: {
      computerName: vmName
      adminUsername: adminUsername
      adminPassword: adminPassword
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsDesktop'
        offer: 'Windows-10'
        sku: 'win10-21h2-pro-g2'
        version: 'latest'
      }
      osDisk: {
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: 'Standard_LRS'
        }
      }
      dataDisks: [
        {
          diskSizeGB: 128
          lun: 0
          createOption: 'Empty'
        }
      ]
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: nic.id
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
        // storageUri: stg.properties.primaryEndpoints.blob
        storageUri: diagStorage.properties.primaryEndpoints.blob
      }
    }
  }
}

output privateIpAdress string = nic.properties.ipConfigurations[0].properties.privateIPAddress
