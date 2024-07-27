output "lb-ip" {
  value = aws_lb.lb.dns_name
}
