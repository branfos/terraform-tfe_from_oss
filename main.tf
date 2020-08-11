terraform {
  required_version = ">= 0.12"
}

provider "aws" {
  version = "~> 2.7"
  region  = "us-east-1"
}

resource "aws_instance" "web" {
  count         = var.size
  ami           = var.ami-id
  instance_type = "t2.micro"

  tags = {
    Name  = "Demo"
    ttl   = "10d"
    owner = "ranjit@hashicorp.com"
  }
}
