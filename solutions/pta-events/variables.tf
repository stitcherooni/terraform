#Main
variable "location" {
  description = "Azure region where resources will be deployed"
  default     = "westeurope"
}
#Environment Name (Name Prefix)
variable "env_name" {
  description = "Environment Name"
}
#VNET
variable "address_space" {
  description = "A list of address spaces for the virtual network to use."
  type        = list(any)
}
#Subnet
variable "subnet_cidr" {
  description = "The address prefix list to use for the subnet"
  default     = {}
}
variable "service_endpoints" {
  description = "The list of Service endpoints to associate with the subnet"
  type        = list(string)
  default     = []
}
variable "service_delegation" {
  description = "if its 'true' service delegation will be added once"
  type        = bool
  default     = false
}
variable "service_delegation_action" {
  description = "Configuration delegations on subnet"
  type        = list(string)
  default     = []
}
#AKS
variable "aks_conf" {
  default     = {}
  description = "Configuration parameters for azure kubernetes service"
}
#Azure Role Assignment
variable "role_assignment_params" {
  default     = {}
  description = "Assigns a given Principal (User or Group) to a given Role."
}

#Azure Private DNS 
variable "private_dns_zone_conf" {
  description = "Private DNS zone configuration"
  default     = {}
}

#MySQL Flexible Server
variable "mysql_conf" {
  description = "Configuration parameters for MySQL Server"
  type        = map(any)
  default     = {}
}

#Azure Bastion Host
variable "bastion_conf" {
  description = "Configuration parameters for Azure Bastion Host"
  type        = map(any)
  default     = {}
}

#Tags
variable "tags" {
  type        = map(string)
  description = "List of the tags that should be added to applicable resources"
}
