# create an IAM role for EC2 instances to use SSM
resource "aws_iam_role" "ec2_ssm_role" {
  name = "ec2-ssm-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy" "ssm_policy" {
  name = "ec2-ssm-policy"
  role = aws_iam_role.ec2_ssm_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = "ssm:GetParametersByPath",
        Resource = "arn:aws:ssm:eu-north-1:340752803932:parameter/dami_celery/project/*"
      },
      {
        Effect   = "Allow",
        Action   = "ssm:PutParameter",
        Resource = "arn:aws:ssm:eu-north-1:340752803932:parameter/dami_celery/project/*"
      }
    ]
  })
}

# Attach the SSM managed policy to the role
resource "aws_iam_role_policy_attachment" "ssm_core" {
  role       = aws_iam_role.ec2_ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# Create an instance profile for the role
resource "aws_iam_instance_profile" "ec2_ssm_profile" {
  name = "ec2-ssm-profile"
  role = aws_iam_role.ec2_ssm_role.name
}