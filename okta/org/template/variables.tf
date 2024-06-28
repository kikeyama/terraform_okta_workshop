variable "okta_org_name" {
  description = "Okta org name"
}

variable "okta_base_url" {
  description = "Okta base url (okta.com|oktapreview.com)"
}

variable "okta_api_client_id" {
  description = "Okta API service client id"
}

variable "okta_api_private_key_path" {
  description = "Okta private key path"
}

variable "okta_api_private_key_id" {
  description = "Okta private key id"
  sensitive   = true
}

variable "app_count" {
  type        = number
  description = "number of app count"
  default     = 1
}

variable "okta_users" {
  type = list(
    object(
      {
        email       = string
        first_name  = string
        last_name   = string
        department = string
        user_type  = string
      }
    )
  )
}

variable "demo_user_password" {
  type        = string
  description = "Okta demo user's common password"
  sensitive   = true
}
