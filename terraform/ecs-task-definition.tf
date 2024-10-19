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
        value = "01" # Increment this for each instance
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
