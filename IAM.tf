resource "aws_iam_role" "ssm_role" {
  name = "ec2-ssm-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ssm_core" {
  role       = aws_iam_role.ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "ssm_profile" {
  name = "ec2-ssm-instance-profile"
  role = aws_iam_role.ssm_role.name
}

resource "aws_iam_role" "ssm_logging_role" {
  name = "ssm-session-logging-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ssm.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_policy" "ssm_logging_policy" {
  name = "ssm-session-logging-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = [
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:DescribeLogGroups",
        "logs:DescribeLogStreams"
      ]
      Resource = "${aws_cloudwatch_log_group.ssm_sessions.arn}:*"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ssm_logging_attach" {
  role       = aws_iam_role.ssm_logging_role.name
  policy_arn = aws_iam_policy.ssm_logging_policy.arn
}


resource "aws_s3_bucket_policy" "ssm_logs" {
  bucket = aws_s3_bucket.ssm_logs.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ssm.amazonaws.com"
      }
      Action   = "s3:PutObject"
      Resource = "${aws_s3_bucket.ssm_logs.arn}/*"
    }]
  })
}
