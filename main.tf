locals{
  domain_name_short = split('.', var.domain_name)[0]
  ecr_us_east_1 = "${data.aws_caller_identity.default.account_id}.dkr.ecr.us-east-1.amazonaws.com"

  zone_id_map = merge({ var.domain_name: var.zone_id }, var.additional_domain_names)
}