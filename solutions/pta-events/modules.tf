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

  depends_on = [module.az_subnet,
  ]
}

#Kubernetes ingress-nginx
module "aks_ingress_controller" {
  source = "../../modules/az-aks-ingress"

  # common part
  ingress_name   = "ingress-controller"
  namespace_name = kubernetes_namespace.ingress.id

  # ingress config
  ingress_pubip = azurerm_public_ip.ingress_pubip.ip_address

  depends_on = [kubernetes_namespace.ingress,
    module.az_aks
  ]
}

#Azure Role Assignment
module "az_role_assignment" {
  source = "../../modules/az-role-assignment"

  role_assignment_params = var.role_assignment_params
}

#Azure Private DNS 
module "az_private_dns_zone" {
  source = "../../modules/az-private-dns-zone"

  resource_group_name   = azurerm_resource_group.this.name
  private_dns_zone_conf = var.private_dns_zone_conf
}

#MySQL Flexible Server
module "az_mysql_flexible_server" {
  source = "../../modules/az-mysql-flexible-server"

  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  mysql_conf          = var.mysql_conf

  tags = merge(
    var.tags,
  )

  depends_on = [module.az_private_dns_zone,
    module.az_subnet
  ]
}

#Azure Bastion Host
module "az_bastion" {
  source = "../../modules/az-bastion"

  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  bastion_conf        = var.bastion_conf

  tags = merge(
    var.tags,
  )
}
