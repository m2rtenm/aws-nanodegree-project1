output "alb_dns" {
  value = aws_lb.load_balancer.dns_name
}

output "alb_zone" {
  value = aws_lb.load_balancer.zone_id
}