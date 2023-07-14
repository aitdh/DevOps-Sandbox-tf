resource "azurerm_kubernetes_cluster" "k8s" {
  location            = var.devops_sb_resource_group_location
  name                = "aks-cmrh"
  resource_group_name = var.ARM_RG_NAME
  dns_prefix          = "aks-cmrh"

  identity {
    type = "SystemAssigned"
  }

  default_node_pool {
    name       = "agentpool"
    vm_size    = "Standard_B2als_v2"
    node_count = var.node_count
  }
#   linux_profile {
#     admin_username = "ubuntu"

#     ssh_key {
#       key_data = jsondecode(azapi_resource_action.ssh_public_key_gen.output).publicKey
#     }
#   }
  network_profile {
    network_plugin    = "kubenet"
    load_balancer_sku = "standard"
  }
}