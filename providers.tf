terraform {
  required_providers {
    tls = {
      source  = "hashicorp/tls"
      version = "3.1.0"
    }
    confluent = {
      source  = "confluentinc/confluent"
      version = "0.10.0"
    }
    google = {
      version = "~> 3.14"
    }
  }
  required_version = ">= 1.2.2"
}

provider "tls" {
}

provider "google" {
  credentials = file("${var.credentials}")
  project     = var.project_name
  region      = var.project_region
  zone        = var.project_zone
}

provider "confluent" {
  api_key    = var.confluent_cloud_api_key    # optionally use CONFLUENT_CLOUD_API_KEY env var
  api_secret = var.confluent_cloud_api_secret # optionally use CONFLUENT_CLOUD_API_SECRET env var
}