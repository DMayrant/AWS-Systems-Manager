resource "aws_lb" "ALB" {
  name                       = "Public-alb"
  internal                   = false # public ALB
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.ssm_endpoints_sg.id] # Correct SG
  subnets                    = aws_subnet.public_subnet[*].id           # Public subnets
  enable_deletion_protection = false

  tags = merge(local.common_tags, {
    Name = "Public-ALB"
  })
}


# Create a target group and Health checks for the ALB
resource "aws_lb_target_group" "alb_tg" {
  name        = "instance-tg" # FIX: Environment-specific name
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = aws_vpc.main_vpc.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = merge(local.common_tags, {
    Name = "ALB"
  })
}

resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.ALB.arn
  port              = 80 # ALB listens on port 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg.arn
  }
}