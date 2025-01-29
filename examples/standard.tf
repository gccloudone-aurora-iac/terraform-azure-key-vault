#################
### Providers ###
#################

provider "azurerm" {
  features {}
}

####################################
### Azure Resource Prerequisites ###
####################################

resource "azurerm_resource_group" "keyvault" {
  name     = "example-keyvault-rg"
  location = "canada central"
}

resource "azurerm_private_dns_zone" "network" {
  name                = "privatelink.vaultcore.azure.net"
  resource_group_name = azurerm_resource_group.keyvault.name
}

### vnet one ###

resource "azurerm_virtual_network" "vnet_one" {
  name                = "example-one-vnet"
  address_space       = ["10.0.0.0/16"]
  resource_group_name = azurerm_resource_group.keyvault.name
  location            = azurerm_resource_group.keyvault.location
}

resource "azurerm_subnet" "storage_vnet_one" {
  name                 = "storage-one"
  resource_group_name  = azurerm_resource_group.keyvault.name
  virtual_network_name = azurerm_virtual_network.vnet_one.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_private_dns_zone_virtual_network_link" "vnet_one" {
  name                  = "mydomain-${azurerm_virtual_network.vnet_one.name}-pdl"
  resource_group_name   = azurerm_resource_group.keyvault.name
  private_dns_zone_name = azurerm_private_dns_zone.network.name
  virtual_network_id    = azurerm_virtual_network.vnet_one.id
}

########################
### Key Vault Module ###
########################

module "enc_key_vault" {
  source = "../"

  azure_resource_attributes = {
    project     = "aur"
    environment = "dev"
    location    = azurerm_resource_group.keyvault.location
    instance    = 0
  }
  user_defined        = "example"
  resource_group_name = azurerm_resource_group.keyvault.name

  sku_name                   = "premium"
  purge_protection_enabled   = true
  soft_delete_retention_days = 90

  public_network_access_enabled = false
  private_endpoints = [
    {
      subnet_id           = azurerm_subnet.storage_vnet_one.id
      private_dns_zone_id = azurerm_private_dns_zone.network.id
    }
  ]

  tags = {
    env = "development"
  }
}
