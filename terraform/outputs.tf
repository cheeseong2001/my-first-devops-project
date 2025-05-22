output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.portfolio_server.id
}

output "instance_eip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_eip.instance_ip
}