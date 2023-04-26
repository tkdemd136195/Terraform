# VPC 생성
resource "aws_vpc" "terraform-vpc" {
  cidr_block = "172.20.0.0/20"
  tags = {
    Name = "main_vpc"
  }
}
