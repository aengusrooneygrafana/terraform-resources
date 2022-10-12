terraform {
  required_providers {
    grafana = {
      source = "grafana/grafana"
      version = "1.29.0"
    }
  }
}

// Step 1: Create a stack
provider "grafana" {
  alias         = "cloudprovider"
  cloud_api_key = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx" 
}

resource "grafana_cloud_stack" "tfstacktest" {
  provider = grafana.cloudprovider

  name        = "tfstacktest"
  slug        = "tfstacktest"
  region_slug = "us"
}

resource "grafana_api_key" "tfmanagementkey" {
  provider = grafana.cloudprovider

  cloud_stack_slug = grafana_cloud_stack.tfstacktest.slug
  name             = "tfmanagementkey"
  role             = "Admin"
}

// Step 2: Create resources within the stack
provider "grafana" {
  alias = "tfstacktestprovider"

  url  = grafana_cloud_stack.tfstacktest.url
  auth = grafana_api_key.tfmanagementkey.key
}

resource "grafana_folder" "tffolder" {
  provider = grafana.tfstacktestprovider

  title = "tffoldertest"
}

resource "grafana_data_source" "prometheus" {
  provider = grafana.tfstacktestprovider

  type = "prometheus"
  name = "tfprometheusds"
  url  = "http://35.226.217.238:9090/"
} 

resource "grafana_dashboard" "dashboard" {
  provider = grafana.tfstacktestprovider

  config_json = file("Prometheus2.0Stats-1664967000834.json")
  folder = grafana_folder.tffolder.id
}


