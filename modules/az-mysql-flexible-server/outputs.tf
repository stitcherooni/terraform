output "mysql_server_name" {
  value = [for sql in azurerm_mysql_flexible_server.this : sql.name]
}
output "mysql_server_id" {
  value = { for sql in azurerm_mysql_flexible_server.this : sql.name => sql.id }
}
output "mysql_server_fqdn" {
  value = { for sql in azurerm_mysql_flexible_server.this : sql.name => sql.fqdn }
}
output "mysql_server_login" {
  value       = { for sql in azurerm_mysql_flexible_server.this : sql.name => sql.administrator_login }
  sensitive   = true
  description = "The Administrator login for the MySQL Flexible Server"
}
output "mysql_server_password" {
  value       = { for sql in azurerm_mysql_flexible_server.this : sql.name => sql.administrator_password }
  sensitive   = true
  description = "The Password associated with the administrator_login for the MySQL Flexible Server"
}
