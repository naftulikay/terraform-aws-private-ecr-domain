provider aws {
  alias = "default"
}

provider aws {
  alias = "us_east_1"
}

locals {
  domain_name_short = split(".", var.domain_name)[0]
  ecr_registry_fqdn = "${var.aws_account_id}.dkr.ecr.${var.ecr_registry_region}.amazonaws.com"

  zone_id_map = merge({ (var.domain_name): (var.zone_id) }, var.additional_domain_names)
}