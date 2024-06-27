# ----------------------------------------------------------------
# Auth0 Provider
# ----------------------------------------------------------------

variable "domain" {
  description = "Auth0 domain"
}

variable "client_id" {
  description = "Auth0 Managemtn API App Client ID"
}

variable "client_secret" {
  description = "Auth0 Managemtn API App Client Secret"
  sensitive   = true
}

# ----------------------------------------------------------------
# Users
# ----------------------------------------------------------------

variable "demo_users" {
  type = list(
    object({
      email        = string
      given_name   = string
      family_name  = string
      user_metadata = object({
        require_mfa = bool
      })
      app_metadata = map(string)
    })
  )
}

variable "demo_user_password" {
  type        = string
  description = "Auth0 demo user's common password"
  sensitive   = true
}

variable "database_connection" {
  type        = string
  default     = "Username-Password-Authentication"
  description = "Database connection name"
}

# ----------------------------------------------------------------
# Connections
# ----------------------------------------------------------------

variable "line_client_id" {
  type        = string
  description = "Social Connection LINE Client ID"
}

variable "line_client_secret" {
  type        = string
  description = "Social Connection LINE Client Secret"
  sensitive   = true
}

variable "yahoo_japan_client_id" {
  type        = string
  description = "Social Connection Yahoo Japan Client ID"
}

variable "yahoo_japan_client_secret" {
  type        = string
  description = "Social Connection Yahoo Japan Client Secret"
  sensitive   = true
}

variable "yahoo_japan_icon_url" {
  type        = string
  description = "Social Connection Yahoo Japan Icon URL"
}
