# Key Vault Terraform Module
## Overview
This repository contains Terraform code for creating an Azure resource group, key vault and configure the access policies. <br/>The following resources will be created:
* Azure resource group
* Azure key vault
## Requirements
* Terraform version 0.14.9 or higher
* Provider version 3.0.0 or higher for azurerm
## Inputs
* rg_name: Name of the resource group. **_(required)_**
* rg_location: Location of the resource group. **_(required)_**
* kv_name: Name of the key vault. **_(required)_**
* kv_sku_name: SKU name for the key vault. **_(required)_**
* tenant_id: he AAD tenant ID that should be used for authenticating requests to the key vault.  **_(required)_**
* kv_enabled_for_purge_protection: Enable or disable purge protection for the key vault.
* kv_enabled_for_rbac_authorization: Enable or disable RBAC authorization for the key vault.
## Outputs
* None
## Configurations
* The key vault is configured with soft delete retention days set to 90 and purge protection enabled.
* The key vault is configured with enabled purge protection.
* The key vault is configured with RBAC authorization enabled.
* Access policies are set to allow access to the current tenant and object id.
* Network access control list _*'network_acls'*_ is set to deny access by default and allows no bypasses.
## Deployment
* Create or push this code to your repository
* Define the variables in the terraform.tfvars file
* Declare the variables in the variables.tf if you create any new one.
* Run terraform init to initialize the provider
* Run terraform plan to see the execution plan
* Run terraform apply to create the resources
* Run terraform destroy to delete the resources created.
## Note
* Before destroying the key vault, make sure to delete all the secrets, keys, and certificates stored in the key vault.
* This module is intended as a starting point and can be extended and modified to suit your specific requirements.
* Make sure you have the necessary permissions to create the above resources in your Azure subscription.
* All the variable names are just for examples
## Integration with Azure DevOps
This repository can be integrated with Azure DevOps by creating a pipeline that runs the terraform commands.

1. Go to your Azure DevOps project.
2. Navigate to the Pipelines tab.
3. Click on New pipeline button.
4. Select the repository where your Terraform code is stored.
5. Choose Terraform template.
6. Configure the pipeline as per your requirement.
7. Save and run the pipeline. <br/>

You can also use the **Azure Terraform** extension in Azure DevOps to run Terraform tasks in pipeline.
## Additional information
* This module contains poweshell script which deploy resource group, storage account and container inside the storage aaccount to keep the terraform state file .tfstate.
* This powershell script get the storage account access key and write it to pipeline variable.
* You must need to provide above mentioned variables in pipeline's terraform init task. Variable names are mentioned in powershell script.