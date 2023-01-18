variable "rg_name" {
    description = "Resource Group Name"
    type = string
    default = "rgTerraformRTQwpi"
}
variable "rg_location" {
    description = "Resource Group Location"
    type = string
    default = "westus"
}
variable "kv_name" {
    description = "Azure Key Vault Name"
    type = string
    default = "kvTerraformRTQwpi"
}

variable "kv_sku_name" {
    description = "Azure Key Vault SKU (Standard or Premium)"
    type = string
    default = "standard"
}

variable "kv_enabled_for_deployment" {
    description = "Azure Key Vault Enabled for Deployment"
    type = string
    default = "false"
}
variable "kv_enabled_for_disk_encryption" {
    description = "Azure Key Vault Enabled for Disk Encryption"
    type = string
    default = "false"
}
variable "kv_enabled_for_template_deployment" {
    description = "Azure Key Vault Enabled for Deployment"
    type = string
    default = "false"
}

variable "kv_enabled_for_purge_protection" {
    description = "Azure Key Vault Enabled for Purge Protection"
    type = string
    default = "false"
}

variable "kv_enabled_for_rbac_authorization" {
    description = "Azure Key Vault Enabled for RBAC authorization"
    type = string
    default = "true"
}
