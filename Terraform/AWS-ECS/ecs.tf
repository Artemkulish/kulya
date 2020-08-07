resource "aws_ecs_cluster" "kulya" {
  name = "ECS"
}

resource "aws_ecs_task_definition" "kulya" {
  family                   = "kulya"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.cpu
  memory                   = var.memory
  container_definitions    = templatefile("./task_definitions/service.json", {
    name: "service",
    cpu    : var.cpu,
    memory : var.memory,
    image  : var.docker_image,
    port   : var.https
  })
}

resource "aws_ecs_service" "kulya" {
  name            = "ECS-service"
  task_definition = aws_ecs_task_definition.kulya.arn
  cluster         = aws_ecs_cluster.kulya.id
  desired_count   = var.instances
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = [aws_subnet.private.id]
    security_groups = [aws_security_group.ECS.id]
  }

  load_balancer {
    container_name   = "kulya"
    container_port   = var.https
    target_group_arn = aws_alb_target_group.kulya.id
  }

  depends_on = [aws_alb.kulya]
}