# Internet Gateway 생성
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.terraform-vpc.id
  tags = {
    Name = "IGW"
  }
}
