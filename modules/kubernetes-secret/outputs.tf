output "secret_name" {
  value = kubernetes_secret.this[*]
}
