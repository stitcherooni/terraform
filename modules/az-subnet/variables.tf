variable "resource_group_name" {
  description = "Resource group name"
  default     = ""
}

variable "virtual_network_name" {
  description = "Virtual network name"
  type        = string
}

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
