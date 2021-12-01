locals {
  resource_group_name = join("-", ["RG", var.region_acronym, var.application, var.environment])
}

resource "azurerm_resource_group" "rg" {
  name     = local.resource_group_name
  location = var.location
}
