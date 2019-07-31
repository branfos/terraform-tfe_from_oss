provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "web" {
  count         = 1
  ami           = "ami-2e1ef954"
  instance_type = "t2.micro"

  tags = {
    label = "test"
  }
}
