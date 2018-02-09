output "heroku_git_url" {
  value       = "${heroku_app.django_server.git_url}"
  description = "The Git endpoint of this heroku app"
  depends_on  = ["heroku_app.django_server"]
}
