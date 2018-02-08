variable "heroku_api_key" {
  type = "string"
  description = "Key for interacting with the Heroku API"
}

variable "app_name" {
  type = "string"
  description = "Name of the Heroku app. letters, numbers, and '-' only. Max 20 chars"
}

variable "region" {
  type = "string"
  default = "us"
  description = "Heroku region to deploy the app to"
}

variable "stack" {
  type = "string"
  default = "heroku-16"
  description = "Heroku stack to launch the app in"
}

variable "org_name" {
  type = "string"
  description = "Heroku organization that owns the app"
}

variable "locked" {
  type = "string"
  default = "false"
  description = "Lock app access in Heroku (true, false)"
}

variable "personal" {
  type = "string"
  description = "is this a personal app?"
}
