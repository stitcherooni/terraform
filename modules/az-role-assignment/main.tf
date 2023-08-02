resource "azurerm_role_assignment" "this" {
  for_each = var.role_assignment_params

  name                             = lookup(each.value, "name", null)
  description                      = lookup(each.value, "description", null)
  scope                            = lookup(each.value, "scope", null)
  role_definition_name             = lookup(each.value, "role_definition_name", null)
  principal_id                     = lookup(each.value, "principal_id", null)
  skip_service_principal_aad_check = lookup(each.value, "skip_service_principal_aad_check", false)

  timeouts {
    create = "3m"
    update = "3m"
    delete = "3m"
  }
}
