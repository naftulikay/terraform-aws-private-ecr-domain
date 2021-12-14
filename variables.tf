variable domain_name {
  description = <<-EOF
    The custom FQDN to use for ACM and CloudFront as your entry-point to private ECR.

    Example: ecr.mycompany.com
  EOF
}

variable zone_id {
  description = <<-EOF
    The Route 53 zone ID in which to create the ECR alias record.
  EOF
}