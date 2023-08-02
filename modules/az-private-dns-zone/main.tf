# Private DNS zone
resource "azurerm_private_dns_zone" "this" {
  for_each = var.private_dns_zone_conf

  name                = lookup(each.value, "name", null)
  resource_group_name = var.resource_group_name

  timeouts {
    create = "2m"
    update = "2m"
    delete = "2m"
  }
}