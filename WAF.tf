resource "aws_wafv2_web_acl" "alb_waf" {
  name        = "alb-web-acl"
  description = "WAF protecting Application Load Balancer"
  scope       = "REGIONAL"

  default_action {
    allow {}
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "ALBWebACL"
    sampled_requests_enabled   = true
  }

  tags = merge(local.common_tags, {
    Name = "ALB-WAF"
  })
}
