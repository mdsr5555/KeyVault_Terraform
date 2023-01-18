# Configure the Azure provider

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.0"
    }
  }
  required_version = ">= 0.14.9"
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = true
    }
  }
}

data "azurerm_client_config" "current" {}

# Create the Resource Group
resource "azurerm_resource_group" "resource_group" {

  name     = var.rg_name
  location = var.rg_location

  tags = {
    billTO = "IT"
  }
}


resource "azurerm_key_vault" "keyvault1" {

    name = var.kv_name
    location = var.rg_location
    resource_group_name = var.rg_name
    sku_name = var.kv_sku_name
    tenant_id = data.azurerm_client_config.current.tenant_id

    #enabled_for_deployment = var.kv_enabled_for_deployment
    #enabled_for_disk_encryption = var.kv_enabled_for_disk_encryption
    #enabled_for_template_deployment = var.kv_enabled_for_template_deployment

    soft_delete_retention_days  = 90
    purge_protection_enabled = var.kv_enabled_for_purge_protection

    enable_rbac_authorization = var.kv_enabled_for_rbac_authorization

    access_policy {
        tenant_id = data.azurerm_client_config.current.tenant_id
        object_id = data.azurerm_client_config.current.object_id

        key_permissions = ["Create", "Get", "List", "Purge", "Recover",]
        secret_permissions = ["Get", "List", "Purge", "Recover", "Set",]
        certificate_permissions = ["Create", "Get", "List", "Purge", "Recover", "Update",]
    } 
    depends_on = [azurerm_resource_group.resource_group]

    # Define your network access control list
    network_acls {
      # The Default Action to use when no rules match from ip_rules / 
      # virtual_network_subnet_ids. Possible values are Allow and Deny
      default_action = "Deny"

      # Allows all azure services to access your keyvault. Can be set to "None" or "AzureServices"
      bypass         = "None"

      # The list of allowed ip addresses.
      # For Example: ip_rules = ["1.1.1.1","2.2.2.2"]      
    }
  
}