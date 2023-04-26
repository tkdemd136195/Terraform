# RDS DB Instance 생성
resource "aws_db_instance" "rds" {
  identifier           = "rds"
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "8.0.32"
  instance_class       = "db.t2.micro"
  username             = "admin"
  password             = "12345678"
  db_subnet_group_name  = "subnet-group"
  vpc_security_group_ids = [aws_security_group.db.id]
}
