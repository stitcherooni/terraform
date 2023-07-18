#VNet
module "az_vnet" {
  source = "../../modules/az-vnet"

  vnet_name           = "${var.env_name}-ptae-vnet-01"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  address_space       = var.address_space

  tags = merge(
    var.tags,
    tomap({
      solution = var.env_name
    })
  )

  depends_on = [azurerm_resource_group.this,
  ]
}

#Subnet
module "az_subnet" {
  source = "../../modules/az-subnet"

  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = module.az_vnet.virtual_network_name
  subnet_cidr          = var.subnet_cidr

  #Optional
  service_endpoints         = var.service_endpoints
  service_delegation        = var.service_delegation
  service_delegation_action = var.service_delegation_action

  depends_on = [module.az_vnet,
  ]
}

#AKS
module "az_aks" {
  source = "../../modules/az-aks"

  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  aks_conf            = var.aks_conf

  tags = merge(
    var.tags,
  )
}