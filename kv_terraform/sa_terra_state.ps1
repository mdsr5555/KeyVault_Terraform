# Parameteres
$RGroupName = "rg-sa-160123"
$RGroupLocation = "UK South"
$StorageAccountName = "saterrastate160123"
$storageContainerName = "terracontainer"

## Add/Modify Tags of your Choice
$ResourceGroupTags = @{
"billTO" = "IT"
}

if(Get-AzResourceGroup -Name $RGroupName -ErrorAction SilentlyContinue)
{
    # if the resource group already exist

    # Write Resource Group name as a variable in the pipeline
    Write-Host "##vso[task.setvariable variable=resource_group_name;isOutput=true]$RGroupName"
    # Write Storage Account name as a variable in the pipeline
    Write-Host "##vso[task.setvariable variable=storage_account_name;isOutput=true]$StorageAccountName"
    # Write Container name as a variable in the pipeline
    Write-Host "##vso[task.setvariable variable=container_name;isOutput=true]$storageContainerName"

    # Get the access key for Storage Account
    $key = Get-AzStorageAccountKey -ResourceGroupName $RGroupName -Name $StorageAccountName
    Write-Host "##vso[task.setvariable variable=storage_account_key;isOutput=true]$key"
}
else
{
    # Create Resource Group
    New-AzResourceGroup -Name $RGroupName -Location $RGroupLocation -Tag $ResourceGroupTags
    # Write Resource Group name as a variable in the pipeline
    Write-Host "##vso[task.setvariable variable=resource_group_name;isOutput=true]$RGroupName"

    # Create Storage Account
    New-AzStorageAccount -ResourceGroupName $RGroupName -Name $StorageAccountName -Location $RGroupLocation -SkuName Standard_LRS -Kind StorageV2
    # Write Storage Account name as a variable in the pipeline
    Write-Host "##vso[task.setvariable variable=storage_account_name;isOutput=true]$StorageAccountName"


    # Get the storage account in which container has to be created  
    $storageAcc = Get-AzStorageAccount -ResourceGroupName $RGroupName -Name $StorageAccountName      
    # Get the storage account context  
    $ctx = $storageAcc.Context
    # Create a Container inside the SA  
    New-AzStorageContainer -Name $storageContainerName -Context $ctx -Permission Container
    Write-Host "##vso[task.setvariable variable=container_name;isOutput=true]$storageContainerName"

    # Get the access key for Storage Account
    $key = Get-AzStorageAccountKey -ResourceGroupName $RGroupName -Name $StorageAccountName
    Write-Host "##vso[task.setvariable variable=storage_account_key;isOutput=true]$key" 
}

