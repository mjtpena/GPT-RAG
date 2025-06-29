# Compute Module - App Service Plan, Application Insights, Function Apps, and App Service

# Log Analytics Workspace for Application Insights
resource "azurerm_log_analytics_workspace" "main" {
  count               = var.provision_application_insights ? 1 : 0
  name                = "${var.app_insights_name}-workspace"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = 30
  tags                = var.tags
}

# Application Insights
resource "azurerm_application_insights" "main" {
  count               = var.provision_application_insights ? 1 : 0
  name                = var.app_insights_name
  location            = var.location
  resource_group_name = var.resource_group_name
  workspace_id        = azurerm_log_analytics_workspace.main[0].id
  application_type    = "web"
  tags                = var.tags
}

# App Service Plan
resource "azurerm_service_plan" "main" {
  name                = var.app_service_plan_name
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = "Linux"
  sku_name            = "P0v3"
  tags                = var.tags
}

# Orchestrator Function App
resource "azurerm_linux_function_app" "orchestrator" {
  name                = var.orchestrator_function_name
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.main.id
  
  storage_account_name       = var.orchestrator_storage_account_name
  storage_account_access_key = var.orchestrator_storage_account_key
  
  # Network configuration
  virtual_network_subnet_id = var.network_isolation ? var.app_integration_subnet_id : null
  
  identity {
    type = "SystemAssigned"
  }

  site_config {
    application_insights_key               = var.provision_application_insights ? azurerm_application_insights.main[0].instrumentation_key : null
    application_insights_connection_string = var.provision_application_insights ? azurerm_application_insights.main[0].connection_string : null
    
    application_stack {
      python_version = var.func_app_runtime_version
    }
    
    cors {
      allowed_origins = ["*"]
    }
    
    minimum_elastic_instance_count = 1
    elastic_instance_minimum       = 1
    pre_warmed_instance_count     = 2
  }

  app_settings = merge(var.orchestrator_app_settings, {
    "WEBSITE_RUN_FROM_PACKAGE"              = "1"
    "ENABLE_ORYX_BUILD"                     = "true"
    "SCM_DO_BUILD_DURING_DEPLOYMENT"       = "true"
    "FUNCTIONS_WORKER_RUNTIME"              = "python"
    "PYTHON_ENABLE_INIT_INDEXING"           = "1"
    "PYTHON_ISOLATE_WORKER_DEPENDENCIES"    = "1"
    "LOGLEVEL"                              = "INFO"
  })

  tags = merge(var.tags, { "azd-service-name" = "orchestrator" })
}

# Data Ingestion Function App
resource "azurerm_linux_function_app" "data_ingestion" {
  name                = var.data_ingestion_function_name
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.main.id
  
  storage_account_name       = var.data_ingestion_storage_account_name
  storage_account_access_key = var.data_ingestion_storage_account_key
  
  # Network configuration
  virtual_network_subnet_id = var.network_isolation ? var.app_integration_subnet_id : null
  
  identity {
    type = "SystemAssigned"
  }

  site_config {
    application_insights_key               = var.provision_application_insights ? azurerm_application_insights.main[0].instrumentation_key : null
    application_insights_connection_string = var.provision_application_insights ? azurerm_application_insights.main[0].connection_string : null
    
    application_stack {
      python_version = var.func_app_runtime_version
    }
    
    cors {
      allowed_origins = ["*"]
    }
    
    minimum_elastic_instance_count = 1
    elastic_instance_minimum       = 1
    pre_warmed_instance_count     = 2
  }

  app_settings = merge(var.data_ingestion_app_settings, {
    "WEBSITE_RUN_FROM_PACKAGE"              = "1"
    "ENABLE_ORYX_BUILD"                     = "true"
    "SCM_DO_BUILD_DURING_DEPLOYMENT"       = "true"
    "FUNCTIONS_WORKER_RUNTIME"              = "python"
    "AzureWebJobsFeatureFlags"              = "EnableWorkerIndexing"
    "LOGLEVEL"                              = "INFO"
  })

  tags = merge(var.tags, { "azd-service-name" = "dataIngest" })
}

# Frontend App Service
resource "azurerm_linux_web_app" "frontend" {
  name                = var.app_service_name
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.main.id
  
  # Network configuration
  virtual_network_subnet_id = var.network_isolation ? var.app_integration_subnet_id : null
  
  identity {
    type = "SystemAssigned"
  }

  site_config {
    application_insights_key               = var.provision_application_insights ? azurerm_application_insights.main[0].instrumentation_key : null
    application_insights_connection_string = var.provision_application_insights ? azurerm_application_insights.main[0].connection_string : null
    
    application_stack {
      python_version = var.app_service_runtime_version
    }
    
    app_command_line = "python ./app.py"
    
    cors {
      allowed_origins = ["*"]
    }
  }

  app_settings = var.frontend_app_settings

  tags = merge(var.tags, { "azd-service-name" = "frontend" })
}
