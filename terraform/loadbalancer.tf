# Load balancer
resource "aws_lb" "load_balancer" {
  name = "${var.prefix}-alb"
  load_balancer_type = "application"
  internal = false
  security_groups = [ aws_security_group.load_balancer.id ]
  subnets = [ aws_subnet.public-subnet-1.id, aws_subnet.public-subnet-2.id ]
}

# Target group
resource "aws_alb_target_group" "default-target-group" {
  name = "${var.prefix}-tg"
  port = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.vpc.id

  health_check {
    path = var.health_check_path
    port = "traffic-port"
    healthy_threshold = 5
    unhealthy_threshold = 2
    timeout = 2
    interval = 60
    matcher = "200"
  }
}

resource "aws_autoscaling_attachment" "asg_attachment_bar" {
  autoscaling_group_name = aws_autoscaling_group.ec2-cluster.id
  lb_target_group_arn = aws_alb_target_group.default-target-group.arn
}

resource "aws_alb_listener" "ec2-alb-http-listener" {
  load_balancer_arn = aws_lb.load_balancer.arn
  port = 80
  protocol = "HTTP"
  depends_on = [ aws_alb_target_group.default-target-group ]

  default_action {
    type = "forward"
    target_group_arn = aws_alb_target_group.default-target-group.arn
  }
}