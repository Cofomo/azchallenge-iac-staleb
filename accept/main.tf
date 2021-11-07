// Configure the Microsoft Azure Provider
provider "azurerm" {
    skip_provider_registration = true
    features  {}
}

// Web App
resource "azurerm_app_service_plan" "service_plan" {
    name                = "calicot-service-plan-accept"
    location            = var.location
    resource_group_name = var.resource-group-name
    kind                = "Windows"
    reserved            = false
    sku {
        tier = "Shared"
        size = "D1"
    }
    tags = {
        environment = var.environment
    }
}

resource "azurerm_app_service" "app_service" {
    name                = "calicot-app-service-accept"
    location            = var.location
    resource_group_name = var.resource-group-name
    app_service_plan_id = azurerm_app_service_plan.service_plan.id

    tags = {
        environment = var.environment
    }
}

// Storage Account
resource "azurerm_storage_account" "storage_account" {
    name                     = "calicotstorageaccountaccept"
    resource_group_name      = var.resource-group-name
    location                 = var.location
    account_tier             = "Standard"
    account_replication_type = "LRS"
    access_tier              = "Hot"

    tags = {
        environment = var.environment
    }
}

// Azure Functions
resource "azurerm_app_service_plan" "azure_functions_app_service" {
    name                = "calicot-azure-functions-app-service-accept"
    location            = var.location
    resource_group_name = var.resource-group-name
    kind                = "FunctionApp"

    sku {
        tier = "Dynamic"
        size = "Y1"
    }

    tags = {
        environment = var.environment
    }
}

resource "azurerm_function_app" "function_app" {
    name                       = "calicot-function-app-accept"
    location                   = var.location
    resource_group_name        = var.resource-group-name
    app_service_plan_id        = azurerm_app_service_plan.azure_functions_app_service.id
    storage_account_name       = azurerm_storage_account.storage_account.name
    storage_account_access_key = azurerm_storage_account.storage_account.primary_access_key

    tags = {
        environment = var.environment
    }
}

// Service Bus
resource "azurerm_servicebus_namespace" "servicebus_namespace" {
    name                = "calicot-servicebus-namespace-accept"
    location            = var.location
    resource_group_name = var.resource-group-name
    sku                 = "Basic"

    tags = {
        environment = var.environment
    }
}

resource "azurerm_servicebus_queue" "servicebus_queue" {
    name                = "calicot-servicebus-accept"
    resource_group_name = var.resource-group-name
    namespace_name      = azurerm_servicebus_namespace.servicebus_namespace.name
}

// SQL Database
resource "azurerm_sql_server" "sql_server" {
    name                         = "calicot-sql-server-accept"
    resource_group_name          = var.resource-group-name
    location                     = var.location
    version                      = "12.0"
    administrator_login          = "4dm1n157r470r"
    administrator_login_password = "4-v3ry-53cr37-p455w0rd"

    tags = {
        environment = var.environment
    }
}

resource "azurerm_sql_database" "sql_database" {
    name                             = "calicot-sql-database-accept"
    resource_group_name              = var.resource-group-name
    location                         = var.location
    server_name                      = azurerm_sql_server.sql_server.name
    edition                          = "Basic"

    tags = {
        environment = var.environment
    }
}

