# Route 53 Zone Configuration 
resource "aws_route53_zone" "shiftme_route53_zone" {
  name          = var.domain_name
  force_destroy = true
}

resource "aws_route53_health_check" "mumbai_health_check" {
  fqdn              = module.mumbai-resources.lb-ip
  port              = 80
  type              = "HTTP"
  resource_path     = "/"
  failure_threshold = "5"
  request_interval  = "30"

  tags = {
    Name = "mumbai-health-check"
  }
}

resource "aws_route53_health_check" "singapore_health_check" {
  fqdn              = module.singapore-resources.lb-ip
  port              = 80
  type              = "HTTP"
  resource_path     = "/"
  failure_threshold = "5"
  request_interval  = "30"

  tags = {
    Name = "singapore-health-check"
  }
}

# Route 53 Record Configuration 
resource "aws_route53_record" "shiftme_mumbai_route53_record" {
  zone_id         = aws_route53_zone.shiftme_route53_zone.zone_id
  set_identifier  = "mumbai"
  name            = var.subdomain_name
  type            = "CNAME"
  health_check_id = aws_route53_health_check.mumbai_health_check.id
  failover_routing_policy {
    type = "PRIMARY"
  }
  ttl     = 300
  records = ["${module.mumbai-resources.lb-ip}"]
}

resource "aws_route53_record" "shiftme_singapore_route53_record" {
  zone_id         = aws_route53_zone.shiftme_route53_zone.zone_id
  set_identifier  = "singapore"
  name            = var.subdomain_name
  type            = "CNAME"
  health_check_id = aws_route53_health_check.singapore_health_check.id
  failover_routing_policy {
    type = "SECONDARY"
  }
  ttl     = 300
  records = ["${module.singapore-resources.lb-ip}"]
}

# AWS Certificate Manager
resource "aws_acm_certificate" "shiftme-domain-certificate" {
  domain_name       = var.domain_name
  validation_method = "DNS"
  lifecycle {
    create_before_destroy = true
  }
}
