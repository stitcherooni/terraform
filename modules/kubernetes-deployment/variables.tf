variable "deployment_conf" {
  description = "Configuration parameters for Kubernetes Deployment"
  type        = map(any)
  default     = {}
}
