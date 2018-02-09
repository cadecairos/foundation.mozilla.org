variable "heroku_api_key" {
  type        = "string"
  description = "Key for interacting with the Heroku API"
}

variable "app_name" {
  type        = "string"
  description = "Name of the Heroku app. letters, numbers, and '-' only. Max 20 chars"
}

variable "region" {
  type        = "string"
  default     = "us"
  description = "Heroku region to deploy the app to"
}

variable "stack" {
  type        = "string"
  default     = "heroku-16"
  description = "Heroku stack to launch the app in"
}

variable "org_name" {
  type        = "string"
  description = "Heroku organization that owns the app"
}

variable "locked" {
  type        = "string"
  default     = "false"
  description = "Lock app access in Heroku (true, false)"
}

variable "personal" {
  type        = "string"
  description = "is this a personal app?"
}

variable "state_s3_bucket" {
  type        = "string"
  description = "Bucket to store terraform state in"
}

variable "state_s3_key" {
  type        = "string"
  description = "key name for the state object"
}

variable "state_s3_region" {
  type        = "string"
  description = "region the S3 bucket is in"
}

variable "state_encrypt" {
  type        = "string"
  description = "Boolean indicating whether or not to use server side encryption"
}

variable "state_kms_key_id" {
  type        = "string"
  description = "The id of the KMS key used for encryption"
}

variable "state_access_key" {
  type        = "string"
  description = "AWS access key"
}

variable "state_secret_key" {
  type        = "string"
  description = "AWS secret access key"
}
