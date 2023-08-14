#Resource Group
output "resource_group_name" {
  value = azurerm_resource_group.this.name
}
output "resource_group_id" {
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
output "node_resource_group" {
  value = module.az_aks.node_resource_group
}
# output "aks_host" {
#   value = module.az_aks.host
# }
# output "client_certificate" {
#   value = module.az_aks.client_certificate
# }
# output "client_key" {
#   value = module.az_aks.client_key
# }
# output "cluster_ca_certificate" {
#   value = module.az_aks.cluster_ca_certificate
# }
output "az_kube_config_raw" {
  value     = module.az_aks.az_kube_config_raw
  sensitive = true
}
output "az_kube_config" {
  value     = module.az_aks.az_kube_config
  sensitive = true
}
output "az_kubelet_identity" {
  value     = module.az_aks.az_kubelet_identity
  sensitive = true
}
output "aks" {
  value     = module.az_aks.aks
  sensitive = true
}
#PublicIP for Ingress Controller
output "ingress_pubip" {
  value = azurerm_public_ip.ingress_pubip.ip_address
}
#PublicIP for Bastion Host
output "bastion_pubip" {
  value = azurerm_public_ip.bastion_pubip.id
}
#Azure Role Assignment
output "role_assignment_name" {
  description = "Role Name"
  value       = module.az_role_assignment.role_assignment_name
}
output "object_id" {
  description = "The assigned object ID"
  value       = module.az_role_assignment.object_id
}
#Azure Private DNS 
output "private_dns_name" {
  value = module.az_private_dns_zone.private_dns_name
}
output "private_dns_id" {
  value = module.az_private_dns_zone.private_dns_id
}
#MySQL Flexible Server
output "mysql_server_name" {
  value = module.az_mysql_flexible_server.mysql_server_name
}
output "mysql_server_id" {
  value = module.az_mysql_flexible_server.mysql_server_id
}
output "mysql_server_fqdn" {
  value = module.az_mysql_flexible_server.mysql_server_fqdn
}
output "mysql_server_login" {
  value       = module.az_mysql_flexible_server.mysql_server_login
  sensitive   = true
  description = "The Administrator login for the MySQL Flexible Server"
}
output "mysql_server_password" {
  value       = module.az_mysql_flexible_server.mysql_server_password
  sensitive   = true
  description = "The Password associated with the administrator_login for the MySQL Flexible Server"
}
