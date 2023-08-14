variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}
variable "location" {
  type        = string
  description = "Azure region (`westeurope`)"
}
variable "bastion_conf" {
  description = "Configuration parameters for Azure Bastion Host"
  type        = map(any)
  default     = {}
}
variable "tags" {
  type        = map(string)
  description = "List of the tags that should be added to applicable resources"
}
