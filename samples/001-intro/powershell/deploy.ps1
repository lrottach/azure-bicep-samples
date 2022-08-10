$resourceGroupName = "rg-storage-data-we-001"
$storagePrefix = "dcosto"
$region = "westeurope"
$shareName = "data"

# Create Resource Group
New-AzResourceGroup `
    -Name $resourceGroupName `
    -Location $region | Out-Null


# Generate Storage Account Name
$storageAccountName = "$($storagePrefix)$(Get-Random)"


# Deploy Storage Account
$storageAcct = New-AzStorageAccount `
    -ResourceGroupName $resourceGroupName `
    -Name $storageAccountName `
    -Location $region `
    -Kind StorageV2 `
    -SkuName Standard_LRS `
    -EnableLargeFileShare


# Add FileShare to StorageAccount
New-AzRmStorageShare `
    -StorageAccount $storageAcct `
    -Name $shareName `
    -EnabledProtocol SMB `
    -QuotaGiB 64 | Out-Null
