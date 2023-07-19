output "role_assignment_name" {
  description = "The Name of the service principal."
  value       = [for r in azurerm_role_assignment.this : r.name]
}
output "object_id" {
  description = "The assigned object ID"
  value       = { for r in azurerm_role_assignment.this : r.name => r.id }
}