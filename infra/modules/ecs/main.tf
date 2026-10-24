resource "aws_ecs_cluster" "this" {
  name = "tripare-cluster"
}

resource "aws_ecs_task_definition" "app" {
  family                   = "tripare-app"
  requires_compatibilities = ["FARGATE"]

  network_mode = "awsvpc"

  cpu    = 256
  memory = 512

  container_definitions = jsonencode([
    {
      name  = "nginx"
      image = "nginx:latest"

      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "app" {
  name            = "tripare-service"
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.app.arn

  desired_count = 1

  launch_type = "FARGATE"

  network_configuration {
    subnets         = [var.subnet_id]
    security_groups = [var.security_group_id]
  }
}