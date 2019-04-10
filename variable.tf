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
    Cosmos      = "cosmos"
    SQLSVR      = "sqlsvr"
    SQLDB       = "sqldb"
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
        Produccion    = "prod"
        Certificacion = "cert"
        Desarrollo    = "dev"
        Integracion   = "int"
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

variable "Proyecto" {
  default="NOTAS SQM"
}

variable "Responsable" {
  default="Javier Olave Ruiz / William Donoso"
}

variable "Version" {
  type    = "string"
  default = "1.7.0"
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