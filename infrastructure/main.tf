provider "azurerm" {}

locals {
    default_tags = {
        author = "Thorsten Hans"
        conference = "BASTA! 2019"
    }
  all_tags = "${merge(local.default_tags, var.tags)}"
}

resource "azurerm_resource_group" "rg" {
  name = "thh-basta-2019-live-${var.environment_name}"
  location = "westeurope"
  tags = "${local.all_tags}"

}

resource "azurerm_app_service_plan" "asp" {
  name="asp-basta-2019-live-${var.environment_name}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  location = "${azurerm_resource_group.rg.location}"
  kind = "Linux"
  reserved = true
  sku {
      tier = "Standard"
      size = "S1"
  }
  tags = "${local.all_tags}"
}

resource "azurerm_application_insights" "ai" {
    name ="ai-basta-2019-live-${var.environment_name}"
    resource_group_name = "${azurerm_resource_group.rg.name}"
    location = "${azurerm_resource_group.rg.location}"
    application_type = "web"
    tags = "${local.all_tags}"
}


resource "azurerm_app_service" "as" {
    name ="as-basta-2019-live-${var.environment_name}"
    resource_group_name = "${azurerm_resource_group.rg.name}"
    location = "${azurerm_resource_group.rg.location}"
    app_service_plan_id = "${azurerm_app_service_plan.asp.id}"
    identity {
        type = "SystemAssigned"
    }
    app_settings = {
        APPINSIGHTS_INSTRUMENTATIONKEY= "${azurerm_application_insights.ai.instrumentation_key}"
    }
    site_config {
        always_on = true
        linux_fx_version = "DOCKER|nginx:latest"
    }
    tags = "${local.all_tags}"
}

