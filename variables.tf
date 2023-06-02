variable "devops_sb_resource_group_location" {
    default = "eastus"
    description = "Location of the resource group."
}

variable "devops_sb_resource_group_name_prefix" {
    default = "rg"
    description = "Prefix of the resource group that's combined with a random ID so name is unique in your Azure Subscription"
}

variable "ARM_TENANT_ID" {
    type = string
}

variable "ARM_CLIENT_ID" {
    type = string
}

variable "ARM_CLIENT_SECRET" {
    type = string
}

variable "ARM_SUBSCRIPTION_ID" {
    type = string
}

variable "ARM_RG_NAME" {
    type = string
}

variable "ARM_RG_ID" {
    type = string
}