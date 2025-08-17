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
  availability_zone = "eu-north-1a"
  tags = {
    Name        = "dami-celery-project-public-subnet"
    Environment = "development"
  }
}

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.0.16/28"
  availability_zone = "eu-north-1a"
  tags = {
    Name        = "dami-celery-project-private-subnet"
    Environment = "development"
  }
}

resource "aws_subnet" "private_AZ1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.0.32/28"
  availability_zone = "eu-north-1b"
  tags = {
    Name        = "dami-celery-project-private-subnet-AZ1"
    Environment = "development"
  }
}

resource "aws_subnet" "public_AZ1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.0.48/28"
  availability_zone = "eu-north-1b"
  tags = {
    Name        = "dami-celery-project-public-subnet-AZ1"
    Environment = "development"
  }
}

resource "aws_subnet" "private_AZ2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.0.64/28"
  availability_zone = "eu-north-1c"
  tags = {
    Name        = "dami-celery-project-private-subnet-AZ2"
    Environment = "development"
  }
}

resource "aws_subnet" "public_AZ2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.0.80/28"
  availability_zone = "eu-north-1c"
  tags = {
    Name        = "dami-celery-project-public-subnet-AZ2"
    Environment = "development"
  }
}


resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name        = "dami-celery-project-internet-gateway"
    Environment = "development"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_AZ2" {
  subnet_id      = aws_subnet.public_AZ2.id
  route_table_id = aws_route_table.public.id
}