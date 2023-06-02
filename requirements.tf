# telling terraform what the required providers/versions are. Build file that keeps track of modules used
terraform {
  cloud {
    hostname     = "app.terraform.io"
    organization = "cmrh"
    workspaces {
      name = "bibek-told-me-so"
    }
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.45.0"
    }
  }
  required_version = "~> 1.4.6"
}