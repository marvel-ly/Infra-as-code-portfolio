output "public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.devops_server.public_ip
}

output "http_url" {
  description = "Browser link to your web server"
  value       = "http://${aws_instance.devops_server.public_ip}"
}

output "ssh_command" {
  description = "SSH command to connect to the EC2"
  value       = "ssh -i ~/.ssh/id_rsa ec2-user@${aws_instance.devops_server.public_ip}"
}
