output "bastion_host_name" {
  value = [ for b in azurerm_bastion_host.this : b.name ]
}
output "bastion_host_id" {
  value = { for b in azurerm_bastion_host.this : b.name => b.id }
}
output "bastion_host_dns" {
  value = { for b in azurerm_bastion_host.this : b.name => b.dns_name }
}
