#키파일 생성
# Create .pem key file in local
resource "tls_private_key" "aws" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "aws" {
  key_name   = "aws"
  public_key = tls_private_key.aws.public_key_openssh
}


resource "local_file" "ssh_key" {
  filename = "aws.pem"
  content = tls_private_key.aws.private_key_pem
}
