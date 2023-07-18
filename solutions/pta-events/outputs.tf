#Resource Group
output "azurerm_resource_group_name" {
  value = azurerm_resource_group.this.name
}
output "azurerm_resource_group_id" {
  value = azurerm_resource_group.this.id
}
#VNet
output "virtual_network_name" {
  value = module.az_vnet.virtual_network_name
}
output "virtual_network_id" {
  value = module.az_vnet.virtual_network_id
}
#Subnet
output "subnet_name" {
  value = module.az_subnet.azurerm_subnet_name
}
output "subnet_id" {
  value = module.az_subnet.subnet_id
}
#AKS
output "aks_name" {
  value = module.az_aks.aks_name
}
output "aks_id" {
  value = module.az_aks.aks_id
}
output "aks_host" {
  value = module.az_aks.host
}
output "client_certificate" {
  value = module.az_aks.client_certificate
}
output "client_key" {
  value = module.az_aks.client_key
}
output "cluster_ca_certificate" {
  value = module.az_aks.cluster_ca_certificate
}




