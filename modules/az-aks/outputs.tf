output "aks_name" {
  description = "The Kubernetes Managed Cluster Name"
  value       = [for aks in azurerm_kubernetes_cluster.this : aks.name]
}
output "aks_id" {
  description = "The Kubernetes Managed Cluster ID"
  value       = { for aks in azurerm_kubernetes_cluster.this : aks.name => aks.id }
}
output "aks_fqdn" {
  description = "The FQDN of the Azure Kubernetes Managed Cluster"
  value       = { for aks in azurerm_kubernetes_cluster.this : aks.name => aks.fqdn }
}
output "node_resource_group" {
  value = { for aks in azurerm_kubernetes_cluster.this : aks.name => aks.node_resource_group }
}
output "host" {
  description = "The Kubernetes cluster server host."
  value       = { for aks in azurerm_kubernetes_cluster.this : aks.name => aks.kube_config.0.host }
  sensitive   = true
}
output "client_certificate" {
  description = "public certificate used by clients to authenticate to the Kubernetes cluster."
  value       = { for aks in azurerm_kubernetes_cluster.this : aks.name => aks.kube_config.0.client_certificate }
  sensitive   = true
}
output "client_key" {
  description = "private key used by clients to authenticate to the Kubernetes cluster"
  value       = { for aks in azurerm_kubernetes_cluster.this : aks.name => aks.kube_config.0.client_key }
  sensitive   = true
}
output "cluster_ca_certificate" {
  description = "public CA certificate used as the root of trust for the Kubernetes cluster."
  value       = { for aks in azurerm_kubernetes_cluster.this : aks.name => aks.kube_config.0.cluster_ca_certificate }
  sensitive   = true
}
