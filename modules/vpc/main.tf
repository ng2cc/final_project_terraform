# Terraform을 사용하여 AWS에서 VPC, 인터넷 게이트웨이, 서브넷, 라우팅 테이블을 생성하고 구성
# Terraform을 사용하여 자동화하고 관리할 수 있도록 해줌


resource "aws_vpc" "vpc" {
  cidr_block           = var.VPC_CIDR
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true
  enable_classiclink   = false


  enable_classiclink_dns_support = false


  assign_generated_ipv6_cidr_block = false



  tags = {
    Name = "${var.PROJECT_NAME}-vpc"
  }
}


resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.PROJECT_NAME}-igw"
  }
}




data "aws_availability_zones" "available_zones" {}


resource "aws_subnet" "pub-sub-1-a" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.PUB_SUB_1_A_CIDR
  availability_zone       = data.aws_availability_zones.available_zones.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name                                        = "pub-sub-1-a"
    "kubernetes.io/cluster/${var.PROJECT_NAME}" = "shared"
    "kubernetes.io/role/elb"                    = 1

  }
}


resource "aws_subnet" "pub-sub-2-b" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.PUB_SUB_2_B_CIDR
  availability_zone       = data.aws_availability_zones.available_zones.names[1]
  map_public_ip_on_launch = true

  tags = {
    Name                                        = "pub-sub-2-b"
    "kubernetes.io/cluster/${var.PROJECT_NAME}" = "shared"
    "kubernetes.io/role/elb"                    = 1
  }
}


resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    Name = "Public-RT"
  }
}


resource "aws_route_table_association" "pub-sub-1-a_route_table_association" {
  subnet_id      = aws_subnet.pub-sub-1-a.id
  route_table_id = aws_route_table.public_route_table.id
}


resource "aws_route_table_association" "pub-sub-2-b_route_table_association" {
  subnet_id      = aws_subnet.pub-sub-2-b.id
  route_table_id = aws_route_table.public_route_table.id
}





resource "aws_subnet" "pri-sub-3-a" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.PRI_SUB_3_A_CIDR
  availability_zone       = data.aws_availability_zones.available_zones.names[0]
  map_public_ip_on_launch = false

  tags = {
    Name                                        = "pri-sub-3-a"
    "kubernetes.io/cluster/${var.PROJECT_NAME}" = "shared"
    "kubernetes.io/role/internal-elb"           = 1
  }
}


resource "aws_subnet" "pri-sub-4-b" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.PRI_SUB_4_B_CIDR
  availability_zone       = data.aws_availability_zones.available_zones.names[1]
  map_public_ip_on_launch = false

  tags = {
    Name                                        = "pri-sub-4-b"
    "kubernetes.io/cluster/${var.PROJECT_NAME}" = "shared"
    "kubernetes.io/role/internal-elb"           = 1
  }
}

