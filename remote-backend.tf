# Using a single workspace:
terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "brandonfoster"

    workspaces {
      name = "my-app-prod"
    }
  }
}