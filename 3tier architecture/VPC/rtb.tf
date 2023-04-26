# Public Routing 테이블 생성 및 라우팅 설정
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.terraform-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }
  tags = {
    Name = "public"
  }
}

# Private Routing 테이블 생성 및 라우팅 설정
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.terraform-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat.id
  }
  tags = {
    Name = "private"
  }
}


# Public Routing 테이블 연결
resource "aws_route_table_association" "public" {
  count          = 2
  subnet_id      = element(concat([aws_subnet.public1.id], [aws_subnet.public2.id]), count.index)
  route_table_id = aws_route_table.public.id
}

# Private Routing 테이블 연결
resource "aws_route_table_association" "private" {
  count          = 6
  subnet_id      = element(concat([aws_subnet.web1.id], [aws_subnet.web2.id], [aws_subnet.was1.id], [aws_subnet.was2.id], [aws_subnet.db1.id], [aws_subnet.db2.id]), count.index)
  route_table_id = aws_route_table.private.id
}
