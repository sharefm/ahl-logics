resource "aws_subnet" "private-a" {
  vpc_id            = aws_vpc.ahl-vpc.id
  cidr_block        = "10.0.0.0/19"
  availability_zone = "us-east-1a"

  tags = {
    "Name"                            = "private-us-east-1a"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/demo"      = "owned"
  }
}


resource "aws_subnet" "private-b" {
  vpc_id            = aws_vpc.ahl-vpc.id
  cidr_block        = "10.0.32.0/19"
  availability_zone = "us-east-1b"

  tags = {
    "Name"                            = "private-b"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/demo"      = "owned"
  }
}


resource "aws_subnet" "public-a" {
  vpc_id                  = aws_vpc.ahl-vpc.id
  cidr_block              = "10.0.64.0/19"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    "Name"                              = "public-a"
    "kubernetes.io/role/elb"            = "1"
    "kubernetes.io/cluster/ahl-cluster" = "owned"
  }
}


resource "aws_subnet" "public-b" {
  vpc_id                  = aws_vpc.ahl-vpc.id
  cidr_block              = "10.0.96.0/19"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    "Name"                       = "public-b"
    "kubernetes.io/role/elb"     = "1"
    "kubernetes.io/cluster/demo" = "owned"
  }
}