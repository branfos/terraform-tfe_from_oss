# Using a single workspace:
terraform {
  cloud {
    organization = "brandonfoster"

    workspaces {
      name = "my-app-prod"
    }
  }
}
