resource aws_cloudfront_distribution default {
  enabled = true
  retain_on_delete = true
  comment = "ECR Docker Registry front-end."

  aliases = [var.domain_name]

  is_ipv6_enabled = true
  http_version = "http2"

  default_root_object = "index.html"

  price_class = "PriceClass_100"

  origin {
    origin_id = "ecr-us-east-1"
    domain_name = local.ecr_us_east_1

    custom_origin_config {
      http_port = 80
      https_port = 443
      origin_protocol_policy = "https-only"
      origin_ssl_protocols = ["TLSv1.2"]
    }
  }

  default_cache_behavior {
    target_origin_id = "ecr-us-east-1"

    min_ttl = 0
    default_ttl = 0
    max_ttl = 60

    allowed_methods = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods = ["GET", "HEAD"]
    viewer_protocol_policy = "redirect-to-https"

    cache_policy_id = aws_cloudfront_cache_policy.default.id
    origin_request_policy_id = aws_cloudfront_origin_request_policy.default.id

    lambda_function_association {
      event_type = "origin-request"
      lambda_arn = aws_lambda_function.host_rewrite.qualified_arn
      include_body = false
    }
  }

  restrictions {
    geo_restriction { restriction_type = "none" }
  }

  viewer_certificate {
    acm_certificate_arn = aws_acm_certificate.default.arn
    minimum_protocol_version = "TLSv1.2_2021"
    ssl_support_method = "sni-only"
  }

  tags = {
    client = "self"
  }
}

resource aws_cloudfront_cache_policy default {
  name = "ecr"
  min_ttl = 1

  parameters_in_cache_key_and_forwarded_to_origin {
    cookies_config {
      cookie_behavior = "all"
    }
    headers_config {
      header_behavior = "whitelist"
      headers {
        items = [
          "Authorization",
        ]
      }
    }
    query_strings_config {
      query_string_behavior = "all"
    }

    enable_accept_encoding_brotli = true
    enable_accept_encoding_gzip = true
  }
}

resource aws_cloudfront_origin_request_policy default {
  name = "ecr"
  cookies_config {
    cookie_behavior = "all"
  }
  headers_config {
    header_behavior = "allViewer"
  }
  query_strings_config {
    query_string_behavior = "all"
  }
}