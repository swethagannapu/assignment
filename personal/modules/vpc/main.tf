resource "aws_vpc" "ledn_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "ledn_vpc"
  }
}

resource "aws_subnet" "ledn_subnet" {
  vpc_id            = aws_vpc.ledn_vpc.id
  cidr_block        = var.subnet_cidr
  availability_zone = "ca-central-1a"

  tags = {
    Name = "ledn_vpc"
  }
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.ledn_vpc.id

  tags = {
    Name = "ledn_igw"
  }
}
resource "aws_route_table" "rtb" {
  vpc_id = aws_vpc.ledn_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "ledn_rtb"
  }
}

resource "aws_route_table_association" "public" {
  subnet_id = aws_subnet.ledn_subnet.id
  route_table_id = aws_route_table.rtb.id
}

