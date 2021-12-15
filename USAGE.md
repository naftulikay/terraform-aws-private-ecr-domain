# Module Usage

```hcl
provider aws {
 region = "us-east-1"
}

locals {
 module_version = "v0.0.1"
}

module private_ecr_domain {
 source = "github.com/naftulikay/terraform-aws-private-ecr-domain?ref=${local.module_version}"
 
 domain_name = "docker.mycompany.com"
 
 additional_domain_names = {
  "docker.aws.mycompany.com" = var.aws_zone_id
 }
 additional_domain_name_ttl = 3600
 
 zone_id = var.zone_id
}
```

## Parameters

### `domain_name`

A fully-qualified domain name which exists in `var.zone_id`.

### `additional_domain_names`

A `map(string, string)`, where the _key_ is the fully-qualified domain name, and the _value_ is the Route53 zone ID
for the given domain name.

Each of these records will be `CNAME`s to the `domain_name` above, which is an `ALIAS` record to CloudFront.

### `additional_domain_name_ttl`

The TTL in seconds for the additional CNAME records.

### `zone_id`

The Route53 zone id in which to create the primary `ALIAS` record to CloudFront.

## Outputs

### `certificate_arn`

The ARN for the ACM certificate.

### `cloudfront_cache_policy_id`

The ID for the CloudFront cache policy.

### `cloudfront_distribution_arn`

The ARN for the CloudFront distribution.

### `cloudfront_origin_request_policy_id`

The ID for the CloudFront origin request policy.

### `domain_validation_options`

The domain validation options for the ACM certificate.

### `lambda_function_arn`

The ARN for the Lambda function.

### `lambda_function_qualified_arn`

The qualified ARN for the latest version of the Lambda function.

### `lambda_function_name`

The Lambda function name.

### `lambda_iam_policy_arn`

The Lambda IAM policy ARN.

### `lambda_iam_policy_name`

The Lambda IAM policy name.

### `lambda_iam_role_arn`

The Lambda IAM role ARN.

### `lambda_iam_role_name`

The Lambda IAM role name.