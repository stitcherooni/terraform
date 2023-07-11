resource "azurerm_resource_group" "this" {
  name     = "${var.env_name}-ptae-rg-01"
  location = var.location

  tags = merge(
    var.tags,
    tomap({
      solution      = var.env_name
      module        = "none"
      resource_type = "resource_group"
      name          = "${var.env_name}-ptae-rg-01"
    })
  )
}