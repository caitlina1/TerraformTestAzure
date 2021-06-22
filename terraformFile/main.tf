provider "azurerm" {
  features {}
}


resource "azurerm_resource_group" "ca825e-rg4" {
  name     = "ca825e-rg2"
  location = "eastus"
}

resource "azurerm_virtual_network" "ca825e-vn3" {
  name                = "ca825e-vn3"
  address_space       = ["10.0.0.0/16"]
  location            = "${azurerm_resource_group.ca825e-rg4.location}"
  resource_group_name = "${azurerm_resource_group.ca825e-rg4.name}"
}

resource "azurerm_subnet" "subnet" {
    name                 = "internal"
    resource_group_name  = "${azurerm_resource_group.ca825e-rg4.name}"
    virtual_network_name = "${azurerm_virtual_network.ca825e-vn3.name}"
    address_prefixes       = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "ca825e-nic" {
  name                = "ca825e-nic1"
  location            = "${azurerm_resource_group.ca825e-rg4.location}"
  resource_group_name = "${azurerm_resource_group.ca825e-rg4.name}"

  ip_configuration {
    name                          = "internal"
    subnet_id                     = "${azurerm_subnet.subnet.id}"
    private_ip_address_allocation = "Dynamic"
  }
}
