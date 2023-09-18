resource aws_acm_certificate default {
  provider = aws.us_east_1

  domain_name = var.domain_name
  subject_alternative_names = keys(var.additional_domain_names)
  validation_method = "DNS"

  tags = {
    client = "self"
  }
}

resource aws_acm_certificate_validation default {
  provider = aws.us_east_1

  certificate_arn = aws_acm_certificate.default.arn
  depends_on = [
    aws_route53_record.acm_validations.0,
    aws_route53_record.acm_validations.1,
  ]
}
