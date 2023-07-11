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