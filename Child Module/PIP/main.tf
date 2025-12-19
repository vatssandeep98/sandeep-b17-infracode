resource "azurerm_public_ip" "pip" {
  name                = var.pip_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

