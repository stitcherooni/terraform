resource "kubernetes_secret" "this" {
  for_each = var.secret

  type = lookup(each.value, "type", null)

  dynamic "metadata" {
    for_each = each.value.metadata[*]
    content {
      name  = lookup(each.value.metadata, "secret_name", null)
      namespace = lookup(each.value.metadata, "namespace", null)
      annotations = lookup(each.value.metadata, "annotations", null) 
      labels      = lookup(each.value.metadata, "labels", null)
    }
  }
  
  data = lookup(each.value, "secret_data", {})
  binary_data = lookup(each.value, "secret_binary_data", {})
}