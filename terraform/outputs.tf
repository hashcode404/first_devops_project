output "frontend_repo_url" {
  value = aws_ecr_repository.frontend.repository_url
}

output "backend_repo_url" {
  value = aws_ecr_repository.backend.repository_url
}

output "ec2_public_ip" {
  value = aws_instance.app_server.public_ip
}