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
    Proyecto = "NOTAS SQM"
    "Key USGR" = "Beatriz Garcia"
    "Responsable TI"= "Javier Olave Ruiz / William Donoso"
    "Created By" = "${var.created}"
  }
}
# App Service Plan
resource "azurerm_app_service_plan" "appserviceplandev" {
  name                = "${var.Componente["ServicePlan"]}${var.Region}${var.Tipo["Aplicacion"]}${var.Codigo}${var.Ambiente["Desarrollo"]}"
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
  name                = "${var.Componente["App"]}${var.Region}${var.Tipo["Aplicacion"]}${var.Codigo}${var.Ambiente["Desarrollo"]}"
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


# QA
resource "azurerm_resource_group" "calidad" {
  name     = "${var.Componente["Grupo"]}${var.location}${var.Tipo["Aplicacion"]}${var.Codigo}${var.Ambiente["Calidad"]}"
  location = "${var.location}"
  tags {
    Ambiente = "${var.AmbienteTags["QA"]}"
    CECO = "04006012"
    Proyecto = "NOTAS SQM"
    "Key USGR" = "Beatriz Garcia"
    "Responsable TI"= "Javier Olave Ruiz / William Donoso"
    "Created By" = "${var.created}"
  }
}
# App Service Plan
resource "azurerm_app_service_plan" "appserviceplanqa" {
  name                = "${var.Componente["ServicePlan"]}${var.Region}${var.Tipo["Aplicacion"]}${var.Codigo}${var.Ambiente["Calidad"]}"
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
  name                = "${var.Componente["App"]}${var.Region}${var.Tipo["Aplicacion"]}${var.Codigo}${var.Ambiente["Calidad"]}"
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


