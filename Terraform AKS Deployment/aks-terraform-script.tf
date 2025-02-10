
provider "azurerm" {
  features {}
  subscription_id   = "813f6f95-133a-45a4-822a-3b1bccebb96f"
  client_id         = "*************************************"
  client_secret     = "*************************************"
  tenant_id         = "*************************************"
}

resource "azurerm_resource_group" "aks_rg" {
  name     = "abb-aks-rg"
  location = "East US"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "abb-vnet"
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name
  address_space       = ["10.0.0.0/16"]

  subnet {
    name           = "aks-subnet"
    address_prefixes = ["10.0.1.0/24"]
  }
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "abb-aks-cluster"
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name
  dns_prefix          = "abb-aks"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_DS2_v2"
    vnet_subnet_id = one(azurerm_virtual_network.vnet.subnet[*].id)
  }

  identity {
    type = "SystemAssigned"
  }
  network_profile {
    network_plugin    = "azure"
    service_cidr      = "10.1.0.0/16"
    dns_service_ip    = "10.1.0.10"
    # docker_bridge_cidr = "172.17.0.1/16"
  }

  tags = {
    environment = "production"
  }
}

resource "azurerm_log_analytics_workspace" "log_analytics" {
  name                = "abb-log-analytics"
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}