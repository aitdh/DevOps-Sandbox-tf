resource "azurerm_kubernetes_cluster" "k8s" {
  location            = var.devops_sb_resource_group_location
  name                = "aks-cmrh"
  resource_group_name = var.ARM_RG_NAME
  dns_prefix          = "aks-cmrh"
  sku_tier            = "Standard"
  private_cluster_enabled = true
  private_dns_zone_id     = azurerm_private_dns_zone.aks-private-dns-zone-cmrh.id

  depends_on = [
    azurerm_role_assignment.aks-role-assignment-cmrh,
  ]

  identity {
    type = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.aks-user-managed-id-cmrh.id]
  }

  default_node_pool {
    name       = "agentpool"
    vm_size    = "Standard_B2als_v2"
    node_count = var.node_count
  }

  network_profile {
    network_plugin    = "kubenet"
    load_balancer_sku = "standard"
  }
}

resource "azurerm_private_dns_zone" "aks-private-dns-zone-cmrh" {
  name                = "privatelink.eastus2.azmk8s.io"
  resource_group_name = var.ARM_RG_NAME
}

resource "azurerm_user_assigned_identity" "aks-user-managed-id-cmrh" {
  name                = "aks-identity-cmrh"
  resource_group_name = var.ARM_RG_NAME
  location            = var.devops_sb_resource_group_location
}

resource "azurerm_role_assignment" "aks-role-assignment-cmrh" {
  scope                = azurerm_private_dns_zone.aks-private-dns-zone-cmrh.id
  role_definition_name = "Private DNS Zone Contributor"
  principal_id         = azurerm_user_assigned_identity.aks-user-managed-id-cmrh.principal_id
}