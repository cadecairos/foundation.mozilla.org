provider "heroku" {
  email = "devops@mozillafoundation.org"
  api_key = "${var.heroku_api_key}"
}

module "foundation/dev" {
  source = "./app"

  app_name = "foundation-mofodev-net-cade"
  region = "us"
  stack = "heroku-16"
  org_name = "mozilla"
  locked = "false"
}

module "foundation/staging" {
  source = "./app"

  app_name = "foundation-mofostaging-net-cade"
  region = "us"
  stack = "heroku-16"
  org_name = "mozilla"
  locked = "false"
}

module "foundation/prod" {
  source = "./app"

  app_name = "foundation-mozilla-org-cade"
  region = "us"
  stack = "heroku-16"
  org_name = "mozilla"
  locked = "true"
}
