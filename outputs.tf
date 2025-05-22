output "aws_instance_ip" {
  value = aws_instance.name.public_ip
  description = "The public IP address of the EC2 instance"
  
}