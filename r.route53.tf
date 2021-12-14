resource aws_route53_record acm_validations {
  for_each = {
    for dvo in aws_acm_certificate.default.domain_validation_options : dvo.domain_name => {
      domain_name = dvo.domain_name
      name = dvo.resource_record_name
      record = dvo.resource_record_value
      type = dvo.resource_record_type
    }
  }

  name = each.value.name
  records = [each.value.record]
  ttl = 60
  type = each.value.type
  zone_id = var.zone_id
  allow_overwrite = true
}

resource aws_route53_record docker {
  name = local.domain_name_short
  type = "A"
  zone_id = var.zone_id

  alias {
    name = aws_cloudfront_distribution.default.domain_name
    zone_id = aws_cloudfront_distribution.default.hosted_zone_id
    evaluate_target_health = true
  }
}