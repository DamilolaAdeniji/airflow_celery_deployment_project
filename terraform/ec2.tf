resource "aws_security_group" "ec2_ssh" {
  name        = "ec2-ssh"
  description = "Allow SSH"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip_address]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "ec2-ssh"
  }
}


module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 5.0"

  name                        = "celery-worker-1"
  ami                         = "ami-042b4708b1d05f512" # Ubuntu 22.04 LTS
  instance_type               = "t3.micro"
  iam_instance_profile        = aws_iam_instance_profile.ec2_ssm_profile.name
  key_name                    = "celery-worker-1"
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.ec2_ssh.id]
  associate_public_ip_address = true
  monitoring                  = true
  user_data                   = <<-EOF
    #!/bin/bash
      wget https://s3.amazonaws.com/ec2-downloads-REGION/SSMAgent/latest/debian_amd64/amazon-ssm-agent.deb
      sudo dpkg -i amazon-ssm-agent.deb
      sudo systemctl status amazon-ssm-agent

      apt-get update
      sudo snap install docker 
      sudo systemctl enable --now docker
      sudo usermod -aG docker ubuntu

      git clone https://github.com/DamilolaAdeniji/airflow_celery_deployment_project.git
EOF
  user_data_replace_on_change = true
  tags = {
    Terraform   = "true"
    Environment = "Dev"
  }
}

module "ec2_instance_redis" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 5.0"

  name                        = "redis"
  ami                         = "ami-042b4708b1d05f512" # Ubuntu 22.04 LTS
  instance_type               = "t3.micro"
  iam_instance_profile        = aws_iam_instance_profile.ec2_ssm_profile.name
  key_name                    = "celery-worker-1"
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.ec2_ssh.id]
  associate_public_ip_address = true
  monitoring                  = true
  user_data                   = <<-EOF
    #!/bin/bash
      wget https://s3.amazonaws.com/ec2-downloads-REGION/SSMAgent/latest/debian_amd64/amazon-ssm-agent.deb
      sudo dpkg -i amazon-ssm-agent.deb
      sudo systemctl status amazon-ssm-agent

      apt-get update
      sudo snap install docker 
      sudo systemctl enable --now docker
      sudo usermod -aG docker ubuntu

      git clone https://github.com/DamilolaAdeniji/airflow_celery_deployment_project.git
EOF
  user_data_replace_on_change = true
  tags = {
    Terraform   = "true"
    Environment = "Dev"
  }
}
