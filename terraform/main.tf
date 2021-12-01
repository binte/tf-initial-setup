terraform {
  backend "azurerm" { }

  required_version = ">= 0.15"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=2.72.0"
    }
  }
}

provider "azurerm" {
  features {}
}

module "example_rg" {
  source         = "./modules/resource-group"
  location       = var.location
  region_acronym = var.region_acronym
  application    = "TerraSetup"
  environment    = var.environment
}
