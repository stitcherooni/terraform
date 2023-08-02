# Link private DNS Zone to Virtual Network
resource "azurerm_private_dns_zone_virtual_network_link" "this" {
  for_each = var.mysql_conf

  name                  = "mysql_dns_zone_link_to_vnet"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = lookup(each.value, "private_dns_zone_name", null) #.private.mysql.database.azure.com"
  virtual_network_id    = lookup(each.value, "vnet_id", null)
}

# Azure MySQL flexible server
resource "azurerm_mysql_flexible_server" "this" {
  for_each = var.mysql_conf

  name                   = lookup(each.value, "name", null)
  resource_group_name    = var.resource_group_name
  location               = var.location
  administrator_login    = lookup(each.value, "mysql_admin_password_login", "myadmin")
  administrator_password = lookup(each.value, "mysql_admin_password", null)
  backup_retention_days  = lookup(each.value, "backup_retention_days", 7)
  delegated_subnet_id    = lookup(each.value, "delegated_subnet_id", null)
  private_dns_zone_id    = lookup(each.value, "private_dns_zone_id", null)
  sku_name               = lookup(each.value, "sku_name", "B_Standard_B2s")
  version                = lookup(each.value, "version", "8.0.21")
  zone                   = lookup(each.value, "zone", null)

  dynamic "storage" {
    for_each = lookup(each.value, "storage", {}) != {} ? [1] : []
    content {
      auto_grow_enabled = lookup(each.value.storage, "auto_grow_enabled", null)
      iops              = lookup(each.value.storage, "iops", null)
      size_gb           = lookup(each.value.storage, "size_gb", 100)
    }
  }

  dynamic "high_availability" {
    for_each = lookup(each.value, "high_availability", {}) != {} ? [1] : []
    content {
      mode                      = lookup(each.value.high_availability, "mode", null)
      standby_availability_zone = lookup(each.value.high_availability, "standby_availability_zone", null)
    }
  }

  dynamic "identity" {
    for_each = lookup(each.value, "identity", {}) != {} ? [1] : []
    content {
      type         = lookup(each.value.identity, "type", null)
      identity_ids = lookup(each.value.identity, "identity_ids", null)
    }
  }

  tags = merge(
    var.tags,
    tomap({
      created_by         = "terraform"
      module             = "az_mysql_flexible_server"
      resource_type      = "azurerm_mysql_flexible_server"
      kubernetes_version = lookup(each.value, "version", "8.0.21")
      name               = lookup(each.value, "name", null)
    })
  )

  lifecycle {
    ignore_changes = [
      zone,
    ]
  }

  depends_on = [azurerm_private_dns_zone_virtual_network_link.this]
}
