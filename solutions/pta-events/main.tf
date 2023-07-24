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

#Create public IP for ingress controller
resource "azurerm_public_ip" "ingress_pubip" {
  name                = "${var.env_name}-ingress-pubip"
  resource_group_name = module.az_aks.node_resource_group["${var.env_name}-ptae-aks-01"]
  location            = var.location
  allocation_method   = "Static"
  ip_version          = "IPv4"
  sku                 = "Standard"
  zones               = [1]

  lifecycle {
    ignore_changes = [
      zones,
    ]
  }

  tags = var.tags
}

#Create Namespace
# resource "kubernetes_namespace" "this" {
#   metadata {
#     name = var.env_name
#   }
# }