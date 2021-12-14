output certificate_arn {
  value = aws_acm_certificate.default.arn
}

output domain_validation_options {
  value = aws_acm_certificate.default.domain_validation_options
  description = <<-EOF
    Domain validation information for setting up ACM for domains.
  EOF
}