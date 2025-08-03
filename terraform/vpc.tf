resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/24"
  tags = {
    Name        = "dami-celery-project-vpc"
    Environment = "development"
  }
}

resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.0.0/28"
  availability_zone = "us-west-1a"
  tags = {
    Name        = "dami-celery-project-public-subnet"
    Environment = "development"
  }
}

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.0.16/28"
  availability_zone = "us-west-1a"
  tags = {
    Name        = "dami-celery-project-private-subnet"
    Environment = "development"
  }
}

resource "aws_subnet" "private-AZ2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.0.32/28"
  availability_zone = "us-west-1b"
  tags = {
    Name        = "dami-celery-project-private-subnet-AZ2"
    Environment = "development"
  }
}

resource "aws_subnet" "public-AZ2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.0.48/28"
  availability_zone = "us-west-1b"
  tags = {
    Name        = "dami-celery-project-public-subnet-AZ2"
    Environment = "development"
  }
}
