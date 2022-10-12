terraform {
  required_providers {
    grafana = {
      source = "grafana/grafana"
      version = "1.29.0"
    }
  }
}

provider "grafana" {
  url  = "http://localhost:3000/"
  auth = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
}

resource "grafana_folder" "test" {
  title = "Test Folder"
}

