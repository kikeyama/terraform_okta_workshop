variable "region" {
  type        = string
  description = "region to deploy instances"
}

variable "access_key" {
  type        = string
  description = "user's access key"
}

variable "secret_key" {
  type        = string
  description = "user's secret key"
}

variable "prefix" {
  type        = string
  description = "prefix for each resource"
}

variable "email" {
  type        = string
  description = "resource owner's email address"
}

variable "key_name" {
  type        = string
  description = "keypair name"
}

variable "key_file_path" {
  type        = string
  description = "path of key files"
  default     = "."
}

variable "home_cidr" {
  type        = string
  description = "home CIDR block e.g. 123.45.6.78/32"
}
