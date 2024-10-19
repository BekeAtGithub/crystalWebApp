output "ecs_service_name" {
  description = "The name of the ECS service"
  value       = aws_ecs_service.my_crystal_app_service.name
}

output "ecs_cluster_name" {
  description = "The name of the ECS cluster"
  value       = aws_ecs_cluster.my_crystal_app_cluster.name
}

output "ecr_repository_url" {
  description = "The URL of the ECR repository"
  value       = aws_ecr_repository.my_crystal_app_repo.repository_url
}
