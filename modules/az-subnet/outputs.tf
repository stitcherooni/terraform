output "azurerm_subnet_name" {
  value = [ for subnet in azurerm_subnet.this : subnet.name ]
}

output "subnet_id" {
  value = { for subnet in azurerm_subnet.this : subnet.name => subnet.id }
}
/*
output "azurerm_subnet_id_1" {
  value = {
    [for subnet in azurerm_subnet.this : subnet.name] = [for subnet in azurerm_subnet.this : subnet.id]
  }
}*/