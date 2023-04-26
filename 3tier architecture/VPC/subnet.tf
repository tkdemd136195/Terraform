# 가용영역 A의 서브넷 생성
resource "aws_subnet" "public1" {
  cidr_block = "172.20.0.0/24"
  availability_zone = "ap-northeast-2a"
  map_public_ip_on_launch = true
  vpc_id = aws_vpc.terraform-vpc.id
  tags = {
    Name = "public1"
  }
}

resource "aws_subnet" "web1" {
  cidr_block = "172.20.1.0/24"
  availability_zone = "ap-northeast-2a"
  map_public_ip_on_launch = false
  vpc_id = aws_vpc.terraform-vpc.id
  tags = {
    Name = "web1"
  }
}

resource "aws_subnet" "was1" {
  cidr_block = "172.20.2.0/24"
  availability_zone = "ap-northeast-2a"
  map_public_ip_on_launch = false
  vpc_id = aws_vpc.terraform-vpc.id
  tags = {
    Name = "was1"
  }
}

resource "aws_subnet" "db1" {
  cidr_block = "172.20.3.0/24"
  availability_zone = "ap-northeast-2a"
  map_public_ip_on_launch = false
  vpc_id = aws_vpc.terraform-vpc.id
  tags = {
    Name = "db1"
  }
}

# 가용영역 C의 서브넷 생성
resource "aws_subnet" "public2" {
  cidr_block = "172.20.4.0/24"
  availability_zone = "ap-northeast-2c"
  map_public_ip_on_launch = true
  vpc_id = aws_vpc.terraform-vpc.id
  tags = {
    Name = "public2"
  }
}

resource "aws_subnet" "web2" {
  cidr_block = "172.20.5.0/24"
  availability_zone = "ap-northeast-2c"
  map_public_ip_on_launch = false
  vpc_id = aws_vpc.terraform-vpc.id
  tags = {
    Name = "web2"
  }
}

resource "aws_subnet" "was2" {
  cidr_block = "172.20.6.0/24"
  availability_zone = "ap-northeast-2c"
  map_public_ip_on_launch = false
  vpc_id = aws_vpc.terraform-vpc.id
  tags = {
    Name = "was2"
  }
}

resource "aws_subnet" "db2" {
  cidr_block = "172.20.7.0/24"
  availability_zone = "ap-northeast-2c"
  map_public_ip_on_launch = false
  vpc_id = aws_vpc.terraform-vpc.id
  tags = {
    Name = "db2"
  }
}
