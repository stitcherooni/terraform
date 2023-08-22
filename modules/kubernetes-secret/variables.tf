variable "secret" {
  description = "Kubernetes secrets. The secret type. Defaults to kubernetes.io/Opaque, other options kubernetes.io/service-account-token, kubernetes.io/basic-auth, kubernetes.io/ssh-auth, kubernetes.io/tls, bootstrap.kubernetes.io/token"
  default     = {}
}