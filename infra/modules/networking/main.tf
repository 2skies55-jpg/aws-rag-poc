resource "aws_vpc" "this" {

  cidr_block = var.vpc_cidr

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.project_name}-${var.environment}-vpc"
  }
}

resource "aws_internet_gateway" "this" {

  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.project_name}-${var.environment}-igw"
  }
}

resource "aws_subnet" "public_1" {

  vpc_id = aws_vpc.this.id

  cidr_block = var.public_subnet_1_cidr

  availability_zone = var.availability_zone_1

  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-public-a"
  }
}

resource "aws_subnet" "public_2" {

  vpc_id = aws_vpc.this.id

  cidr_block = var.public_subnet_2_cidr

  availability_zone = var.availability_zone_2

  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-public-b"
  }
}


resource "aws_route_table" "public" {

  vpc_id = aws_vpc.this.id

  route {

    cidr_block = "0.0.0.0/0"

    gateway_id = aws_internet_gateway.this.id
  }

  tags = {
    Name = "${var.project_name}-public-rt"
  }
}


resource "aws_route_table_association" "public1" {

  subnet_id = aws_subnet.public_1.id

  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public2" {

  subnet_id = aws_subnet.public_2.id

  route_table_id = aws_route_table.public.id
}


output "vpc_id" {
  value = aws_vpc.this.id
}

output "public_subnet_1" {
  value = aws_subnet.public_1.id
}

output "public_subnet_2" {
  value = aws_subnet.public_2.id
}