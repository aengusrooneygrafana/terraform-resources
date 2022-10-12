terraform {
  required_providers {
    grafana = {
      source = "grafana/grafana"
      version = "1.28.0"
    }
  }
}

provider "grafana" {
  alias = "cloud"
  cloud_api_key = var.grafana_cloud_api_key
}

resource "grafana_cloud_stack" "stack" {
  provider = grafana.cloud

  name        = "mltdemo"
  slug        = "mltdemo"
  region_slug = "us"
}

resource "grafana_api_key" "management" {
  provider = grafana.cloud

  cloud_stack_slug = grafana_cloud_stack.stack.slug
  name             = "management-key"
  role             = "Admin"
}

provider "grafana" {
  alias = "stack"

  url  = grafana_cloud_stack.stack.url
  auth = grafana_api_key.management.key
}

resource "grafana_dashboard" "service-overview" {
  provider = grafana.stack
  config_json = file("../grafana/dashboards/service_overview.json")
}

