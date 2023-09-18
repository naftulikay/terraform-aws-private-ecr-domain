resource aws_iam_role lambda_host_rewrite {
  provider = aws.default

  name = "ecr-lambda-rewrite-role"
  path = "/ecr/"

  assume_role_policy = file("${path.module}/policies/lambda-assume-role.json")

  tags = {
    client = "self"
  }
}

resource aws_iam_role_policy_attachment lambda_basic_execution {
  provider = aws.default

  role = aws_iam_role.lambda_host_rewrite.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource aws_iam_policy lambda_log_all {
  provider = aws.default

  name = "lambda-cloudwatch-write-all"
  policy = file("${path.module}/policies/lambda-logging-policy.json")
}

resource aws_iam_role_policy_attachment lambda_log_all {
  provider = aws.default

  role = aws_iam_role.lambda_host_rewrite.name
  policy_arn = aws_iam_policy.lambda_log_all.arn
}