resource "azurerm_bastion_host" "this" {
  for_each = var.bastion_conf

  name                = lookup(each.value, "name", "")
  resource_group_name = var.resource_group_name
  location            = var.location

  sku                    = lookup(each.value, "sku", "Standard")
  copy_paste_enabled     = lookup(each.value, "copy_paste_enabled", true)
  file_copy_enabled      = lookup(each.value, "file_copy_enabled", true)
  shareable_link_enabled = lookup(each.value, "shareable_link_enabled", true)
  tunneling_enabled      = lookup(each.value, "tunneling_enabled", true)

  dynamic "ip_configuration" {
    for_each = lookup(each.value, "ip_configuration", {}) != {} ? [1] : []
    content {
      name                 = "ip_config"
      subnet_id            = lookup(each.value.ip_configuration, "subnet_id", null)
      public_ip_address_id = lookup(each.value.ip_configuration, "public_ip_address_id", null)
    }
  }

  tags = merge(
    var.tags,
    tomap({
      created_by    = "terraform"
      module        = "az_bastion"
      resource_type = "bastion_host"
      name          = lookup(each.value, "name", "")
    })
  )
}
