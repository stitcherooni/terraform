variable "ingress_name" {
  type        = string
  description = "Default name prefix to be used for all resources without specific naming requirements (VMs, azure container instances, application gateways, etc.)"
}

variable "namespace_name" {
  type        = string
  description = "k8s namespace"
}

variable "ingress_pubip" {
  type        = string
  description = "Public ip for ingress controller"
}
