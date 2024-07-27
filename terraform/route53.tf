# Route 53 Zone Configuration 
resource "aws_route53_zone" "shiftme_route53_zone" {
  name = "mygcpprojects.xyz"
}

resource "aws_route53_health_check" "health_check" {
  fqdn              = "lb.mygcpprojects.xyz"
  port              = 80
  type              = "HTTP"
  resource_path     = "/"
  failure_threshold = "5"
  request_interval  = "30"

  tags = {
    Name = "tf-test-health-check"
  }
}

# Route 53 Record Configuration 
resource "aws_route53_record" "shiftme_mumbai_route53_record" {
  zone_id         = aws_route53_zone.shiftme_route53_zone.zone_id
  set_identifier  = "mumbai"
  name            = "lb.mygcpprojects.xyz"
  type            = "A"
  health_check_id = aws_route53_health_check.health_check.id
  failover_routing_policy {
    type = "PRIMARY"
  }
  ttl     = 300
  records = ["${module.mumbai-resources.lb-ip}"]
}

resource "aws_route53_record" "shiftme_singapore_route53_record" {
  zone_id        = aws_route53_zone.shiftme_route53_zone.zone_id
  set_identifier = "singapore"
  name           = "lb.mygcpprojects.xyz"
  type           = "A"
  failover_routing_policy {
    type = "SECONDARY"
  }
  ttl     = 300
  records = ["${module.singapore-resources.lb-ip}"]
}

# AWS Certificate Manager
resource "aws_acm_certificate" "shiftme-domain-certificate" {
  domain_name       = "mygcpprojects.xyz"
  validation_method = "DNS"
  lifecycle {
    create_before_destroy = true
  }
}
