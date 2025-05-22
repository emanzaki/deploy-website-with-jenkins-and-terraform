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
  subnet_id = data.aws_vpc.default.id
  
  tags = {
    Name = "Terraform-Instance"
  }
}
data "aws_vpc" "default" {
  default = true
}
resource "aws_security_group" "SG" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = data.aws_vpc.default.id

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
#igw
resource "aws_internet_gateway" "igw" {
  vpc_id = data.aws_vpc.default.id
}
#route table
resource "aws_route_table" "route_table" {
  vpc_id = data.aws_vpc.default.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}
#route table association
resource "aws_route_table_association" "rta" {
  subnet_id      = data.aws_vpc.default.id
  route_table_id = aws_route_table.route_table.id
}
