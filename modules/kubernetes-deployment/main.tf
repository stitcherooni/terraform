resource "kubernetes_deployment_v1" "this" {
  for_each = var.deployment_conf

  dynamic "metadata" {
    for_each = lookup(each.value, "metadata", {}) != {} ? [1] : []
    content {
      name        = lookup(each.value.metadata, "name", "")
      namespace   = lookup(each.value.metadata, "namespace", null)
      annotations = lookup(each.value.metadata, "annotations", null)
      labels      = lookup(each.value.metadata, "labels", null)
    }
  }

  dynamic "spec" {
    for_each = lookup(each.value, "spec", {}) != {} ? [1] : []
    content {
      replicas = lookup(each.value.spec, "replicas", "1")
      dynamic "selector" {
        for_each = lookup(each.value.spec, "selector", {}) != {} ? [1] : []
        content {
          match_labels = lookup(each.value.spec.selector, "match_labels", {})
        }
      }
      dynamic "template" {
        for_each = lookup(each.value.spec, "template", {}) != {} ? [1] : []
        content {
          dynamic "metadata" {
            for_each = lookup(each.value.spec.template, "metadata", {}) != {} ? [1] : []
            content {
              labels = lookup(each.value.spec.template.metadata, "labels", {})
            }
          }
          dynamic "spec" {
            for_each = lookup(each.value.spec.template, "spec", {}) != {} ? [1] : []
            content {
              restart_policy       = lookup(each.value.spec.template.spec, "restart_policy", null)
              service_account_name = lookup(each.value.spec.template.spec, "service_account_name", null)
              dynamic "container" {
                for_each = lookup(each.value.spec.template.spec, "container", {}) != {} ? [1] : []
                content {
                  name              = lookup(each.value.spec.template.spec.container, "name", null)
                  image             = lookup(each.value.spec.template.spec.container, "image", null)
                  image_pull_policy = lookup(each.value.spec.template.spec.container, "image_pull_policy", null)
                  dynamic "port" {
                    for_each = lookup(each.value.spec.template.spec.container, "port", {}) != {} ? [1] : []
                    content {
                      name           = lookup(each.value.spec.template.spec.container.port, "name", null)
                      container_port = lookup(each.value.spec.template.spec.container.port, "container_port", null)
                      protocol       = lookup(each.value.spec.template.spec.container.port, "protocol", null)
                    }
                  }
                  dynamic "env" {
                    iterator = env
                    for_each = can(var.deployment_conf[each.key].spec.template.spec.container.env) ? [for value in var.deployment_conf[each.key].spec.template.spec.container.env : value] : []
                    content {
                      name  = lookup(env.value, "name", null)
                      value = lookup(env.value, "value", null)
                      dynamic "value_from" {
                        for_each = lookup(env.value, "value_from", {}) != {} ? [1] : []
                        content {
                          dynamic "field_ref" {
                            for_each = lookup(env.value.value_from, "field_ref", {}) != {} ? [1] : []
                            content {
                              name = lookup(env.value.value_from.field_ref, "api_version", null)
                              key  = lookup(env.value.value_from.field_ref, "field_path", null)
                            }
                          }
                          dynamic "secret_key_ref" {
                            for_each = lookup(env.value.value_from, "secret_key_ref", {}) != {} ? [1] : []
                            content {
                              name = lookup(env.value.value_from.secret_key_ref, "name", null)
                              key  = lookup(env.value.value_from.secret_key_ref, "value", null)
                            }
                          }
                        }
                      }
                    }
                  }
                  dynamic "resources" {
                    for_each = lookup(each.value.spec.template.spec.container, "resources", {}) != {} ? [1] : []
                    content {
                      requests = lookup(each.value.spec.template.spec.container.resources, "requests", null)
                      limits   = lookup(each.value.spec.template.spec.container.resources, "limits", null)
                    }
                  }
                  dynamic "liveness_probe" {
                    for_each = lookup(each.value.spec.template.spec.container, "liveness_probe", {}) != {} ? [1] : []
                    content {
                      initial_delay_seconds = lookup(each.value.spec.template.spec.container.liveness_probe, "initial_delay_seconds", null)
                      period_seconds        = lookup(each.value.spec.template.spec.container.liveness_probe, "period_seconds", null)
                      timeout_seconds       = lookup(each.value.spec.template.spec.container.liveness_probe, "timeout_seconds", null)
                      success_threshold     = lookup(each.value.spec.template.spec.container.liveness_probe, "success_threshold", null)
                      failure_threshold     = lookup(each.value.spec.template.spec.container.liveness_probe, "failure_threshold", null)
                      dynamic "tcp_socket" {
                        for_each = lookup(each.value.spec.template.spec.container.liveness_probe, "tcp_socket", {}) != {} ? [1] : []
                        content {
                          port = lookup(each.value.spec.template.spec.container.liveness_probe.tcp_socket, "port", null)
                        }
                      }
                    }
                  }
                  dynamic "readiness_probe" {
                    for_each = lookup(each.value.spec.template.spec.container, "readiness_probe", {}) != {} ? [1] : []
                    content {
                      initial_delay_seconds = lookup(each.value.spec.template.spec.container.readiness_probe, "initial_delay_seconds", null)
                      period_seconds        = lookup(each.value.spec.template.spec.container.readiness_probe, "period_seconds", null)
                      timeout_seconds       = lookup(each.value.spec.template.spec.container.readiness_probe, "timeout_seconds", null)
                      success_threshold     = lookup(each.value.spec.template.spec.container.readiness_probe, "success_threshold", null)
                      failure_threshold     = lookup(each.value.spec.template.spec.container.readiness_probe, "failure_threshold", null)
                      dynamic "http_get" {
                        for_each = lookup(each.value.spec.template.spec.container.readiness_probe, "http_get", {}) != {} ? [1] : []
                        content {
                          path   = lookup(each.value.spec.template.spec.container.liveness_probe.http_get, "path", null)
                          port   = lookup(each.value.spec.template.spec.container.liveness_probe.http_get, "port", null)
                          scheme = lookup(each.value.spec.template.spec.container.liveness_probe.http_get, "scheme", null)
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}