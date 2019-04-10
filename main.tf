# Vamos a crear para DEV-QA-PROD
# 1 RG eastus 
# 1 App Service
# 1 CosmosDB

#SQM Terraform Demo
provider "azurerm" {
  version = "=1.7.0"
  subscription_id = "${var.subscription_id}"
  client_id       = "${var.client_id}"
  client_secret   = "${var.client_secret}"
  tenant_id       = "${var.tenant_id}"
}

# Desarrollo
resource "azurerm_resource_group" "desarrollo" {
  name     = "${var.Componente["Grupo"]}${var.location}${var.Tipo["Aplicacion"]}${var.Codigo}${var.Ambiente["Desarrollo"]}"
  location = "${var.location}"
  tags {
    Ambiente = "${var.AmbienteTags["Desarrollo"]}"
    CECO = "04006012"
    Proyecto = "${var.Proyecto}"
    "Key USGR" = "Beatriz Garcia"
    "Responsable TI"= "${var.Responsable}"
    "Created By" = "${var.created}"
  }
}
# App Service Plan
resource "azurerm_app_service_plan" "appserviceplandev" {
  name                = "${var.Componente["ServicePlan"]}${var.location}${var.Tipo["Aplicacion"]}${var.Codigo}${var.Ambiente["Desarrollo"]}"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.desarrollo.name}"
  # Define Linux as Host OS
  kind = "Linux"
  sku {
    tier = "Standard"
    size = "S1"
  }
  properties {
    reserved = true # Mandatory for Linux plans
  }  
}

# Create an Azure Web App for Containers FrontEnd
resource "azurerm_app_service" "dockerappfront" {
  name                = "${var.Componente["App"]}${var.location}${var.Tipo["Aplicacion"]}${var.Codigo}${var.Ambiente["Desarrollo"]}"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.desarrollo.name}"
  app_service_plan_id = "${azurerm_app_service_plan.appserviceplandev.id}"
  # Do not attach Storage by default
  app_settings {
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = false
    /*
    # Settings for private Container Registires  
    DOCKER_REGISTRY_SERVER_URL      = ""
    DOCKER_REGISTRY_SERVER_USERNAME = ""
    DOCKER_REGISTRY_SERVER_PASSWORD = ""
    */
  }

  # Configure Docker Image to load on start
  site_config {
    always_on        = "true"
  }
  identity {
    type = "SystemAssigned"
  }
}

# CosmosDB

resource "azurerm_cosmosdb_account" "example" {
  name                = "${var.Componente["Cosmos"]}${var.location}${var.Tipo["Aplicacion"]}${var.Codigo}${var.Ambiente["Desarrollo"]}"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.desarrollo.name}"
  offer_type          = "Standard"
  kind                = "MongoDB"

  consistency_policy {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 10
    max_staleness_prefix    = 200
  }

  geo_location {
    prefix            = "${var.Componente["Cosmos"]}-customid"
    location          = "${var.location}"
    failover_priority = 0
  }
}


# QA
resource "azurerm_resource_group" "calidad" {
  name     = "${var.Componente["Grupo"]}${var.location}${var.Tipo["Aplicacion"]}${var.Codigo}${var.Ambiente["Calidad"]}"
  location = "${var.location}"
  tags {
    Ambiente = "${var.AmbienteTags["QA"]}"
    CECO = "04006012"
    Proyecto = "${var.Proyecto}"
    "Key USGR" = "Beatriz Garcia"
    "Responsable TI"= "${var.Responsable}"
    "Created By" = "${var.created}"
  }
}
# App Service Plan
resource "azurerm_app_service_plan" "appserviceplanqa" {
  name                = "${var.Componente["ServicePlan"]}${var.location}${var.Tipo["Aplicacion"]}${var.Codigo}${var.Ambiente["Calidad"]}"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.calidad.name}"
  # Define Linux as Host OS
  kind = "Linux"
  sku {
    tier = "Standard"
    size = "S1"
  }
  properties {
    reserved = true # Mandatory for Linux plans
  }
}

# Create an Azure Web App for Containers FrontEnd
resource "azurerm_app_service" "dockerappfrontqa" {
  name                = "${var.Componente["App"]}${var.location}${var.Tipo["Aplicacion"]}${var.Codigo}${var.Ambiente["Calidad"]}"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.calidad.name}"
  app_service_plan_id = "${azurerm_app_service_plan.appserviceplanqa.id}"
  # Do not attach Storage by default
  app_settings {
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = false
    /*
    # Settings for private Container Registires  
    DOCKER_REGISTRY_SERVER_URL      = ""
    DOCKER_REGISTRY_SERVER_USERNAME = ""
    DOCKER_REGISTRY_SERVER_PASSWORD = ""
    */
  }

  # Configure Docker Image to load on start
  site_config {
    always_on        = "true"
  }
  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_sql_server" "test" {
  name                         = "${var.Componente["SQLSVR"]}${var.location}${var.Tipo["Aplicacion"]}${var.Codigo}${var.Ambiente["Calidad"]}"
  resource_group_name          = "${azurerm_resource_group.calidad.name}"
  location                     = "${var.location}"
  version                      = "12.0"
  administrator_login          = "4dm1n157r470r"
  administrator_login_password = "4-v3ry-53cr37-p455w0rd"
}

resource "azurerm_sql_database" "test" {
  name                = "${var.Componente["SQLDB"]}${var.location}${var.Tipo["Aplicacion"]}${var.Codigo}${var.Ambiente["Calidad"]}"
  resource_group_name = "${azurerm_resource_group.calidad.name}"
  location            = "${var.location}"
  server_name         = "${azurerm_sql_server.test.name}"

  tags = {
    environment = "calidad"
  }
}

# Productivo
resource "azurerm_resource_group" "Productivo" {
  name     = "${var.Componente["Grupo"]}${var.location}${var.Tipo["Aplicacion"]}${var.Codigo}${var.Ambiente["Produccion"]}"
  location = "${var.location}"
  tags {
    Ambiente = "${var.AmbienteTags["Produccion"]}"
    CECO = "04006012"
    Proyecto = "${var.Proyecto}"
    "Key USGR" = "Beatriz Garcia"
    "Responsable TI"= "${var.Responsable}"
    "Created By" = "${var.created}"
  }
}
# App Service Plan
resource "azurerm_app_service_plan" "appserviceplanprod" {
  name                = "${var.Componente["ServicePlan"]}${var.location}${var.Tipo["Aplicacion"]}${var.Codigo}${var.Ambiente["Produccion"]}"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.Productivo.name}"
  # Define Linux as Host OS
  kind = "Linux"
  sku {
    tier = "Standard"
    size = "S1"
  }
  properties {
    reserved = true # Mandatory for Linux plans
  }
}

# Create an Azure Web App for Containers FrontEnd
resource "azurerm_app_service" "dockerappfrontprod" {
  name                = "${var.Componente["App"]}${var.location}${var.Tipo["Aplicacion"]}${var.Codigo}${var.Ambiente["Produccion"]}"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.Productivo.name}"
  app_service_plan_id = "${azurerm_app_service_plan.appserviceplanprod.id}"
  # Do not attach Storage by default
  app_settings {
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = false
    /*
    # Settings for private Container Registires  
    DOCKER_REGISTRY_SERVER_URL      = ""
    DOCKER_REGISTRY_SERVER_USERNAME = ""
    DOCKER_REGISTRY_SERVER_PASSWORD = ""
    */
  }

  # Configure Docker Image to load on start
  site_config {
    always_on        = "true"
  }
  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_virtual_network" "test" {
  name                = "acceptanceTestVirtualNetwork1"
  address_space       = ["10.0.0.0/16"]
  location            = "${azurerm_resource_group.Productivo.location}"
  resource_group_name = "${azurerm_resource_group.Productivo.name}"
}

resource "azurerm_subnet" "test" {
  name                 = "testsubnet"
  resource_group_name  = "${azurerm_resource_group.Productivo.name}"
  virtual_network_name = "${azurerm_virtual_network.Productivo.name}"
  address_prefix       = "10.0.2.0/24"
}

resource "azurerm_network_interface" "example" {
  name                = "acceptanceTestNetworkInterface1"
  location            = "${azurerm_resource_group.Productivo.location}"
  resource_group_name = "${azurerm_resource_group.Productivo.name}"

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = "${azurerm_subnet.test.id}"
    private_ip_address_allocation = "Dynamic"
  }

  tags = {
    environment = "Productivo"
  }
}
resource "azurerm_virtual_machine" "example" {
  name                  = "${local.virtual_machine_name}"
  location              = "${azurerm_resource_group.Productivo.location}"
  resource_group_name   = "${azurerm_resource_group.Productivo.name}"
  network_interface_ids = ["${azurerm_network_interface.example.id}"]
  vm_size               = "Standard_F2"

  # This means the OS Disk will be deleted when Terraform destroys the Virtual Machine
  # NOTE: This may not be optimal in all cases.
  delete_os_disk_on_termination = true

  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }

  storage_os_disk {
    name              = "sqlsvr-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "WinServer2016"
    admin_username = "Administrador"
    admin_password = "Administrador.,12345"
  }
}

