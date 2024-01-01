resource "aws_vpc" "dev-vpc" {
  cidr_block           = var.cidr[0]
  enable_dns_hostnames = var.dns_hostnames
  enable_dns_support   = var.dns_support

  tags = {
    Name = "dev"
  }
}

resource "aws_subnet" "dev-public-subnet" {
  vpc_id                  = aws_vpc.dev-vpc.id
  cidr_block              = var.subnet_cidr[0]
  map_public_ip_on_launch = var.map_ip
  availability_zone       = var.availability-zones[0]
  tags = {
    Name = "dev-public-subnet"
  }
}

resource "aws_internet_gateway" "dev-gw" {
  vpc_id = aws_vpc.dev-vpc.id

  tags = {
    Name = "dev-gw"
  }
}

resource "aws_route_table" "dev-route-table" {
  vpc_id = aws_vpc.dev-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dev-gw.id
  }
  tags = {
    Name = "dev-rt"
  }
}
resource "aws_route_table_association" "dev-rt-association" {
  subnet_id      = aws_subnet.dev-public-subnet.id
  route_table_id = aws_route_table.dev-route-table.id
}

resource "aws_security_group" "dev-sg" {
  name   = "dev_sg"
  vpc_id = aws_vpc.dev-vpc.id

  ingress {
    description = "TLS from VPC"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.my_ip
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "dev-sg"
  }
}
resource "aws_key_pair" "dev-auth" {
  key_name   = "dev-key-pair"
  public_key = file(var.keypair)
}