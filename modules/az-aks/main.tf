resource "azurerm_kubernetes_cluster" "this" {
  for_each = var.aks_conf

  name                = lookup(each.value, "name", null)
  dns_prefix          = lookup(each.value, "name", null)
  node_resource_group = "${lookup(each.value, "name", "")}-np-rg"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku_tier            = lookup(each.value, "sku_tier", "Standard")
  kubernetes_version  = lookup(each.value, "kubernetes_version", "1.26.3")

  private_cluster_enabled           = lookup(each.value, "private_cluster_enabled", false)
  azure_policy_enabled              = lookup(each.value, "azure_policy_enabled", true)
  http_application_routing_enabled  = lookup(each.value, "http_application_routing_enabled", false)
  role_based_access_control_enabled = lookup(each.value, "role_based_access_control_enabled", true)
  local_account_disabled            = lookup(each.value, "local_account_disabled", true)
  node_os_channel_upgrade           = lookup(each.value, "node_os_channel_upgrade", "SecurityPatch")

  dynamic "azure_active_directory_role_based_access_control" {
    for_each = lookup(each.value, "azad_rbac", {}) != {} ? [1] : []
    content {
      managed                = lookup(each.value.azad_rbac, "rbac_managed", true)
      azure_rbac_enabled     = lookup(each.value.azad_rbac, "azure_rbac_enabled", false)
      admin_group_object_ids = lookup(each.value.azad_rbac, "admin_group_object_ids", []) #[]
      tenant_id              = lookup(each.value.azad_rbac, "tenant_id", null)
    }
  }

  dynamic "network_profile" {
    for_each = lookup(each.value, "network_profile", {}) != {} ? [1] : []
    content {
      network_plugin     = lookup(each.value.network_profile, "network_plugin", "azure")
      network_policy     = lookup(each.value.network_profile, "network_policy", "azure")
      dns_service_ip     = lookup(each.value.network_profile, "dns_service_ip", null)
      docker_bridge_cidr = lookup(each.value.network_profile, "docker_bridge_cidr", null)
      service_cidr       = lookup(each.value.network_profile, "service_cidr", null)
      load_balancer_sku  = lookup(each.value.network_profile, "load_balancer_sku", null)
    }
  }

  default_node_pool {
    name                 = lookup(each.value.default_node_pool, "name", "default")
    vm_size              = lookup(each.value.default_node_pool, "vm_size", "Standard_B2s")
    orchestrator_version = lookup(each.value.default_node_pool, "orchestrator_version", null)
    os_disk_size_gb      = lookup(each.value.default_node_pool, "os_disk_size_gb", 256)
    vnet_subnet_id       = lookup(each.value.default_node_pool, "vnet_subnet_id", null)
    zones                = lookup(each.value.default_node_pool, "zones", null)
    max_pods             = lookup(each.value.default_node_pool, "max_pods", 50)
    node_labels          = lookup(each.value.default_node_pool, "node_labels", null)
    node_taints          = lookup(each.value.default_node_pool, "node_taints", null)
    type                 = lookup(each.value.default_node_pool, "type", null)
    enable_auto_scaling  = lookup(each.value.default_node_pool, "enable_auto_scaling", null)
    node_count           = lookup(each.value.default_node_pool, "node_count", null)
    min_count            = lookup(each.value.default_node_pool, "min_count", null)
    max_count            = lookup(each.value.default_node_pool, "max_count", null)
  }

  dynamic "identity" {
    for_each = lookup(each.value, "identity", {}) != {} ? [1] : []
    content {
      type         = lookup(each.value.identity, "type", "SystemAssigned")
      identity_ids = lookup(each.value.identity, "identity_ids", null)
    }
  }

  dynamic "microsoft_defender" {
    for_each = lookup(each.value, "microsoft_defender", {}) != {} ? [1] : []
    content {
      log_analytics_workspace_id = lookup(each.value.microsoft_defender, "log_analytics_workspace_id", null)
    }
  }

  dynamic "api_server_access_profile" {
    for_each = lookup(each.value, "api_server_access_profile", {}) != {} ? [1] : []
    content {
      authorized_ip_ranges     = lookup(each.value.api_server_access_profile, "authorized_ip_ranges", []) #Whitelist IPs
      vnet_integration_enabled = lookup(each.value.api_server_access_profile, "vnet_integration_enabled", false)
      subnet_id                = lookup(each.value.api_server_access_profile, "api_server_subnet_id", null)
    }
  }

  tags = merge(
    var.tags,
    tomap({
      created_by         = "terraform"
      module             = "az_aks"
      resource_type      = "kubernetes_cluster"
      kubernetes_version = lookup(each.value, "kubernetes_version", "1.27.1")
      name               = lookup(each.value, "name", null)
    })
  )

  lifecycle {
    ignore_changes = [
      default_node_pool[0].node_labels,
      default_node_pool[0].node_taints,
    ]
  }
}
