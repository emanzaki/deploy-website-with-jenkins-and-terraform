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
  tags = {
    Name = "Terraform-Instance"
  }
}