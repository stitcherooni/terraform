resource "azurerm_kubernetes_cluster" "this" {
  for_each = var.aks_conf != null ? { for k, v in var.aks_conf : k => v } : {}

  name                = lookup(var.aks_conf, "name", null)
  dns_prefix          = lookup(var.aks_conf, "name", null)
  node_resource_group = "${lookup(var.aks_conf, "name", "")}-np-rg"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku_tier            = lookup(var.aks_conf, "sku_tier", "Standard")
  kubernetes_version  = lookup(var.aks_conf, "kubernetes_version", "1.25.5")

  private_cluster_enabled           = lookup(var.aks_conf, "private_cluster_enabled", false)
  azure_policy_enabled              = lookup(var.aks_conf, "azure_policy_enabled", true)
  http_application_routing_enabled  = lookup(var.aks_conf, "http_application_routing_enabled", false)
  role_based_access_control_enabled = lookup(var.aks_conf, "role_based_access_control_enabled", true)
  local_account_disabled            = lookup(var.aks_conf, "local_account_disabled", true)

  dynamic "azure_active_directory_role_based_access_control" {
    for_each = lookup(var.aks_conf, "azad_rbac", {}) != {} ? [1] : []
    content {
      managed                = lookup(var.aks_conf.azad_rbac, "rbac_managed", false)
      azure_rbac_enabled     = lookup(var.aks_conf.azad_rbac, "azure_rbac_enabled", null)
      admin_group_object_ids = lookup(var.aks_conf.azad_rbac, "admin_group_object_ids", []) #[]
      tenant_id              = lookup(var.aks_conf.azad_rbac, "tenant_id", null)
    }
  }

  dynamic "network_profile" {
    for_each = lookup(var.aks_conf, "network_profile", {}) != {} ? [1] : []
    content {
      network_plugin     = lookup(var.aks_conf.network_profile, "network_plugin", "azure")
      network_policy     = lookup(var.aks_conf.network_profile, "network_policy", "azure")
      dns_service_ip     = lookup(var.aks_conf.network_profile, "dns_service_ip", null)
      docker_bridge_cidr = lookup(var.aks_conf.network_profile, "docker_bridge_cidr", null)
      service_cidr       = lookup(var.aks_conf.network_profile, "service_cidr", null)
      load_balancer_sku  = lookup(var.aks_conf.network_profile, "load_balancer_sku", null)
    }
  }

  default_node_pool {
    name                 = lookup(var.aks_conf.default_node_pool, "name", "default")
    vm_size              = lookup(var.aks_conf.default_node_pool, "vm_size", "Standard_B2s")
    orchestrator_version = lookup(var.aks_conf.default_node_pool, "orchestrator_version", null)
    os_disk_size_gb      = lookup(var.aks_conf.default_node_pool, "os_disk_size_gb", 256)
    vnet_subnet_id       = lookup(var.aks_conf.default_node_pool, "vnet_subnet_id", null)
    zones                = lookup(var.aks_conf.default_node_pool, "zones", null)
    max_pods             = lookup(var.aks_conf.default_node_pool, "max_pods", 50)
    node_labels          = lookup(var.aks_conf.default_node_pool, "node_labels", null)
    node_taints          = lookup(var.aks_conf.default_node_pool, "node_taints", null)
    type                 = lookup(var.aks_conf.default_node_pool, "type", null)
    enable_auto_scaling  = lookup(var.aks_conf.default_node_pool, "enable_auto_scaling", null)
    node_count           = lookup(var.aks_conf.default_node_pool, "node_count", null)
    min_count            = lookup(var.aks_conf.default_node_pool, "min_count", null)
    max_count            = lookup(var.aks_conf.default_node_pool, "max_count", null)
  }

  dynamic "identity" {
    for_each = lookup(var.aks_conf, "identity", {}) != {} ? [1] : []
    content {
      type         = lookup(var.aks_conf.identity, "type", "SystemAssigned")
      identity_ids = lookup(var.aks_conf.identity, "identity_ids", null)
    }
  }

  dynamic "microsoft_defender" {
    for_each = lookup(var.aks_conf, "microsoft_defender", {}) != {} ? [1] : []
    content {
      log_analytics_workspace_id = lookup(var.aks_conf.microsoft_defender, "log_analytics_workspace_id", null)
    }
  }

  dynamic "api_server_access_profile" {
    for_each = lookup(var.aks_conf, "api_server_access_profile", {}) != {} ? [1] : []
    content {
      authorized_ip_ranges     = lookup(var.aks_conf.api_server_access_profile, "authorized_ip_ranges", []) #Whitelist IPs
      vnet_integration_enabled = lookup(var.aks_conf.api_server_access_profile, "vnet_integration_enabled", false)
      subnet_id                = lookup(var.aks_conf.api_server_access_profile, "api_server_subnet_id", null)
    }
  }

  tags = merge(
    var.tags,
    tomap({
      module             = "az_aks"
      resource_type      = "kubernetes_cluster"
      kubernetes_version = lookup(var.aks_conf, "kubernetes_version", "1.27.1")
      name               = lookup(var.aks_conf, "name", null)
    })
  )

  lifecycle {
    ignore_changes = [
      default_node_pool[0].node_labels,
      default_node_pool[0].node_taints,
    ]
  }
}
