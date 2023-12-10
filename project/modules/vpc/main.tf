resource "aws_vpc" "my_vpc" {
    cidr_block = var.vpc_cidr
    tags = {
        Name = "${var.project}-vpc"
        env = var.env
    }
}

resource "aws_subnet" "pvt_subnet" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = var.pvt.sub.cidr

  tags = {
    Name = "${var.project}-private_subnet"
    env = var.env
  }
}

resource "aws_subnet" "pub_subnet" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = var.pub.sub.cidr

  tags = {
    Name = "${var.project}-public_subnet"
    env = var.env
  }
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "${var.project}-igw"
    env = var.env
  }
}

resource "aws_default_route_table" "example" {
  default_route_table_id = aws_vpc.my_vpc.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }
   tags = {
    Name = "${var.project}-rt"
    env = var.env
  }
}