variable "okta_users" {
  type = list(
    object(
      {
        email      = string
        first_name = string
        last_name  = string
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

variable "app_count" {
  type        = number
  description = "number of app count"
  default     = 1
}

