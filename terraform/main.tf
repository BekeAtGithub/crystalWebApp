provider "aws" {
  region = var.region
}

resource "aws_ecs_cluster" "my_crystal_app_cluster" {
  name = "my-crystal-app-cluster"
}

resource "aws_ecs_task_definition" "my_crystal_app_task" {
  family                   = "my-crystal-app"
  container_definitions    = jsonencode([{
    name      = "my-crystal-app-container"
    image     = "${aws_ecr_repository.my_crystal_app_repo.repository_url}:latest"
    essential = true
    portMappings = [{
      containerPort = 8080
      hostPort      = 8080
    }]
    environment = [
      {
        name  = "NODE_NUMBER"
        value = "01" # Change this for each instance
      },
      {
        name  = "PORT"
        value = "8080"
      }
    ]
  }])
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
}

resource "aws_ecs_service" "my_crystal_app_service" {
  name            = "my-crystal-app-service"
  cluster         = aws_ecs_cluster.my_crystal_app_cluster.id
  task_definition = aws_ecs_task_definition.my_crystal_app_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  network_configuration {
    subnets          = var.subnets
    security_groups  = [aws_security_group.ecs_service_sg.id]
    assign_public_ip = true
  }
}

resource "aws_ecr_repository" "my_crystal_app_repo" {
  name = "my-crystal-app-repo"
}
