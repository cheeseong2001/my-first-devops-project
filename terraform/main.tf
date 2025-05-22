terraform {
  cloud {
    organization = "cheeseong-tf"

    workspaces {
      name = "portfolio"
    }
  }

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

resource "aws_default_vpc" "default" {
}

resource "aws_default_subnet" "default_az1" {
  availability_zone = "ap-southeast-1a"
}

resource "aws_key_pair" "deployer" {
  key_name = "deployer"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDeRKZ5XOzy3l63+pijc6kYurHzqXJuOIyIurQxnjprz5XZ/QU7vGWSJalU96LEpimOWGkDtxICkaKNLGeOzvPr9N/DdBHoYE9bGpCpWOGKPfLe4JHPslUem+viyL/9u9C3cDVjhKUjHEkssOIQDupRG5RLmTjVX2XD0Jr4LF81aZPS/0KnYvi5vlYShumeWGR2QfCoQbthriciAKry4AhmZX8zI7XQF2EkCzU4WI8FUYunrnHf4STrJ0u2LcY9rpBi2L9P91b6m0D54EspJ/ANE1XINA7YCjYl92obJyDUN3goGj6hTKoIZD84U3D2G4PRen090ESAOqq+b2ybLCAEklVa7MDvaUC3E2KuBeoTkxZWx7hYThep4dMOeFsk4+DbkdqqVfYnPhUjwggRFP7HFqH1g6AfMMLxTuOU7Wez/oKG1vjSDOEQl8+fgXL0gwrMgf++JhXyQsbTLsw+McjZSLDdYXJX7LmB32tJbPgRfKnoOazVZnKMaAUzBaYbndc= cheese@MacBook-Air.local"
}

resource "aws_instance" "portfolio_server" {
  ami           = "ami-0afc7fe9be84307e4"
  instance_type = "t2.micro"
  subnet_id = aws_default_subnet.default_az1.id
  key_name = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  tags = {
    Name = "Portfolio Server"
  }
}

resource "aws_security_group" "web_sg" {
  name = "allow-web-traffic"
  description = "Allow SSH and HTTPS"
  vpc_id = aws_default_vpc.default.id
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.web_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 22
  ip_protocol = "tcp"
  to_port     = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.web_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  ip_protocol = "tcp"
  to_port     = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_https" {
  security_group_id = aws_security_group.web_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 443
  ip_protocol = "tcp"
  to_port     = 443
}

resource "aws_vpc_security_group_egress_rule" "allow_ssh" {
  security_group_id = aws_security_group.web_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 22
  ip_protocol = "tcp"
  to_port     = 22
}

resource "aws_vpc_security_group_egress_rule" "allow_http" {
  security_group_id = aws_security_group.web_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  ip_protocol = "tcp"
  to_port     = 80
}

resource "aws_vpc_security_group_egress_rule" "allow_https" {
  security_group_id = aws_security_group.web_sg.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 443
  ip_protocol = "tcp"
  to_port     = 443
}

resource "aws_eip" "instance_ip" {
  domain = "vpc"
}

resource "aws_eip_association" "eip_assoc" {
  instance_id = aws_instance.portfolio_server.id
  allocation_id = aws_eip.instance_ip.id
}