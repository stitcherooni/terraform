output "private_dns_name" {
  value = [ for dns in azurerm_private_dns_zone.this : dns.name ]
}

output "private_dns_id" {
  value = { for dns in azurerm_private_dns_zone.this : dns.name => dns.id }
}
