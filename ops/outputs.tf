output "heroku_git_url" {
  value       = "git@heroku.com/${heroku_app.django_server.id}.git"
  description = "The Git endpoint of this heroku app"
  depends_on  = ["heroku_app.django_server"]
}
