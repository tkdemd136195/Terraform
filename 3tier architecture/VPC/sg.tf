# Bastion 보안 그룹
resource "aws_security_group" "bastion" {
  vpc_id      = aws_vpc.terraform-vpc.id
  name = "BASTION"
  tags = {
    Name = "BASTION"
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EX-LB 보안 그룹
resource "aws_security_group" "ex_lb" {
  vpc_id      = aws_vpc.terraform-vpc.id
  name = "EX-LB"
  tags = {
    Name = "EX-LB"
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# WEB 보안 그룹
resource "aws_security_group" "web" {
  vpc_id      = aws_vpc.terraform-vpc.id
  name = "WEB"
  tags = {
    Name = "WEB"
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    security_groups = [aws_security_group.bastion.id]
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    security_groups = [aws_security_group.ex_lb.id]
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    security_groups = [aws_security_group.ex_lb.id]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# IN-LB 보안 그룹
resource "aws_security_group" "in_lb" {
  vpc_id      = aws_vpc.terraform-vpc.id
  name = "IN-LB"
  tags = {
    Name = "IN-LB"
  }

  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    security_groups = [aws_security_group.web.id]
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    security_groups = [aws_security_group.web.id]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# WAS 보안 그룹
resource "aws_security_group" "was" {
  vpc_id      = aws_vpc.terraform-vpc.id
  name = "WAS"
  tags = {
    Name = "WAS"
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    security_groups = [aws_security_group.bastion.id]
  }

  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    security_groups = [aws_security_group.in_lb.id]
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    security_groups = [aws_security_group.in_lb.id]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# DB 보안 그룹
resource "aws_security_group" "db" {
  vpc_id      = aws_vpc.terraform-vpc.id
  name = "DB"
  tags = {
    Name = "DB"
  }

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion.id]
  }

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.was.id]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
