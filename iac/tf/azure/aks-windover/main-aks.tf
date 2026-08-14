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
  default     = "windover-dev"
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0" # Or at least >= 3.100.0
    }
  }
  required_version = ">= 1.1.0"
}

resource "random_id" "suffix" {
  byte_length = 4
}

// Modules _must_ use remote state. The provider does not persist state.
// NOTE: This is for keeping state in CrossPlane in a K8s cluster.

//terraform {
//  backend "kubernetes" {
//    secret_suffix     = "providerconfig-default"
//    namespace         = "default"
//    in_cluster_config = true
//  }
//}




provider "azurerm" {
  features {}
  client_id = "c25b384e-db11-4832-b78a-0299eea10a61"
  tenant_id = "6e9c22cb-0e3a-4833-ad50-1690aee81043"
  subscription_id = "a1edaf77-9558-458a-b34b-06ab5f41b71c"
  client_secret = var.client_secret
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-${var.cluster-name-suffix}-${random_id.suffix.hex}"
  location = var.region
}

resource "azurerm_kubernetes_cluster" "example" {
  name                = "cluster-${var.cluster-name-suffix}-${random_id.suffix.hex}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "dns-${var.cluster-name-suffix}-${random_id.suffix.hex}"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "standard_d4as_v7"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Development"
    //SkipGPUDriverInstall = true
  }

}

output "client_certificate" {
  value     = azurerm_kubernetes_cluster.example.kube_config.0.client_certificate
  sensitive = true
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.example.kube_config_raw

  sensitive = true
}