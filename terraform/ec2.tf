resource "aws_security_group" "ec2_ssh" {
  name        = "ec2-ssh"
  description = "Allow SSH"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["MY.IP.ADDR.0/32"] # TODO: tighten this!
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
  ami                         = "ami-0742eb7300e2d407c" # Ubuntu 22.04 LTS
  instance_type               = "t3.micro"
  key_name                    = "celery-worker-1"
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.ec2_ssh.id]
  associate_public_ip_address = true
  monitoring                  = true

  tags = {
    Terraform   = "true"
    Environment = "Dev"
  }
}