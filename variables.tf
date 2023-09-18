variable aws_account_id {
  description = <<-EOF
    The AWS account id we are operating in, required for generating the ECR private registry hostname.
  EOF
}

variable domain_name {
  description = <<-EOF
    The custom FQDN to use for ACM and CloudFront as your entry-point to private ECR.

    Example: ecr.mycompany.com
  EOF
}

variable ecr_registry_region {
  type = string
  default = "us-east-1"
  description = <<-EOF
    The AWS region in which your private ECR registry lives.
  EOF
}

variable additional_domain_names {
  type =  map(string)
  default = {}
  description = <<-EOF
    Additional list of domain names to associate with the ACM certificate, CloudFront, and Route53.

    This value is a map with string keys representing domain names to a string holding the Route53 zone id for the
    record. If you require a _nested_ domain, such as `docker.origin.mycompany.com`, pass a zone ID for the sub hosted
    zone, e.g. for `origin.mycompany.com`, otherwise this will break as it takes the first name in the FQDN, e.g.
    `docker`.

    These records will be created as CNAMEs pointing to the main alias record.
  EOF
}

variable additional_domain_name_ttl {
  type = number
  default = 300
  description = <<-EOF
    The TTL to set on additional CNAME records.
  EOF
}

variable zone_id {
  description = <<-EOF
    The Route 53 zone ID in which to create the ECR alias record.
  EOF
}

variable lambda_provider {
  default = null
  description = <<-EOF
    An AWS provider name which is in us-east-1.

    Lambda functions _must_ live in us-east-1. If you are running in a different region, setup another provider and pass
    its name here.
  EOF
}