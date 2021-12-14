resource aws_acm_certificate default {
  domain_name = var.domain_name
  subject_alternative_names = []
  validation_method = "DNS"

  tags = {
    client = "self"
  }
}

resource aws_acm_certificate_validation default {
  certificate_arn = aws_acm_certificate.default.arn
  depends_on = [
    aws_route53_record.acm_validations.0,
    aws_route53_record.acm_validations.1,
  ]
}
