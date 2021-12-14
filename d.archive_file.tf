data archive_file lambda_code {
  type = "zip"
  source_dir = "${path.module}/lambda"
  output_path = "${path.module}/build/lambda.zip"
  excludes = ["build"]
}