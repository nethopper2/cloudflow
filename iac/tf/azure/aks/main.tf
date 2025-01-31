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

variable "client_id" {
  description = "Azure AD registered application ID (optional)"
  type        = string
  default     = "00000000-0000-0000-0000-000000000000"
}

variable "tenant_id" {
  description = "Azure AD Tenant ID (optional)"
  type        = string
  default     = "00000000-0000-0000-0000-000000000000"
}

variable "subscription_id" {
  description = "Azure AD Billing/Support ID (required)"
  type        = string
  default     = "00000000-0000-0000-0000-000000000000"
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
  client_id = var.client_id
  tenant_id = var.tenant_id
  subscription_id = var.subscription_id
  client_secret = var.client_secret
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-cloudflow-${var.cluster-name-suffix}"
  location = var.region
}

resource "azurerm_kubernetes_cluster" "example" {
  name                = "cloudflow-${var.cluster-name-suffix}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "cloudflow${var.cluster-name-suffix}"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "standard_d3_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Development"
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

