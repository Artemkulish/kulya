resource "aws_alb" "kulya" {
  name            = "ECS_ALB"
  subnets         = [aws_subnet.private.id]
  security_groups = [aws_security_group.load_balancer.id]
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_alb.kulya.id
  port              = var.http
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = var.https
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_alb.kulya.id
  port              = var.https
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-FS-1-2-Res-2019-08"
  certificate_arn   = aws_acm_certificate.nodejs-certificate.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.kulya.arn
  }
}

resource "aws_alb_target_group" "kulya" {
  name        = "ECS"
  port        = var.https
  protocol    = "HTTPS"
  vpc_id      = aws_vpc.kulya.id
  target_type = "ip"
}