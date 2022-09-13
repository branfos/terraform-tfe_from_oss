terraform {
  required_version = ">= 0.12"
}

provider "aws" {
    region  = "us-east-1"
}

resource "aws_instance"  {
  count         = var.size
  ami           = var.ami_id
  instance_type = "t2.micro"

  tags = {
    Name  = "Demo2"
    ttl   = "10d"
    owner = "brandon.foster@hashicorp.com"
  }
}
