# Configure the Azure provider
variable "client_secret" {
  type = string
  description = "azure client secret for the appropriate service principle below"
  default = "abcde"
}

variable "region" {
  type = string
  description = "Azure region"
  default = "eastus"
}

variable "cluster-name-suffix" {
  description = "Cluster name suffix"
  type        = string
  default     = "aks"
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.48.0"
    }
  }

  required_version = ">= 1.1.0"
}

resource "random_id" "suffix" {
  byte_length = 4
}

// Modules _must_ use remote state. The provider does not persist state.
// NOTE: This is for keeping state in CrossPlane in a K8s cluster.
terraform {
  backend "kubernetes" {
    secret_suffix     = "providerconfig-default"
    namespace         = "default"
    in_cluster_config = true
  }
}

provider "azurerm" {
  features {}
  client_id = "40872f6d-74b1-4f0c-a560-7d754d8fd3dd"
  tenant_id = "6cea5d02-bfe1-4887-89f4-1dae00a54c60"
  subscription_id = "b471e439-04ca-42fe-af9c-a2eedb46cdfa"
  client_secret = var.client_secret
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-cloudflow-${var.cluster-name-suffix}-${random_id.suffix.hex}"
  location = var.region
}

resource "azurerm_kubernetes_cluster" "example" {
  name                = "cloudflow-${var.cluster-name-suffix}-${random_id.suffix.hex}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "cloudflow${var.cluster-name-suffix}-${random_id.suffix.hex}"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "standard_B4ms"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Development"
    //SkipGPUDriverInstall = true
  }

}

resource "azurerm_kubernetes_cluster_node_pool" "example" {
  name                  = "gpu"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.example.id
  vm_size               = "Standard_NC4as_T4_v3"
  node_count            = 1
  node_labels = { "NodePool" = "gpu" }
  node_taints = ["sku=gpu:NoSchedule"]
  mode        = "User"
  depends_on = [azurerm_kubernetes_cluster.example]
}

output "client_certificate" {
  value     = azurerm_kubernetes_cluster.example.kube_config.0.client_certificate
  sensitive = true
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.example.kube_config_raw

  sensitive = true
}

