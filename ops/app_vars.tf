variable "allowed_hosts" {
  type        = "list"
  default     = ["localhost"]
  description = "list of hosts allowed to serve the site"
}

variable "content_type_no_sniff" {
  type        = "string"
  default     = "true"
  description = "Set X-Content-Type-Options: nosniff header if set to true"
}

variable "domain_name" {
  type        = "string"
  default     = "localhost"
  description = "The domain that the site will be served from"
}

variable "django_secret_key" {
  type        = "string"
  description = "Key for use with cryptographic signing"
}

variable "cors_whitelist" {
  type        = "list"
  default     = ["localhost"]
  description = "A list of hostnames allowed to make cross origin requests"
}

variable "django_log_level" {
  type        = "string"
  description = "Verbosity of server logging"
}

variable "domain_redirect_middlware_enabled" {
  type        = "string"
  default     = "false"
  description = "Set to true to redirect requests from one hostname to another"
}

variable "target_domain" {
  type        = "string"
  description = "The target domain to redirect to when domain_redirect_middlware_enabled is true"
}

variable "ssl_redirect" {
  type        = "string"
  default     = "false"
  description = "Redirect http to https when True"
}

variable "debug" {
  type        = "string"
  default     = "false"
  description = "Enable Debug mode in Django"
}

variable "social_auth_google_oauth2_key" {
  type        = "string"
  default     = ""
  description = "OAuth2 key for social sign in"
}

variable "social_auth_google_oauth2_secret" {
  type        = "string"
  default     = ""
  description = "OAuth2 secret key for social sign in"
}

variable "social_auth_login_redirect_url" {
  type        = "string"
  default     = ""
  description = "The redirect URL configured for the OAuth application in Google"
}

variable "filebrowser_directory" {
  type        = "string"
  default     = ""
  description = "Directory for filebrowser storage. leave blank if using S3"
}

variable "use_s3" {
  type        = "string"
  default     = "false"
  description = "Store uploaded media on S3"
}

variable "aws_access_key_id" {
  type        = "string"
  default     = ""
  description = "AWS Key with read/write permissions for the S3 uploads bucket"
}

variable "aws_secret_access_key" {
  type        = "string"
  default     = ""
  description = "AWS Secret Key with read/write permissions for the S3 uploads bucket"
}

variable "aws_location" {
  type        = "string"
  default     = ""
  description = "S3 Bucket prefix for media uploads"
}

variable "aws_s3_custom_domain" {
  type        = "string"
  default     = ""
  description = "Custom domain for S3 bucket"
}

variable "aws_storage_bucket_name" {
  type        = "string"
  default     = ""
  description = "S3 Bucket name for media uploads"
}

variable "petition_sqs_queue_url" {
  type        = "string"
  default     = ""
  description = "URL of the SQS queue that processes petition signatures"
}

variable "aws_sqs_access_key_id" {
  type        = "string"
  default     = ""
  description = "AWS key with write permissions on the petition queue"
}

variable "aws_sqs_secret_access_key" {
  type        = "string"
  default     = ""
  description = "AWS secret access key with write permissions on the petition queue"
}

variable "aws_sqs_region" {
  type        = "string"
  default     = ""
  description = "AWS region that the SQS queue is in"
}

variable "use_x_forwarded_host" {
  type        = "string"
  default     = "false"
  description = "Set to True if site is behind a reverse proxy"
}

variable "x_frame_options" {
  type        = "string"
  default     = "DENY"
  description = "Value to use for the X-Frame-Options header"
}

variable "xss_protection" {
  type        = "string"
  default     = "true"
  description = "Set to true to enable X-XSS-Protection header"
}

variable "set_hsts" {
  type        = "string"
  default     = "false"
  description = "Set to true to enable the Strict-Transport-Security header"
}

variable "csp_child_src" {
  type        = "string"
  description = "Value for the child-src CSP directive"
}

variable "csp_connect_src" {
  type        = "string"
  description = "Value for the connect-src CSP directive"
}

variable "csp_default_src" {
  type        = "string"
  description = "Value for the default-src CSP directive"
}

variable "csp_font_src" {
  type        = "string"
  description = "Value for the font-src CSP directive"
}

variable "csp_frame_src" {
  type        = "string"
  description = "Value for the frame-src CSP directive"
}

variable "csp_img_src" {
  type        = "string"
  description = "Value for the img-src CSP directive"
}

variable "csp_media_src" {
  type        = "string"
  description = "Value for the media-src CSP directive"
}

variable "csp_script_src" {
  type        = "string"
  description = "Value for the script-src CSP directive"
}

variable "csp_style_src" {
  type        = "string"
  description = "Value for the style-src CSP directive"
}

variable "pulse_api_domain" {
  type        = "string"
  description = "Hostname that the Network Pulse API can be reached at"
}

variable "pulse_domain" {
  type        = "string"
  description = "Hostname that the Network Pulse Front End can be found at"
}
