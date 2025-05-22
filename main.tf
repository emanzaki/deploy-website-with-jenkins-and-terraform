terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.0.0"
}
provider "aws" {
  region = "us-east-1"
}
resource "aws_instance" "name" {
  ami = "ami-084568db4383264d4" #Ubuntu Server 24.04 LTS
  instance_type = "t2.micro"
  associate_public_ip_address = true
  key_name = "myKey" 
  vpc_security_group_ids = [aws_security_group.SG.id]
  tags = {
    Name = "Terraform-Instance"
  }
}
resource "aws_security_group" "SG" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = "vpc-0a1b2c3d4e5f6g7h8" # Replace with your VPC ID

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow SSH from anywhere
  }
  ingress {
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

  
}