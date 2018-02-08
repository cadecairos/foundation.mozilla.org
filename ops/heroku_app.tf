resource "heroku_app" "django_server" {
  name   = "${var.app_name}"
  region = "${var.region}"
  stack  = "${var.stack}"

  config_vars {
    # Django Configuration settings
    ALLOWED_HOSTS                     = "${join(',', var.allowed_hosts)}"
    CONTENT_TYPE_NO_SNIFF             = "${var.content_type_no_sniff}"
    CORS_WHITELIST                    = "${join(',', var.domain_name)}"
    DJANGO_SECRET_KEY                 = "${var.django_secret_key}"
    DJANGO_LOG_LEVEL                  = "${var.django_log_level}"
    DOMAIN_REDIRECT_MIDDLWARE_ENABLED = "${var.domain_redirect_middlware_enabled}"
    TARGET_DOMAIN                     = "${var.target_domain}"
    SSL_REDIRECT                      = "${var.ssl_redirect}"
    DEBUG                             = "${var.debug}"

    # Social Sign-in
    SOCIAL_AUTH_GOOGLE_OAUTH2_KEY     = "${var.social_auth_google_oauth2_key}"
    SOCIAL_AUTH_GOOGLE_OAUTH2_SECRET  = "${var.social_auth_google_oauth2_secret}"
    SOCIAL_AUTH_LOGIN_REDIRECT_URL    = "${var.social_auth_login_redirect_url}"

    # Asset uploads
    FILEBROWSER_DIRECTORY    = "${var.FILEBROWSER_DIRECTORY}"
    USE_S3                   = "${var.USE_S3}"
    AWS_ACCESS_KEY_ID        = "${var.AWS_ACCESS_KEY}"
    AWS_SECRET_ACCESS_KEY    = "${var.AWS_SECRET_ACCESS_KEY}"
    AWS_LOCATION             = "${var.AWS_LOCATION}"
    AWS_S3_CUSTOM_DOMAIN     = "${var.AWS_S3_CUSTOM_DOMAIN}"
    AWS_STORAGE_BUCKET_NAME  = "${var.AWS_STORAGE_BUCKET_NAME}"

    # Petition message queue
    PETITION_SQS_QUEUE_URL    = "${var.petition_sqs_queue_url}"
    AWS_SQS_ACCESS_KEY_ID     = "${var.aws_sqs_access_key_id}"
    AWS_SQS_SECRET_ACCESS_KEY = "${var.aws_sqs_secret_access_key}"
    AWS_SQS_REGION            = "${var.aws_sqs_region}"

    # Security Settings
    USE_X_FORWARDED_HOST = "${var.use_x_forwarded_host}"
    X_FRAME_OPTIONS      = "${var.x_frame_options}"
    XSS_PROTECTION       = "${var.xss_protection}"
    SET_HSTS             = "${var.set_hsts}"
    CSP_CHILD_SRC        = "${var.csp_child_src}"
    CSP_CONNECT_SRC      = "${var.csp_connect_src}"
    CSP_DEFAULT_SRC      = "${var.csp_default_src}"
    CSP_FONT_SRC         = "${var.csp_font_src}"
    CSP_FRAME_SRC        = "${var.csp_frame_src}"
    CSP_IMG_SRC          = "${var.csp_img_src}"
    CSP_MEDIA_SRC        = "${var.csp_media_src}"
    CSP_SCRIPT_SRC       = "${var.csp_script_src}"
    CSP_STYLE_SRC        = "${var.csp_style_src}"

    # Pulse API
    PULSE_API_DOMAIN = "${var.pulse_api_domain}"
    PULSE_DOMAIN     = "${var.pulse_domain}"
  }

  buildpacks = [
    "heroku/nodejs",
    "heroku_python"
  ]

  organization {
    name = "${var.org_name}"
    locked = "${var.locked}"
    personal = "${var.personal}"
  }
}

resource "heroku_addon" "django_server" {
  app  = "${var.app_name}"
  plan = "heroku-postgresql:hobby-basic"
}

resource "heroku_domain" "django_server" {
  app      = "${var.app_name}"
  hostname = "foundation.mofodev.net"
}
