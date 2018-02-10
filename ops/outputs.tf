output "heroku_app_name" {
  value       = "${heroku_app.django_server.id}"
  description = "The Git endpoint of this heroku app"
  depends_on  = ["heroku_app.django_server"]
}
