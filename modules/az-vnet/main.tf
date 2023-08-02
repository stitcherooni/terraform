resource "azurerm_virtual_network" "this" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.address_space

  tags = merge(
    var.tags,
    tomap({
      created_by    = "terraform"
      module        = "az_vnet"
      resource_type = "virtual_network"
      name          = "${var.vnet_name}"
    })
  )
}
