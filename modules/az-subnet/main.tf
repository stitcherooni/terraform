resource "azurerm_subnet" "this" {
  for_each = var.subnet_cidr

  name                 = lookup(each.value, "subnet_name", [])
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name

  address_prefixes  = [each.value.cidr]
  service_endpoints = lookup(each.value, "service_endpoints", [])

  dynamic "delegation" {
    for_each = lookup(each.value, "delegations", {}) != {} ? [1] : []
    content {
      name = each.key
      service_delegation {
        name    = each.value.delegations.delegation_name
        actions = each.value.delegations.actions
      }
    }
  }
}
