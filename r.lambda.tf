# NOTE in order for cloudfront proxy to ECR to work, we need to rewrite the `Host` header dynamically. Normally, it
#      would be possible to do this in Cloudfront, but Cloudfront does not allow rewriting the `Host` header. Therefore,
#      we have a Lambda@Edge function which simply overwrites the `Host` header for us.
resource aws_lambda_function host_rewrite {
  provider = aws.us_east_1

  function_name = "ecr-docker-host-rewrite"
  description = "Rewrites the Host header for incoming requests to ECR to allow custom domains."

  runtime = "nodejs14.x"
  filename = data.archive_file.lambda_code.output_path
  source_code_hash = filebase64sha256(data.archive_file.lambda_code.output_path)
  handler = "index.handler"
  timeout = 5
  memory_size = 128
  publish = true

  role = aws_iam_role.lambda_host_rewrite.arn

  tags = {
    client = "self"
  }

  depends_on = [data.archive_file.lambda_code]
}