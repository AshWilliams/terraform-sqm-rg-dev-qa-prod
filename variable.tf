variable "location" {
 default = "eastus"
}

variable "created" {
    default = "Maikel Majul"
}
variable "Componente" {
  type        = "map"
  default     = {
    Grupo       = "rg"
    Storage     = "sa"
    App         = "ap"
    Kubernetes  = "aks"
    APIMan      = "api"
    ServicePlan = "sp"
  }  
}
variable "Tipo" {
  type            = "map"
  default         = {
      Aplicacion      = "app"
      Infraestructura = "infra"
  }
}
variable "Ambiente" {
  type          = "map"
  default       = {
        Produccion    = "p"
        Certificacion = "c"
        Desarrollo    = "d"
        Integracion   = "i"
        Calidad       = "qa"
  }
}

variable "AmbienteTags" {
  type          = "map"
  default       = {
        Produccion    = "Produccion"
        Certificacion = "c"
        QA            = "Calidad"
        Desarrollo    = "Desarrollo"
        Integracion   = "i"
  }
}
variable "Region" {
  type    = "string"
  default = "eu"
}

variable "Codigo" {
  type    = "string"
  default = "sqmtestapp"
}

variable "Version" {
  type    = "string"
  default = "01"
}
variable "client_id" {
 description = "client_id from your Azure login settings, this can be set using an environment variable by prefixing the env var with TF_VAR_client_id"
}
variable "client_secret" {
 description = "client_secret from your Azure login settings, this can be set using an environment variable by prefixing the env var with TF_VAR_client_secret"
}
variable "subscription_id" {
 description = "subscription_id from your Azure login settings, this can be set using an environment variable by prefixing the env var with TF_VAR_subscription_id"
}
variable "tenant_id" {
 description = "tenant_id from your Azure login settings, this can be set using an environment variable by prefixing the env var with TF_VAR_tenant_id"
}

variable "ssh_key_public" {}
variable "ssh_key_private" {}