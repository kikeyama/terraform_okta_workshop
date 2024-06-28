terraform {
  required_providers {
    okta = {
      source  = "okta/okta"
      version = "~> 4.9.0"
    }
  }
}

provider "okta" {
  org_name       = var.okta_org_name
  base_url       = var.okta_base_url
  client_id      = var.okta_api_client_id
  private_key_id = var.okta_api_private_key_id
  private_key    = file(var.okta_api_private_key_path)
  scopes         = [
    "okta.apps.manage",
    "okta.users.manage",
    "okta.groups.manage",
    "okta.policies.manage",
  ]
}

module "demo" {
  source             = "../../modules"
  app_count          = var.app_count
  okta_users         = var.okta_users
  demo_user_password = var.demo_user_password
}
