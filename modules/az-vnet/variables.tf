variable "vnet_name" {
  type        = string
  description = "Azure VNET name"
}
variable "resource_group_name" {
  description = "Resource group name"
  default     = ""
}
variable "location" {
  description = "Azure region where resources will be deployed"
  default     = "westeurope"
}
variable "tags" {
  type        = map(string)
  description = "List of the tags that should be added to applicable resources"
}
variable "address_space" {
  description = "A list of address spaces for the virtual network to use."
  type        = list(any)
}
