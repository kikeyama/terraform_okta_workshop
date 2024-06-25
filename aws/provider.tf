terraform {
  required_providers {
    tls = {
      source  = "hashicorp/tls"
      # Fix tls provider version to make resources compatible with those of already created
      # tls certs need to be replaced after upgrading provider 3.3.0 -> 4.0.4
      version = "~> 3.3.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.55.0"
    }
  }
}

provider "aws" {
  region  = var.region
  access_key = var.access_key
  secret_key = var.secret_key
  default_tags {
    tags = {
      Owner     = "${var.email}"
      ManagedBy = "terraform"
      Purpose   = "testing no prod code or customer data"
    }
  }
}
