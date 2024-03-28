resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.ahl-vpc.id

  tags = {
    Name = "igw"
  }
}