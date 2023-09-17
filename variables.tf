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
    record.

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