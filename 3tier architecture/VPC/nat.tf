# EIP 할당 후 NAT Gateway 생성
resource "aws_eip" "eip_nat" {
  vpc = true
}
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.eip_nat.id
  subnet_id     = aws_subnet.public1.id
}
