output certificate_arn {
  value = aws_acm_certificate.default.arn

  description = <<-EOF
    The ARN for the ACM certificate.
  EOF
}

output cloudfront_cache_policy_id {
  value = aws_cloudfront_cache_policy.default.id
  description = <<-EOF
    The ID for the CloudFront cache policy.
  EOF
}

output cloudfront_distribution_arn {
  value = aws_cloudfront_distribution.default.arn
  description = <<-EOF
    The ARN for the CloudFront distribution.
  EOF
}

output cloudfront_origin_request_policy_id {
  value = aws_cloudfront_origin_request_policy.default.id
  description = <<-EOF
    The ID for the CloudFront origin request policy.
  EOF
}

output domain_validation_options {
  value = aws_acm_certificate.default.domain_validation_options
  description = <<-EOF
    Domain validation information for setting up ACM for domains.
  EOF
}

output ecr_origin_fqdn {
  value = local.ecr_registry_fqdn
  description = <<-EOF
    The AWS-provided ECR private registry FQDN.

    NOTE: This is not going to be the same as your chosen alias FQDN, rather it is the long-form AWS ECR private
    registry FQDN.
  EOF
}

output ecr_registry_region {
  value = var.ecr_registry_region
  description = <<-EOF
    The region in which the private registry lives.
  EOF
}

output lambda_function_arn {
  value = aws_lambda_function.host_rewrite.arn
  description = <<-EOF
    The ARN for the Lambda function.
  EOF
}

output lambda_function_qualified_arn {
  value = aws_lambda_function.host_rewrite.qualified_arn
  description = <<-EOF
    The qualified ARN for the latest version of the Lambda function.
  EOF
}

output lambda_function_name {
  value = aws_lambda_function.host_rewrite.function_name
  description = <<-EOF
    The Lambda function name.
  EOF
}

output lambda_iam_policy_arn {
  value = aws_iam_policy.lambda_log_all.arn
  description = <<-EOF

  EOF
}

output lambda_iam_role_arn {
  value = aws_iam_role.lambda_host_rewrite.arn
  description = <<-EOF
    The Lambda IAM role ARN.
  EOF
}

output lambda_iam_role_name {
  value = aws_iam_role.lambda_host_rewrite.name
  description = <<-EOF
    The Lambda IAM role name.
  EOF
}