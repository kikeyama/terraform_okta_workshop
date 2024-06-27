terraform {
  required_providers {
    auth0 = {
      source  = "auth0/auth0"
      version = "~>1.3.0"
    }
  }
}

# ----------------------------------------------------------------
# Auth0 Provider
# ----------------------------------------------------------------

provider "auth0" {
  domain        = var.domain
  client_id     = var.client_id
  client_secret = var.client_secret
  debug         = false
}

# ----------------------------------------------------------------
# Call modules
# ----------------------------------------------------------------

module "common" {
  source = "../../modules/common"

  demo_users                = var.demo_users
  demo_user_password        = var.demo_user_password
  database_connection       = var.database_connection
  line_client_id            = var.line_client_id
  line_client_secret        = var.line_client_secret
  yahoo_japan_client_id     = var.yahoo_japan_client_id
  yahoo_japan_client_secret = var.yahoo_japan_client_secret
  yahoo_japan_icon_url      = var.yahoo_japan_icon_url
}
