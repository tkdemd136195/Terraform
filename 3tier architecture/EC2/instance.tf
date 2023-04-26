#인스턴스 생성
resource "aws_instance" "bastion" {
  ami           = "ami-0a306845f8cfbd41a"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.public1.id
  key_name = "TEST"
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.bastion.id]
  tags = {
    Name = "Bastion"
  }
}

resource "aws_instance" "web" {
  ami           = "ami-0a306845f8cfbd41a"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.web1.id
  key_name = "TEST"
  vpc_security_group_ids = [aws_security_group.web.id]
  tags = {
    Name = "Web Server"
  }
}

resource "aws_instance" "was" {
  ami           = "ami-03db74b70e1da9c56"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.was1.id
  key_name = "TEST"
  vpc_security_group_ids = [aws_security_group.was.id]
  tags = {
    Name = "Was Server"
  }
}

resource "aws_instance" "db" {
  ami           = "ami-04cebc8d6c4f297a3"
  instance_type = "t2.micro"

  subnet_id = aws_subnet.db1.id
  key_name = "TEST"

  vpc_security_group_ids = [aws_security_group.db.id]
  tags = {
    Name = "DB Server"
  }
}
