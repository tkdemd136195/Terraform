# Subnet group 생성
resource "aws_db_subnet_group" "subnet-group" {
  name       = "subnet-group"
  subnet_ids = [aws_subnet.db1.id, aws_subnet.db2.id]
  tags = {
    Name = "subnet-group"
  }
}
