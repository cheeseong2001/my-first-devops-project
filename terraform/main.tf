terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "ap-southeast-1"
}

resource "aws_instance" "app_server" {
  ami           = "ami-0afc7fe9be84307e4"
  instance_type = "t2.micro"

  tags = {
    Name = "Portfolio Server"
  }
}
