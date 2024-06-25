variable "region" {
  description = "region to deploy instances"
}

variable "access_key" {
  description = "user's access key"
}

variable "secret_key" {
  description = "user's secret key"
}

variable "prefix" {
  description = "prefix for each resource"
}

variable "email" {
  description = "resource owner's email address"
}

variable "home_cidr" {
  description = "home CIDR block e.g. 123.45.6.78/32"
}

variable "office_cidr" {
  description = "office CIDR block e.g. 123.45.6.78/32"
}

variable "vpn_cidr" {
  description = "VPN CIDR blocks e.g. 123.45.6.78/32"
}
